import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'native_adaptive.dart';
import 'native_frame.dart';
import 'native_host_io.dart' if (dart.library.js_interop) 'native_host_stub.dart';
import 'native_pointer.dart';
import 'native_session.dart';
import 'native_capture.dart';

/// 把 [child] 鏡像到網頁的 `<aqutter-native session="[sessionId]">`。
///
/// [child] 照常在 Flutter 裡渲染（通常放在 WebView 之下，由網頁蓋住），本元件每隔一段時間擷取其畫面、
/// 經 localhost WebSocket 送給網頁畫進 canvas；網頁端的手勢與指令以 [onMessage] 回來，由 App 套用到 [child]
/// 的狀態。這讓網頁能在原生內容（地圖、Flutter 自繪元件）**之上**疊 HTML / 做 z-index。
///
/// 擷取方式：預設用 [RepaintBoundary] 擷取（只適用純 Flutter 內容；Texture 與 PlatformView 擷取不到，改用 [captureOverride]）；
/// iOS 的 PlatformView 需設 [nativeCapture] 走 `drawHierarchy`。
class AqutterNative extends StatefulWidget {
  const AqutterNative({
    super.key,
    required this.sessionId,
    required this.child,
    this.onMessage,
    this.fps = 60,
    this.pixelRatio = 1.5,
    this.maxPixelRatio = 3.0,
    this.skipUnchanged = true,
    this.adaptive = AqutterNativeAdaptive.off,
    this.minScale = 0.5,
    this.settleDelay = const Duration(milliseconds: 250),
    this.format = AqutterNativeFormat.rgba,
    this.nativeCapture = false,
    this.nativeJpegQuality,
    this.nativeSettleJpegQuality,
    this.nativeMaxDuty,
    this.nativeViewTypeContains,
    this.matchViewportAspect = false,
    this.injectPointers = false,
    this.captureOverride,
  });

  /// 與網頁端 `session` 屬性一致；同時掛了兩個相同 id 時，後掛上的取代先掛上的。
  final String sessionId;
  final Widget child;
  final AqutterNativeMessageHandler? onMessage;
  final int fps;

  /// 網頁尚未回報顯示尺寸前使用的擷取倍率（logical → pixel）。
  ///
  /// 網頁回報顯示尺寸後（`<aqutter-native>` 會自動回報），改依「網頁實際需要多少像素」擷取，
  /// 不再使用本值；調低換 fps、調高換畫質只在回報前有效。
  final double pixelRatio;

  /// 依網頁尺寸擷取時的倍率上限，避免高密度螢幕上把畫面擷取得比原生內容還細。
  final double maxPixelRatio;

  /// 擷取跟不上目標幀率時的處理方式，見 [AqutterNativeAdaptive]。預設關閉。
  final AqutterNativeAdaptive adaptive;

  /// [AqutterNativeAdaptive.resolution] 的解析度倍率下限（線性）。
  final double minScale;

  /// 內容停止變動多久後補一幀完整解析度的定格幀（僅在目前解析度低於完整時）。
  final Duration settleDelay;

  /// 內容沒有重繪時跳過擷取（閒置時不耗 CPU 與頻寬）。
  ///
  /// 以 `RepaintBoundary` 擷取時才有效；[nativeCapture]（PlatformView）的內容變化 Flutter 看不到，
  /// 一律每輪擷取。內容若是以 Flutter 之外的方式改變（例如 texture 外部更新），請設為 false。
  final bool skipUnchanged;
  final AqutterNativeFormat format;

  /// 以原生方式擷取（Texture 與 PlatformView 用，如地圖）：iOS 用 `drawHierarchy`，Android 用 `PixelCopy`；其他平台忽略。
  final bool nativeCapture;

  /// 原生擷取時，畫面在動的幀壓成 JPEG 的品質（0 到 1）；`null`（預設）依平台決定：iOS 用 0.85、其他平台傳未壓縮的 RGBA；0 以下明確關閉壓縮。
  /// Android 的 JPEG 是軟體編碼（每幀約 20 到 30 ms），平板實測比傳 7 MB 未壓縮的幀還慢（9 到 14 fps 對 14 到 18 fps），
  /// 而且未壓縮沒有壓縮痕跡；iOS 的 JPEG 是硬體編碼（約 1 到 6 ms），並讓每幀從數 MB 降到數百 KB，主執行緒才不會被擠爆。
  /// 停下來補的定格幀用 [nativeSettleJpegQuality]（預設同樣依平台：iOS 0.92，其他平台未壓縮）。
  final double? nativeJpegQuality;

