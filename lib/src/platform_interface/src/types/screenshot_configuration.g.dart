// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screenshot_configuration.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the configuration data to use when generating an image from a web view’s contents using [AqutterPlatformWebViewController.takeScreenshot].
class AqutterScreenshotConfiguration {
  ///A Boolean value that indicates whether to take the snapshot after incorporating any pending screen updates.
  ///The default value of this property is `true`, which causes the web view to incorporate any recent changes to the view’s content and then generate the snapshot.
  ///If you change the value to `false`, the `WebView` takes the snapshot immediately, and before incorporating any new changes.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 13.0+
  ///- macOS WKWebView 10.15+
  bool afterScreenUpdates;

  ///The compression format of the captured image.
  ///The default value is [AqutterCompressFormat.PNG].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  AqutterCompressFormat compressFormat;

  ///Use [afterScreenUpdates] instead.
  @Deprecated('Use afterScreenUpdates instead')
  bool? iosAfterScreenUpdates;

  ///Hint to the compressor, `0-100`. The value is interpreted differently depending on the [AqutterCompressFormat].
  ///[AqutterCompressFormat.PNG] is lossless, so this value is ignored.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  int quality;

  ///The portion of your web view to capture, specified as a rectangle in the view’s coordinate system.
  ///The default value of this property is `null`, which captures everything in the view’s bounds rectangle.
  ///If you specify a custom rectangle, it must lie within the bounds rectangle of the `WebView` object.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  AqutterWebViewRect? rect;

  ///The width of the captured image, in points.
  ///Use this property to scale the generated image to the specified width.
  ///The web view maintains the aspect ratio of the captured content, but scales it to match the width you specify.
  ///
  ///The default value of this property is `null`, which returns an image whose size matches the original size of the captured rectangle.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  double? snapshotWidth;
  AqutterScreenshotConfiguration({
    this.rect,
    this.snapshotWidth,
    AqutterCompressFormat? compressFormat,
    this.quality = 100,
    @Deprecated("Use afterScreenUpdates instead") this.iosAfterScreenUpdates,
    this.afterScreenUpdates = true,
  }) : compressFormat = compressFormat ?? AqutterCompressFormat.PNG {
    assert(this.quality >= 0);
    this.afterScreenUpdates = this.iosAfterScreenUpdates != null
        ? this.iosAfterScreenUpdates!
        : this.afterScreenUpdates;
  }

  ///Gets a possible [AqutterScreenshotConfiguration] instance from a [Map] value.
  static AqutterScreenshotConfiguration? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterScreenshotConfiguration(
      iosAfterScreenUpdates: map['afterScreenUpdates'],
      rect: AqutterWebViewRect.fromMap(
        map['rect']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      snapshotWidth: map['snapshotWidth'],
    );
    if (map['afterScreenUpdates'] != null) {
      instance.afterScreenUpdates = map['afterScreenUpdates'];
    }
    if (map['compressFormat'] != null) {
      instance.compressFormat = switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterCompressFormat.fromNativeValue(
          map['compressFormat'],
        ),
        AqutterEnumMethod.value => AqutterCompressFormat.fromValue(
          map['compressFormat'],
        ),
        AqutterEnumMethod.name => AqutterCompressFormat.byName(
          map['compressFormat'],
        ),
      }!;
    }
    if (map['quality'] != null) {
      instance.quality = map['quality'];
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "afterScreenUpdates": afterScreenUpdates,
      "compressFormat": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => compressFormat.toNativeValue(),
        AqutterEnumMethod.value => compressFormat.toValue(),
        AqutterEnumMethod.name => compressFormat.name(),
      },
      "quality": quality,
      "rect": rect?.toMap(enumMethod: enumMethod),
      "snapshotWidth": snapshotWidth,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterScreenshotConfiguration{afterScreenUpdates: $afterScreenUpdates, compressFormat: $compressFormat, quality: $quality, rect: $rect, snapshotWidth: $snapshotWidth}';
  }
}
