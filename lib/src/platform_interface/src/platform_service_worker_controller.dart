import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'webview_platform.dart';
import 'platform_webview_feature.dart';
import 'types/main.dart';

part 'platform_service_worker_controller.g.dart';

///{@template aqutter_core.AqutterPlatformServiceWorkerControllerCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformServiceWorkerController].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformServiceWorkerControllerCreationParams.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
@immutable
class AqutterPlatformServiceWorkerControllerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformServiceWorkerController].
  const AqutterPlatformServiceWorkerControllerCreationParams();

  ///{@template aqutter_core.AqutterPlatformServiceWorkerControllerCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformServiceWorkerControllerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformServiceWorkerController}
///Class that manages Service Workers used by `WebView`.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformServiceWorkerControllerCreationParams.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(
      apiName: 'ServiceWorkerControllerCompat',
      apiUrl:
          'https://developer.android.com/reference/androidx/webkit/ServiceWorkerControllerCompat',
    ),
  ],
)
abstract class AqutterPlatformServiceWorkerController extends PlatformInterface {
  /// Creates a new [AqutterPlatformServiceWorkerController]
  factory AqutterPlatformServiceWorkerController(
    AqutterPlatformServiceWorkerControllerCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformServiceWorkerController serviceWorkerController =
        AqutterWebViewPlatform.instance!.createPlatformServiceWorkerController(
          params,
        );
    PlatformInterface.verify(serviceWorkerController, _token);
    return serviceWorkerController;
  }

  /// Creates a new [AqutterPlatformServiceWorkerController]
  factory AqutterPlatformServiceWorkerController.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformServiceWorkerController serviceWorkerControllerStatic =
        AqutterWebViewPlatform.instance!
            .createPlatformServiceWorkerControllerStatic();
    PlatformInterface.verify(serviceWorkerControllerStatic, _token);
    return serviceWorkerControllerStatic;
  }

  /// Used by the platform implementation to create a new
  /// [AqutterPlatformServiceWorkerController].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformServiceWorkerController.implementation(this.params)
    : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformServiceWorkerController].
  final AqutterPlatformServiceWorkerControllerCreationParams params;

  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.serviceWorkerClient}
  ///Service Worker client.
  ///{@endtemplate}
  AqutterServiceWorkerClient? get serviceWorkerClient;

  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.setServiceWorkerClient}
  ///Sets the client to capture service worker related callbacks.
  ///A [AqutterServiceWorkerClient] should be set before any service workers are active, e.g. a safe place is before any WebView instances are created or pages loaded.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setServiceWorkerClient.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'ServiceWorkerControllerCompat.setServiceWorkerClient',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/ServiceWorkerControllerCompat#setServiceWorkerClient(androidx.webkit.ServiceWorkerClientCompat)',
      ),
    ],
  )
  Future<void> setServiceWorkerClient(AqutterServiceWorkerClient? value) {
    throw UnimplementedError(
      'setServiceWorkerClient is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.getAllowContentAccess}
  ///Gets whether Service Workers support content URL access.
  ///This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.SERVICE_WORKER_CONTENT_ACCESS].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.getAllowContentAccess.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'ServiceWorkerWebSettingsCompat.getAllowContentAccess',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#getAllowContentAccess()',
      ),
    ],
  )
  Future<bool> getAllowContentAccess() {
    throw UnimplementedError(
      'getAllowContentAccess is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.getAllowFileAccess}
  ///Gets whether Service Workers support file access.
  ///This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.SERVICE_WORKER_FILE_ACCESS].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.getAllowFileAccess.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'ServiceWorkerWebSettingsCompat.getAllowFileAccess',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#getAllowFileAccess()',
      ),
    ],
  )
  Future<bool> getAllowFileAccess() {
    throw UnimplementedError(
      'getAllowFileAccess is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.getBlockNetworkLoads}
  ///Gets whether Service Workers are prohibited from loading any resources from the network.
  ///This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.SERVICE_WORKER_BLOCK_NETWORK_LOADS].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.getBlockNetworkLoads.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'ServiceWorkerWebSettingsCompat.getBlockNetworkLoads',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#getBlockNetworkLoads()',
      ),
    ],
  )
  Future<bool> getBlockNetworkLoads() {
    throw UnimplementedError(
      'getBlockNetworkLoads is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.getCacheMode}
  ///Gets the current setting for overriding the cache mode.
  ///This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.SERVICE_WORKER_CACHE_MODE].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.getCacheMode.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'ServiceWorkerWebSettingsCompat.getCacheMode',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#getCacheMode()',
      ),
    ],
  )
  Future<AqutterCacheMode?> getCacheMode() {
    throw UnimplementedError(
      'getCacheMode is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.setAllowContentAccess}
  ///Enables or disables content URL access from Service Workers.
  ///This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.SERVICE_WORKER_CONTENT_ACCESS].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setAllowContentAccess.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'ServiceWorkerWebSettingsCompat.setAllowContentAccess',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#setAllowContentAccess(boolean)',
      ),
    ],
  )
  Future<void> setAllowContentAccess(bool allow) {
    throw UnimplementedError(
      'setAllowContentAccess is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.setAllowFileAccess}
  ///Enables or disables file access within Service Workers.
  ///This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.SERVICE_WORKER_FILE_ACCESS].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setAllowFileAccess.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'ServiceWorkerWebSettingsCompat.setAllowFileAccess',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#setAllowFileAccess(boolean)',
      ),
    ],
  )
  Future<void> setAllowFileAccess(bool allow) {
    throw UnimplementedError(
      'setAllowFileAccess is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.setBlockNetworkLoads}
  ///Sets whether Service Workers should not load resources from the network.
  ///This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.SERVICE_WORKER_BLOCK_NETWORK_LOADS].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setBlockNetworkLoads.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'ServiceWorkerWebSettingsCompat.setBlockNetworkLoads',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#setBlockNetworkLoads(boolean)',
      ),
    ],
  )
  Future<void> setBlockNetworkLoads(bool flag) {
    throw UnimplementedError(
      'setBlockNetworkLoads is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.setCacheMode}
  ///Overrides the way the cache is used.
  ///This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.SERVICE_WORKER_CACHE_MODE].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformServiceWorkerController.setCacheMode.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'ServiceWorkerWebSettingsCompat.setCacheMode',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#setCacheMode(int)',
      ),
    ],
  )
  Future<void> setCacheMode(AqutterCacheMode mode) {
    throw UnimplementedError(
      'setCacheMode is not implemented on the current platform',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformServiceWorkerControllerCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);

  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformServiceWorkerControllerMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformServiceWorkerControllerMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}

