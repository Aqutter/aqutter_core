import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../webview_platform.dart';
import '../types/disposable.dart';
import '../types/web_notification.dart';

// ignore: uri_has_not_been_generated
part 'platform_web_notification_controller.g.dart';

///{@template aqutter_core.AqutterPlatformWebNotificationControllerCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformWebNotificationController].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.supported_platforms}
@SupportedPlatforms(platforms: [WindowsPlatform()])
@immutable
class AqutterPlatformWebNotificationControllerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformWebNotificationController].
  const AqutterPlatformWebNotificationControllerCreationParams({
    required this.id,
    required this.notification,
  });

  ///{@template aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.id}
  ///Web notification ID.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.id.supported_platforms}
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  final String id;

  ///{@template aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.notification}
  ///The notification data.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.notification.supported_platforms}
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  final AqutterWebNotification notification;

  ///{@template aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebNotificationControllerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformWebNotificationControllerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) =>
      _AqutterPlatformWebNotificationControllerCreationParamsPropertySupported.isPropertySupported(
        property,
        platform: platform,
      );
}

///A completion handler for the [AqutterPlatformWebNotificationController.onClose] event.
typedef AqutterWebNotificationCloseHandler = Future<void> Function()?;

///{@template aqutter_core.AqutterPlatformWebNotificationController}
///Class representing a web notification controller.
///
///This class provides methods to report the notification has been displayed, clicked, or closed
///as required by the [ICoreWebView2Notification](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notification?view=webview2-1.0.3595.46) interface.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebNotificationController.supported_platforms}
@SupportedPlatforms(platforms: [WindowsPlatform()])
abstract class AqutterPlatformWebNotificationController extends PlatformInterface
    implements AqutterDisposable {
  /// Creates a new [AqutterPlatformWebNotificationController]
  factory AqutterPlatformWebNotificationController(
    AqutterPlatformWebNotificationControllerCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebNotificationController webNotificationController =
        AqutterWebViewPlatform.instance!.createPlatformWebNotificationController(
          params,
        );
    PlatformInterface.verify(webNotificationController, _token);
    return webNotificationController;
  }

  /// Creates a new empty [AqutterPlatformWebNotificationController] to access static methods.
  factory AqutterPlatformWebNotificationController.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebNotificationController webNotificationControllerStatic =
        AqutterWebViewPlatform.instance!
            .createPlatformWebNotificationControllerStatic();
    PlatformInterface.verify(webNotificationControllerStatic, _token);
    return webNotificationControllerStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformWebNotificationController].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformWebNotificationController.implementation(this.params)
    : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformWebNotificationController].
  final AqutterPlatformWebNotificationControllerCreationParams params;

  ///{@macro aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.id}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.id.supported_platforms}
  String get id => params.id;

  ///{@macro aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.notification}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.notification.supported_platforms}
  AqutterWebNotification get notification => params.notification;

  ///{@template aqutter_core.AqutterPlatformWebNotificationController.onClose}
  ///Event fired when the notification is closed by the web code, such as through `notification.close()`.
  ///
  ///You don't need to call [reportClosed] since this is coming from the web code.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.onClose.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2Notification.add_CloseRequested',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notification?view=webview2-1.0.3595.46#add_closerequested',
      ),
    ],
  )
  AqutterWebNotificationCloseHandler? onClose;

  ///{@template aqutter_core.AqutterPlatformWebNotificationController.reportShown}
  ///The host may run this to report the notification has been displayed
  ///and it will cause the [show](https://developer.mozilla.org/docs/Web/API/Notification/show_event) event
  ///to be raised for non-persistent notifications.
  ///
  ///You must not run this unless you are handling the `onNotificationReceived` event.
  ///Returns `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)` if `handled` is `false` when this is called.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.reportShown.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2Notification.ReportShown',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notification?view=webview2-1.0.3595.46#reportshown',
      ),
    ],
  )
  Future<void> reportShown() {
    throw UnimplementedError(
      'reportShown is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebNotificationController.reportClicked}
  ///The host may run this to report the notification has been clicked,
  ///and it will cause the [click](https://developer.mozilla.org/docs/Web/API/Notification/click_event) event
  ///to be raised for non-persistent notifications and the
  ///[notificationclick](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope/notificationclick_event)
  ///event for persistent notifications.
  ///
  ///You must not run this unless you are handling the `onNotificationReceived` event.
  ///Returns `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)` if `handled` is `false` or [reportShown] has not been run when this is called.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.reportClicked.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2Notification.ReportClicked',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notification?view=webview2-1.0.3595.46#reportclicked',
      ),
    ],
  )
  Future<void> reportClicked() {
    throw UnimplementedError(
      'reportClicked is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebNotificationController.reportClosed}
  ///The host may run this to report the notification was dismissed,
  ///and it will cause the [close](https://developer.mozilla.org/docs/Web/API/Notification/close_event) event
  ///to be raised for non-persistent notifications and the
  ///[notificationclose](https://developer.mozilla.org/docs/Web/API/ServiceWorkerGlobalScope/notificationclose_event)
  ///event for persistent notifications.
  ///
  ///You must not run this unless you are handling the `onNotificationReceived` event.
  ///Returns `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)` if `handled` is `false` or [reportShown] has not been run when this is called.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.reportClosed.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2Notification.ReportClosed',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notification?view=webview2-1.0.3595.46#reportclosed',
      ),
    ],
  )
  Future<void> reportClosed() {
    throw UnimplementedError(
      'reportClosed is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebNotificationController.dispose}
  ///Disposes the web notification controller.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.dispose.supported_platforms}
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  @override
  void dispose() {
    throw UnimplementedError(
      'dispose is not implemented on the current platform',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);

  ///{@template aqutter_core.AqutterPlatformWebNotificationController.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///The property should be one of the [AqutterPlatformWebNotificationControllerProperty] or [AqutterPlatformWebNotificationControllerCreationParamsProperty] values.
  ///{@endtemplate}
  bool isPropertySupported(dynamic property, {TargetPlatform? platform}) =>
      property is AqutterPlatformWebNotificationControllerCreationParamsProperty
      ? params.isPropertySupported(property, platform: platform)
      : _AqutterPlatformWebNotificationControllerPropertySupported.isPropertySupported(
          property,
          platform: platform,
        );

  ///{@template aqutter_core.AqutterPlatformWebNotificationController.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformWebNotificationControllerMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformWebNotificationControllerMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}
