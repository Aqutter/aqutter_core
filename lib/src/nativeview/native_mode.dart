import 'dart:ui' show Rect;

import 'package:flutter/foundation.dart';

/// 原生內容與網頁的顯示模式。
///
/// 用在兩個地方，意義略有不同：
///   - 網頁 `<aqutter-native mode="…">` 的**請求**；
///   - [AqutterNative.mode] 的**允許範圍**：[mirror] 表示絕不穿透，[passthrough]、[auto] 表示允許穿透（仍受平台限制）。
/// 實際生效的模式由原生端依 [decideAqutterNativeMode] 決定，網頁只負責回報頁面條件。
enum AqutterNativeMode {
  /// 平台支援、widget 允許、且頁面可穿透時用穿透，否則用鏡像。
  auto,

  /// 一律鏡像：擷取原生內容、以 WebSocket 送幀給網頁畫進 canvas。
  mirror,

  /// 穿透：原生內容直接畫在（透明的）WebView 下面，網頁的元素只佔版面、不畫 canvas。
  passthrough;

  /// 解析網頁送來的值；不認得的值回 `null`。
  static AqutterNativeMode? tryParse(Object? value) {
    for (final mode in values) {
      if (mode.name == value) {
        return mode;
      }
    }
    return null;
  }
}

/// 請求穿透卻退回鏡像的原因（線上格式為 [wire]）。
enum AqutterNativeModeReason {
  /// 平台沒有穿透實作（目前支援 Android、iOS、macOS 與 Windows；Linux、Web 沒有）。
  unsupportedPlatform('unsupported-platform'),

  /// [AqutterNative.mode] 為 [AqutterNativeMode.mirror]。
  unsupportedWidget('unsupported-widget'),

  /// `auto` 時網頁回報頁面不可穿透（元素後方的祖先有不透明背景）。
  pageNotReady('page-not-ready'),

  /// 殼無法使 WebView 透明（見 [AqutterNativeHost.passthroughAvailable]）。
  transparentFailed('transparent-failed');

  const AqutterNativeModeReason(this.wire);

  final String wire;
}

/// 模式協商的結果：實際生效的模式，以及與請求不同時的原因。
@immutable
class AqutterNativeModeDecision {
  const AqutterNativeModeDecision({required this.passthrough, this.reason});

  /// `true` 為穿透，`false` 為鏡像。
  final bool passthrough;

  /// 只有請求的是穿透（或 `auto`）卻退回鏡像時才有。
  final AqutterNativeModeReason? reason;

  /// 回覆給網頁的訊息：`{"type":"mode","mode":"mirror｜passthrough","reason"?:…}`。
  Map<String, Object> toJson() => {
    'type': 'mode',
    'mode': passthrough ? 'passthrough' : 'mirror',
    if (reason != null) 'reason': reason!.wire,
  };

  @override
  bool operator ==(Object other) =>
      other is AqutterNativeModeDecision &&
      other.passthrough == passthrough &&
      other.reason == reason;

  @override
  int get hashCode => Object.hash(passthrough, reason);

  @override
  String toString() =>
      'AqutterNativeModeDecision(${passthrough ? 'passthrough' : 'mirror'}${reason == null ? '' : ', ${reason!.wire}'})';
}

/// 這個平台有沒有穿透模式的實作。
///
/// Android（實機驗證過）、iOS（模擬器驗證過，實機待驗）、macOS 與 Windows（debug、顯示縮放 125% 驗證過）；
/// Linux 與 Web 沒有實作。傳入 [platform] 方便測試。
bool aqutterNativePassthroughSupported([TargetPlatform? platform]) {
  if (kIsWeb) {
    return false;
  }
  return switch (platform ?? defaultTargetPlatform) {
    TargetPlatform.android || TargetPlatform.iOS || TargetPlatform.macOS || TargetPlatform.windows => true,
    _ => false,
  };
}

