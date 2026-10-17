import 'package:flutter/foundation.dart';

/// 以 `--dart-define=AQUTTER_NATIVE_STATS=true` 開啟：每 2 秒把各階段平均耗時印到 console，量效能用。
const bool aqutterNativeLogStats = bool.fromEnvironment('AQUTTER_NATIVE_STATS');

/// 擷取管線各階段的耗時統計（毫秒）。關閉時所有方法都是 no-op。
class AqutterNativeStats {
  AqutterNativeStats(this.id);

  final String id;
  final Map<String, double> _sums = {};
  final Map<String, int> _counts = {};
  int _frames = 0;

  /// 目前的自適應解析度倍率（只用於輸出）。
  double scale = 1.0;

  int _ticks = 0;
  int _skippedBusy = 0;
  int _skippedPressure = 0;
  int _skippedUnchanged = 0;
  int _lastPaintCount = -1;
  int _paints = 0;

  /// 一輪計時器觸發的去向（只在開啟統計時計數）。
  void tick({bool busy = false, bool pressure = false}) {
    if (!aqutterNativeLogStats) {
      return;
    }
    _ticks += 1;
    if (busy) {
      _skippedBusy += 1;
    }
    if (pressure) {
      _skippedPressure += 1;
    }
  }

  /// 擷取來源因為內容沒變而跳過這一輪。
  void unchanged() {
    if (aqutterNativeLogStats) {
      _skippedUnchanged += 1;
    }
  }

  /// 目前的重繪次數（累計值）；用來算每秒實際重繪幾次。
  void paintCount(int count) {
    if (!aqutterNativeLogStats) {
      return;
    }
    if (_lastPaintCount >= 0 && count > _lastPaintCount) {
      _paints += count - _lastPaintCount;
    }
    _lastPaintCount = count;
  }
  int _bytes = 0;
  final Stopwatch _window = Stopwatch()..start();

  /// 記錄某個階段的一次耗時。
  void add(String stage, Stopwatch stopwatch) {
    if (!aqutterNativeLogStats) {
      return;
    }
    _sums[stage] = (_sums[stage] ?? 0) + stopwatch.elapsedMicroseconds / 1000;
    _counts[stage] = (_counts[stage] ?? 0) + 1;
  }

  /// 記錄送出一幀。
  void frameSent(int bytes) {
    if (!aqutterNativeLogStats) {
      return;
    }
    _frames += 1;
    _bytes += bytes;
    if (_window.elapsedMilliseconds < 2000) {
      return;
    }
    final seconds = _window.elapsedMilliseconds / 1000;
    final stages = _sums.entries.map((e) => '${e.key}=${(e.value / (_counts[e.key] ?? 1)).toStringAsFixed(1)}ms').join(' ');
    debugPrint('[aqutter-native:$id] ${(_frames / seconds).toStringAsFixed(1)} fps, '
        '${(_bytes / _frames / 1024).toStringAsFixed(0)} KB/frame, ${(_bytes / seconds / 1048576).toStringAsFixed(1)} MB/s | scale=${scale.toStringAsFixed(2)} paints=${(_paints / seconds).toStringAsFixed(1)}/s ticks=$_ticks busy=$_skippedBusy pressure=$_skippedPressure unchanged=$_skippedUnchanged $stages');
    _ticks = 0;
    _skippedBusy = 0;
    _skippedPressure = 0;
    _skippedUnchanged = 0;
    _paints = 0;
    _sums.clear();
    _counts.clear();
    _frames = 0;
    _bytes = 0;
    _window
      ..reset()
      ..start();
  }
}
