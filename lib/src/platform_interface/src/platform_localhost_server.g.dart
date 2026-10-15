// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_localhost_server.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformLocalhostServerCreationParamsClassSupported
    on AqutterPlatformLocalhostServerCreationParams {
  ///{@template aqutter_core.AqutterPlatformLocalhostServerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformLocalhostServerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.windows,
          TargetPlatform.linux,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformLocalhostServerClassSupported
    on AqutterPlatformLocalhostServer {
  ///{@template aqutter_core.AqutterPlatformLocalhostServer.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformLocalhostServer.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.windows,
          TargetPlatform.linux,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformLocalhostServer]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformLocalhostServerMethod {
  ///Can be used to check if the [AqutterPlatformLocalhostServer.close] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformLocalhostServer.close.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformLocalhostServer.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  close,

  ///Can be used to check if the [AqutterPlatformLocalhostServer.isRunning] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformLocalhostServer.isRunning.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformLocalhostServer.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isRunning,

  ///Can be used to check if the [AqutterPlatformLocalhostServer.start] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformLocalhostServer.start.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformLocalhostServer.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  start,
}

extension _AqutterPlatformLocalhostServerMethodSupported
    on AqutterPlatformLocalhostServer {
  static bool isMethodSupported(
    AqutterPlatformLocalhostServerMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformLocalhostServerMethod.close:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformLocalhostServerMethod.isRunning:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformLocalhostServerMethod.start:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
