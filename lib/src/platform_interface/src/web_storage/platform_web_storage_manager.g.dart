// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_web_storage_manager.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformWebStorageManagerCreationParamsClassSupported
    on AqutterPlatformWebStorageManagerCreationParams {
  ///{@template aqutter_core.AqutterPlatformWebStorageManagerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView 9.0+
  ///- Linux WPE WebKit
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPlatformWebStorageManagerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.linux,
          TargetPlatform.macOS,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformWebStorageManagerClassSupported
    on AqutterPlatformWebStorageManager {
  ///{@template aqutter_core.AqutterPlatformWebStorageManager.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterWebStorage](https://developer.android.com/reference/android/webkit/AqutterWebStorage.html))
  ///- iOS WKWebView 9.0+ ([Official API - WKWebsiteDataStore](https://developer.apple.com/documentation/webkit/wkwebsitedatastore))
  ///- Linux WPE WebKit ([Official API - WebKitWebsiteDataManager](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.WebsiteDataManager.html))
  ///- macOS WKWebView ([Official API - WKWebsiteDataStore](https://developer.apple.com/documentation/webkit/wkwebsitedatastore))
  ///
  ///Use the [AqutterPlatformWebStorageManager.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.linux,
          TargetPlatform.macOS,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformWebStorageManager]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformWebStorageManagerMethod {
  ///Can be used to check if the [AqutterPlatformWebStorageManager.deleteAllData] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebStorageManager.deleteAllData.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterWebStorage.deleteAllData](https://developer.android.com/reference/android/webkit/AqutterWebStorage#deleteAllData()))
  ///
  ///Use the [AqutterPlatformWebStorageManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  deleteAllData,

  ///Can be used to check if the [AqutterPlatformWebStorageManager.deleteOrigin] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebStorageManager.deleteOrigin.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterWebStorage.deleteOrigin](https://developer.android.com/reference/android/webkit/AqutterWebStorage#deleteOrigin(java.lang.String)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [origin]: all platforms
  ///
  ///Use the [AqutterPlatformWebStorageManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  deleteOrigin,

  ///Can be used to check if the [AqutterPlatformWebStorageManager.fetchDataRecords] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebStorageManager.fetchDataRecords.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 9.0+ ([Official API - WKWebsiteDataStore.fetchDataRecords](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532932-fetchdatarecords))
  ///- Linux WPE WebKit ([Official API - webkit_website_data_manager_fetch](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebsiteDataManager.fetch.html))
  ///- macOS WKWebView ([Official API - WKWebsiteDataStore.fetchDataRecords](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532932-fetchdatarecords))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [dataTypes]: all platforms
  ///
  ///Use the [AqutterPlatformWebStorageManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  fetchDataRecords,

  ///Can be used to check if the [AqutterPlatformWebStorageManager.getOrigins] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebStorageManager.getOrigins.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterWebStorage.getOrigins](https://developer.android.com/reference/android/webkit/AqutterWebStorage#getOrigins(android.webkit.ValueCallback%3Cjava.util.Map%3E)))
  ///
  ///Use the [AqutterPlatformWebStorageManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getOrigins,

  ///Can be used to check if the [AqutterPlatformWebStorageManager.getQuotaForOrigin] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebStorageManager.getQuotaForOrigin.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterWebStorage.getQuotaForOrigin](https://developer.android.com/reference/android/webkit/AqutterWebStorage#getQuotaForOrigin(java.lang.String,%20android.webkit.ValueCallback%3Cjava.lang.Long%3E)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [origin]: all platforms
  ///
  ///Use the [AqutterPlatformWebStorageManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getQuotaForOrigin,

  ///Can be used to check if the [AqutterPlatformWebStorageManager.getUsageForOrigin] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebStorageManager.getUsageForOrigin.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterWebStorage.getUsageForOrigin](https://developer.android.com/reference/android/webkit/AqutterWebStorage#getUsageForOrigin(java.lang.String,%20android.webkit.ValueCallback%3Cjava.lang.Long%3E)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [origin]: all platforms
  ///
  ///Use the [AqutterPlatformWebStorageManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getUsageForOrigin,

  ///Can be used to check if the [AqutterPlatformWebStorageManager.removeDataFor] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebStorageManager.removeDataFor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 9.0+ ([Official API - WKWebsiteDataStore.removeData](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532936-removedata))
  ///- Linux WPE WebKit ([Official API - webkit_website_data_manager_remove](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebsiteDataManager.remove.html))
  ///- macOS WKWebView ([Official API - WKWebsiteDataStore.removeData](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532936-removedata))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [dataTypes]: all platforms
  ///- [dataRecords]: all platforms
  ///
  ///Use the [AqutterPlatformWebStorageManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  removeDataFor,

  ///Can be used to check if the [AqutterPlatformWebStorageManager.removeDataModifiedSince] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebStorageManager.removeDataModifiedSince.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 9.0+ ([Official API - WKWebsiteDataStore.removeData](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532938-removedata))
  ///- Linux WPE WebKit ([Official API - webkit_website_data_manager_clear](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebsiteDataManager.clear.html))
  ///- macOS WKWebView ([Official API - WKWebsiteDataStore.removeData](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532938-removedata))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [dataTypes]: all platforms
  ///- [date]: all platforms
  ///
  ///Use the [AqutterPlatformWebStorageManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  removeDataModifiedSince,
}

extension _AqutterPlatformWebStorageManagerMethodSupported
    on AqutterPlatformWebStorageManager {
  static bool isMethodSupported(
    AqutterPlatformWebStorageManagerMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformWebStorageManagerMethod.deleteAllData:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebStorageManagerMethod.deleteOrigin:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebStorageManagerMethod.fetchDataRecords:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.linux,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebStorageManagerMethod.getOrigins:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebStorageManagerMethod.getQuotaForOrigin:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebStorageManagerMethod.getUsageForOrigin:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebStorageManagerMethod.removeDataFor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.linux,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebStorageManagerMethod.removeDataModifiedSince:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.linux,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
