// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_web_notification_controller.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformWebNotificationControllerCreationParamsClassSupported
    on AqutterPlatformWebNotificationControllerCreationParams {
  ///{@template aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebNotificationControllerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.windows].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformWebNotificationControllerCreationParams]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformWebNotificationControllerCreationParamsProperty {
  ///Can be used to check if the [AqutterPlatformWebNotificationControllerCreationParams.id] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.id.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebNotificationControllerCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  id,

  ///Can be used to check if the [AqutterPlatformWebNotificationControllerCreationParams.notification] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.notification.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebNotificationControllerCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  notification,
}

extension _AqutterPlatformWebNotificationControllerCreationParamsPropertySupported
    on AqutterPlatformWebNotificationControllerCreationParams {
  static bool isPropertySupported(
    AqutterPlatformWebNotificationControllerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformWebNotificationControllerCreationParamsProperty.id:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebNotificationControllerCreationParamsProperty
          .notification:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

extension _AqutterPlatformWebNotificationControllerClassSupported
    on AqutterPlatformWebNotificationController {
  ///{@template aqutter_core.AqutterPlatformWebNotificationController.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebNotificationController.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.windows].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformWebNotificationController]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformWebNotificationControllerProperty {
  ///Can be used to check if the [AqutterPlatformWebNotificationController.onClose] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebNotificationController.onClose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2Notification.add_CloseRequested](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notification?view=webview2-1.0.3595.46#add_closerequested))
  ///
  ///Use the [AqutterPlatformWebNotificationController.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onClose,
}

extension _AqutterPlatformWebNotificationControllerPropertySupported
    on AqutterPlatformWebNotificationController {
  static bool isPropertySupported(
    AqutterPlatformWebNotificationControllerProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformWebNotificationControllerProperty.onClose:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

///List of [AqutterPlatformWebNotificationController]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformWebNotificationControllerMethod {
  ///Can be used to check if the [AqutterPlatformWebNotificationController.dispose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebNotificationController.dispose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebNotificationController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dispose,

  ///Can be used to check if the [AqutterPlatformWebNotificationController.reportClicked] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebNotificationController.reportClicked.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2Notification.ReportClicked](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notification?view=webview2-1.0.3595.46#reportclicked))
  ///
  ///Use the [AqutterPlatformWebNotificationController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  reportClicked,

  ///Can be used to check if the [AqutterPlatformWebNotificationController.reportClosed] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebNotificationController.reportClosed.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2Notification.ReportClosed](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notification?view=webview2-1.0.3595.46#reportclosed))
  ///
  ///Use the [AqutterPlatformWebNotificationController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  reportClosed,

  ///Can be used to check if the [AqutterPlatformWebNotificationController.reportShown] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebNotificationController.reportShown.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2Notification.ReportShown](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notification?view=webview2-1.0.3595.46#reportshown))
  ///
  ///Use the [AqutterPlatformWebNotificationController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  reportShown,
}

extension _AqutterPlatformWebNotificationControllerMethodSupported
    on AqutterPlatformWebNotificationController {
  static bool isMethodSupported(
    AqutterPlatformWebNotificationControllerMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformWebNotificationControllerMethod.dispose:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebNotificationControllerMethod.reportClicked:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebNotificationControllerMethod.reportClosed:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebNotificationControllerMethod.reportShown:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
