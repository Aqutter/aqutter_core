import 'dart:async';

import 'package:flutter/foundation.dart';

import 'native_frame.dart';
import 'native_stats.dart';

/// 擷取一幀；回 null 表示這一輪沒有可送的畫面（尚未繪製、擷取失敗等）。
typedef AqutterNativeFrameCapture = Future<AqutterNativeFrame?> Function();

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
    this.fps = 60,
  }) : assert(fps > 0 && fps <= 120, 'fps must be within 1..120');

  /// 與網頁端 `<aqutter-native session="…">` 一致的識別字。
  final String id;

  final AqutterNativeFrameCapture capture;
  final AqutterNativeMessageHandler? onMessage;

  /// 目標幀率（擷取較慢時實際會更低，不會堆積）。預設 60。
  final int fps;

  /// 送出一個二進位幀給所有連線；由 host 掛上。
  void Function(Uint8List header, Uint8List payload)? _send;

  /// 是否有任何連線還能接收新幀（未確認的幀沒超過上限）；由 host 掛上。
  bool Function()? _canSend;

  int _clients = 0;

  /// 各階段耗時統計（`AQUTTER_NATIVE_STATS` 開啟時才記錄）。
  late final AqutterNativeStats stats = AqutterNativeStats(id);

  /// 網頁端回報「看得到」的連線數；沒有任何看得到的連線時暫停擷取（元素被捲出畫面、分頁隱藏等）。
  int _visibleClients = 0;
  int _seq = 0;
  bool _dirty = true;

  /// 網頁端最近回報的顯示尺寸；尚未回報為 null。
  AqutterNativeViewport? viewport;
  bool _loopRunning = false;
  bool _disposed = false;
  bool _capturing = false;

  /// 最近一次擷取耗時（毫秒，指數平滑）；供除錯 / 效能觀察。
  double captureMs = 0;

  /// host 連上 / 斷開時呼叫。
  void attachTransport({required void Function(Uint8List header, Uint8List payload) send, required bool Function() canSend}) {
    _send = send;
    _canSend = canSend;
  }

  /// 標記「下一輪必須擷取」：有新連線、解析度改變等不由內容重繪觸發的情況。
  void markDirty() => _dirty = true;

  /// 取走並清除 [markDirty] 的標記；供擷取來源判斷這一輪是否可以跳過。
  bool takeDirty() {
    final dirty = _dirty;
    _dirty = false;
    return dirty;
  }

  /// 網頁端回報顯示尺寸（host 呼叫）。尺寸改變時下一輪會重新擷取。
  void updateViewport(AqutterNativeViewport next) {
    if (viewport == next) {
      return;
    }
    viewport = next;
    markDirty();
  }

  /// 網頁連線數改變。新連線預設為「看得到」，直到它回報 `visibility`。
  void clientCountChanged(int count, {int? visible}) {
    if (count > _clients) {
      markDirty();
    }
    _clients = count;
    final nextVisible = visible ?? count;
    if (nextVisible > _visibleClients) {
      markDirty(); // 重新看得到時第一幀要立刻有
    }
    _visibleClients = nextVisible;
    _syncTimer();
  }

  /// 看得到的連線數改變（網頁回報 `visibility`）。
  void visibleClientsChanged(int visible) {
    if (visible > _visibleClients) {
      markDirty();
    }
    _visibleClients = visible;
    _syncTimer();
  }

  /// 有看得到的連線才跑擷取迴圈：沒人看到的畫面不該耗 CPU。
  void _syncTimer() {
    if (_visibleClients > 0 && !_loopRunning && !_disposed) {
      _loopRunning = true;
      unawaited(_run());
    }
  }

  /// 擷取迴圈：做完一輪就立刻排下一輪，只在比目標間隔快時才補等。
  ///
  /// 不用固定週期的 `Timer.periodic`：擷取加送出若剛好略超過一個間隔（例如 60 fps 的 16.6ms 對上 16.8ms），
  /// 週期計時器會錯過下一個 tick、被迫等到再下一個，幀率被量化成 60 / 30 的混合（實機量到約 46 fps）。
  Future<void> _run() async {
    final interval = Duration(microseconds: 1000000 ~/ fps);
    final stopwatch = Stopwatch();
    while (_visibleClients > 0 && !_disposed) {
      stopwatch
        ..reset()
        ..start();
      await _tick();
      final remaining = interval - stopwatch.elapsed;
      // 沒有剩餘時間也要讓出事件迴圈，UI 的畫面才有機會更新
      await Future<void>.delayed(remaining > Duration.zero ? remaining : Duration.zero);
    }
    _loopRunning = false;
  }

  bool get hasClients => _clients > 0;

  Future<void> _tick() async {
    // 沒人看、或所有連線都來不及處理（未確認的幀太多）時不擷取：多送只會在對方堆積
    final pressure = !(_canSend?.call() ?? true);
    stats.tick(busy: _capturing, pressure: pressure);
    if (_capturing || _clients == 0 || pressure) {
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
      stats.add('capture', stopwatch);
      final ms = stopwatch.elapsedMicroseconds / 1000;
      captureMs = captureMs == 0 ? ms : captureMs * 0.8 + ms * 0.2;
      _seq += 1;
      final header = encodeAqutterNativeFrameHeader(frame, seq: _seq, sentAtMs: DateTime.now().millisecondsSinceEpoch);
      final sendWatch = Stopwatch()..start();
      _send?.call(header, frame.payload);
      stats.add('send', sendWatch);
      stats.frameSent(header.length + frame.payload.length);
    }
    catch (error) {
      debugPrint('[aqutter-native:$id] capture failed: $error');
    }
    finally {
      _capturing = false;
    }
  }

  /// 收到網頁端訊息（host 呼叫）。
  void handleMessage(AqutterNativeMessage message) => onMessage?.call(message);

  void dispose() {
    _disposed = true;
    _send = null;
    _canSend = null;
  }
}
