// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_web_message_channel.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformWebMessageChannelCreationParamsClassSupported
    on AqutterPlatformWebMessageChannelCreationParams {
  ///{@template aqutter_core.AqutterPlatformWebMessageChannelCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit:
  ///    - Implemented via JavaScript MessageChannel API.
  ///- Windows WebView2:
  ///    - Implemented via JavaScript MessageChannel API.
  ///
  ///Use the [AqutterPlatformWebMessageChannelCreationParams.isClassSupported] method to check if this class is supported at runtime.
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

///List of [AqutterPlatformWebMessageChannelCreationParams]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformWebMessageChannelCreationParamsProperty {
  ///Can be used to check if the [AqutterPlatformWebMessageChannelCreationParams.id] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebMessageChannelCreationParams.id.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit:
  ///    - Implemented via JavaScript MessageChannel API.
  ///- Windows WebView2:
  ///    - Implemented via JavaScript MessageChannel API.
  ///
  ///Use the [AqutterPlatformWebMessageChannelCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  id,

  ///Can be used to check if the [AqutterPlatformWebMessageChannelCreationParams.port1] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebMessageChannelCreationParams.port1.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit:
  ///    - Implemented via JavaScript MessageChannel API.
  ///- Windows WebView2:
  ///    - Implemented via JavaScript MessageChannel API.
  ///
  ///Use the [AqutterPlatformWebMessageChannelCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  port1,

  ///Can be used to check if the [AqutterPlatformWebMessageChannelCreationParams.port2] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebMessageChannelCreationParams.port2.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit:
  ///    - Implemented via JavaScript MessageChannel API.
  ///- Windows WebView2:
  ///    - Implemented via JavaScript MessageChannel API.
  ///
  ///Use the [AqutterPlatformWebMessageChannelCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  port2,
}

extension _AqutterPlatformWebMessageChannelCreationParamsPropertySupported
    on AqutterPlatformWebMessageChannelCreationParams {
  static bool isPropertySupported(
    AqutterPlatformWebMessageChannelCreationParamsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformWebMessageChannelCreationParamsProperty.id:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebMessageChannelCreationParamsProperty.port1:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebMessageChannelCreationParamsProperty.port2:
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

extension _AqutterPlatformWebMessageChannelClassSupported
    on AqutterPlatformWebMessageChannel {
  ///{@template aqutter_core.AqutterPlatformWebMessageChannel.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit:
  ///    - Implemented via JavaScript MessageChannel API.
  ///- Windows WebView2:
  ///    - Implemented via JavaScript MessageChannel API.
  ///
  ///Use the [AqutterPlatformWebMessageChannel.isClassSupported] method to check if this class is supported at runtime.
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

///List of [AqutterPlatformWebMessageChannel]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformWebMessageChannelMethod {
  ///Can be used to check if the [AqutterPlatformWebMessageChannel.dispose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebMessageChannel.dispose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit:
  ///    - Implemented via JavaScript MessageChannel API.
  ///- Windows WebView2:
  ///    - Implemented via JavaScript MessageChannel API.
  ///
  ///Use the [AqutterPlatformWebMessageChannel.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dispose,
}

extension _AqutterPlatformWebMessageChannelMethodSupported
    on AqutterPlatformWebMessageChannel {
  static bool isMethodSupported(
    AqutterPlatformWebMessageChannelMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformWebMessageChannelMethod.dispose:
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
