import 'dart:typed_data';
import 'dart:ui' show Rect;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mirror_frame.dart';

/// 平台原生擷取。
///
/// PlatformView（如 `google_maps_flutter` 的地圖）在 iOS 是 UIKit 疊合的原生 view，
/// 不進 Flutter 可 rasterize 的場景，`RenderRepaintBoundary.toImage` 抓不到——
/// 這裡改走 iOS 的 `drawHierarchy`。其他平台（Android 等）用 Flutter 自己的擷取即可。
class AqutterNativeCapture {
  const AqutterNativeCapture._();

  static const MethodChannel _channel = MethodChannel('com.github.aqutter/nativeview');

  /// 目前平台是否需要（且支援）原生擷取。
  static bool get isSupported => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// 擷取 [rect]（Flutter 全域座標，logical points）範圍的合成後畫面。
  ///
  /// [viewTypeContains] 給了且在 view 階層找得到類名含此字串的 view 時，直接擷取該 view
  /// （不含疊在其上的網頁覆蓋層，也免裁切）；否則擷取整個 window 再裁切到 [rect]。
  /// 回 null 代表這一輪擷取不到。
  static Future<AqutterMirrorFrame?> capture(Rect rect, {String? viewTypeContains}) async {
    final result = await _channel.invokeMethod<Map<dynamic, dynamic>>('capture', {
      'x': rect.left,
      'y': rect.top,
      'w': rect.width,
      'h': rect.height,
      'viewTypeContains': ?viewTypeContains,
    });
    if (result == null) {
      return null;
    }
    return AqutterMirrorFrame(
      width: result['width'] as int,
      height: result['height'] as int,
      format: AqutterMirrorFormat.rgba,
      payload: result['bytes'] as Uint8List,
    );
  }
}
