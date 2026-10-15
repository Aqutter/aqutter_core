import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'webview/platform_webview_controller.dart';
import 'webview_platform.dart';
import 'platform_webview_feature.dart';
import 'types/enum_method.dart';

part 'platform_process_global_config.g.dart';

///{@template aqutter_core.AqutterPlatformProcessGlobalConfigCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformProcessGlobalConfig].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformProcessGlobalConfigCreationParams.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
@immutable
class AqutterPlatformProcessGlobalConfigCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformProcessGlobalConfig].
  const AqutterPlatformProcessGlobalConfigCreationParams();

  ///{@template aqutter_core.AqutterPlatformProcessGlobalConfigCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformProcessGlobalConfigCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformProcessGlobalConfig}
///Process Global Configuration for `WebView`.
///WebView has some process-global configuration parameters
///that cannot be changed once WebView has been loaded.
///This class allows apps to set these parameters.
///
///If it is used, the configuration should be set and apply should
///be called prior to loading WebView into the calling process.
///Most of the methods in `android.webkit` and `androidx.webkit` packages load WebView,
///so the configuration should be applied before calling any of these methods.
///
///The following code configures the data directory suffix that WebView uses and
///then applies the configuration. WebView uses this configuration when it is loaded.
///
///[apply] can only be called once.
///
///Only a single thread should access this class at a given time.
///
///The configuration should be set up as early as possible during application startup,
///to ensure that it happens before any other thread can call a method that loads `WebView`.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformProcessGlobalConfig.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(
      apiName: 'AqutterProcessGlobalConfig',
      apiUrl:
          'https://developer.android.com/reference/androidx/webkit/AqutterProcessGlobalConfig',
    ),
  ],
)
abstract class AqutterPlatformProcessGlobalConfig extends PlatformInterface {
  /// Creates a new [AqutterPlatformProcessGlobalConfig]
  factory AqutterPlatformProcessGlobalConfig(
    AqutterPlatformProcessGlobalConfigCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformProcessGlobalConfig processGlobalConfig = AqutterWebViewPlatform
        .instance!
        .createPlatformProcessGlobalConfig(params);
    PlatformInterface.verify(processGlobalConfig, _token);
    return processGlobalConfig;
  }

  /// Creates a new [AqutterPlatformProcessGlobalConfig] to access static methods.
  factory AqutterPlatformProcessGlobalConfig.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformProcessGlobalConfig processGlobalConfigStatic =
        AqutterWebViewPlatform.instance!
            .createPlatformProcessGlobalConfigStatic();
    PlatformInterface.verify(processGlobalConfigStatic, _token);
    return processGlobalConfigStatic;
  }

  /// Used by the platform implementation to create a new
  /// [AqutterPlatformProcessGlobalConfig].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformProcessGlobalConfig.implementation(this.params)
    : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformProcessGlobalConfig].
  final AqutterPlatformProcessGlobalConfigCreationParams params;

  ///{@template aqutter_core.AqutterPlatformProcessGlobalConfig.apply}
  ///Applies the configuration to be used by `WebView` on loading.
  ///This method can only be called once.
  ///
  ///Calling this method will not cause `WebView` to be loaded and will not block the calling thread.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformProcessGlobalConfig.apply.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'AqutterProcessGlobalConfig.apply',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/AqutterProcessGlobalConfig#apply(androidx.webkit.AqutterProcessGlobalConfig)',
      ),
    ],
  )
  Future<void> apply({required AqutterProcessGlobalConfigSettings settings}) {
    throw UnimplementedError(
      'apply is not implemented on the current platform',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformProcessGlobalConfigCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);

  ///{@template aqutter_core.AqutterPlatformProcessGlobalConfig.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformProcessGlobalConfigMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformProcessGlobalConfigMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}

///{@template aqutter_core.AqutterProcessGlobalConfigSettings}
///Class that represents the settings used to configure the [AqutterPlatformProcessGlobalConfig].
///{@endtemplate}
///
///{@macro aqutter_core.AqutterProcessGlobalConfigSettings.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(
      apiName: 'AqutterProcessGlobalConfig.apply',
      apiUrl:
          'https://developer.android.com/reference/androidx/webkit/AqutterProcessGlobalConfig#apply(androidx.webkit.AqutterProcessGlobalConfig)',
    ),
  ],
)
@ExchangeableObject(copyMethod: true)
class AqutterProcessGlobalConfigSettings_ {
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
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        note:
            'Available only if [AqutterWebViewFeature.STARTUP_FEATURE_SET_DATA_DIRECTORY_SUFFIX] feature is supported.',
      ),
    ],
  )
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
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        note:
            'Available only if [AqutterWebViewFeature.STARTUP_FEATURE_SET_DIRECTORY_BASE_PATHS] feature is supported.',
      ),
    ],
  )
  AqutterProcessGlobalConfigDirectoryBasePaths_? directoryBasePaths;

  AqutterProcessGlobalConfigSettings_({
    this.dataDirectorySuffix,
    this.directoryBasePaths,
  });

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
  }) => _AqutterProcessGlobalConfigSettingsPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );
}

///Class that represents the settings used to configure the [AqutterProcessGlobalConfigSettings.directoryBasePaths].
///
///**Officially Supported Platforms/Implementations**:
///- Android native WebView ([Official API - ProxyConfig](https://developer.android.com/reference/androidx/webkit/ProxyConfig))
@ExchangeableObject()
class AqutterProcessGlobalConfigDirectoryBasePaths_ {
  ///The absolute base path for the WebView data directory.
  String dataDirectoryBasePath;

  ///The absolute base path for the WebView cache directory.
  String cacheDirectoryBasePath;

  AqutterProcessGlobalConfigDirectoryBasePaths_({
    required this.dataDirectoryBasePath,
    required this.cacheDirectoryBasePath,
  });
}
