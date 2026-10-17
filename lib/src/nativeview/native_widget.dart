import 'dart:ui' as ui;

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
    this.format = AqutterNativeFormat.rgba,
    this.nativeCapture = false,
    this.nativeViewTypeContains,
  });

  /// 與網頁端 `session` 屬性一致；同一時間不得有兩個相同 id。
  final String sessionId;
  final Widget child;
  final AqutterNativeMessageHandler? onMessage;
  final int fps;

  /// 擷取解析度倍率（logical → pixel）；調低換 fps、調高換畫質。
  final double pixelRatio;
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
    if (box is! RenderRepaintBoundary || !box.hasSize) {
      return null;
    }
    if (widget.nativeCapture && AqutterNativeCapture.isSupported) {
      final origin = box.localToGlobal(Offset.zero);
      return AqutterNativeCapture.capture(
        origin & box.size,
        viewTypeContains: widget.nativeViewTypeContains,
      );
    }
    if (box.debugNeedsPaint) {
      return null;
    }
    final image = await box.toImage(pixelRatio: widget.pixelRatio);
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

  @override
  void dispose() {
    _unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(key: _boundaryKey, child: widget.child);
  }
}
