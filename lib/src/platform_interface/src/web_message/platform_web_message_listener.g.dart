// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_web_message_listener.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformWebMessageListenerCreationParamsClassSupported
    on AqutterPlatformWebMessageListenerCreationParams {
  ///{@template aqutter_core.AqutterPlatformWebMessageListenerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebMessageListenerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.linux,
          TargetPlatform.windows,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformWebMessageListenerCreationParams]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformWebMessageListenerCreationParamsProperty {
  ///Can be used to check if the [AqutterPlatformWebMessageListenerCreationParams.allowedOriginRules] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebMessageListenerCreationParams.allowedOriginRules.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebMessageListenerCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  allowedOriginRules,

  ///Can be used to check if the [AqutterPlatformWebMessageListenerCreationParams.jsObjectName] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebMessageListenerCreationParams.jsObjectName.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebMessageListenerCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  jsObjectName,

  ///Can be used to check if the [AqutterPlatformWebMessageListenerCreationParams.onPostMessage] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebMessageListenerCreationParams.onPostMessage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewCompat.AqutterWebMessageListener.onPostMessage](https://developer.android.com/reference/androidx/webkit/WebViewCompat.AqutterWebMessageListener#onPostMessage(android.webkit.WebView,%20androidx.webkit.WebMessageCompat,%20android.net.Uri,%20boolean,%20androidx.webkit.AqutterJavaScriptReplyProxy)))
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///- Windows WebView2
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [message]: all platforms
  ///- [sourceOrigin]: all platforms
  ///- [isMainFrame]: all platforms
  ///- [replyProxy]: all platforms
  ///
  ///Use the [AqutterPlatformWebMessageListenerCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onPostMessage,
}

extension _AqutterPlatformWebMessageListenerCreationParamsPropertySupported
    on AqutterPlatformWebMessageListenerCreationParams {
  static bool isPropertySupported(
    AqutterPlatformWebMessageListenerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformWebMessageListenerCreationParamsProperty
          .allowedOriginRules:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebMessageListenerCreationParamsProperty.jsObjectName:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebMessageListenerCreationParamsProperty
          .onPostMessage:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

extension _AqutterPlatformWebMessageListenerClassSupported
    on AqutterPlatformWebMessageListener {
  ///{@template aqutter_core.AqutterPlatformWebMessageListener.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebMessageListener.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.linux,
          TargetPlatform.windows,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformWebMessageListener]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformWebMessageListenerMethod {
  ///Can be used to check if the [AqutterPlatformWebMessageListener.dispose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebMessageListener.dispose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebMessageListener.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dispose,
}

extension _AqutterPlatformWebMessageListenerMethodSupported
    on AqutterPlatformWebMessageListener {
  static bool isMethodSupported(
    AqutterPlatformWebMessageListenerMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformWebMessageListenerMethod.dispose:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
