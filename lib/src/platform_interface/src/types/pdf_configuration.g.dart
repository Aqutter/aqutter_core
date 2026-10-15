// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_configuration.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the configuration data to use when generating a PDF representation of a web view's contents.
class AqutterPDFConfiguration {
  ///The portion of your web view to capture, specified as a rectangle in the view's coordinate system.
  ///The default value of this property is `null`, which captures everything in the view's bounds rectangle.
  ///If you specify a custom rectangle, it must lie within the bounds rectangle of the `WebView` object.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  AqutterWebViewRect? rect;

  ///The print settings to use when generating the PDF.
  ///These settings control page size, orientation, margins, and other printing options.
  ///If not specified, default print settings will be used.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  AqutterPrintJobSettings? settings;
  AqutterPDFConfiguration({this.rect, this.settings});

  ///Gets a possible [AqutterPDFConfiguration] instance from a [Map] value.
  static AqutterPDFConfiguration? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterPDFConfiguration(
      rect: AqutterWebViewRect.fromMap(
        map['rect']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      settings: AqutterPrintJobSettings.fromMap(
        map['settings']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "rect": rect?.toMap(enumMethod: enumMethod),
      "settings": settings?.toMap(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterPDFConfiguration{rect: $rect, settings: $settings}';
  }
}

///An iOS-specific class that represents the configuration data to use when generating a PDF representation of a web view’s contents.
///
///**NOTE**: available on iOS 14.0+.
///
///Use [AqutterPDFConfiguration] instead.
@Deprecated('Use AqutterPDFConfiguration instead')
class AqutterIOSWKPDFConfiguration {
  ///The portion of your web view to capture, specified as a rectangle in the view’s coordinate system.
  ///The default value of this property is `null`, which captures everything in the view’s bounds rectangle.
  ///If you specify a custom rectangle, it must lie within the bounds rectangle of the `WebView` object.
  AqutterWebViewRect? rect;
  AqutterIOSWKPDFConfiguration({this.rect});

  ///Gets a possible [AqutterIOSWKPDFConfiguration] instance from a [Map] value.
  static AqutterIOSWKPDFConfiguration? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterIOSWKPDFConfiguration(
      rect: AqutterWebViewRect.fromMap(
        map['rect']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"rect": rect?.toMap(enumMethod: enumMethod)};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterIOSWKPDFConfiguration{rect: $rect}';
  }
}
