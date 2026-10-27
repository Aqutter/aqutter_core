import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('binary channel', () {
    late AqutterNativeHost host;

    setUp(() => host = AqutterNativeHost.instance);
    tearDown(() => host.stop());

    Future<WebSocket> connect(AqutterNativeEndpoint endpoint, String path, {String? token}) {
      final query = token ?? endpoint.token;
      return WebSocket.connect('ws://127.0.0.1:${endpoint.port}/$path?token=$query');
    }

    Future<WebSocket> openChannel(AqutterNativeEndpoint endpoint, String name) => connect(endpoint, 'channel/$name');

    test('rejects an unregistered name and a wrong token with 403', () async {
      final endpoint = await host.ensureStarted();
      host.registerChannel('bench.echo', (_) {});
      await expectLater(openChannel(endpoint, 'bench.other'), throwsA(isA<WebSocketException>()));
      await expectLater(connect(endpoint, 'channel/bench.echo', token: 'wrong'), throwsA(isA<WebSocketException>()));
    });

    test('rejects a malformed channel name when registering', () {
      for (final name in ['echo', 'Bench.echo', 'bench.Echo', 'bench.echo.x', 'bench.', '.echo']) {
        expect(() => host.registerChannel(name, (_) {}), throwsArgumentError, reason: name);
      }
    });

    test('echoes binary messages in both directions', () async {
      final endpoint = await host.ensureStarted();
      host.registerChannel('bench.echo', (connection) {
        connection.messages.listen((data) {
          connection.send(Uint8List.fromList([...data, 0xff]));
        });
      });
      final socket = await openChannel(endpoint, 'bench.echo');
      final reply = socket.first;
      socket.add(Uint8List.fromList([1, 2, 3]));
      expect(await reply, [1, 2, 3, 0xff]);
      await socket.close();
    });

    test('moves a large binary message intact', () async {
      final endpoint = await host.ensureStarted();
      host.registerChannel('bench.echo', (connection) {
        connection.messages.listen(connection.send);
      });
      final socket = await openChannel(endpoint, 'bench.echo');
      final payload = Uint8List(2 * 1024 * 1024);
      for (var i = 0; i < payload.length; i++) {
        payload[i] = i % 251;
      }
      final reply = socket.first;
      socket.add(payload);
      final received = await reply as List<int>;
      expect(received.length, payload.length);
      expect(received[1000], payload[1000]);
      expect(received.last, payload.last);
      await socket.close();
    });

    test('ignores text messages', () async {
      final endpoint = await host.ensureStarted();
      final received = <Uint8List>[];
      host.registerChannel('bench.sink', (connection) {
        connection.messages.listen(received.add);
      });
      final socket = await openChannel(endpoint, 'bench.sink');
      socket.add('hello');
      socket.add(Uint8List.fromList([7]));
      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(received, [Uint8List.fromList([7])]);
      await socket.close();
    });

    test('buffers messages that arrive before the handler listens', () async {
      final endpoint = await host.ensureStarted();
      final received = Completer<List<int>>();
      host.registerChannel('bench.late', (connection) {
        Future<void>.delayed(const Duration(milliseconds: 100), () {
          connection.messages.first.then(received.complete);
        });
      });
      final socket = await openChannel(endpoint, 'bench.late');
      socket.add(Uint8List.fromList([9, 9]));
      expect(await received.future.timeout(const Duration(seconds: 5)), [9, 9]);
      await socket.close();
    });

    test('completes done when the web side closes', () async {
      final endpoint = await host.ensureStarted();
      final done = Completer<void>();
      host.registerChannel('bench.close', (connection) {
        connection.done.then((_) => done.complete());
      });
      final socket = await openChannel(endpoint, 'bench.close');
      await socket.close();
      await done.future.timeout(const Duration(seconds: 5));
    });

    test('closes the connection from the Dart side with the given code', () async {
      final endpoint = await host.ensureStarted();
      host.registerChannel('bench.kick', (connection) {
        connection.close(WebSocketStatus.normalClosure, 'bye');
      });
      final socket = await openChannel(endpoint, 'bench.kick');
      await socket.drain<void>();
      expect(socket.closeCode, WebSocketStatus.normalClosure);
      expect(socket.closeReason, 'bye');
    });

    test('unregisterChannel closes the live connections with 1001', () async {
      final endpoint = await host.ensureStarted();
      final connected = Completer<void>();
      host.registerChannel('bench.gone', (_) => connected.complete());
      final socket = await openChannel(endpoint, 'bench.gone');
      await connected.future;
      host.unregisterChannel('bench.gone');
      await socket.drain<void>();
      expect(socket.closeCode, WebSocketStatus.goingAway);
      expect(host.hasChannel('bench.gone'), isFalse);
      await expectLater(openChannel(endpoint, 'bench.gone'), throwsA(isA<WebSocketException>()));
    });

    test('registering the same name again sends new connections to the new handler', () async {
      final endpoint = await host.ensureStarted();
      host.registerChannel('bench.swap', (connection) => connection.send(Uint8List.fromList([1])));
      host.registerChannel('bench.swap', (connection) => connection.send(Uint8List.fromList([2])));
      final socket = await openChannel(endpoint, 'bench.swap');
      expect(await socket.first, [2]);
      await socket.close();
    });

    test('a throwing handler closes the connection with 1011', () async {
      final endpoint = await host.ensureStarted();
      host.registerChannel('bench.boom', (_) => throw StateError('boom'));
      final socket = await openChannel(endpoint, 'bench.boom');
      await socket.drain<void>();
      expect(socket.closeCode, WebSocketStatus.internalServerError);
    });

    test('restart closes the channel connections and the new endpoint works', () async {
      final endpoint = await host.ensureStarted();
      host.registerChannel('bench.restart', (connection) => connection.send(Uint8List.fromList([5])));
      final first = await openChannel(endpoint, 'bench.restart');
      final firstReply = Completer<List<int>>();
      final firstClosed = Completer<void>();
      first.listen((data) => firstReply.complete(data as List<int>), onDone: firstClosed.complete);
      expect(await firstReply.future, [5]);
      await host.restart();
      await firstClosed.future.timeout(const Duration(seconds: 5), onTimeout: () => fail('old connection stayed open'));
      expect(first.closeCode, WebSocketStatus.goingAway);
      final fresh = await host.ensureStarted();
      final second = await openChannel(fresh, 'bench.restart');
      expect(await second.first, [5]);
      await second.close();
    });

    test('the mirror path is unaffected: an unknown session is still refused', () async {
      final endpoint = await host.ensureStarted();
      host.registerChannel('bench.echo', (_) {});
      await expectLater(connect(endpoint, 'native/unknown'), throwsA(isA<WebSocketException>()));
    });
  });
}