  /// 畫面停下來補的定格幀的 JPEG 品質；`null`（預設）依平台決定：iOS 0.92、其他平台傳未壓縮的 RGBA。
  final double? nativeSettleJpegQuality;

  /// 原生擷取佔用主執行緒的上限（0 到 1，擷取耗時占的比例）。擷取在主執行緒做（iOS `drawHierarchy` 一次約 40 ms），
  /// 連續擷取會把主執行緒吃滿，觸控與網頁的繪製都被拖慢（實機量到網頁每秒卡一次、輸入延遲達數秒）。
  /// 每次擷取後多等 `耗時 × (1/上限 − 1)` 才進行下一次。`null`：iOS 預設 0.7，其他平台不限制。
  final double? nativeMaxDuty;

  /// 原生擷取時，優先直接擷取類名含此字串的 view（例如 `GMSMapView`）。
  final String? nativeViewTypeContains;

  /// 讓 [child] 的長寬比跟網頁元素一致（在可用空間內置中、等比放大到最大）。
  ///
  /// 預設關閉：[child] 填滿可用空間，網頁元素比例不同時會被縮放／裁切（`fit`）。
  /// 開啟後擷取的每個像素都對應網頁上實際會看到的內容，幀更小、不會有被裁掉的部分；
  /// 網頁回報尺寸前維持填滿。
  final bool matchViewportAspect;

  /// 把網頁轉送來的原始指標事件（`<aqutter-native input="pointers">`）注入 [child]，
  /// 讓 [child] 直接用標準的 `GestureDetector`、`ScaleGestureRecognizer` 或地圖手勢，
  /// 與原生 Flutter App 的行為一致（連點、長按、多指縮放都由 Flutter 自己判斷）。
  ///
  /// 預設關閉。開啟後 `pointer` 訊息仍會經 [onMessage] 通知。滑鼠與觸控筆以觸控注入。
  final bool injectPointers;

  /// 自訂畫面來源，取代內建的 `RepaintBoundary`／原生擷取。
  ///
  /// `RepaintBoundary.toImage` 抓不到 Texture 與 PlatformView 的內容（Android 上的地圖就是透明的）；
  /// 這類內容若有自己的快照 API（例如 `GoogleMapController.takeSnapshot`），用這個參數把快照包成幀回傳。
  /// 使用後 [skipUnchanged]、[adaptive]、[pixelRatio] 都不再作用（畫面來源完全由呼叫端決定），
  /// 擷取迴圈改成依 [fps] 輪詢；回傳 null 代表這一輪沒有新畫面。
  final AqutterNativeFrameCapture? captureOverride;

  @override
  State<AqutterNative> createState() => _AqutterNativeState();
}

class _AqutterNativeState extends State<AqutterNative> {
  final GlobalKey _boundaryKey = GlobalKey();
  AqutterNativeSession? _session;
  final AqutterNativePointerInjector _pointers = AqutterNativePointerInjector();

  /// 上一次擷取時的重繪次數；沒變代表畫面沒變。
  int _lastPaintCount = -1;

  late AqutterNativeScaler _scaler = AqutterNativeScaler(minScale: widget.minScale);
  final Stopwatch _sinceChange = Stopwatch()..start();
  bool _settled = true;

  /// 原生擷取連續「畫面沒變」的次數。原生擷取（drawHierarchy）在主執行緒做，一次要幾十毫秒，
  /// 靜止的地圖也每 1/fps 秒擷取一次會把主執行緒吃滿，連觸控都被拖慢（實機量到輸入延遲達數秒）。
  int _unchangedStreak = 0;
  int _backoffTick = 0;
  int _compareTick = 0;
  int _nativeFrames = 0;
  int _nativeUnchanged = 0;
  int _nativeBackoff = 0;

  /// 連續多少次沒變之後開始降頻，以及降頻後每幾次輪詢才真的擷取一次。
  static const int _backoffAfter = 30;
  static const int _backoffEvery = 6;

