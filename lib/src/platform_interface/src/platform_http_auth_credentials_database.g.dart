// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_http_auth_credentials_database.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformHttpAuthCredentialDatabaseCreationParamsClassSupported
    on AqutterPlatformHttpAuthCredentialDatabaseCreationParams {
  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabaseCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformHttpAuthCredentialDatabaseCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.linux,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformHttpAuthCredentialDatabaseClassSupported
    on AqutterPlatformHttpAuthCredentialDatabase {
  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - It has a custom implementation using `android.database.sqlite.SQLiteDatabase` because [WebViewDatabase](https://developer.android.com/reference/android/webkit/WebViewDatabase) doesn't offer the same functionalities as iOS/macOS `URLCredentialStorage`.
  ///- iOS WKWebView:
  ///    - It is implemented using the [URLCredentialStorage](https://developer.apple.com/documentation/foundation/urlcredentialstorage) class.
  ///- macOS WKWebView:
  ///    - It is implemented using the [URLCredentialStorage](https://developer.apple.com/documentation/foundation/urlcredentialstorage) class.
  ///- Linux WPE WebKit:
  ///    - Implemented using libsecret for secure credential storage in the system keyring (gnome-keyring, KDE Wallet, etc.).
  ///
  ///Use the [AqutterPlatformHttpAuthCredentialDatabase.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.linux,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformHttpAuthCredentialDatabase]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformHttpAuthCredentialDatabaseMethod {
  ///Can be used to check if the [AqutterPlatformHttpAuthCredentialDatabase.clearAllAuthCredentials] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.clearAllAuthCredentials.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformHttpAuthCredentialDatabase.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  clearAllAuthCredentials,

  ///Can be used to check if the [AqutterPlatformHttpAuthCredentialDatabase.getAllAuthCredentials] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.getAllAuthCredentials.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView ([Official API - URLCredentialStorage.allCredentials](https://developer.apple.com/documentation/foundation/urlcredentialstorage/1413859-allcredentials))
  ///- macOS WKWebView ([Official API - URLCredentialStorage.allCredentials](https://developer.apple.com/documentation/foundation/urlcredentialstorage/1413859-allcredentials))
  ///- Linux WPE WebKit:
  ///    - Implemented using libsecret for secure storage.
  ///
  ///Use the [AqutterPlatformHttpAuthCredentialDatabase.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getAllAuthCredentials,

  ///Can be used to check if the [AqutterPlatformHttpAuthCredentialDatabase.getHttpAuthCredentials] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.getHttpAuthCredentials.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [protectionSpace]: all platforms
  ///
  ///Use the [AqutterPlatformHttpAuthCredentialDatabase.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getHttpAuthCredentials,

  ///Can be used to check if the [AqutterPlatformHttpAuthCredentialDatabase.removeHttpAuthCredential] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.removeHttpAuthCredential.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView ([Official API - URLCredentialStorage.remove](https://developer.apple.com/documentation/foundation/urlcredentialstorage/1408664-remove))
  ///- macOS WKWebView ([Official API - URLCredentialStorage.remove](https://developer.apple.com/documentation/foundation/urlcredentialstorage/1408664-remove))
  ///- Linux WPE WebKit:
  ///    - Implemented using libsecret for secure storage.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [protectionSpace]: all platforms
  ///- [credential]: all platforms
  ///
  ///Use the [AqutterPlatformHttpAuthCredentialDatabase.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  removeHttpAuthCredential,

  ///Can be used to check if the [AqutterPlatformHttpAuthCredentialDatabase.removeHttpAuthCredentials] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.removeHttpAuthCredentials.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [protectionSpace]: all platforms
  ///
  ///Use the [AqutterPlatformHttpAuthCredentialDatabase.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  removeHttpAuthCredentials,

  ///Can be used to check if the [AqutterPlatformHttpAuthCredentialDatabase.setHttpAuthCredential] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.setHttpAuthCredential.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView ([Official API - URLCredentialStorage.set](https://developer.apple.com/documentation/foundation/urlcredentialstorage/1407227-set))
  ///- macOS WKWebView ([Official API - URLCredentialStorage.set](https://developer.apple.com/documentation/foundation/urlcredentialstorage/1407227-set))
  ///- Linux WPE WebKit:
  ///    - Implemented using libsecret for secure storage.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [protectionSpace]: all platforms
  ///- [credential]: all platforms
  ///
  ///Use the [AqutterPlatformHttpAuthCredentialDatabase.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setHttpAuthCredential,
}

extension _AqutterPlatformHttpAuthCredentialDatabaseMethodSupported
    on AqutterPlatformHttpAuthCredentialDatabase {
  static bool isMethodSupported(
    AqutterPlatformHttpAuthCredentialDatabaseMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformHttpAuthCredentialDatabaseMethod
          .clearAllAuthCredentials:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformHttpAuthCredentialDatabaseMethod
          .getAllAuthCredentials:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformHttpAuthCredentialDatabaseMethod
          .getHttpAuthCredentials:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformHttpAuthCredentialDatabaseMethod
          .removeHttpAuthCredential:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformHttpAuthCredentialDatabaseMethod
          .removeHttpAuthCredentials:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformHttpAuthCredentialDatabaseMethod
          .setHttpAuthCredential:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
