// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_web_authenticate_session.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformWebAuthenticationSessionCreationParamsClassSupported
    on AqutterPlatformWebAuthenticationSessionCreationParams {
  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSessionCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 11.0+
  ///- macOS WKWebView 10.15+
  ///
  ///Use the [AqutterPlatformWebAuthenticationSessionCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.iOS,
          TargetPlatform.macOS,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformWebAuthenticationSessionClassSupported
    on AqutterPlatformWebAuthenticationSession {
  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 11.0+
  ///- macOS WKWebView 10.15+
  ///
  ///Use the [AqutterPlatformWebAuthenticationSession.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.iOS,
          TargetPlatform.macOS,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformWebAuthenticationSession]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformWebAuthenticationSessionProperty {
  ///Can be used to check if the [AqutterPlatformWebAuthenticationSession.callbackURLScheme] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.callbackURLScheme.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPlatformWebAuthenticationSession.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  callbackURLScheme,

  ///Can be used to check if the [AqutterPlatformWebAuthenticationSession.id] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.id.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPlatformWebAuthenticationSession.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  id,

  ///Can be used to check if the [AqutterPlatformWebAuthenticationSession.initialSettings] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.initialSettings.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPlatformWebAuthenticationSession.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  initialSettings,

  ///Can be used to check if the [AqutterPlatformWebAuthenticationSession.onComplete] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.onComplete.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [error]: all platforms
  ///
  ///Use the [AqutterPlatformWebAuthenticationSession.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onComplete,

  ///Can be used to check if the [AqutterPlatformWebAuthenticationSession.url] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.url.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPlatformWebAuthenticationSession.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  url,
}

extension _AqutterPlatformWebAuthenticationSessionPropertySupported
    on AqutterPlatformWebAuthenticationSession {
  static bool isPropertySupported(
    AqutterPlatformWebAuthenticationSessionProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformWebAuthenticationSessionProperty.callbackURLScheme:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebAuthenticationSessionProperty.id:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebAuthenticationSessionProperty.initialSettings:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebAuthenticationSessionProperty.onComplete:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebAuthenticationSessionProperty.url:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

///List of [AqutterPlatformWebAuthenticationSession]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformWebAuthenticationSessionMethod {
  ///Can be used to check if the [AqutterPlatformWebAuthenticationSession.canStart] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.canStart.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - ASWebAuthenticationSession.canStart](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/3516277-canstart))
  ///- macOS WKWebView ([Official API - ASWebAuthenticationSession.canStart](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/3516277-canstart))
  ///
  ///Use the [AqutterPlatformWebAuthenticationSession.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  canStart,

  ///Can be used to check if the [AqutterPlatformWebAuthenticationSession.cancel] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.cancel.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - ASWebAuthenticationSession.cancel](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/2990951-cancel))
  ///- macOS WKWebView ([Official API - ASWebAuthenticationSession.cancel](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/2990951-cancel))
  ///
  ///Use the [AqutterPlatformWebAuthenticationSession.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  cancel,

  ///Can be used to check if the [AqutterPlatformWebAuthenticationSession.create] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.create.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [callbackURLScheme]: all platforms
  ///- [onComplete]: all platforms
  ///- [initialSettings]: all platforms
  ///
  ///Use the [AqutterPlatformWebAuthenticationSession.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  create,

  ///Can be used to check if the [AqutterPlatformWebAuthenticationSession.dispose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.dispose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPlatformWebAuthenticationSession.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dispose,

  ///Can be used to check if the [AqutterPlatformWebAuthenticationSession.isAvailable] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.isAvailable.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPlatformWebAuthenticationSession.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isAvailable,

  ///Can be used to check if the [AqutterPlatformWebAuthenticationSession.start] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.start.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - ASWebAuthenticationSession.start](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/2990953-start))
  ///- macOS WKWebView ([Official API - ASWebAuthenticationSession.start](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/2990953-start))
  ///
  ///Use the [AqutterPlatformWebAuthenticationSession.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  start,
}

extension _AqutterPlatformWebAuthenticationSessionMethodSupported
    on AqutterPlatformWebAuthenticationSession {
  static bool isMethodSupported(
    AqutterPlatformWebAuthenticationSessionMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformWebAuthenticationSessionMethod.canStart:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebAuthenticationSessionMethod.cancel:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebAuthenticationSessionMethod.create:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebAuthenticationSessionMethod.dispose:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebAuthenticationSessionMethod.isAvailable:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebAuthenticationSessionMethod.start:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