  @override
  void initState() {
    super.initState();
    _register();
  }

  @override
  void didUpdateWidget(AqutterNative oldWidget) {
    super.didUpdateWidget(oldWidget);
    final changed = oldWidget.sessionId != widget.sessionId
        || oldWidget.fps != widget.fps
        || oldWidget.format != widget.format
        || oldWidget.pixelRatio != widget.pixelRatio
        || oldWidget.nativeCapture != widget.nativeCapture
        || oldWidget.adaptive != widget.adaptive
        || oldWidget.minScale != widget.minScale
        || oldWidget.matchViewportAspect != widget.matchViewportAspect
        || oldWidget.captureOverride != widget.captureOverride;
    if (changed) {
      _unregister();
      _register();
    }
  }

  void _register() {
    _scaler = AqutterNativeScaler(minScale: widget.minScale);
    final session = AqutterNativeSession(
      id: widget.sessionId,
      fps: widget.fps,
      // 以 RepaintBoundary 擷取時，內容重繪會喚醒擷取迴圈；PlatformView 的原生擷取沒有變動通知，需要輪詢
      eventDriven: widget.captureOverride == null && !(widget.nativeCapture && AqutterNativeCapture.isSupported),
      capture: widget.captureOverride ?? _capture,
      // 讀 widget.onMessage 而非捕捉當下值：父層重建後換了 callback 也不必重註冊
      onMessage: (message) {
        if (widget.injectPointers && message.type == 'pointer') {
          final box = _boundaryKey.currentContext?.findRenderObject();
          _pointers.handle(message, box is RenderBox ? box : null);
        }
        _unchangedStreak = 0; // 網頁有操作：地圖馬上會動（含之後的圖磚載入），恢復全速擷取
        widget.onMessage?.call(message);
      },
    );
    _session = session;
    AqutterNativeHost.instance.register(session);
  }

  void _unregister() {
    _pointers.cancelAll();
    final session = _session;
    if (session != null) {
      AqutterNativeHost.instance.unregister(session);
      _session = null;
    }
  }

  Future<AqutterNativeFrame?> _capture() async {
    final box = _boundaryKey.currentContext?.findRenderObject();
    if (box is! _RenderCountingRepaintBoundary || !box.hasSize) {
      return null;
    }
    final session = _session;
    if (session == null) {
      return null;
    }
    final forced = session.takeDirty();
    try {
      return await _captureFrame(box, session, forced);
    }
    catch (_) {
      session.markDirty(); // 失敗不能吃掉「必須擷取」的標記，否則畫面沒變時永遠不會重試
      rethrow;
    }
  }

