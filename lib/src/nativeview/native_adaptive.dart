/// 擷取解析度的政策：移動中的畫面用多高的解析度。停止變動後一律補一張完整解析度的定格幀（`sharp` 本來就是完整解析度）。
///
/// 解析度的決定：基準解析度（網頁元素實際顯示的物理像素，上限 `maxPixelRatio`）乘上這裡決定的倍率。
enum AqutterNativeQuality {
  /// 盡可能快：移動中固定在 `minScale`（預設 0.5，線性，面積約四分之一）。擷取很貴的內容（原生擷取，例如地圖）預設用這個。
  smooth,

  /// 一律清晰：移動中也是基準解析度。每幀大很多（Android 平板全螢幕一幀約 27 MB），幀率會低。
  sharp,

  /// 自適應：依擷取耗時在 `minScale` 與 1.0 之間調整，目標是每幀不超過 `autoBudget`（預設 30 ms）。
  /// 擷取很快的內容（Flutter 自己畫的畫面）預設用這個：夠快就維持完整解析度。
  auto,
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
