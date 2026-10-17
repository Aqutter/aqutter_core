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
        '${(_bytes / _frames / 1024).toStringAsFixed(0)} KB/frame, ${(_bytes / seconds / 1048576).toStringAsFixed(1)} MB/s | $stages');
    _sums.clear();
    _counts.clear();
    _frames = 0;
    _bytes = 0;
    _window
      ..reset()
      ..start();
  }
}