  /// 原生擷取（PlatformView）：與 Flutter 擷取同一套自適應——擷取跟不上就降解析度，畫面停下來（連續兩張相同）
  /// 補一張完整解析度的定格幀；畫面完全沒變的幀（iOS）不回傳，靜止的地圖不再持續占用傳輸與網頁解碼。
  Future<AqutterNativeFrame?> _captureNative(_RenderCountingRepaintBoundary box, AqutterNativeSession session, bool forced) async {
    final origin = box.localToGlobal(Offset.zero);
    final rect = origin & box.size;
    final base = _pixelRatioFor(box.size, session.viewport);
    final adaptive = widget.adaptive == AqutterNativeAdaptive.resolution;
    // 定格後（_settled）以完整解析度比對；動起來的第一張也是完整解析度，之後才降
    final full = !adaptive || _settled || _scaler.scale >= 1.0;
    if (!forced && _unchangedStreak >= _backoffAfter) {
      _backoffTick = (_backoffTick + 1) % _backoffEvery;
      if (_backoffTick != 0) {
        _nativeBackoff += 1;
        _publishNativeDebug(session);
        return null;
      }
    }
    final watch = Stopwatch()..start();
    final duty = widget.nativeMaxDuty ?? (defaultTargetPlatform == TargetPlatform.iOS ? 0.7 : null);
    var frame = await AqutterNativeCapture.capture(
      rect,
      viewTypeContains: widget.nativeViewTypeContains,
      pixelRatio: full ? base : base * _scaler.scale,
      // 網頁剛連上、重新看得到、尺寸變了（forced）時，一定要送一張，否則靜止的畫面永遠到不了網頁
      // 比對要掃過整張像素（Android 平板約 10 到 15 ms）：連續在動時每 4 幀才比一次，確認靜止後才每幀比
      skipUnchanged: !forced && (_unchangedStreak > 0 || _compareTick++ % 4 == 0),
      // 動的時候壓成 JPEG（小一個數量級）；定格幀（full 且已停下）走下面無損的那一張
      jpegQuality: _movingJpegQuality,
    );
    if (duty != null && duty > 0 && duty < 1) {
      // 讓出主執行緒：觸控與網頁的繪製才跟得上
      await Future<void>.delayed(watch.elapsed * (1 / duty - 1));
    }
    if (frame == null) {
      _unchangedStreak += 1;
      _nativeUnchanged += 1;
      // 畫面沒變（或這輪擷取不到）：解析度被降過就補一張完整解析度的定格幀
      if (adaptive && !_settled && _scaler.scale < 1.0 && _sinceChange.elapsed >= widget.settleDelay) {
        _settled = true;
        frame = await AqutterNativeCapture.capture(rect, viewTypeContains: widget.nativeViewTypeContains, pixelRatio: base, jpegQuality: _settleJpegQuality);
      }
      _publishNativeDebug(session);
      return frame;
    }
    _unchangedStreak = 0;
    _nativeFrames += 1;
    _sinceChange
      ..reset()
      ..start();
    _settled = false;
    session.stats.scale = _scaler.scale;
    if (adaptive) {
      _scaler.record(watch.elapsedMicroseconds / 1000, 1000 / widget.fps * 0.9);
    }
    _publishNativeDebug(session);
    return frame;
  }

  static bool get _isIos => defaultTargetPlatform == TargetPlatform.iOS;

  /// 0 以下代表明確關閉壓縮（一律傳未壓縮的 RGBA）；`null` 才依平台決定。
  double? get _movingJpegQuality {
    final quality = widget.nativeJpegQuality;
    return quality == null ? (_isIos ? 0.85 : null) : (quality > 0 ? quality : null);
  }

  double? get _settleJpegQuality {
    final quality = widget.nativeSettleJpegQuality;
    return quality == null ? (_isIos ? 0.92 : null) : (quality > 0 ? quality : null);
  }

  void _publishNativeDebug(AqutterNativeSession session) {
    session.debug
      ..['nativeFrames'] = _nativeFrames
      ..['nativeUnchanged'] = _nativeUnchanged
      ..['nativeBackoff'] = _nativeBackoff
      ..['streak'] = _unchangedStreak
      ..['settled'] = _settled
      ..['scale'] = _scaler.scale
      ..['nativeTimingMs'] = AqutterNativeCapture.lastTimings;
  }

