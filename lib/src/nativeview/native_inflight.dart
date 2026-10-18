/// 自動調節每個連線的在途（已送出、未確認）幀數。
///
/// 做法是探測：依序各試一段時間（先 3，再 1，必要時 2），比較實際送出的幀率，選「幀率不明顯下降的最小值」。
/// 在途越少延遲越低（沒有排隊），但傳輸有空檔，傳輸受限的中小幀內容幀率會掉；擷取受限的內容（例如地圖）每個值幀率都一樣，
/// 會選到 1。選定後維持一段時間再重新探測。內容靜止（幀率趨近 0）時不探測，沿用目前的值。
///
/// 純邏輯、不碰時間與平台，呼叫端每秒左右呼叫 [onTick]，所以可以用假時鐘測試。
class AqutterNativeInFlightController {
  AqutterNativeInFlightController({
    this.probe = const Duration(seconds: 3),
    this.hold = const Duration(seconds: 30),
    this.lowestAcceptable = 0.9,
    this.middleAcceptable = 0.95,
    this.minFps = 2,
  });

  /// 每個候選值試多久。
  final Duration probe;

  /// 選定後維持多久再重新探測。
  final Duration hold;

  /// 在途 1 的幀率至少要達到在途 3 的多少比例才採用 1。
  final double lowestAcceptable;

  /// 在途 2 的幀率至少要達到在途 3 的多少比例才採用 2。
  final double middleAcceptable;

  /// 低於這個幀率視為靜止，不探測。
  final double minFps;

  /// 目前應套用的在途幀數。
  int get current => _current;

  int _current = 3;
  _Phase _phase = _Phase.measureThree;
  Duration _phaseStart = Duration.zero;
  int _framesAtPhaseStart = 0;
  double _fpsThree = 0;
  double _fpsOne = 0;
  bool _started = false;

  /// 呼叫端定期呼叫：[now] 是單調時間，[framesSent] 是這個工作階段累計送出的幀數。回傳目前應套用的在途幀數。
  int onTick(Duration now, int framesSent) {
    if (!_started) {
      _started = true;
      _begin(_Phase.measureThree, 3, now, framesSent);
      return _current;
    }
    final elapsed = now - _phaseStart;
    switch (_phase) {
      case _Phase.hold:
        if (elapsed >= hold) {
          _begin(_Phase.measureThree, 3, now, framesSent);
        }
      case _Phase.measureThree:
        if (elapsed >= probe) {
          _fpsThree = _fps(elapsed, framesSent);
          if (_fpsThree < minFps) {
            _begin(_Phase.hold, _current, now, framesSent); // 靜止：不探測，稍後再看
          }
          else {
            _begin(_Phase.measureOne, 1, now, framesSent);
          }
        }
      case _Phase.measureOne:
        if (elapsed >= probe) {
          _fpsOne = _fps(elapsed, framesSent);
          if (_fpsOne >= _fpsThree * lowestAcceptable) {
            _begin(_Phase.hold, 1, now, framesSent);
          }
          else {
            _begin(_Phase.measureTwo, 2, now, framesSent);
          }
        }
      case _Phase.measureTwo:
        if (elapsed >= probe) {
          final fpsTwo = _fps(elapsed, framesSent);
          _begin(_Phase.hold, fpsTwo >= _fpsThree * middleAcceptable ? 2 : 3, now, framesSent);
        }
    }
    return _current;
  }

  double _fps(Duration elapsed, int framesSent) {
    final seconds = elapsed.inMicroseconds / Duration.microsecondsPerSecond;
    return seconds <= 0 ? 0 : (framesSent - _framesAtPhaseStart) / seconds;
  }

  void _begin(_Phase phase, int window, Duration now, int framesSent) {
    _phase = phase;
    _current = window;
    _phaseStart = now;
    _framesAtPhaseStart = framesSent;
  }
}

enum _Phase { measureThree, measureOne, measureTwo, hold }
