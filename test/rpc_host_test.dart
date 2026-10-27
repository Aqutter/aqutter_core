import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter_test/flutter_test.dart';

class _Client {
  _Client(this.socket) {
    socket.listen(
      (data) {
        final frame = _reassembler.add(Uint8List.fromList(data as List<int>));
        if (frame != null) {
          _frames.add(frame);
        }
      },
      onDone: () => _closed.complete(),
    );
  }

  final AqutterRpcReassembler _reassembler = AqutterRpcReassembler();
  int _partId = 0;

  final WebSocket socket;
  final StreamController<AqutterRpcFrame> _frames = StreamController<AqutterRpcFrame>.broadcast();
  final Completer<void> _closed = Completer<void>();

  Future<void> get closed => _closed.future;

  void call(int id, String name, [Object? payload]) {
    for (final message in encodeAqutterRpcMessages(AqutterRpcFrame(type: AqutterRpcFrameType.call, id: id, name: name, payload: payload), partId: _partId++)) {
      socket.add(message);
    }
  }

  Future<AqutterRpcFrame> next() => _frames.stream.first.timeout(const Duration(seconds: 5));
}

void main() {
  group('AqutterRpcHost', () {
    late AqutterNativeHost nativeHost;
    late AqutterRpcHost rpc;

    setUp(() {
      nativeHost = AqutterNativeHost.instance;
      rpc = AqutterRpcHost(host: nativeHost);
    });
    tearDown(() => nativeHost.stop());

    Future<_Client> connect() async {
      final endpoint = await nativeHost.ensureStarted();
      final socket = await WebSocket.connect('ws://127.0.0.1:${endpoint.port}/channel/$aqutterRpcChannelName?token=${endpoint.token}');
      final client = _Client(socket);
      // 等伺服器端登記好這條連線
      await Future<void>.delayed(const Duration(milliseconds: 50));
      return client;
    }

    test('answers a call with res and fills in an empty payload', () async {
      rpc.registerHandler('t.echo', (payload) async => {'got': payload});
      final client = await connect();
      final reply = client.next();
      client.call(1, 't.echo');
      final frame = await reply;
      expect(frame.type, AqutterRpcFrameType.res);
      expect(frame.id, 1);
      expect(frame.payload, {'got': <String, dynamic>{}});
      await client.socket.close();
    });

    test('moves binary in both directions', () async {
      rpc.registerHandler('t.bin', (payload) async {
        final data = payload['data'] as Uint8List;
        return {'reversed': Uint8List.fromList(data.reversed.toList()), 'length': data.length};
      });
      final client = await connect();
      final reply = client.next();
      client.call(2, 't.bin', {'data': Uint8List.fromList([1, 2, 3])});
      final frame = await reply;
      final result = frame.payload as Map<String, dynamic>;
      expect(result['reversed'], [3, 2, 1]);
      expect(result['length'], 3);
      await client.socket.close();
    });

    test('moves a 4 MiB binary intact', () async {
      rpc.registerHandler('t.big', (payload) async => payload['data']);
      final client = await connect();
      final data = Uint8List(4 * 1024 * 1024)..fillRange(0, 4 * 1024 * 1024, 7);
      data[100000] = 42;
      final reply = client.next();
      client.call(3, 't.big', {'data': data});
      final echoed = (await reply).payload as Uint8List;
      expect(echoed.length, data.length);
      expect(echoed[100000], data[100000]);
      await client.socket.close();
    });

    test('an unknown handler answers HANDLER_NOT_FOUND', () async {
      final client = await connect();
      final reply = client.next();
      client.call(4, 't.nope');
      final frame = await reply;
      expect(frame.type, AqutterRpcFrameType.err);
      expect(frame.errorCode, aqutterRpcHandlerNotFound);
      await client.socket.close();
    });

    test('a throwing handler answers HANDLER_FAILED, a coded one keeps its code', () async {
      rpc.registerHandler('t.boom', (_) async => throw StateError('boom'));
      rpc.registerHandler('t.coded', (_) async => throw const AqutterRpcException('UNSUPPORTED_PLATFORM', 'not here'));
      final client = await connect();
      var reply = client.next();
      client.call(5, 't.boom');
      var frame = await reply;
      expect(frame.errorCode, aqutterRpcHandlerFailed);
      expect(frame.errorMessage, contains('boom'));
      reply = client.next();
      client.call(6, 't.coded');
      frame = await reply;
      expect(frame.errorCode, 'UNSUPPORTED_PLATFORM');
      expect(frame.errorMessage, 'not here');
      await client.socket.close();
    });

    test('handlers run concurrently: a slow call does not block a fast one', () async {
      final release = Completer<void>();
      rpc.registerHandler('t.slow', (_) async {
        await release.future;
        return 'slow';
      });
      rpc.registerHandler('t.fast', (_) async => 'fast');
      final client = await connect();
      client.call(7, 't.slow');
      final first = client.next();
      client.call(8, 't.fast');
      final fastFrame = await first;
      expect(fastFrame.id, 8);
      final second = client.next();
      release.complete();
      expect((await second).id, 7);
      await client.socket.close();
    });

    test('a non-object payload and an unserializable result answer errors', () async {
      rpc.registerHandler('t.obj', (_) async => 1);
      rpc.registerHandler('t.bad', (_) async => Object());
      final client = await connect();
      var reply = client.next();
      client.call(9, 't.obj', [1, 2]);
      var frame = await reply;
      expect(frame.errorCode, aqutterRpcHandlerFailed);
      reply = client.next();
      client.call(10, 't.bad');
      frame = await reply;
      expect(frame.errorCode, aqutterRpcHandlerFailed);
      await client.socket.close();
    });

    test('moves 70 MiB in both directions: the framework splits and reassembles', () async {
      rpc.registerHandler('t.huge', (payload) async => {'data': payload['data'], 'n': (payload['data'] as Uint8List).length});
      final client = await connect();
      final data = Uint8List(70 * 1024 * 1024)..fillRange(0, 70 * 1024 * 1024, 3);
      data[12345] = 42;
      final reply = client.next();
      client.call(11, 't.huge', {'data': data});
      final result = (await reply).payload as Map<String, dynamic>;
      expect(result['n'], data.length);
      expect((result['data'] as Uint8List)[12345], 42);
      expect((result['data'] as Uint8List).length, data.length);
      await client.socket.close();
    });

    test('an event over 64 MiB is split and reassembled too', () async {
      final client = await connect();
      final event = client.next();
      await rpc.emit('t.bigEvent', {'data': Uint8List(66 * 1024 * 1024)});
      final frame = await event;
      expect(frame.channel, 't.bigEvent');
      expect(((frame.payload as Map)['data'] as Uint8List).length, 66 * 1024 * 1024);
      await client.socket.close();
    });

    test('emit reaches the connected page and is dropped when nobody is connected', () async {
      await rpc.emit('t.nothing', {'a': 1});
      expect(rpc.connected, isFalse);
      final client = await connect();
      expect(rpc.connected, isTrue);
      final event = client.next();
      await rpc.emit('t.changed', {'level': 0.5, 'icon': Uint8List.fromList([7])});
      final frame = await event;
      expect(frame.type, AqutterRpcFrameType.evt);
      expect(frame.channel, 't.changed');
      expect((frame.payload as Map)['icon'], [7]);
      await client.socket.close();
      await client.closed;
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(rpc.connected, isFalse);
    });

    test('a new connection replaces the old one', () async {
      final first = await connect();
      final second = await connect();
      await first.closed.timeout(const Duration(seconds: 5));
      expect(first.socket.closeCode, 1000);
      expect(rpc.connected, isTrue);
      rpc.registerHandler('t.ok', (_) async => 'ok');
      final reply = second.next();
      second.call(12, 't.ok');
      expect((await reply).payload, 'ok');
      await second.socket.close();
    });

    test('a malformed frame closes the connection with 1002', () async {
      final client = await connect();
      client.socket.add(Uint8List.fromList([0, 0, 0, 9, 1]));
      await client.closed.timeout(const Duration(seconds: 5));
      expect(client.socket.closeCode, 1002);
    });

    test('a frame that is not a call closes the connection with 1002', () async {
      final client = await connect();
      client.socket.add(encodeAqutterRpcFrame(const AqutterRpcFrame(type: AqutterRpcFrameType.evt, channel: 'x.y')));
      await client.closed.timeout(const Duration(seconds: 5));
      expect(client.socket.closeCode, 1002);
    });

    test('registering a handler again replaces it; unregistering removes it', () async {
      rpc.registerHandler('t.v', (_) async => 1);
      rpc.registerHandler('t.v', (_) async => 2);
      final client = await connect();
      var reply = client.next();
      client.call(13, 't.v');
      expect((await reply).payload, 2);
      rpc.unregisterHandler('t.v');
      expect(rpc.hasHandler('t.v'), isFalse);
      reply = client.next();
      client.call(14, 't.v');
      expect((await reply).errorCode, aqutterRpcHandlerNotFound);
      await client.socket.close();
    });
  });
}
