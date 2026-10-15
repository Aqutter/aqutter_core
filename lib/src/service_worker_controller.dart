import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformServiceWorkerController}
///
///{@macro aqutter_core.AqutterPlatformServiceWorkerController.supported_platforms}
class AqutterServiceWorkerController {
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController}
  AqutterServiceWorkerController()
    : this.fromPlatformCreationParams(
        const AqutterPlatformServiceWorkerControllerCreationParams(),
      );

  /// Constructs a [AqutterServiceWorkerController] from creation params for a specific
  /// platform.
  AqutterServiceWorkerController.fromPlatformCreationParams(
    AqutterPlatformServiceWorkerControllerCreationParams params,
  ) : this.fromPlatform(AqutterPlatformServiceWorkerController(params));

  /// Constructs a [AqutterServiceWorkerController] from a specific platform
  /// implementation.
  AqutterServiceWorkerController.fromPlatform(this.platform);

  /// Implementation of [AqutterPlatformServiceWorkerController] for the current platform.
  final AqutterPlatformServiceWorkerController platform;

  static AqutterServiceWorkerController? _instance;

  ///Gets the [AqutterServiceWorkerController] shared instance.
  static AqutterServiceWorkerController instance() {
    if (_instance == null) {
      _instance = AqutterServiceWorkerController();
    }
    return _instance!;
  }

  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.serviceWorkerClient}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.serviceWorkerClient.supported_platforms}
  AqutterServiceWorkerClient? get serviceWorkerClient => platform.serviceWorkerClient;

  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setServiceWorkerClient}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setServiceWorkerClient.supported_platforms}
  setServiceWorkerClient(AqutterServiceWorkerClient? value) =>
      platform.setServiceWorkerClient(value);

  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.getAllowContentAccess}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.getAllowContentAccess.supported_platforms}
  static Future<bool> getAllowContentAccess() =>
      AqutterPlatformServiceWorkerController.static().getAllowContentAccess();

  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.getAllowFileAccess}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.getAllowFileAccess.supported_platforms}
  static Future<bool> getAllowFileAccess() =>
      AqutterPlatformServiceWorkerController.static().getAllowFileAccess();

  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.getBlockNetworkLoads}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.getBlockNetworkLoads.supported_platforms}
  static Future<bool> getBlockNetworkLoads() =>
      AqutterPlatformServiceWorkerController.static().getBlockNetworkLoads();

  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.getCacheMode}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.getCacheMode.supported_platforms}
  static Future<AqutterCacheMode?> getCacheMode() =>
      AqutterPlatformServiceWorkerController.static().getCacheMode();

  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setAllowContentAccess}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setAllowContentAccess.supported_platforms}
  static Future<void> setAllowContentAccess(bool allow) =>
      AqutterPlatformServiceWorkerController.static().setAllowContentAccess(allow);

  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setAllowFileAccess}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setAllowFileAccess.supported_platforms}
  static Future<void> setAllowFileAccess(bool allow) =>
      AqutterPlatformServiceWorkerController.static().setAllowFileAccess(allow);

  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setBlockNetworkLoads}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setBlockNetworkLoads.supported_platforms}
  static Future<void> setBlockNetworkLoads(bool flag) =>
      AqutterPlatformServiceWorkerController.static().setBlockNetworkLoads(flag);

  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setCacheMode}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setCacheMode.supported_platforms}
  static Future<void> setCacheMode(AqutterCacheMode mode) =>
      AqutterPlatformServiceWorkerController.static().setCacheMode(mode);

  ///{@macro aqutter_core.AqutterPlatformServiceWorkerControllerCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformServiceWorkerController.static().isClassSupported(
        platform: platform,
      );

  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformServiceWorkerControllerMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformServiceWorkerController.static().isMethodSupported(
    method,
    platform: platform,
  );
}

///Class that represents an Android-specific class that manages Service Workers used by `WebView`.
///
///**NOTE**: available on Android 24+.
///
///**Official Android API**: https://developer.android.com/reference/androidx/webkit/ServiceWorkerControllerCompat
///
///Use [AqutterServiceWorkerController] instead.
@Deprecated("Use AqutterServiceWorkerController instead")
class AqutterAndroidServiceWorkerController {
  static AqutterAndroidServiceWorkerController? _instance;

  AqutterAndroidServiceWorkerClient? _serviceWorkerClient;

  AqutterAndroidServiceWorkerClient? get serviceWorkerClient => _serviceWorkerClient;

  ///Gets the [AqutterAndroidServiceWorkerController] shared instance.
  static AqutterAndroidServiceWorkerController instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static AqutterAndroidServiceWorkerController _init() {
    _instance = AqutterAndroidServiceWorkerController();
    return _instance!;
  }

  @Deprecated("Use setServiceWorkerClient instead")
  set serviceWorkerClient(AqutterAndroidServiceWorkerClient? value) {
    setServiceWorkerClient(value);
  }

  ///Sets the service worker client
  setServiceWorkerClient(AqutterAndroidServiceWorkerClient? value) async {
    await AqutterServiceWorkerController.instance().setServiceWorkerClient(
      value != null
          ? AqutterServiceWorkerClient(
              shouldInterceptRequest: value.shouldInterceptRequest,
            )
          : null,
    );
    _serviceWorkerClient = value;
  }

