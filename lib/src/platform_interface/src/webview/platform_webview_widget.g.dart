// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_webview_widget.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformWebViewWidgetCreationParamsClassSupported
    on AqutterPlatformWebViewWidgetCreationParams {
  ///{@template aqutter_core.AqutterPlatformWebViewWidgetCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebViewWidgetCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return kIsWeb && platform == null
        ? true
        : ((kIsWeb && platform != null) || !kIsWeb) &&
              [
                TargetPlatform.android,
                TargetPlatform.iOS,
                TargetPlatform.macOS,
                TargetPlatform.windows,
                TargetPlatform.linux,
              ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformWebViewWidgetCreationParams]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformWebViewWidgetCreationParamsProperty {
  ///Can be used to check if the [AqutterPlatformWebViewWidgetCreationParams.headlessWebView] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewWidgetCreationParams.headlessWebView.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebViewWidgetCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  headlessWebView,

  ///Can be used to check if the [AqutterPlatformWebViewWidgetCreationParams.keepAlive] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewWidgetCreationParams.keepAlive.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebViewWidgetCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  keepAlive,

  ///Can be used to check if the [AqutterPlatformWebViewWidgetCreationParams.preventGestureDelay] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewWidgetCreationParams.preventGestureDelay.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformWebViewWidgetCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  preventGestureDelay,

  ///Can be used to check if the [AqutterPlatformWebViewWidgetCreationParams.webViewEnvironment] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewWidgetCreationParams.webViewEnvironment.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///- Linux WPE WebKit ([Official API - WebKitWebContext](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.WebContext.html))
  ///
  ///Use the [AqutterPlatformWebViewWidgetCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  webViewEnvironment,
}

extension _AqutterPlatformWebViewWidgetCreationParamsPropertySupported
    on AqutterPlatformWebViewWidgetCreationParams {
  static bool isPropertySupported(
    AqutterPlatformWebViewWidgetCreationParamsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformWebViewWidgetCreationParamsProperty.headlessWebView:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewWidgetCreationParamsProperty.keepAlive:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewWidgetCreationParamsProperty
          .preventGestureDelay:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewWidgetCreationParamsProperty
          .webViewEnvironment:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
