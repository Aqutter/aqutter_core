// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_process_global_config.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///{@template aqutter_core.AqutterProcessGlobalConfigSettings}
///Class that represents the settings used to configure the [AqutterPlatformProcessGlobalConfig].
///{@endtemplate}
///
///{@macro aqutter_core.AqutterProcessGlobalConfigSettings.supported_platforms}
///
///**Officially Supported Platforms/Implementations**:
///- Android WebView ([Official API - AqutterProcessGlobalConfig.apply](https://developer.android.com/reference/androidx/webkit/AqutterProcessGlobalConfig#apply(androidx.webkit.AqutterProcessGlobalConfig)))
class AqutterProcessGlobalConfigSettings {
  ///The directory name suffix to be used for the current process.
  ///Must not contain a path separator and should not be empty.
  ///
  ///Define the directory used to store WebView data for the current process.
  ///The provided suffix will be used when constructing data and cache directory paths.
  ///If this API is not called, no suffix will be used.
  ///Each directory can be used by only one process in the application.
  ///If more than one process in an app wishes to use WebView,
  ///only one process can use the default directory,
  ///and other processes must call this API to define a unique suffix.
  ///
  ///This means that different processes in the same application cannot directly share `WebView`-related data,
  ///since the data directories must be distinct.
  ///Applications that use this API may have to explicitly pass data between processes.
  ///For example, login cookies may have to be copied from one process's cookie jar to the other using [AqutterPlatformCookieManager] if both processes' WebViews are intended to be logged in.
  ///
  ///Most applications should simply ensure that all components of the app that rely
  ///on WebView are in the same process, to avoid needing multiple data directories.
  ///The [AqutterPlatformWebViewController.disableWebView] method can be used to ensure that the other processes do not use WebView by accident in this case.
  ///
  ///{@macro aqutter_core.AqutterProcessGlobalConfigSettings.dataDirectorySuffix.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - Available only if [AqutterWebViewFeature.STARTUP_FEATURE_SET_DATA_DIRECTORY_SUFFIX] feature is supported.
  String? dataDirectorySuffix;

  ///Set the base directories that `WebView` will use for the current process.
  ///If this method is not used, `WebView` uses the default base paths defined by the Android framework.
  ///
  ///WebView will create and use a subdirectory under each of the base paths supplied to this method.
  ///
  ///This method can be used in conjunction with setDataDirectorySuffix.
  ///A different subdirectory is created for each suffix.
  ///
  ///The base paths must be absolute paths.
  ///
  ///The data directory must not be under the Android cache directory,
  ///as Android may delete cache files when disk space is low and WebView may not function properly if this occurs.
  ///Refer to [this link](https://developer.android.com/training/data-storage/app-specific#internal-remove-cache).
  ///
  ///If the specified directories already exist then they must be readable and writable by the current process.
  ///If they do not already exist, `WebView` will attempt to create them during initialization, along with any missing parent directories.
  ///In such a case, the directory in which `WebView` creates missing directories must be readable and writable by the current process.
  ///
  ///{@macro aqutter_core.AqutterProcessGlobalConfigSettings.directoryBasePaths.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - Available only if [AqutterWebViewFeature.STARTUP_FEATURE_SET_DIRECTORY_BASE_PATHS] feature is supported.
  AqutterProcessGlobalConfigDirectoryBasePaths? directoryBasePaths;

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterProcessGlobalConfig.apply](https://developer.android.com/reference/androidx/webkit/AqutterProcessGlobalConfig#apply(androidx.webkit.AqutterProcessGlobalConfig)))
  AqutterProcessGlobalConfigSettings({
    this.dataDirectorySuffix,
    this.directoryBasePaths,
  });

  ///Gets a possible [AqutterProcessGlobalConfigSettings] instance from a [Map] value.
  static AqutterProcessGlobalConfigSettings? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterProcessGlobalConfigSettings(
      dataDirectorySuffix: map['dataDirectorySuffix'],
      directoryBasePaths: AqutterProcessGlobalConfigDirectoryBasePaths.fromMap(
        map['directoryBasePaths']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
    );
    return instance;
  }

  ///{@template aqutter_core.AqutterProcessGlobalConfigSettings.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterProcessGlobalConfigSettingsClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterProcessGlobalConfigSettings.isPropertySupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  static bool isPropertySupported(
    AqutterProcessGlobalConfigSettingsProperty property, {
    TargetPlatform? platform,
  }) =>
      _AqutterProcessGlobalConfigSettingsPropertySupported.isPropertySupported(
        property,
        platform: platform,
      );

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "dataDirectorySuffix": dataDirectorySuffix,
      "directoryBasePaths": directoryBasePaths?.toMap(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  ///Returns a copy of AqutterProcessGlobalConfigSettings.
  AqutterProcessGlobalConfigSettings copy() {
    return AqutterProcessGlobalConfigSettings.fromMap(toMap()) ??
        AqutterProcessGlobalConfigSettings();
  }

  @override
  String toString() {
    return 'AqutterProcessGlobalConfigSettings{dataDirectorySuffix: $dataDirectorySuffix, directoryBasePaths: $directoryBasePaths}';
  }
}

