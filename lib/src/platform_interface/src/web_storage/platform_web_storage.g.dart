// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_web_storage.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformWebStorageCreationParamsClassSupported
    on AqutterPlatformWebStorageCreationParams {
  ///{@template aqutter_core.AqutterPlatformWebStorageCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebStorageCreationParams.isClassSupported] method to check if this class is supported at runtime.
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

///List of [AqutterPlatformWebStorageCreationParams]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformWebStorageCreationParamsProperty {
  ///Can be used to check if the [AqutterPlatformWebStorageCreationParams.localStorage] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebStorageCreationParams.localStorage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebStorageCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  localStorage,

  ///Can be used to check if the [AqutterPlatformWebStorageCreationParams.sessionStorage] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebStorageCreationParams.sessionStorage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebStorageCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  sessionStorage,
}

extension _AqutterPlatformWebStorageCreationParamsPropertySupported
    on AqutterPlatformWebStorageCreationParams {
  static bool isPropertySupported(
    AqutterPlatformWebStorageCreationParamsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformWebStorageCreationParamsProperty.localStorage:
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
      case AqutterPlatformWebStorageCreationParamsProperty.sessionStorage:
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
}

extension _AqutterPlatformWebStorageClassSupported
    on AqutterPlatformWebStorage {
  ///{@template aqutter_core.AqutterPlatformWebStorage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebStorage.isClassSupported] method to check if this class is supported at runtime.
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

///List of [AqutterPlatformWebStorage]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformWebStorageProperty {
  ///Can be used to check if the [AqutterPlatformWebStorage.localStorage] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebStorage.localStorage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebStorage.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  localStorage,

  ///Can be used to check if the [AqutterPlatformWebStorage.sessionStorage] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebStorage.sessionStorage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebStorage.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  sessionStorage,
}

extension _AqutterPlatformWebStoragePropertySupported
    on AqutterPlatformWebStorage {
  static bool isPropertySupported(
    AqutterPlatformWebStorageProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformWebStorageProperty.localStorage:
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
      case AqutterPlatformWebStorageProperty.sessionStorage:
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
}

///List of [AqutterPlatformWebStorage]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformWebStorageMethod {
  ///Can be used to check if the [AqutterPlatformWebStorage.dispose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebStorage.dispose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dispose,
}

extension _AqutterPlatformWebStorageMethodSupported
    on AqutterPlatformWebStorage {
  static bool isMethodSupported(
    AqutterPlatformWebStorageMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformWebStorageMethod.dispose:
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
}

extension _AqutterPlatformStorageCreationParamsClassSupported
    on AqutterPlatformStorageCreationParams {
  ///{@template aqutter_core.AqutterPlatformStorageCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformStorageCreationParams.isClassSupported] method to check if this class is supported at runtime.
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

///List of [AqutterPlatformStorageCreationParams]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformStorageCreationParamsProperty {
  ///Can be used to check if the [AqutterPlatformStorageCreationParams.controller] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformStorageCreationParams.controller.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformStorageCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  controller,

  ///Can be used to check if the [AqutterPlatformStorageCreationParams.webStorageType] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformStorageCreationParams.webStorageType.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformStorageCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  webStorageType,
}

extension _AqutterPlatformStorageCreationParamsPropertySupported
    on AqutterPlatformStorageCreationParams {
  static bool isPropertySupported(
    AqutterPlatformStorageCreationParamsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformStorageCreationParamsProperty.controller:
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
      case AqutterPlatformStorageCreationParamsProperty.webStorageType:
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
}

extension _AqutterPlatformLocalStorageCreationParamsClassSupported
    on AqutterPlatformLocalStorageCreationParams {
  ///{@template aqutter_core.AqutterPlatformLocalStorageCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformLocalStorageCreationParams.isClassSupported] method to check if this class is supported at runtime.
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

extension _AqutterPlatformLocalStorageClassSupported
    on AqutterPlatformLocalStorage {
  ///{@template aqutter_core.AqutterPlatformLocalStorage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformLocalStorage.isClassSupported] method to check if this class is supported at runtime.
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

///List of [AqutterPlatformLocalStorage]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformLocalStorageMethod {
  ///Can be used to check if the [AqutterPlatformLocalStorage.clear] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformLocalStorage.clear.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformLocalStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  clear,

  ///Can be used to check if the [AqutterPlatformLocalStorage.dispose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformLocalStorage.dispose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformLocalStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dispose,

  ///Can be used to check if the [AqutterPlatformLocalStorage.getItem] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformLocalStorage.getItem.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [key]: all platforms
  ///
  ///Use the [AqutterPlatformLocalStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getItem,

  ///Can be used to check if the [AqutterPlatformLocalStorage.getItems] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformLocalStorage.getItems.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformLocalStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getItems,

  ///Can be used to check if the [AqutterPlatformLocalStorage.key] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformLocalStorage.key.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [index]: all platforms
  ///
  ///Use the [AqutterPlatformLocalStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  key,

  ///Can be used to check if the [AqutterPlatformLocalStorage.length] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformLocalStorage.length.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformLocalStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  length,

  ///Can be used to check if the [AqutterPlatformLocalStorage.removeItem] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformLocalStorage.removeItem.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [key]: all platforms
  ///
  ///Use the [AqutterPlatformLocalStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  removeItem,

  ///Can be used to check if the [AqutterPlatformLocalStorage.setItem] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformLocalStorage.setItem.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [key]: all platforms
  ///- [value]: all platforms
  ///
  ///Use the [AqutterPlatformLocalStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setItem,
}

extension _AqutterPlatformLocalStorageMethodSupported
    on AqutterPlatformLocalStorage {
  static bool isMethodSupported(
    AqutterPlatformLocalStorageMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformLocalStorageMethod.clear:
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
      case AqutterPlatformLocalStorageMethod.dispose:
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
      case AqutterPlatformLocalStorageMethod.getItem:
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
      case AqutterPlatformLocalStorageMethod.getItems:
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
      case AqutterPlatformLocalStorageMethod.key:
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
      case AqutterPlatformLocalStorageMethod.length:
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
      case AqutterPlatformLocalStorageMethod.removeItem:
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
      case AqutterPlatformLocalStorageMethod.setItem:
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
}

extension _AqutterPlatformSessionStorageCreationParamsClassSupported
    on AqutterPlatformSessionStorageCreationParams {
  ///{@template aqutter_core.AqutterPlatformSessionStorageCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformSessionStorageCreationParams.isClassSupported] method to check if this class is supported at runtime.
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

extension _AqutterPlatformSessionStorageClassSupported
    on AqutterPlatformSessionStorage {
  ///{@template aqutter_core.AqutterPlatformSessionStorage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformSessionStorage.isClassSupported] method to check if this class is supported at runtime.
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

///List of [AqutterPlatformSessionStorage]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformSessionStorageMethod {
  ///Can be used to check if the [AqutterPlatformSessionStorage.clear] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformSessionStorage.clear.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformSessionStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  clear,

  ///Can be used to check if the [AqutterPlatformSessionStorage.dispose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformSessionStorage.dispose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformSessionStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dispose,

  ///Can be used to check if the [AqutterPlatformSessionStorage.getItem] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformSessionStorage.getItem.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [key]: all platforms
  ///
  ///Use the [AqutterPlatformSessionStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getItem,

  ///Can be used to check if the [AqutterPlatformSessionStorage.getItems] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformSessionStorage.getItems.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformSessionStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getItems,

  ///Can be used to check if the [AqutterPlatformSessionStorage.key] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformSessionStorage.key.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [index]: all platforms
  ///
  ///Use the [AqutterPlatformSessionStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  key,

  ///Can be used to check if the [AqutterPlatformSessionStorage.length] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformSessionStorage.length.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformSessionStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  length,

  ///Can be used to check if the [AqutterPlatformSessionStorage.removeItem] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformSessionStorage.removeItem.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [key]: all platforms
  ///
  ///Use the [AqutterPlatformSessionStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  removeItem,

  ///Can be used to check if the [AqutterPlatformSessionStorage.setItem] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformSessionStorage.setItem.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [key]: all platforms
  ///- [value]: all platforms
  ///
  ///Use the [AqutterPlatformSessionStorage.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setItem,
}

extension _AqutterPlatformSessionStorageMethodSupported
    on AqutterPlatformSessionStorage {
  static bool isMethodSupported(
    AqutterPlatformSessionStorageMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformSessionStorageMethod.clear:
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
      case AqutterPlatformSessionStorageMethod.dispose:
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
      case AqutterPlatformSessionStorageMethod.getItem:
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
      case AqutterPlatformSessionStorageMethod.getItems:
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
      case AqutterPlatformSessionStorageMethod.key:
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
      case AqutterPlatformSessionStorageMethod.length:
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
      case AqutterPlatformSessionStorageMethod.removeItem:
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
      case AqutterPlatformSessionStorageMethod.setItem:
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
}
