// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_authenticate_session_settings.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the settings that can be used for a [AqutterPlatformWebAuthenticationSession].
///
///**Officially Supported Platforms/Implementations**:
///- iOS WKWebView 13.0+
///- macOS WKWebView 10.15+
class AqutterWebAuthenticationSessionSettings {
  ///A Boolean value that indicates whether the session should ask the browser for a private authentication session.
  ///
  ///Set [prefersEphemeralWebBrowserSession] to `true` to request that the browser
  ///doesn’t share cookies or other browsing data between the authentication session and the user’s normal browser session.
  ///Whether the request is honored depends on the user’s default web browser.
  ///Safari always honors the request.
  ///
  ///The value of this property is `false` by default.
  ///
  ///Set this property before you call [AqutterPlatformWebAuthenticationSession.start]. Otherwise it has no effect.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 13.0+
  ///- macOS WKWebView 10.15+
  bool? prefersEphemeralWebBrowserSession;

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 13.0+
  ///- macOS WKWebView 10.15+
  AqutterWebAuthenticationSessionSettings({
    this.prefersEphemeralWebBrowserSession = false,
  });

  ///Gets a possible [AqutterWebAuthenticationSessionSettings] instance from a [Map] value.
  static AqutterWebAuthenticationSessionSettings? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebAuthenticationSessionSettings();
    instance.prefersEphemeralWebBrowserSession =
        map['prefersEphemeralWebBrowserSession'];
    return instance;
  }

  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isPropertySupported(
    AqutterWebAuthenticationSessionSettingsProperty property, {
    TargetPlatform? platform,
  }) =>
      _AqutterWebAuthenticationSessionSettingsPropertySupported.isPropertySupported(
        property,
        platform: platform,
      );

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "prefersEphemeralWebBrowserSession": prefersEphemeralWebBrowserSession,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  ///Returns a copy of AqutterWebAuthenticationSessionSettings.
  AqutterWebAuthenticationSessionSettings copy() {
    return AqutterWebAuthenticationSessionSettings.fromMap(toMap()) ??
        AqutterWebAuthenticationSessionSettings();
  }

  @override
  String toString() {
    return 'AqutterWebAuthenticationSessionSettings{prefersEphemeralWebBrowserSession: $prefersEphemeralWebBrowserSession}';
  }
}

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

///List of [AqutterWebAuthenticationSessionSettings]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterWebAuthenticationSessionSettingsProperty {
  ///Can be used to check if the [AqutterWebAuthenticationSessionSettings.prefersEphemeralWebBrowserSession] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebAuthenticationSessionSettings.prefersEphemeralWebBrowserSession.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 13.0+
  ///- macOS WKWebView 10.15+
  ///
  ///Use the [AqutterWebAuthenticationSessionSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  prefersEphemeralWebBrowserSession,
}

extension _AqutterWebAuthenticationSessionSettingsPropertySupported
    on AqutterWebAuthenticationSessionSettings {
  static bool isPropertySupported(
    AqutterWebAuthenticationSessionSettingsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterWebAuthenticationSessionSettingsProperty
          .prefersEphemeralWebBrowserSession:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
