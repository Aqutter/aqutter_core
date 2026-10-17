import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('frame encoding', () {
    test('writes a little-endian 20 byte header followed by the payload', () {
      final frame = AqutterNativeFrame(
        width: 3,
        height: 2,
        format: AqutterNativeFormat.rgba,
        payload: Uint8List.fromList([1, 2, 3, 4]),
      );
      final bytes = encodeAqutterNativeFrame(frame, sentAtMs: 1700000000000);
      final view = ByteData.sublistView(bytes);
      expect(bytes.length, aqutterNativeHeaderLength + 4);
      expect(view.getUint32(0, Endian.little), 3);
      expect(view.getUint32(4, Endian.little), 2);
      expect(view.getUint32(8, Endian.little), 1);
      expect(view.getFloat64(12, Endian.little), 1700000000000);
      expect(bytes.sublist(aqutterNativeHeaderLength), [1, 2, 3, 4]);
    });

    test('png uses wire code 0', () {
      expect(AqutterNativeFormat.png.wire, 0);
    });
  });

  group('host and session', () {
    late AqutterNativeHost host;

    setUp(() => host = AqutterNativeHost.instance);
    tearDown(() => host.stop());

    Future<WebSocket> connect(AqutterNativeEndpoint endpoint, String id, {String? token}) {
      return WebSocket.connect('ws://127.0.0.1:${endpoint.port}/mirror/$id?token=${token ?? endpoint.token}');
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

      final first = await socket.first as List<int>;
      expect(first.sublist(aqutterNativeHeaderLength), [9, 8, 7, 255]);

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

    test('rejects a wrong token and an unknown session', () async {
      host.register(AqutterNativeSession(id: 'known', capture: () async => null));
      final endpoint = await host.ensureStarted();
      await expectLater(connect(endpoint, 'known', token: 'nope'), throwsA(isA<WebSocketException>()));
      await expectLater(connect(endpoint, 'missing'), throwsA(isA<WebSocketException>()));
    });

    test('refuses a duplicate session id', () async {
      host.register(AqutterNativeSession(id: 'dup', capture: () async => null));
      expect(() => host.register(AqutterNativeSession(id: 'dup', capture: () async => null)), throwsStateError);
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