///Class that represents the settings used to configure the [AqutterProcessGlobalConfigSettings.directoryBasePaths].
///
///**Officially Supported Platforms/Implementations**:
///- Android native WebView ([Official API - ProxyConfig](https://developer.android.com/reference/androidx/webkit/ProxyConfig))
class AqutterProcessGlobalConfigDirectoryBasePaths {
  ///The absolute base path for the WebView cache directory.
  String cacheDirectoryBasePath;

  ///The absolute base path for the WebView data directory.
  String dataDirectoryBasePath;
  AqutterProcessGlobalConfigDirectoryBasePaths({
    required this.cacheDirectoryBasePath,
    required this.dataDirectoryBasePath,
  });

  ///Gets a possible [AqutterProcessGlobalConfigDirectoryBasePaths] instance from a [Map] value.
  static AqutterProcessGlobalConfigDirectoryBasePaths? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterProcessGlobalConfigDirectoryBasePaths(
      cacheDirectoryBasePath: map['cacheDirectoryBasePath'],
      dataDirectoryBasePath: map['dataDirectoryBasePath'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "cacheDirectoryBasePath": cacheDirectoryBasePath,
      "dataDirectoryBasePath": dataDirectoryBasePath,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterProcessGlobalConfigDirectoryBasePaths{cacheDirectoryBasePath: $cacheDirectoryBasePath, dataDirectoryBasePath: $dataDirectoryBasePath}';
  }
}

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformProcessGlobalConfigCreationParamsClassSupported
    on AqutterPlatformProcessGlobalConfigCreationParams {
  ///{@template aqutter_core.AqutterPlatformProcessGlobalConfigCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformProcessGlobalConfigCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformProcessGlobalConfigClassSupported
    on AqutterPlatformProcessGlobalConfig {
  ///{@template aqutter_core.AqutterPlatformProcessGlobalConfig.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterProcessGlobalConfig](https://developer.android.com/reference/androidx/webkit/AqutterProcessGlobalConfig))
  ///
  ///Use the [AqutterPlatformProcessGlobalConfig.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformProcessGlobalConfig]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformProcessGlobalConfigMethod {
  ///Can be used to check if the [AqutterPlatformProcessGlobalConfig.apply] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformProcessGlobalConfig.apply.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterProcessGlobalConfig.apply](https://developer.android.com/reference/androidx/webkit/AqutterProcessGlobalConfig#apply(androidx.webkit.AqutterProcessGlobalConfig)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [settings]: all platforms
  ///
  ///Use the [AqutterPlatformProcessGlobalConfig.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  apply,
}

extension _AqutterPlatformProcessGlobalConfigMethodSupported
    on AqutterPlatformProcessGlobalConfig {
  static bool isMethodSupported(
    AqutterPlatformProcessGlobalConfigMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformProcessGlobalConfigMethod.apply:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

extension _AqutterProcessGlobalConfigSettingsClassSupported
    on AqutterProcessGlobalConfigSettings {
  ///{@template aqutter_core.AqutterProcessGlobalConfigSettings.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterProcessGlobalConfig.apply](https://developer.android.com/reference/androidx/webkit/AqutterProcessGlobalConfig#apply(androidx.webkit.AqutterProcessGlobalConfig)))
  ///
  ///Use the [AqutterProcessGlobalConfigSettings.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterProcessGlobalConfigSettings]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterProcessGlobalConfigSettingsProperty {
  ///Can be used to check if the [AqutterProcessGlobalConfigSettings.dataDirectorySuffix] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterProcessGlobalConfigSettings.dataDirectorySuffix.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - Available only if [AqutterWebViewFeature.STARTUP_FEATURE_SET_DATA_DIRECTORY_SUFFIX] feature is supported.
  ///
  ///Use the [AqutterProcessGlobalConfigSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  dataDirectorySuffix,

  ///Can be used to check if the [AqutterProcessGlobalConfigSettings.directoryBasePaths] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterProcessGlobalConfigSettings.directoryBasePaths.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - Available only if [AqutterWebViewFeature.STARTUP_FEATURE_SET_DIRECTORY_BASE_PATHS] feature is supported.
  ///
  ///Use the [AqutterProcessGlobalConfigSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  directoryBasePaths,
}

extension _AqutterProcessGlobalConfigSettingsPropertySupported
    on AqutterProcessGlobalConfigSettings {
  static bool isPropertySupported(
    AqutterProcessGlobalConfigSettingsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterProcessGlobalConfigSettingsProperty.dataDirectorySuffix:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterProcessGlobalConfigSettingsProperty.directoryBasePaths:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
