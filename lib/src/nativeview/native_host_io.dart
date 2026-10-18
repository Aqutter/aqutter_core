import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'native_frame.dart';
import 'native_session.dart';

/// 每個連線允許同時未被確認的幀數。
/// 預設的在途幀數。每個工作階段可各自設定（`AqutterNative.maxInFlight`、網頁的 `max-in-flight` 屬性，執行中可改）；
/// `--dart-define=AQUTTER_NATIVE_MAX_INFLIGHT=N` 只改這個預設值。1 沒有排隊、延遲最低但吞吐較低；3 讓擷取與傳輸流水線化。
const int aqutterNativeMaxInFlight = int.fromEnvironment('AQUTTER_NATIVE_MAX_INFLIGHT', defaultValue: 3);

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
/// 網頁回報顯示尺寸的 `{"type":"resize"}`、回報可見性的 `{"type":"visibility","visible":bool}` 由本類別處理，
/// 不會轉給 `onMessage`；所有連線都回報看不到時，工作階段暫停擷取。
class AqutterNativeHost with WidgetsBindingObserver {
  AqutterNativeHost._();

  static final AqutterNativeHost instance = AqutterNativeHost._();

  HttpServer? _server;
  AqutterNativeEndpoint? _endpoint;
  Future<AqutterNativeEndpoint>? _starting;
  bool _observing = false;
  bool _wasBackgrounded = false;

  final Map<String, AqutterNativeSession> _sessions = {};
  final Map<String, Set<WebSocket>> _clients = {};

  /// 每個連線目前未被確認的幀數。
  final Map<WebSocket, int> _inFlight = {};

  /// 網頁回報看不到的連線（預設看得到）。
  final Set<WebSocket> _hidden = {};

  /// 啟動伺服器（冪等）並回傳連線資訊。
  Future<AqutterNativeEndpoint> ensureStarted() {
    final existing = _endpoint;
    if (existing != null) {
      return Future.value(existing);
    }
    return _starting ??= _start();
  }

