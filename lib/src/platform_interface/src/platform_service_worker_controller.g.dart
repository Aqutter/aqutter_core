// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_service_worker_controller.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformServiceWorkerControllerCreationParamsClassSupported
    on AqutterPlatformServiceWorkerControllerCreationParams {
  ///{@template aqutter_core.AqutterPlatformServiceWorkerControllerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformServiceWorkerControllerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformServiceWorkerControllerClassSupported
    on AqutterPlatformServiceWorkerController {
  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ServiceWorkerControllerCompat](https://developer.android.com/reference/androidx/webkit/ServiceWorkerControllerCompat))
  ///
  ///Use the [AqutterPlatformServiceWorkerController.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformServiceWorkerController]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformServiceWorkerControllerMethod {
  ///Can be used to check if the [AqutterPlatformServiceWorkerController.getAllowContentAccess] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.getAllowContentAccess.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ServiceWorkerWebSettingsCompat.getAllowContentAccess](https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#getAllowContentAccess()))
  ///
  ///Use the [AqutterPlatformServiceWorkerController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getAllowContentAccess,

  ///Can be used to check if the [AqutterPlatformServiceWorkerController.getAllowFileAccess] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.getAllowFileAccess.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ServiceWorkerWebSettingsCompat.getAllowFileAccess](https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#getAllowFileAccess()))
  ///
  ///Use the [AqutterPlatformServiceWorkerController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getAllowFileAccess,

  ///Can be used to check if the [AqutterPlatformServiceWorkerController.getBlockNetworkLoads] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.getBlockNetworkLoads.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ServiceWorkerWebSettingsCompat.getBlockNetworkLoads](https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#getBlockNetworkLoads()))
  ///
  ///Use the [AqutterPlatformServiceWorkerController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getBlockNetworkLoads,

  ///Can be used to check if the [AqutterPlatformServiceWorkerController.getCacheMode] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.getCacheMode.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ServiceWorkerWebSettingsCompat.getCacheMode](https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#getCacheMode()))
  ///
  ///Use the [AqutterPlatformServiceWorkerController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getCacheMode,

  ///Can be used to check if the [AqutterPlatformServiceWorkerController.setAllowContentAccess] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.setAllowContentAccess.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ServiceWorkerWebSettingsCompat.setAllowContentAccess](https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#setAllowContentAccess(boolean)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [allow]: all platforms
  ///
  ///Use the [AqutterPlatformServiceWorkerController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setAllowContentAccess,

  ///Can be used to check if the [AqutterPlatformServiceWorkerController.setAllowFileAccess] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.setAllowFileAccess.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ServiceWorkerWebSettingsCompat.setAllowFileAccess](https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#setAllowFileAccess(boolean)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [allow]: all platforms
  ///
  ///Use the [AqutterPlatformServiceWorkerController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setAllowFileAccess,

  ///Can be used to check if the [AqutterPlatformServiceWorkerController.setBlockNetworkLoads] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.setBlockNetworkLoads.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ServiceWorkerWebSettingsCompat.setBlockNetworkLoads](https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#setBlockNetworkLoads(boolean)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [flag]: all platforms
  ///
  ///Use the [AqutterPlatformServiceWorkerController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setBlockNetworkLoads,

  ///Can be used to check if the [AqutterPlatformServiceWorkerController.setCacheMode] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.setCacheMode.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ServiceWorkerWebSettingsCompat.setCacheMode](https://developer.android.com/reference/androidx/webkit/ServiceWorkerWebSettingsCompat#setCacheMode(int)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [mode]: all platforms
  ///
  ///Use the [AqutterPlatformServiceWorkerController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setCacheMode,

  ///Can be used to check if the [AqutterPlatformServiceWorkerController.setServiceWorkerClient] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformServiceWorkerController.setServiceWorkerClient.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ServiceWorkerControllerCompat.setServiceWorkerClient](https://developer.android.com/reference/androidx/webkit/ServiceWorkerControllerCompat#setServiceWorkerClient(androidx.webkit.ServiceWorkerClientCompat)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [value]: all platforms
  ///
  ///Use the [AqutterPlatformServiceWorkerController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setServiceWorkerClient,
}

extension _AqutterPlatformServiceWorkerControllerMethodSupported
    on AqutterPlatformServiceWorkerController {
  static bool isMethodSupported(
    AqutterPlatformServiceWorkerControllerMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformServiceWorkerControllerMethod.getAllowContentAccess:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformServiceWorkerControllerMethod.getAllowFileAccess:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformServiceWorkerControllerMethod.getBlockNetworkLoads:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformServiceWorkerControllerMethod.getCacheMode:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformServiceWorkerControllerMethod.setAllowContentAccess:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformServiceWorkerControllerMethod.setAllowFileAccess:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformServiceWorkerControllerMethod.setBlockNetworkLoads:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformServiceWorkerControllerMethod.setCacheMode:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformServiceWorkerControllerMethod.setServiceWorkerClient:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

extension _AqutterServiceWorkerClientClassSupported
    on AqutterServiceWorkerClient {
  ///{@template aqutter_core.AqutterServiceWorkerClient.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ServiceWorkerClientCompat](https://developer.android.com/reference/androidx/webkit/ServiceWorkerClientCompat))
  ///
  ///Use the [AqutterServiceWorkerClient.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterServiceWorkerClient]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterServiceWorkerClientProperty {
  ///Can be used to check if the [AqutterServiceWorkerClient.shouldInterceptRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterServiceWorkerClient.shouldInterceptRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ServiceWorkerClientCompat.shouldInterceptRequest](https://developer.android.com/reference/androidx/webkit/ServiceWorkerClientCompat#shouldInterceptRequest(android.webkit.AqutterWebResourceRequest)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterServiceWorkerClient.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  shouldInterceptRequest,
}

extension _AqutterServiceWorkerClientPropertySupported
    on AqutterServiceWorkerClient {
  static bool isPropertySupported(
    AqutterServiceWorkerClientProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterServiceWorkerClientProperty.shouldInterceptRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