/// 模式決策：生效模式 = 請求 ∩ widget 允許 ∩ 平台支援 ∩（`auto` 時）頁面可穿透。
///
/// 同時有多個原因退回鏡像時，依序回報：widget → 平台 → 殼無法透明 → 頁面。請求本來就是鏡像時沒有原因。
/// 純函式，不碰平台，所以能單元測試。
AqutterNativeModeDecision decideAqutterNativeMode({
  required AqutterNativeMode request,
  required AqutterNativeMode widgetMode,
  required bool platformSupported,
  required bool pageReady,
  bool passthroughAvailable = true,
}) {
  if (request == AqutterNativeMode.mirror) {
    return const AqutterNativeModeDecision(passthrough: false);
  }
  if (widgetMode == AqutterNativeMode.mirror) {
    return const AqutterNativeModeDecision(
      passthrough: false,
      reason: AqutterNativeModeReason.unsupportedWidget,
    );
  }
  if (!platformSupported) {
    return const AqutterNativeModeDecision(
      passthrough: false,
      reason: AqutterNativeModeReason.unsupportedPlatform,
    );
  }
  if (!passthroughAvailable) {
    return const AqutterNativeModeDecision(
      passthrough: false,
      reason: AqutterNativeModeReason.transparentFailed,
    );
  }
  if (request == AqutterNativeMode.auto && !pageReady) {
    return const AqutterNativeModeDecision(
      passthrough: false,
      reason: AqutterNativeModeReason.pageNotReady,
    );
  }
  return const AqutterNativeModeDecision(passthrough: true);
}

/// 穿透模式下網頁回報的元素矩形：CSS 像素（等同 Flutter 的邏輯像素），原點是 WebView 視窗的左上角。
@immutable
class AqutterNativeLayout {
  const AqutterNativeLayout({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.visible,
    this.webRegions,
  });

  final double left;
  final double top;
  final double width;
  final double height;

  /// 元素沒渲染、`display:none`、寬或高為 0、或頁面不可見時為 `false`。
  final bool visible;

  /// 元素矩形內「網頁要接管觸控」的區域，相對元素左上角（CSS 像素）。
  ///
  /// `null`＝client 不支援原生觸控（舊 client），觸控全部走網頁；非 `null`（含空清單）＝支援，
  /// 元素矩形扣掉這些區域的部分，觸控可以直接交給原生。
  final List<Rect>? webRegions;

  /// [webRegions] 的數量上限。
  static const int maxWebRegions = 64;

  /// 解析 `{"type":"layout",...}` 訊息；欄位缺漏、型別不符、不是有限數或寬高為負時回 `null`。
  static AqutterNativeLayout? tryParse(Map<String, dynamic> message) {
    final left = message['left'];
    final top = message['top'];
    final width = message['width'];
    final height = message['height'];
    final visible = message['visible'];
    if (left is! num ||
        top is! num ||
        width is! num ||
        height is! num ||
        visible is! bool) {
      return null;
    }
    final values = [
      left.toDouble(),
      top.toDouble(),
      width.toDouble(),
      height.toDouble(),
    ];
    if (values.any((value) => !value.isFinite) ||
        values[2] < 0 ||
        values[3] < 0) {
      return null;
    }
    return AqutterNativeLayout(
      left: values[0],
      top: values[1],
      width: values[2],
      height: values[3],
      visible: visible,
      webRegions: _parseWebRegions(message['webRegions']),
    );
  }

  /// 解析 `webRegions`：格式不合（非陣列、超過上限、元素缺欄位、非有限數、寬高不為正）就整個忽略（回 `null`）。
  static List<Rect>? _parseWebRegions(Object? raw) {
    if (raw is! List || raw.length > maxWebRegions) {
      return null;
    }
    final regions = <Rect>[];
    for (final item in raw) {
      if (item is! Map) {
        return null;
      }
      final x = item['x'];
      final y = item['y'];
      final width = item['width'];
      final height = item['height'];
      if (x is! num || y is! num || width is! num || height is! num) {
        return null;
      }
      final values = [x.toDouble(), y.toDouble(), width.toDouble(), height.toDouble()];
      if (values.any((value) => !value.isFinite) || values[2] <= 0 || values[3] <= 0) {
        return null;
      }
      regions.add(Rect.fromLTWH(values[0], values[1], values[2], values[3]));
    }
    return List<Rect>.unmodifiable(regions);
  }

  /// 這個矩形在 WebView 視窗座標系中的位置與大小。
  Rect get rect => Rect.fromLTWH(left, top, width, height);

  @override
  bool operator ==(Object other) =>
      other is AqutterNativeLayout &&
      other.left == left &&
      other.top == top &&
      other.width == width &&
      other.height == height &&
      other.visible == visible &&
      listEquals(other.webRegions, webRegions);

  @override
  int get hashCode => Object.hash(left, top, width, height, visible, webRegions == null ? null : Object.hashAll(webRegions!));

  @override
  String toString() =>
      'AqutterNativeLayout($left, $top, ${width}x$height, visible: $visible, webRegions: $webRegions)';
}
