// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_print_job_controller.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformPrintJobControllerCreationParamsClassSupported
    on AqutterPlatformPrintJobControllerCreationParams {
  ///{@template aqutter_core.AqutterPlatformPrintJobControllerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformPrintJobControllerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.windows,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformPrintJobControllerCreationParams]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformPrintJobControllerCreationParamsProperty {
  ///Can be used to check if the [AqutterPlatformPrintJobControllerCreationParams.id] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPrintJobControllerCreationParams.id.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformPrintJobControllerCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  id,
}

extension _AqutterPlatformPrintJobControllerCreationParamsPropertySupported
    on AqutterPlatformPrintJobControllerCreationParams {
  static bool isPropertySupported(
    AqutterPlatformPrintJobControllerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformPrintJobControllerCreationParamsProperty.id:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

extension _AqutterPlatformPrintJobControllerClassSupported
    on AqutterPlatformPrintJobController {
  ///{@template aqutter_core.AqutterPlatformPrintJobController.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformPrintJobController.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.windows,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformPrintJobController]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformPrintJobControllerProperty {
  ///Can be used to check if the [AqutterPlatformPrintJobController.onComplete] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPrintJobController.onComplete.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - PrintDocumentAdapter.onFinish](https://developer.android.com/reference/android/print/PrintDocumentAdapter#onFinish())):
  ///    - `completed` is always `true` and `error` is always `null`.
  ///- iOS WKWebView ([Official API - UIPrintInteractionController.CompletionHandler](https://developer.apple.com/documentation/uikit/uiprintinteractioncontroller/completionhandler))
  ///- macOS WKWebView ([Official API - NSPrintOperation.runModal](https://developer.apple.com/documentation/appkit/nsprintoperation/1532065-runmodal))
  ///- Windows WebView2
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [completed]: all platforms
  ///- [error]: all platforms
  ///
  ///Use the [AqutterPlatformPrintJobController.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onComplete,
}

extension _AqutterPlatformPrintJobControllerPropertySupported
    on AqutterPlatformPrintJobController {
  static bool isPropertySupported(
    AqutterPlatformPrintJobControllerProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformPrintJobControllerProperty.onComplete:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

///List of [AqutterPlatformPrintJobController]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformPrintJobControllerMethod {
  ///Can be used to check if the [AqutterPlatformPrintJobController.cancel] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPrintJobController.cancel.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - PrintJob.cancel](https://developer.android.com/reference/android/print/PrintJob#cancel()))
  ///
  ///Use the [AqutterPlatformPrintJobController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  cancel,

  ///Can be used to check if the [AqutterPlatformPrintJobController.dismiss] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPrintJobController.dismiss.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [animated]: all platforms
  ///
  ///Use the [AqutterPlatformPrintJobController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dismiss,

  ///Can be used to check if the [AqutterPlatformPrintJobController.dispose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPrintJobController.dispose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformPrintJobController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dispose,

  ///Can be used to check if the [AqutterPlatformPrintJobController.getInfo] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPrintJobController.getInfo.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - PrintJob.getInfo](https://developer.android.com/reference/android/print/PrintJob#getInfo()))
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformPrintJobController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getInfo,

  ///Can be used to check if the [AqutterPlatformPrintJobController.restart] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPrintJobController.restart.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - PrintJob.restart](https://developer.android.com/reference/android/print/PrintJob#restart()))
  ///
  ///Use the [AqutterPlatformPrintJobController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  restart,
}

extension _AqutterPlatformPrintJobControllerMethodSupported
    on AqutterPlatformPrintJobController {
  static bool isMethodSupported(
    AqutterPlatformPrintJobControllerMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformPrintJobControllerMethod.cancel:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPrintJobControllerMethod.dismiss:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPrintJobControllerMethod.dispose:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPrintJobControllerMethod.getInfo:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPrintJobControllerMethod.restart:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
