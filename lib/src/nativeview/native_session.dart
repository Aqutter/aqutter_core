import 'dart:async';

import 'package:flutter/foundation.dart';

import 'native_frame.dart';

/// 擷取一幀；回 null 表示這一輪沒有可送的畫面（尚未繪製、擷取失敗等）。
typedef AqutterNativeCapture = Future<AqutterNativeFrame?> Function();

/// 網頁端訊息的處理者。
typedef AqutterNativeMessageHandler = void Function(AqutterNativeMessage message);

/// 一個鏡像工作階段：一個被鏡像的對象 + 其擷取迴圈 + 與網頁端的訊息通道。
///
/// 由 `AqutterNativeHost` 依 [id] 對應網頁端的連線。擷取迴圈只在有網頁連線時才跑——
/// 沒人看的畫面不該耗 CPU。
class AqutterNativeSession {
  AqutterNativeSession({
    required this.id,
    required this.capture,
    this.onMessage,
    this.fps = 30,
  }) : assert(fps > 0 && fps <= 120, 'fps must be within 1..120');

  /// 與網頁端 `<aqutter-native session="…">` 一致的識別字。
  final String id;

  final AqutterNativeCapture capture;
  final AqutterNativeMessageHandler? onMessage;

  /// 目標幀率（擷取較慢時實際會更低，不會堆積）。
  final int fps;

  /// 送出一個二進位幀給所有連線；由 host 掛上。
  void Function(Uint8List frame)? _send;

  int _clients = 0;
  Timer? _timer;
  bool _capturing = false;

  /// 最近一次擷取耗時（毫秒，指數平滑）；供除錯 / 效能觀察。
  double captureMs = 0;

  /// host 連上 / 斷開時呼叫。
  void attachTransport(void Function(Uint8List frame) send) {
    _send = send;
  }

  /// 網頁連線數改變。
  void clientCountChanged(int count) {
    _clients = count;
    if (count > 0 && _timer == null) {
      _timer = Timer.periodic(Duration(microseconds: 1000000 ~/ fps), (_) => _tick());
    }
    else if (count == 0) {
      _timer?.cancel();
      _timer = null;
    }
  }

  bool get hasClients => _clients > 0;

  Future<void> _tick() async {
    if (_capturing || _clients == 0) {
      return;
    }
    _capturing = true;
    final stopwatch = Stopwatch()..start();
    try {
      final frame = await capture();
      stopwatch.stop();
      if (frame == null) {
        return;
      }
      final ms = stopwatch.elapsedMicroseconds / 1000;
      captureMs = captureMs == 0 ? ms : captureMs * 0.8 + ms * 0.2;
      _send?.call(encodeAqutterNativeFrame(frame, sentAtMs: DateTime.now().millisecondsSinceEpoch));
    }
    catch (error) {
      debugPrint('[aqutter-mirror:$id] capture failed: $error');
    }
    finally {
      _capturing = false;
    }
  }

  /// 收到網頁端訊息（host 呼叫）。
  void handleMessage(AqutterNativeMessage message) => onMessage?.call(message);

  void dispose() {
    _timer?.cancel();
    _timer = null;
    _send = null;
  }
}