  Future<AqutterNativeEndpoint> _start() async {
    if (!_observing) {
      _observing = true;
      WidgetsFlutterBinding.ensureInitialized().addObserver(this);
    }
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final random = Random.secure();
    final token = base64UrlEncode(List<int>.generate(24, (_) => random.nextInt(256)));
    _server = server;
    _endpoint = AqutterNativeEndpoint(port: server.port, token: token);
    server.listen(_onRequest);
    debugPrint('[aqutter-native] ws server on ws://127.0.0.1:${server.port}');
    return _endpoint!;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden) {
      _wasBackgrounded = true;
    }
    else if (state == AppLifecycleState.resumed && _wasBackgrounded) {
      _wasBackgrounded = false;
      unawaited(restart());
    }
  }

  /// 重啟伺服器（保留所有工作階段）：以新的埠與令牌重新監聽，並關掉全部既有連線讓網頁重連。
  ///
  /// 螢幕關掉或 App 進背景後，iOS 會讓背景中的 socket 失效（監聽埠壞掉、網頁的連線變成半開），
  /// 兩邊都不會得到錯誤——網頁還以為連著，原生端也等不到它的確認，回到前景就一直沒有畫面。
  /// 網頁每次重連都會重新向 App 要連線資訊，所以換新的埠不影響它。
  Future<void> restart() async {
    final server = _server;
    _server = null;
    _endpoint = null;
    _starting = null;
    await server?.close(force: true);
    for (final sockets in _clients.values) {
      for (final socket in sockets) {
        socket.close(WebSocketStatus.goingAway);
      }
    }
    _clients.clear();
    _inFlight.clear();
    _hidden.clear();
    for (final session in _sessions.values) {
      session.clientCountChanged(0, visible: 0);
    }
    await ensureStarted();
  }

  /// 註冊工作階段。同 id 已存在時，新的**取代**舊的並承接既有的網頁連線（連線不中斷）。
  ///
  /// 不能擲錯：Flutter 重建子樹時（例如 widget 樹上層的型別改變）會先執行新 `State` 的 `initState`，
  /// 之後才 `dispose` 舊的，同一個 id 因此會短暫出現兩次。舊工作階段之後呼叫 [unregister] 時，
  /// 因為已不是登記中的那一個，不會有任何作用。
  void register(AqutterNativeSession session) {
    _sessions[session.id]?.dispose();
    _sessions[session.id] = session;
    session.attachTransport(
      send: (header, payload) => _broadcast(session.id, header, payload),
      canSend: () => _canSend(session.id),
    );
    session.clientCountChanged(_clients[session.id]?.length ?? 0, visible: _visibleCount(session.id));
  }

  void unregister(AqutterNativeSession session) {
    if (_sessions[session.id] != session) {
      return;
    }
    _sessions.remove(session.id);
    session.dispose();
    final sockets = _clients.remove(session.id);
    for (final socket in sockets ?? const <WebSocket>{}) {
      _inFlight.remove(socket);
      _hidden.remove(socket);
      socket.close(WebSocketStatus.goingAway);
    }
  }

  bool hasSession(String id) => _sessions.containsKey(id);

  /// 某個工作階段與其連線的內部狀態（除錯用）。
  Map<String, Object?> diagnostics(String id) => {
        'session': _sessions[id]?.diagnostics(),
        'sockets': [
          for (final socket in _clients[id] ?? const <WebSocket>{}) {'inFlight': _inFlight[socket] ?? 0, 'hidden': _hidden.contains(socket)},
        ],
        'endpointPort': _endpoint?.port,
      };

  bool _canSend(String id) {
    final sockets = _clients[id];
    if (sockets == null || sockets.isEmpty) {
      return true;
    }
    final limit = _sessions[id]?.maxInFlight ?? aqutterNativeMaxInFlight;
    return sockets.any((socket) => (_inFlight[socket] ?? 0) < limit);
  }

  void _broadcast(String id, Uint8List header, Uint8List payload) {
    for (final socket in List<WebSocket>.of(_clients[id] ?? const <WebSocket>{})) {
      final pending = _inFlight[socket] ?? 0;
      if (pending >= (_sessions[id]?.maxInFlight ?? aqutterNativeMaxInFlight)) {
        continue; // 這個連線還沒消化完，丟掉這一幀而不是堆在記憶體
      }
      _inFlight[socket] = pending + 1;
      // 標頭與像素分兩則送（省掉複製）；兩則之間不會插入其他幀，網頁端依序配對
      socket.add(header);
      socket.add(payload);
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
    // 關閉 permessage-deflate：瀏覽器預設會協商壓縮，對每幀數 MB 的原始像素做 zlib 會讓送出一幀多花數倍時間
    final WebSocket socket;
    try {
      socket = await WebSocketTransformer.upgrade(request, compression: CompressionOptions.compressionOff);
    }
    catch (error) {
      debugPrint('[aqutter-native] websocket upgrade failed: $error');
      return;
    }
    final sockets = _clients.putIfAbsent(id, () => <WebSocket>{});
    sockets.add(socket);
    _inFlight[socket] = 0;
    _sessions[id]?.clientCountChanged(sockets.length, visible: _visibleCount(id));
    socket.listen(
      (data) => _onData(id, socket, data),
      onDone: () => _onClosed(id, socket),
      onError: (_) => _onClosed(id, socket),
    );
  }

  void _onClosed(String id, WebSocket socket) {
    // 工作階段已經被取消登記時 _clients[id] 已不存在，但這個連線的狀態仍要清掉，否則每次重新註冊都會留下殘骸
    _inFlight.remove(socket);
    _hidden.remove(socket);
    final sockets = _clients[id];
    if (sockets == null) {
      return;
    }
    sockets.remove(socket);
    _sessions[id]?.clientCountChanged(sockets.length, visible: _visibleCount(id));
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
        case 'config':
          // 網頁端設定：目前只有 maxInFlight（1 到 8）
          final limit = decoded['maxInFlight'];
          if (limit is num && limit >= 1 && limit <= 8) {
            _sessions[id]?.maxInFlight = limit.toInt();
          }
        case 'visibility':
          if (decoded['visible'] == false) {
            _hidden.add(socket);
          }
          else {
            _hidden.remove(socket);
          }
          _sessions[id]?.visibleClientsChanged(_visibleCount(id));
        default:
          _sessions[id]?.handleMessage(AqutterNativeMessage(type, decoded));
      }
    }
    catch (error) {
      debugPrint('[aqutter-native:$id] bad message: $error');
    }
  }

  int _visibleCount(String id) => (_clients[id] ?? const <WebSocket>{}).where((socket) => !_hidden.contains(socket)).length;

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
    if (_observing) {
      _observing = false;
      WidgetsBinding.instance.removeObserver(this);
    }
  }
}
