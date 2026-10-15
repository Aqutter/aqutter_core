// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_webview_asset_loader.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///{@template aqutter_core.AqutterWebViewAssetLoader}
///Helper class to load local files including application's static assets and resources using http(s):// URLs inside a `WebView` class.
///Loading local files using web-like URLs instead of `file://` is desirable as it is compatible with the Same-Origin policy.
///
///For more context about application's assets and resources and how to normally access them please refer to
///[Android Developer Docs: App resources overview](https://developer.android.com/guide/topics/resources/providing-resources).
///
///Using http(s):// URLs to access local resources may conflict with a real website.
///This means that local files should only be hosted on domains your organization owns
///(at paths reserved for this purpose) or the default domain reserved for this: `appassets.androidplatform.net`.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterWebViewAssetLoader.supported_platforms}
///
///**Officially Supported Platforms/Implementations**:
///- Android WebView
class AqutterWebViewAssetLoader {
  ///An unused domain reserved for Android applications to intercept requests for app assets.
  ///
  ///It is used by default unless the user specified a different domain.
  static final String DEFAULT_DOMAIN = "appassets.androidplatform.net";

  ///Set the domain under which app assets can be accessed. The default domain is `appassets.androidplatform.net`.
  String? domain;

  ///Allow using the HTTP scheme in addition to HTTPS. The default is to not allow HTTP.
  bool? httpAllowed;

  ///List of registered path handlers.
  ///
  ///[AqutterWebViewAssetLoader] will try Path Handlers in the order they're registered,
  ///and will use whichever is the first to return a non-null.
  List<AqutterPlatformPathHandler>? pathHandlers;

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  AqutterWebViewAssetLoader({this.domain, this.httpAllowed, this.pathHandlers});

  ///Gets a possible [AqutterWebViewAssetLoader] instance from a [Map] value.
  static AqutterWebViewAssetLoader? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebViewAssetLoader(
      domain: map['domain'],
      httpAllowed: map['httpAllowed'],
      pathHandlers: map['pathHandlers'] != null
          ? List<AqutterPlatformPathHandler>.from(
              map['pathHandlers'].map((e) => e),
            )
          : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "domain": domain,
      "httpAllowed": httpAllowed,
      "pathHandlers": pathHandlers
          ?.map((e) => e.toMap(enumMethod: enumMethod))
          .toList(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  ///Returns a copy of AqutterWebViewAssetLoader.
  AqutterWebViewAssetLoader copy() {
    return AqutterWebViewAssetLoader.fromMap(toMap()) ??
        AqutterWebViewAssetLoader();
  }

  @override
  String toString() {
    return 'AqutterWebViewAssetLoader{domain: $domain, httpAllowed: $httpAllowed, pathHandlers: $pathHandlers}';
  }
}

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformPathHandlerCreationParamsClassSupported
    on AqutterPlatformPathHandlerCreationParams {
  ///{@template aqutter_core.AqutterPlatformPathHandlerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformPathHandlerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformAssetsPathHandlerCreationParamsClassSupported
    on AqutterPlatformAssetsPathHandlerCreationParams {
  ///{@template aqutter_core.AqutterPlatformAssetsPathHandlerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformAssetsPathHandlerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformAssetsPathHandlerClassSupported
    on AqutterPlatformAssetsPathHandler {
  ///{@template aqutter_core.AqutterPlatformAssetsPathHandler.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformAssetsPathHandler.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformResourcesPathHandlerCreationParamsClassSupported
    on AqutterPlatformResourcesPathHandlerCreationParams {
  ///{@template aqutter_core.AqutterPlatformResourcesPathHandlerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformResourcesPathHandlerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformResourcesPathHandlerClassSupported
    on AqutterPlatformResourcesPathHandler {
  ///{@template aqutter_core.AqutterPlatformResourcesPathHandler.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformResourcesPathHandler.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformInternalStoragePathHandlerCreationParamsClassSupported
    on AqutterPlatformInternalStoragePathHandlerCreationParams {
  ///{@template aqutter_core.AqutterPlatformInternalStoragePathHandlerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformInternalStoragePathHandlerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformInternalStoragePathHandlerClassSupported
    on AqutterPlatformInternalStoragePathHandler {
  ///{@template aqutter_core.AqutterPlatformInternalStoragePathHandler.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformInternalStoragePathHandler.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformCustomPathHandlerCreationParamsClassSupported
    on AqutterPlatformCustomPathHandlerCreationParams {
  ///{@template aqutter_core.AqutterPlatformCustomPathHandlerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformCustomPathHandlerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformCustomPathHandlerClassSupported
    on AqutterPlatformCustomPathHandler {
  ///{@template aqutter_core.AqutterPlatformCustomPathHandler.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformCustomPathHandler.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}
