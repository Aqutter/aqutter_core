import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import 'native_frame.dart';
import 'native_session.dart';

/// 每個連線允許同時未被確認的幀數。
const int aqutterNativeMaxInFlight = 2;

/// 網頁端連線所需的資訊；由 App 以 bridge 交給網頁。
class AqutterNativeEndpoint {
  const AqutterNativeEndpoint({required this.port, required this.token});

  final int port;

  /// 本次啟動產生的隨機令牌。localhost 上的任何行程都連得到埠，令牌讓其他程式無法冒連。
  final String token;

  Map<String, Object> toJson() => {'port': port, 'token': token};
}

/// 內嵌的 localhost WebSocket 伺服器：把各 [AqutterNativeSession] 的幀送給網頁，並把網頁訊息送回。
///
/// 連線路徑：`ws://127.0.0.1:<port>/native/<sessionId>?token=<token>`。
/// 單例；第一次 [ensureStarted] 時以暫時埠啟動。
///
/// 流量控制：每個連線最多同時有 [aqutterNativeMaxInFlight] 幀未被確認；網頁每處理完（畫出或丟棄）
/// 一幀就回 `{"type":"ack"}`。超過上限時不再送新幀給該連線，所有連線都滿時工作階段也不再擷取。
/// 網頁回報顯示尺寸的 `{"type":"resize"}` 由本類別處理，不會轉給 `onMessage`。
class AqutterNativeHost {
  AqutterNativeHost._();

  static final AqutterNativeHost instance = AqutterNativeHost._();

  HttpServer? _server;
  AqutterNativeEndpoint? _endpoint;
  Future<AqutterNativeEndpoint>? _starting;

  final Map<String, AqutterNativeSession> _sessions = {};
  final Map<String, Set<WebSocket>> _clients = {};

  /// 每個連線目前未被確認的幀數。
  final Map<WebSocket, int> _inFlight = {};

  /// 啟動伺服器（冪等）並回傳連線資訊。
  Future<AqutterNativeEndpoint> ensureStarted() {
    final existing = _endpoint;
    if (existing != null) {
      return Future.value(existing);
    }
    return _starting ??= _start();
  }

  Future<AqutterNativeEndpoint> _start() async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final random = Random.secure();
    final token = base64UrlEncode(List<int>.generate(24, (_) => random.nextInt(256)));
    _server = server;
    _endpoint = AqutterNativeEndpoint(port: server.port, token: token);
    server.listen(_onRequest);
    debugPrint('[aqutter-native] ws server on ws://127.0.0.1:${server.port}');
    return _endpoint!;
  }

  /// 註冊工作階段；同 id 已存在會拋 [StateError]（兩個被鏡像的對象不能共用一個畫面）。
  void register(AqutterNativeSession session) {
    if (_sessions.containsKey(session.id)) {
      throw StateError('Native session "${session.id}" is already registered');
    }
    _sessions[session.id] = session;
    session.attachTransport(
      send: (frame) => _broadcast(session.id, frame),
      canSend: () => _canSend(session.id),
    );
    session.clientCountChanged(_clients[session.id]?.length ?? 0);
  }

  void unregister(AqutterNativeSession session) {
    if (_sessions[session.id] != session) {
      return;
    }
    _sessions.remove(session.id);
    session.dispose();
    final sockets = _clients.remove(session.id);
    for (final socket in sockets ?? const <WebSocket>{}) {
      socket.close(WebSocketStatus.goingAway);
    }
  }

  bool hasSession(String id) => _sessions.containsKey(id);

  bool _canSend(String id) {
    final sockets = _clients[id];
    if (sockets == null || sockets.isEmpty) {
      return true;
    }
    return sockets.any((socket) => (_inFlight[socket] ?? 0) < aqutterNativeMaxInFlight);
  }

  void _broadcast(String id, Uint8List frame) {
    for (final socket in List<WebSocket>.of(_clients[id] ?? const <WebSocket>{})) {
      final pending = _inFlight[socket] ?? 0;
      if (pending >= aqutterNativeMaxInFlight) {
        continue; // 這個連線還沒消化完，丟掉這一幀而不是堆在記憶體
      }
      _inFlight[socket] = pending + 1;
      socket.add(frame);
    }
  }

  Future<void> _onRequest(HttpRequest request) async {
    final endpoint = _endpoint;
    final segments = request.uri.pathSegments;
    final valid = endpoint != null
        && WebSocketTransformer.isUpgradeRequest(request)
        && segments.length == 2
        && segments[0] == 'native'
        && request.uri.queryParameters['token'] == endpoint.token
        && _sessions.containsKey(segments[1]);
    if (!valid) {
      request.response.statusCode = HttpStatus.forbidden;
      await request.response.close();
      return;
    }
    final id = segments[1];
    final socket = await WebSocketTransformer.upgrade(request);
    final sockets = _clients.putIfAbsent(id, () => <WebSocket>{});
    sockets.add(socket);
    _inFlight[socket] = 0;
    _sessions[id]?.clientCountChanged(sockets.length);
    socket.listen(
      (data) => _onData(id, socket, data),
      onDone: () => _onClosed(id, socket),
      onError: (_) => _onClosed(id, socket),
    );
  }

  void _onClosed(String id, WebSocket socket) {
    final sockets = _clients[id];
    if (sockets == null) {
      return;
    }
    sockets.remove(socket);
    _inFlight.remove(socket);
    _sessions[id]?.clientCountChanged(sockets.length);
  }

  void _onData(String id, WebSocket socket, dynamic data) {
    if (data is! String) {
      return;
    }
    try {
      final decoded = jsonDecode(data);
      if (decoded is! Map<String, dynamic>) {
        return;
      }
      final type = decoded['type'];
      if (type is! String) {
        return;
      }
      switch (type) {
        case 'ack':
          final pending = _inFlight[socket];
          if (pending != null && pending > 0) {
            _inFlight[socket] = pending - 1;
          }
        case 'resize':
          _applyResize(id, decoded);
        default:
          _sessions[id]?.handleMessage(AqutterNativeMessage(type, decoded));
      }
    }
    catch (error) {
      debugPrint('[aqutter-native:$id] bad message: $error');
    }
  }

  void _applyResize(String id, Map<String, dynamic> message) {
    final width = message['width'];
    final height = message['height'];
    final ratio = message['dpr'];
    if (width is! num || height is! num || ratio is! num || width <= 0 || height <= 0 || ratio <= 0) {
      return;
    }
    _sessions[id]?.updateViewport(AqutterNativeViewport(
      width: width.toDouble(),
      height: height.toDouble(),
      devicePixelRatio: ratio.toDouble(),
    ));
  }

  /// 關閉伺服器並清掉所有工作階段（測試或 App 結束時用）。
  Future<void> stop() async {
    for (final session in List<AqutterNativeSession>.of(_sessions.values)) {
      unregister(session);
    }
    await _server?.close(force: true);
    _server = null;
    _endpoint = null;
    _starting = null;
  }
}
