import 'dart:typed_data';
import 'dart:ui' show Rect;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_frame.dart';

/// 平台原生擷取。
///
/// Texture 與 PlatformView（如 `google_maps_flutter` 的地圖）不進 Flutter 可 rasterize 的場景，
/// `RenderRepaintBoundary.toImage` 抓不到（鏡像出來是透明的），這裡改走原生擷取：
/// - iOS：`drawHierarchy`，直接擷取目標 view（可排除疊在其上的網頁）。
/// - Android：`PixelCopy` 複製 Flutter 的繪圖表面（Texture 與 PlatformView 已被合成進去；網頁是獨立的 View，不會被拍進去）。
///   需要 API 26 以上、Flutter 以 surface 模式渲染。
/// 其他平台沒有原生擷取，用 Flutter 自己的擷取。
class AqutterNativeCapture {
  const AqutterNativeCapture._();

  static const MethodChannel _channel = MethodChannel('com.github.aqutter/nativeview');

  /// 目前平台是否需要（且支援）原生擷取。
  static bool get isSupported => !kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android);

  /// 擷取 [rect]（Flutter 全域座標，logical points）範圍的合成後畫面。
  ///
  /// [viewTypeContains] 給了且在 view 階層找得到類名含此字串的 view 時，直接擷取該 view
  /// （不含疊在其上的網頁覆蓋層，也免裁切）；否則擷取整個 window 再裁切到 [rect]。
  /// 回 null 代表這一輪擷取不到。
  ///
  /// [pixelRatio]（每個 logical 像素要幾個像素）給了就縮到那個解析度、不放大；Android 使用，iOS 固定取最多 2 倍。
  static Future<AqutterNativeFrame?> capture(Rect rect, {String? viewTypeContains, double? pixelRatio}) async {
    final result = await _channel.invokeMethod<Map<dynamic, dynamic>>('capture', {
      'x': rect.left,
      'y': rect.top,
      'w': rect.width,
      'h': rect.height,
      'viewTypeContains': ?viewTypeContains,
      'pixelRatio': ?pixelRatio,
    });
    if (result == null) {
      return null;
    }
    return AqutterNativeFrame(
      width: result['width'] as int,
      height: result['height'] as int,
      format: AqutterNativeFormat.rgba,
      payload: result['bytes'] as Uint8List,
    );
  }
}