  Future<AqutterNativeFrame?> _captureFrame(_RenderCountingRepaintBoundary box, AqutterNativeSession session, bool forced) async {
    if (widget.nativeCapture && AqutterNativeCapture.isSupported) {
      return _captureNative(box, session, forced);
    }
    // 開發模式下尚未繪製就 toImage 會觸發斷言；release 沒有這個旗標，故以 kReleaseMode 守住。
    // 內容持續重繪時 debug 版常落在「已標記、尚未繪製」的空檔：直接放棄這一輪會讓 debug 幀率遠低於 release
    // （實機 debug 只有 3 到 5 fps），所以先等下一幀畫完再試一次。
    if (!kReleaseMode && box.debugNeedsPaint) {
      await WidgetsBinding.instance.endOfFrame.timeout(const Duration(milliseconds: 50), onTimeout: () {});
      if (box.debugNeedsPaint) {
        session.markDirty();
        return null;
      }
    }
    final paintCount = box.paintCount;
    session.stats.paintCount(paintCount);
    final changed = paintCount != _lastPaintCount;
    final adaptive = widget.adaptive == AqutterNativeAdaptive.resolution;
    var settleFrame = false;
    if (widget.skipUnchanged && !forced && !changed) {
      // 內容停了：解析度被降過就補一幀完整解析度的定格幀，靜止的畫面才會清楚
      final needsSettle = adaptive && _scaler.scale < 1.0 && !_settled && _sinceChange.elapsed >= widget.settleDelay;
      if (!needsSettle) {
        session.stats.unchanged();
        return null;
      }
      settleFrame = true;
    }
    _lastPaintCount = paintCount;
    if (changed) {
      _sinceChange
        ..reset()
        ..start();
      _settled = false;
    }
    if (settleFrame) {
      _settled = true;
    }
    final scale = adaptive && !settleFrame ? _scaler.scale : 1.0;
    session.stats.scale = _scaler.scale;
    final totalWatch = Stopwatch()..start();

    final imageWatch = Stopwatch()..start();
    final image = await box.toImage(pixelRatio: (_pixelRatioFor(box.size, session.viewport) * scale).clamp(0.25, widget.maxPixelRatio));
    session.stats.add('toImage', imageWatch);
    try {
      final byteFormat = widget.format == AqutterNativeFormat.png
          ? ui.ImageByteFormat.png
          : ui.ImageByteFormat.rawStraightRgba;
      final readWatch = Stopwatch()..start();
      final data = await image.toByteData(format: byteFormat);
      session.stats.add('toByteData', readWatch);
      if (data == null) {
        return null;
      }
      if (adaptive && !settleFrame && changed) {
        _scaler.record(totalWatch.elapsedMicroseconds / 1000, 1000 / widget.fps * 0.9);
      }
      return AqutterNativeFrame(
        width: image.width,
        height: image.height,
        format: widget.format,
        payload: data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      );
    }
    finally {
      image.dispose();
    }
  }

  /// 擷取倍率：網頁回報了顯示尺寸，就擷取到「與網頁元素同樣多的像素」（含 devicePixelRatio）；否則用 [AqutterNative.pixelRatio]。
  ///
  /// 以**面積**而非單邊算：被鏡像的對象與網頁元素長寬比不同時（例如全螢幕的畫面塞進一個小方框），
  /// 單邊算法會把整個對象擷取成遠超過網頁能顯示的解析度。長寬比相同時兩者等價（剛好 1:1）。
  double _pixelRatioFor(Size size, AqutterNativeViewport? viewport) {
    if (viewport == null || size.isEmpty) {
      return widget.pixelRatio;
    }
    final targetPixels = viewport.width * viewport.height * viewport.devicePixelRatio * viewport.devicePixelRatio;
    final needed = math.sqrt(targetPixels / (size.width * size.height));
    return needed.clamp(0.25, widget.maxPixelRatio);
  }

  @override
  void dispose() {
    _unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boundary = _CountingRepaintBoundary(
      key: _boundaryKey,
      onPaint: () => _session?.wake(), // 重繪時喚醒閒置中的擷取迴圈
      child: widget.child,
    );
    final session = _session;
    if (!widget.matchViewportAspect || session == null) {
      return boundary;
    }
    return ValueListenableBuilder<AqutterNativeViewport?>(
      valueListenable: session.viewportListenable,
      child: boundary,
      builder: (context, viewport, child) {
        if (viewport == null || viewport.width <= 0 || viewport.height <= 0) {
          return child!;
        }
        return Center(
          child: AspectRatio(aspectRatio: viewport.width / viewport.height, child: child),
        );
      },
    );
  }
}

/// 會記錄「真的重繪了幾次」的 [RepaintBoundary]。
///
/// 子樹沒變時，Flutter 會直接重用快取的圖層而不呼叫 [paint]，所以 [paintCount] 沒變就代表畫面沒變。
class _CountingRepaintBoundary extends SingleChildRenderObjectWidget {
  const _CountingRepaintBoundary({super.key, super.child, this.onPaint});

  final VoidCallback? onPaint;

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderCountingRepaintBoundary()..onPaint = onPaint;

  @override
  void updateRenderObject(BuildContext context, _RenderCountingRepaintBoundary renderObject) {
    renderObject.onPaint = onPaint;
  }
}

class _RenderCountingRepaintBoundary extends RenderRepaintBoundary {
  int paintCount = 0;
  VoidCallback? onPaint;

  @override
  void paint(PaintingContext context, Offset offset) {
    paintCount += 1;
    onPaint?.call();
    super.paint(context, offset);
  }
}