  ///Gets whether Service Workers support content URL access.
  ///This method should only be called if [AqutterAndroidWebViewFeature.isFeatureSupported] returns `true` for [AqutterAndroidWebViewFeature.SERVICE_WORKER_CONTENT_ACCESS].
  ///
  ///**NOTE**: available on Android 24+.
  ///
  ///**Official Android API**: https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#getAllowContentAccess()
  static Future<bool> getAllowContentAccess() async {
    return await AqutterServiceWorkerController.getAllowContentAccess();
  }

  ///Gets whether Service Workers support file access.
  ///This method should only be called if [AqutterAndroidWebViewFeature.isFeatureSupported] returns `true` for [AqutterAndroidWebViewFeature.SERVICE_WORKER_FILE_ACCESS].
  ///
  ///**NOTE**: available on Android 24+.
  ///
  ///**Official Android API**: https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#getAllowFileAccess()
  static Future<bool> getAllowFileAccess() async {
    return await AqutterServiceWorkerController.getAllowFileAccess();
  }

  ///Gets whether Service Workers are prohibited from loading any resources from the network.
  ///This method should only be called if [AqutterAndroidWebViewFeature.isFeatureSupported] returns `true` for [AqutterAndroidWebViewFeature.SERVICE_WORKER_BLOCK_NETWORK_LOADS].
  ///
  ///**NOTE**: available on Android 24+.
  ///
  ///**Official Android API**: https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#getBlockNetworkLoads()
  static Future<bool> getBlockNetworkLoads() async {
    return await AqutterServiceWorkerController.getBlockNetworkLoads();
  }

  ///Gets the current setting for overriding the cache mode.
  ///This method should only be called if [AqutterAndroidWebViewFeature.isFeatureSupported] returns `true` for [AqutterAndroidWebViewFeature.SERVICE_WORKER_CACHE_MODE].
  ///
  ///**NOTE**: available on Android 24+.
  ///
  ///**Official Android API**: https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#getCacheMode()
  static Future<AqutterAndroidCacheMode?> getCacheMode() async {
    return AqutterAndroidCacheMode.fromNativeValue(
      (await AqutterServiceWorkerController.getCacheMode())?.toNativeValue(),
    );
  }

  ///Enables or disables content URL access from Service Workers.
  ///This method should only be called if [AqutterAndroidWebViewFeature.isFeatureSupported] returns `true` for [AqutterAndroidWebViewFeature.SERVICE_WORKER_CONTENT_ACCESS].
  ///
  ///**NOTE**: available on Android 24+.
  ///
  ///**Official Android API**: https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#setAllowContentAccess(boolean)
  static Future<void> setAllowContentAccess(bool allow) async {
    await AqutterServiceWorkerController.setAllowContentAccess(allow);
  }

  ///Enables or disables file access within Service Workers.
  ///This method should only be called if [AqutterAndroidWebViewFeature.isFeatureSupported] returns `true` for [AqutterAndroidWebViewFeature.SERVICE_WORKER_FILE_ACCESS].
  ///
  ///**NOTE**: available on Android 24+.
  ///
  ///**Official Android API**: https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#setAllowFileAccess(boolean)
  static Future<void> setAllowFileAccess(bool allow) async {
    await AqutterServiceWorkerController.setAllowFileAccess(allow);
  }

  ///Sets whether Service Workers should not load resources from the network.
  ///This method should only be called if [AqutterAndroidWebViewFeature.isFeatureSupported] returns `true` for [AqutterAndroidWebViewFeature.SERVICE_WORKER_BLOCK_NETWORK_LOADS].
  ///
  ///**NOTE**: available on Android 24+.
  ///
  ///**Official Android API**: https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#setBlockNetworkLoads(boolean)
  static Future<void> setBlockNetworkLoads(bool flag) async {
    await AqutterServiceWorkerController.setBlockNetworkLoads(flag);
  }

  ///Overrides the way the cache is used.
  ///This method should only be called if [AqutterAndroidWebViewFeature.isFeatureSupported] returns `true` for [AqutterAndroidWebViewFeature.SERVICE_WORKER_CACHE_MODE].
  ///
  ///**NOTE**: available on Android 24+.
  ///
  ///**Official Android API**: https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#setCacheMode(int)
  static Future<void> setCacheMode(AqutterAndroidCacheMode mode) async {
    await AqutterServiceWorkerController.setCacheMode(
      AqutterCacheMode.fromNativeValue(mode.toNativeValue())!,
    );
  }
}

///Class that represents an Android-specific class for clients to capture Service Worker related callbacks.
///
///**NOTE**: available on Android 24+.
///
///**Official Android API**: https://developer.android.com/reference/androidx/webkit/ServiceWorkerClientCompat
///Use [AqutterServiceWorkerClient] instead.
@Deprecated("Use AqutterServiceWorkerClient instead")
class AqutterAndroidServiceWorkerClient {
  ///Notify the host application of a resource request and allow the application to return the data.
  ///If the return value is `null`, the Service Worker will continue to load the resource as usual.
  ///Otherwise, the return response and data will be used.
  ///
  ///This method is called only if [AqutterAndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST] is supported.
  ///You can check whether that flag is supported using [AqutterAndroidWebViewFeature.isFeatureSupported].
  ///
  ///[request] represents an object containing the details of the request.
  ///
  ///**NOTE**: available on Android 24+.
  final Future<AqutterWebResourceResponse?> Function(AqutterWebResourceRequest request)?
  shouldInterceptRequest;

  AqutterAndroidServiceWorkerClient({this.shouldInterceptRequest});
}
