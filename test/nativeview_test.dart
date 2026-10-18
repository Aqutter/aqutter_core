import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('frame header encoding', () {
    test('writes a little-endian 24 byte header', () {
      final frame = AqutterNativeFrame(
        width: 3,
        height: 2,
        format: AqutterNativeFormat.rgba,
        payload: Uint8List.fromList([1, 2, 3, 4]),
      );
      final bytes = encodeAqutterNativeFrameHeader(frame, seq: 7, sentAtMs: 1700000000000);
      final view = ByteData.sublistView(bytes);
      expect(bytes.length, aqutterNativeHeaderLength);
      expect(view.getUint32(0, Endian.little), 3);
      expect(view.getUint32(4, Endian.little), 2);
      expect(view.getUint32(8, Endian.little), 1);
      expect(view.getUint32(12, Endian.little), 7);
      expect(view.getFloat64(16, Endian.little), 1700000000000);
    });

    test('png uses wire code 0', () {
      expect(AqutterNativeFormat.png.wire, 0);
    });

    test('jpeg uses wire code 2', () {
      expect(AqutterNativeFormat.jpeg.wire, 2);
    });
  });

  group('host and session', () {
    late AqutterNativeHost host;

    setUp(() => host = AqutterNativeHost.instance);
    tearDown(() => host.stop());

    Future<WebSocket> connect(AqutterNativeEndpoint endpoint, String id, {String? token}) {
      return WebSocket.connect('ws://127.0.0.1:${endpoint.port}/native/$id?token=${token ?? endpoint.token}');
    }

    test('streams captured frames to a connected client and routes messages back', () async {
      final messages = Completer<AqutterNativeMessage>();
      final session = AqutterNativeSession(
        id: 'demo',
        fps: 60,
        onMessage: messages.complete,
        capture: () async => AqutterNativeFrame(
          width: 1,
          height: 1,
          format: AqutterNativeFormat.rgba,
          payload: Uint8List.fromList([9, 8, 7, 255]),
        ),
      );
      host.register(session);
      final endpoint = await host.ensureStarted();
      final socket = await connect(endpoint, 'demo');
      addTearDown(() => socket.close());

      // 一幀是兩則訊息：標頭、像素
      final frameMessages = await socket.take(2).toList();
      expect((frameMessages[0] as List<int>).length, aqutterNativeHeaderLength);
      expect(frameMessages[1], [9, 8, 7, 255]);

      socket.add(jsonEncode({'type': 'tap', 'x': 0.25, 'y': 0.5}));
      final message = await messages.future.timeout(const Duration(seconds: 2));
      expect(message.type, 'tap');
      expect(message.number('x'), 0.25);
      expect(message.number('missing'), isNull);
    });

    test('does not capture while nobody is connected', () async {
      var captures = 0;
      final session = AqutterNativeSession(
        id: 'idle',
        fps: 60,
        capture: () async {
          captures += 1;
          return null;
        },
      );
      host.register(session);
      await host.ensureStarted();
      await Future<void>.delayed(const Duration(milliseconds: 150));
      expect(captures, 0);
    });

    test('restart rebinds with a new endpoint, closes old clients and keeps the sessions streaming', () async {
      final session = AqutterNativeSession(
        id: 'resume',
        fps: 60,
        capture: () async => AqutterNativeFrame(
          width: 1,
          height: 1,
          format: AqutterNativeFormat.rgba,
          payload: Uint8List.fromList([1, 2, 3, 255]),
        ),
      );
      host.register(session);
      final before = await host.ensureStarted();
      final oldSocket = await connect(before, 'resume');
      final closed = Completer<void>();
      oldSocket.listen((_) {}, onDone: closed.complete);

      await host.restart();
      await closed.future.timeout(const Duration(seconds: 2));
      final after = await host.ensureStarted();
      expect(after.token, isNot(before.token));
      expect(host.hasSession('resume'), isTrue);

      final socket = await connect(after, 'resume');
      addTearDown(() => socket.close());
      final frame = await socket.take(2).toList();
      expect(frame[1], [1, 2, 3, 255]);
    });

    test('a per-session maxInFlight (set by the page via a config message) limits unacknowledged frames', () async {
      final session = AqutterNativeSession(
        id: 'inflight',
        fps: 120,
        capture: () async => AqutterNativeFrame(
          width: 1,
          height: 1,
          format: AqutterNativeFormat.rgba,
          payload: Uint8List.fromList([1, 2, 3, 255]),
        ),
      );
      session.maxInFlight = 1;
      host.register(session);
      final endpoint = await host.ensureStarted();
      final socket = await connect(endpoint, 'inflight');
      addTearDown(() => socket.close());
      var messages = 0;
      socket.listen((_) => messages += 1);
      await Future<void>.delayed(const Duration(milliseconds: 300));
      // 一幀是標頭加像素兩則；上限 1，沒有確認就只送一幀
      expect(messages, 2);
      // 網頁把上限調成 3：不必重連，之後最多再送 3 幀（含已送的那一幀共 3）
      socket.add(jsonEncode({'type': 'config', 'maxInFlight': 3}));
      await Future<void>.delayed(const Duration(milliseconds: 300));
      expect(messages, 6);
      expect(session.maxInFlight, 3);
      // 不合法的值被忽略
      socket.add(jsonEncode({'type': 'config', 'maxInFlight': 99}));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(session.maxInFlight, 3);
    });

    test('rejects a wrong token and an unknown session', () async {
      host.register(AqutterNativeSession(id: 'known', capture: () async => null));
      final endpoint = await host.ensureStarted();
      await expectLater(connect(endpoint, 'known', token: 'nope'), throwsA(isA<WebSocketException>()));
      await expectLater(connect(endpoint, 'missing'), throwsA(isA<WebSocketException>()));
    });

    test('a session registered with the same id replaces the old one and keeps its clients', () async {
      var oldCaptures = 0;
      var newCaptures = 0;
      final oldSession = AqutterNativeSession(id: 'swap', fps: 120, capture: () async {
        oldCaptures += 1;
        return null;
      });
      host.register(oldSession);
      final endpoint = await host.ensureStarted();
      final socket = await connect(endpoint, 'swap');
      addTearDown(() => socket.close());
      socket.listen((_) {});
      await Future<void>.delayed(const Duration(milliseconds: 80));
      expect(oldCaptures, greaterThan(0));

      host.register(AqutterNativeSession(id: 'swap', fps: 120, capture: () async {
        newCaptures += 1;
        return null;
      }));
      final oldBefore = oldCaptures;
      await Future<void>.delayed(const Duration(milliseconds: 150));
      expect(newCaptures, greaterThan(0)); // 連線沒斷，新的立刻接手
      expect(oldCaptures, oldBefore);

      host.unregister(oldSession); // 舊的稍後才被 dispose：不能把新的拆掉
      expect(host.hasSession('swap'), isTrue);
    });

    test('stops sending when the client does not acknowledge, and resumes after acks', () async {
      var captures = 0;
      final session = AqutterNativeSession(
        id: 'pressure',
        fps: 120,
        capture: () async {
          captures += 1;
          return AqutterNativeFrame(width: 1, height: 1, format: AqutterNativeFormat.rgba, payload: Uint8List(4));
        },
      );
      host.register(session);
      final endpoint = await host.ensureStarted();
      final socket = await connect(endpoint, 'pressure');
      addTearDown(() => socket.close());
      var messages = 0;
      socket.listen((_) => messages += 1);
      int frames() => messages ~/ 2; // 一幀 = 標頭 + 像素

      await Future<void>.delayed(const Duration(milliseconds: 300));
      expect(frames(), aqutterNativeMaxInFlight);
      // 沒有確認時擷取也停了（最多多一次已在進行中的）
      expect(captures, lessThanOrEqualTo(aqutterNativeMaxInFlight + 1));

      for (var seq = 1; seq <= aqutterNativeMaxInFlight; seq++) {
        socket.add(jsonEncode({'type': 'ack', 'seq': seq}));
      }
      await Future<void>.delayed(const Duration(milliseconds: 300));
      expect(frames(), aqutterNativeMaxInFlight * 2);
    });

    test('pauses capture while every client reports it is hidden, and resumes with a fresh frame', () async {
      var captures = 0;
      final session = AqutterNativeSession(
        id: 'visible',
        fps: 120,
        capture: () async {
          captures += 1;
          return null;
        },
      );
      host.register(session);
      final endpoint = await host.ensureStarted();
      final socket = await connect(endpoint, 'visible');
      addTearDown(() => socket.close());
      socket.listen((_) {});

      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(captures, greaterThan(0));

      socket.add(jsonEncode({'type': 'visibility', 'visible': false}));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      final paused = captures;
      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(captures, paused);

      session.takeDirty(); // 清掉先前的標記，確認恢復時會重新標記
      socket.add(jsonEncode({'type': 'visibility', 'visible': true}));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(captures, greaterThan(paused));
    });

    test('numbers frames in increasing order', () async {
      final seqs = <int>[];
      host.register(AqutterNativeSession(
        id: 'seq',
        fps: 60,
        capture: () async => AqutterNativeFrame(width: 1, height: 1, format: AqutterNativeFormat.rgba, payload: Uint8List(4)),
      ));
      final endpoint = await host.ensureStarted();
      final socket = await connect(endpoint, 'seq');
      addTearDown(() => socket.close());
      final done = Completer<void>();
      var isHeader = true;
      socket.listen((data) {
        if (isHeader) {
          seqs.add(ByteData.sublistView(Uint8List.fromList(data as List<int>)).getUint32(12, Endian.little));
          socket.add(jsonEncode({'type': 'ack', 'seq': seqs.last}));
          if (seqs.length == 5 && !done.isCompleted) {
            done.complete();
          }
        }
        isHeader = !isHeader; // 標頭、像素交替
      });
      await done.future.timeout(const Duration(seconds: 2));
      expect(seqs, [1, 2, 3, 4, 5]);
    });

    test('resize updates the viewport and is not forwarded to onMessage', () async {
      final received = <AqutterNativeMessage>[];
      final session = AqutterNativeSession(id: 'resize', capture: () async => null, onMessage: received.add);
      host.register(session);
      final endpoint = await host.ensureStarted();
      final socket = await connect(endpoint, 'resize');
      addTearDown(() => socket.close());
      socket
        ..add(jsonEncode({'type': 'resize', 'width': 320, 'height': 200, 'dpr': 2}))
        ..add(jsonEncode({'type': 'resize', 'width': -1, 'height': 200, 'dpr': 2}))
        ..add(jsonEncode({'type': 'tap', 'x': 0.5, 'y': 0.5}));
      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(session.viewport, const AqutterNativeViewport(width: 320, height: 200, devicePixelRatio: 2));
      expect(received.map((m) => m.type), ['tap']);
    });

    test('markDirty is consumed once and set again by a new viewport', () {
      final session = AqutterNativeSession(id: 'dirty', capture: () async => null);
      expect(session.takeDirty(), isTrue);
      expect(session.takeDirty(), isFalse);
      session.updateViewport(const AqutterNativeViewport(width: 1, height: 1, devicePixelRatio: 1));
      expect(session.takeDirty(), isTrue);
      session.updateViewport(const AqutterNativeViewport(width: 1, height: 1, devicePixelRatio: 1));
      expect(session.takeDirty(), isFalse);
    });

    test('ignores malformed messages', () async {
      final received = <AqutterNativeMessage>[];
      host.register(AqutterNativeSession(id: 'bad', capture: () async => null, onMessage: received.add));
      final endpoint = await host.ensureStarted();
      final socket = await connect(endpoint, 'bad');
      addTearDown(() => socket.close());
      socket
        ..add('not json')
        ..add(jsonEncode([1, 2]))
        ..add(jsonEncode({'no': 'type'}))
        ..add(jsonEncode({'type': 'ok'}));
      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(received.map((m) => m.type), ['ok']);
    });
  });
}
