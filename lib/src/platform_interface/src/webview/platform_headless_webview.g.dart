// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_headless_webview.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformHeadlessWebViewCreationParamsClassSupported
    on AqutterPlatformHeadlessWebViewCreationParams {
  ///{@template aqutter_core.AqutterPlatformHeadlessWebViewCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformHeadlessWebViewCreationParams.isClassSupported] method to check if this class is supported at runtime.
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

///List of [AqutterPlatformHeadlessWebViewCreationParams]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformHeadlessWebViewCreationParamsProperty {
  ///Can be used to check if the [AqutterPlatformHeadlessWebViewCreationParams.initialSize] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformHeadlessWebViewCreationParams.initialSize.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - `Size` width and height values will be converted to `int` values because they cannot have `double` values.
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformHeadlessWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  initialSize,

  ///Can be used to check if the [AqutterPlatformHeadlessWebViewCreationParams.webViewEnvironment] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformHeadlessWebViewCreationParams.webViewEnvironment.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///- Linux WPE WebKit ([Official API - WebKitWebContext](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.WebContext.html))
  ///
  ///Use the [AqutterPlatformHeadlessWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  webViewEnvironment,
}

extension _AqutterPlatformHeadlessWebViewCreationParamsPropertySupported
    on AqutterPlatformHeadlessWebViewCreationParams {
  static bool isPropertySupported(
    AqutterPlatformHeadlessWebViewCreationParamsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformHeadlessWebViewCreationParamsProperty.initialSize:
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
      case AqutterPlatformHeadlessWebViewCreationParamsProperty
          .webViewEnvironment:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

extension _AqutterPlatformHeadlessWebViewClassSupported
    on AqutterPlatformHeadlessWebView {
  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformHeadlessWebView.isClassSupported] method to check if this class is supported at runtime.
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

///List of [AqutterPlatformHeadlessWebView]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformHeadlessWebViewMethod {
  ///Can be used to check if the [AqutterPlatformHeadlessWebView.dispose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.dispose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformHeadlessWebView.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dispose,

  ///Can be used to check if the [AqutterPlatformHeadlessWebView.getSize] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.getSize.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformHeadlessWebView.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getSize,

  ///Can be used to check if the [AqutterPlatformHeadlessWebView.isRunning] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.isRunning.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformHeadlessWebView.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isRunning,

  ///Can be used to check if the [AqutterPlatformHeadlessWebView.run] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.run.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>:
  ///    - It will append a new `iframe` to the body.
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformHeadlessWebView.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  run,

  ///Can be used to check if the [AqutterPlatformHeadlessWebView.setSize] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.setSize.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - `Size` width and height values will be converted to `int` values because they cannot have `double` values.
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [size]: all platforms
  ///
  ///Use the [AqutterPlatformHeadlessWebView.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setSize,
}

extension _AqutterPlatformHeadlessWebViewMethodSupported
    on AqutterPlatformHeadlessWebView {
  static bool isMethodSupported(
    AqutterPlatformHeadlessWebViewMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformHeadlessWebViewMethod.dispose:
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
      case AqutterPlatformHeadlessWebViewMethod.getSize:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformHeadlessWebViewMethod.isRunning:
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
      case AqutterPlatformHeadlessWebViewMethod.run:
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
      case AqutterPlatformHeadlessWebViewMethod.setSize:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
