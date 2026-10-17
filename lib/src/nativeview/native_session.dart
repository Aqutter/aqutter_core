import 'dart:async';

import 'package:flutter/foundation.dart';

import 'native_frame.dart';
import 'native_stats.dart';

/// 閒置時的低頻輪詢間隔（也是補定格幀等計時事件的最長延遲）。
const Duration _idlePoll = Duration(milliseconds: 100);

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
    this.eventDriven = false,
  }) : assert(fps > 0 && fps <= 120, 'fps must be within 1..120');

  /// 與網頁端 `<aqutter-native session="…">` 一致的識別字。
  final String id;

  final AqutterNativeFrameCapture capture;
  final AqutterNativeMessageHandler? onMessage;

  /// 目標幀率（擷取較慢時實際會更低，不會堆積）。預設 60。
  final int fps;

  /// 擷取來源會在內容改變時呼叫 [wake]（例如 `AqutterNative` 的重繪事件）。
  ///
  /// true：擷取由事件觸發，閒置時不輪詢（只留低頻逾時），事件一到立刻擷取；
  /// false（預設）：以兩倍目標幀率輪詢，適用沒有變動通知的來源（自訂擷取、iOS 的 PlatformView）。
  final bool eventDriven;

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

  /// 閒置時迴圈在這裡等待；內容重繪、新連線、尺寸改變等事件會喚醒它。
  Completer<void>? _wake;

  /// 自上次檢查以來是否有喚醒事件（避免事件發生在迴圈建立等待之前而被漏掉）。
  bool _woken = false;

  /// 單調時鐘與「上一幀開始擷取」的時刻；用來限制擷取不超過目標幀率。
  ///
  /// 從**開始擷取**算起而不是送出完成：擷取本身要花幾毫秒，從送出算起會讓每幀的週期多出擷取耗時。
  final Stopwatch _clock = Stopwatch()..start();
  int _lastFrameStartMicros = -1;
  bool _capturing = false;

  /// 最近一次擷取耗時（毫秒，指數平滑）；供除錯 / 效能觀察。
  double captureMs = 0;

  /// host 連上 / 斷開時呼叫。
  void attachTransport({required void Function(Uint8List header, Uint8List payload) send, required bool Function() canSend}) {
    _send = send;
    _canSend = canSend;
  }

  /// 標記「下一輪必須擷取」：有新連線、解析度改變等不由內容重繪觸發的情況。
  void markDirty() {
    _dirty = true;
    wake();
  }

  /// 喚醒閒置中的擷取迴圈（內容重繪時由擷取來源呼叫）。
  void wake() {
    _woken = true;
    final completer = _wake;
    _wake = null;
    if (completer != null && !completer.isCompleted) {
      completer.complete();
    }
  }

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

  /// 擷取迴圈。
  ///
  /// - [eventDriven]：每輪擷取後先等限速的剩餘時間，再等「內容重繪」的喚醒（或低頻逾時，讓補定格幀等計時事件仍會發生）。
  ///   擷取直接跟著重繪事件走，不會和內容的更新節奏「拍頻」——輪詢頻率若接近內容的重繪頻率（都是 60Hz），
  ///   相位會慢慢漂移，漂到擷取時間點恰好在重繪之前就撲空、晚一輪才補（實測大元素因此漏掉一成到四成的幀）。
  /// - 否則以兩倍目標幀率輪詢（絕對時間表，計時器的超時誤差不會累積；落後就不等，也不補跑落下的幀）。
  /// - 擷取一律以目標幀率為上限（見 [_tick]）。
  Future<void> _run() async {
    final minGapMicros = (1000000 / fps * 0.9).round();
    final poll = Duration(microseconds: 1000000 ~/ (fps * 2));
    final clock = Stopwatch()..start();
    var deadline = Duration.zero;
    while (_visibleClients > 0 && !_disposed) {
      await _tick();
      if (eventDriven) {
        final gate = minGapMicros - (_clock.elapsedMicroseconds - _lastFrameStartMicros);
        if (_lastFrameStartMicros >= 0 && gate > 0) {
          await Future<void>.delayed(Duration(microseconds: gate));
          continue;
        }
        if (_woken) {
          _woken = false;
          await Future<void>.delayed(Duration.zero);
          continue;
        }
        final wake = Completer<void>();
        _wake = wake;
        await Future.any<void>([wake.future, Future<void>.delayed(_idlePoll)]);
        _wake = null;
        continue;
      }
      deadline += poll;
      final now = clock.elapsed;
      if (deadline > now) {
        await Future<void>.delayed(deadline - now);
      }
      else {
        deadline = now;
        // 沒有剩餘時間也要讓出事件迴圈，UI 的畫面才有機會更新
        await Future<void>.delayed(Duration.zero);
      }
    }
    _loopRunning = false;
  }

  bool get hasClients => _clients > 0;

  Future<void> _tick() async {
    // 擷取不超過目標幀率：距離上一幀太近就等下一輪輪詢（輪詢頻率是目標幀率的兩倍）
    if (_lastFrameStartMicros >= 0 && _clock.elapsedMicroseconds - _lastFrameStartMicros < 1000000 / fps * 0.9) {
      return;
    }
    final attemptStartMicros = _clock.elapsedMicroseconds;
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
      _lastFrameStartMicros = attemptStartMicros;
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
