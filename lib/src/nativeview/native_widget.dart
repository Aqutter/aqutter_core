import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'native_frame.dart';
import 'native_host_io.dart' if (dart.library.js_interop) 'native_host_stub.dart';
import 'native_session.dart';
import 'native_capture.dart';

/// 把 [child] 鏡像到網頁的 `<aqutter-native session="[sessionId]">`。
///
/// [child] 照常在 Flutter 裡渲染（通常放在 WebView 之下，由網頁蓋住），本元件每隔一段時間擷取其畫面、
/// 經 localhost WebSocket 送給網頁畫進 canvas；網頁端的手勢與指令以 [onMessage] 回來，由 App 套用到 [child]
/// 的狀態。這讓網頁能在原生內容（地圖、Flutter 自繪元件）**之上**疊 HTML / 做 z-index。
///
/// 擷取方式：預設用 [RepaintBoundary] 擷取（純 Flutter 內容、Android 上的 PlatformView）；
/// iOS 的 PlatformView 需設 [nativeCapture] 走 `drawHierarchy`。
class AqutterNative extends StatefulWidget {
  const AqutterNative({
    super.key,
    required this.sessionId,
    required this.child,
    this.onMessage,
    this.fps = 30,
    this.pixelRatio = 1.5,
    this.maxPixelRatio = 3.0,
    this.skipUnchanged = true,
    this.format = AqutterNativeFormat.rgba,
    this.nativeCapture = false,
    this.nativeViewTypeContains,
  });

  /// 與網頁端 `session` 屬性一致；同一時間不得有兩個相同 id。
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

  /// 內容沒有重繪時跳過擷取（閒置時不耗 CPU 與頻寬）。
  ///
  /// 以 `RepaintBoundary` 擷取時才有效；[nativeCapture]（PlatformView）的內容變化 Flutter 看不到，
  /// 一律每輪擷取。內容若是以 Flutter 之外的方式改變（例如 texture 外部更新），請設為 false。
  final bool skipUnchanged;
  final AqutterNativeFormat format;

  /// 在 iOS 以原生 `drawHierarchy` 擷取（PlatformView 用）；其他平台忽略。
  final bool nativeCapture;

  /// 原生擷取時，優先直接擷取類名含此字串的 view（例如 `GMSMapView`）。
  final String? nativeViewTypeContains;

  @override
  State<AqutterNative> createState() => _AqutterNativeState();
}

class _AqutterNativeState extends State<AqutterNative> {
  final GlobalKey _boundaryKey = GlobalKey();
  AqutterNativeSession? _session;

  /// 上一次擷取時的重繪次數；沒變代表畫面沒變。
  int _lastPaintCount = -1;

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
        || oldWidget.nativeCapture != widget.nativeCapture;
    if (changed) {
      _unregister();
      _register();
    }
  }

  void _register() {
    final session = AqutterNativeSession(
      id: widget.sessionId,
      fps: widget.fps,
      capture: _capture,
      // 讀 widget.onMessage 而非捕捉當下值：父層重建後換了 callback 也不必重註冊
      onMessage: (message) => widget.onMessage?.call(message),
    );
    _session = session;
    AqutterNativeHost.instance.register(session);
  }

  void _unregister() {
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
    if (widget.nativeCapture && AqutterNativeCapture.isSupported) {
      final origin = box.localToGlobal(Offset.zero);
      return AqutterNativeCapture.capture(
        origin & box.size,
        viewTypeContains: widget.nativeViewTypeContains,
      );
    }
    // 開發模式下尚未繪製就 toImage 會觸發斷言；release 沒有這個旗標，故以 kReleaseMode 守住
    if (!kReleaseMode && box.debugNeedsPaint) {
      session.markDirty();
      return null;
    }
    final paintCount = box.paintCount;
    if (widget.skipUnchanged && !forced && paintCount == _lastPaintCount) {
      return null;
    }
    _lastPaintCount = paintCount;

    final image = await box.toImage(pixelRatio: _pixelRatioFor(box.size, session.viewport));
    try {
      final byteFormat = widget.format == AqutterNativeFormat.png
          ? ui.ImageByteFormat.png
          : ui.ImageByteFormat.rawStraightRgba;
      final data = await image.toByteData(format: byteFormat);
      if (data == null) {
        return null;
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

  /// 擷取倍率：網頁回報了顯示尺寸就剛好擷取到網頁需要的像素數（含 devicePixelRatio），否則用 [AqutterNative.pixelRatio]。
  double _pixelRatioFor(Size size, AqutterNativeViewport? viewport) {
    if (viewport == null || size.isEmpty) {
      return widget.pixelRatio;
    }
    final needed = math.max(
      viewport.width * viewport.devicePixelRatio / size.width,
      viewport.height * viewport.devicePixelRatio / size.height,
    );
    return needed.clamp(0.25, widget.maxPixelRatio);
  }

  @override
  void dispose() {
    _unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CountingRepaintBoundary(key: _boundaryKey, child: widget.child);
  }
}

/// 會記錄「真的重繪了幾次」的 [RepaintBoundary]。
///
/// 子樹沒變時，Flutter 會直接重用快取的圖層而不呼叫 [paint]，所以 [paintCount] 沒變就代表畫面沒變。
class _CountingRepaintBoundary extends SingleChildRenderObjectWidget {
  const _CountingRepaintBoundary({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderCountingRepaintBoundary();
}

class _RenderCountingRepaintBoundary extends RenderRepaintBoundary {
  int paintCount = 0;

  @override
  void paint(PaintingContext context, Offset offset) {
    paintCount += 1;
    super.paint(context, offset);
  }
}
