import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import '../nativeview/native_channel.dart';
import '../nativeview/native_host_io.dart' if (dart.library.js_interop) '../nativeview/native_host_stub.dart';
import 'rpc_frame.dart';

/// handler 的簽章：吃單一 JSON 物件（可含 [Uint8List]），回傳可序列化的結果（可含 [Uint8List]）。
typedef AqutterRpcHandler = Future<dynamic> Function(Map<String, dynamic> payload);

/// 錯誤碼（`err` 訊框的 `e.code`）。
const String aqutterRpcHandlerNotFound = 'HANDLER_NOT_FOUND';
const String aqutterRpcHandlerFailed = 'HANDLER_FAILED';
const String aqutterRpcPayloadTooLarge = 'PAYLOAD_TOO_LARGE';

/// 通道名稱：網頁連 `/channel/aqutter.rpc`。
const String aqutterRpcChannelName = 'aqutter.rpc';

/// handler 以此例外回報有明確錯誤碼的失敗；其他例外一律是 `HANDLER_FAILED`。
class AqutterRpcException implements Exception {
  const AqutterRpcException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => 'AqutterRpcException($code): $message';
}

/// 網頁與 Dart 之間的多工 RPC：呼叫、回應、事件與二進位共用**一條**本機連線。
///
/// 建立在 [AqutterNativeHost] 的通用二進位通道上（通道名 [aqutterRpcChannelName]），
/// 沿用其伺服器與令牌；網頁以 `native_endpoint` 取得埠與令牌後連線。
///
/// 一次頁面載入一條連線；新連線到來時，舊連線以 1000 關閉（最後一條有效）。
/// 事件只送給目前的連線，沒有連線時直接丟棄（不排隊）。
class AqutterRpcHost {
  AqutterRpcHost({AqutterNativeHost? host}) : _host = host ?? AqutterNativeHost.instance {
    try {
      _host.registerChannel(aqutterRpcChannelName, _onConnection);
    }
    on UnsupportedError {
      // Web 平台沒有本機伺服器：RPC 不可用，登錄與 emit 仍可安全呼叫
    }
  }

  /// 預設實例：殼與 plugin 都用它。
  static final AqutterRpcHost instance = AqutterRpcHost();

  final AqutterNativeHost _host;
  final Map<String, AqutterRpcHandler> _handlers = {};
  AqutterChannelConnection? _connection;
  int _nextPartId = 0;

  /// 登錄 [name] 的 handler；同名取代舊的。
  void registerHandler(String name, AqutterRpcHandler handler) => _handlers[name] = handler;

  void unregisterHandler(String name) => _handlers.remove(name);

  bool hasHandler(String name) => _handlers.containsKey(name);

  /// 目前是否有網頁連線。
  bool get connected => _connection != null;

  /// 對目前的連線送出事件 [channel]；沒有連線時略過。
  ///
  /// 酬載無法序列化、或訊框超過上限時拋出（呼叫端的程式錯誤）。
  Future<void> emit(String channel, Object? payload) async {
    final connection = _connection;
    final messages = encodeAqutterRpcMessages(
      AqutterRpcFrame(type: AqutterRpcFrameType.evt, channel: channel, payload: payload),
      partId: _nextPartId++,
    );
    if (connection != null) {
      _send(connection, messages);
    }
  }

  void _send(AqutterChannelConnection connection, List<Uint8List> messages) {
    for (final message in messages) {
      connection.send(message);
    }
  }

  void _onConnection(AqutterChannelConnection connection) {
    _connection?.close(1000, 'replaced');
    _connection = connection;
    final reassembler = AqutterRpcReassembler();
    connection.messages.listen(
      (data) => _onMessage(connection, reassembler, data),
      onError: (Object _) => connection.close(),
    );
    unawaited(
      connection.done.then((_) {
        if (identical(_connection, connection)) {
          _connection = null;
        }
      }),
    );
  }

  void _onMessage(AqutterChannelConnection connection, AqutterRpcReassembler reassembler, Uint8List data) {
    final AqutterRpcFrame? frame;
    try {
      frame = reassembler.add(data);
    }
    on AqutterRpcFormatException catch (error) {
      debugPrint('[aqutter-rpc] bad frame: ${error.message}');
      connection.close(data.length > aqutterRpcMaxFrameBytes ? 1009 : 1002, 'BAD_FRAME');
      return;
    }
    if (frame == null) {
      return;
    }
    if (frame.type != AqutterRpcFrameType.call) {
      connection.close(1002, 'BAD_FRAME');
      return;
    }
    unawaited(_dispatch(connection, frame));
  }

  Future<void> _dispatch(AqutterChannelConnection connection, AqutterRpcFrame frame) async {
    final id = frame.id!;
    final handler = _handlers[frame.name];
    if (handler == null) {
      _sendError(connection, id, aqutterRpcHandlerNotFound, 'No handler registered for "${frame.name}"');
      return;
    }
    final payload = frame.payload;
    if (payload != null && payload is! Map<String, dynamic>) {
      _sendError(connection, id, aqutterRpcHandlerFailed, 'The payload of "${frame.name}" must be an object');
      return;
    }
    final dynamic result;
    try {
      result = await handler((payload as Map<String, dynamic>?) ?? <String, dynamic>{});
    }
    on AqutterRpcException catch (error) {
      _sendError(connection, id, error.code, error.message);
      return;
    }
    catch (error) {
      _sendError(connection, id, aqutterRpcHandlerFailed, '$error');
      return;
    }
    final List<Uint8List> messages;
    try {
      messages = encodeAqutterRpcMessages(AqutterRpcFrame(type: AqutterRpcFrameType.res, id: id, payload: result), partId: _nextPartId++);
    }
    on AqutterRpcFormatException {
      _sendError(connection, id, aqutterRpcPayloadTooLarge, 'The result of "${frame.name}" exceeds the message size limit');
      return;
    }
    catch (error) {
      _sendError(connection, id, aqutterRpcHandlerFailed, 'The result of "${frame.name}" cannot be serialized: $error');
      return;
    }
    _send(connection, messages);
  }

  void _sendError(AqutterChannelConnection connection, int id, String code, String message) {
    connection.send(
      encodeAqutterRpcFrame(
        AqutterRpcFrame(type: AqutterRpcFrameType.err, id: id, errorCode: code, errorMessage: message),
      ),
    );
  }
}