///{@template aqutter_core.AqutterServiceWorkerClient}
///Class used by clients to capture Service Worker related callbacks.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterServiceWorkerClient.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(
      apiName: 'ServiceWorkerClientCompat',
      apiUrl:
          'https://developer.android.com/reference/androidx/webkit/ServiceWorkerClientCompat',
    ),
  ],
)
class AqutterServiceWorkerClient {
  ///{@template aqutter_core.AqutterServiceWorkerClient.shouldInterceptRequest}
  ///Notify the host application of a resource request and allow the application to return the data.
  ///If the return value is `null`, the Service Worker will continue to load the resource as usual.
  ///Otherwise, the return response and data will be used.
  ///
  ///This method is called only if [AqutterWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST] is supported.
  ///You can check whether that flag is supported using [AqutterWebViewFeature.isFeatureSupported].
  ///
  ///[request] represents an object containing the details of the request.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterServiceWorkerClient.shouldInterceptRequest.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'ServiceWorkerClientCompat.shouldInterceptRequest',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/ServiceWorkerClientCompat#shouldInterceptRequest(android.webkit.AqutterWebResourceRequest)',
      ),
    ],
  )
  final Future<AqutterWebResourceResponse?> Function(AqutterWebResourceRequest request)?
  shouldInterceptRequest;

  AqutterServiceWorkerClient({this.shouldInterceptRequest});

  ///{@template aqutter_core.AqutterServiceWorkerClient.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformServiceWorkerControllerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterServiceWorkerClient.isPropertySupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  static bool isPropertySupported(
    AqutterServiceWorkerClientProperty property, {
    TargetPlatform? platform,
  }) => _AqutterServiceWorkerClientPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );
}
