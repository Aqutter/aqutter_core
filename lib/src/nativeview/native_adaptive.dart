/// 自適應策略：擷取跟不上目標幀率時如何處理。
enum AqutterNativeAdaptive {
  /// 不調整（預設）。畫質固定，擷取慢就是幀率低。
  off,

  /// 持續變動的內容跟不上時降低擷取解析度，停止變動後補一幀完整解析度的定格幀。
  ///
  /// 以降低畫質換流暢：動的時候略糊，靜止時清楚。適合動畫、影片、拖曳中的地圖。
  resolution,
}

/// 依擷取耗時調整解析度倍率（0 < scale ≤ 1，相對於「與網頁元素等面積」的完整解析度）。
///
/// 連續幾幀超過預算才降、連續很多幀都很快才升，並有下限，避免畫質忽高忽低。
class AqutterNativeScaler {
  AqutterNativeScaler({
    this.minScale = 0.5,
    this.step = 0.85,
    this.slowFramesToDegrade = 3,
    this.fastFramesToRecover = 30,
  }) : assert(minScale > 0 && minScale <= 1, 'minScale must be within (0, 1]');

  /// 倍率下限（線性，面積為其平方）。
  final double minScale;

  /// 每次調整乘上或除以的係數。
  final double step;
  final int slowFramesToDegrade;
  final int fastFramesToRecover;

  double scale = 1.0;
  int _slow = 0;
  int _fast = 0;

  /// 記錄一幀（內容有變動的幀）的擷取耗時；[budgetMs] 是每幀可用的時間（約 1000/fps 的 9 成）。
  void record(double captureMs, double budgetMs) {
    if (captureMs > budgetMs) {
      _fast = 0;
      _slow += 1;
      if (_slow >= slowFramesToDegrade && scale > minScale) {
        scale = (scale * step).clamp(minScale, 1.0);
        _slow = 0;
      }
    }
    else if (captureMs < budgetMs * 0.6) {
      _slow = 0;
      _fast += 1;
      if (_fast >= fastFramesToRecover && scale < 1.0) {
        scale = (scale / step).clamp(minScale, 1.0);
        _fast = 0;
      }
    }
    else {
      _slow = 0;
      _fast = 0;
    }
  }
}
