import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformWebNotificationController}
///
///{@macro aqutter_core.AqutterPlatformWebNotificationController.supported_platforms}
class AqutterWebNotificationController {
  ///{@macro aqutter_core.AqutterPlatformWebNotificationController}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.supported_platforms}
  AqutterWebNotificationController({
    required String id,
    required AqutterWebNotification notification,
  }) : this.fromPlatformCreationParams(
         params: AqutterPlatformWebNotificationControllerCreationParams(
           id: id,
           notification: notification,
         ),
       );

  /// Constructs a [AqutterWebNotificationController].
  ///
  /// See [AqutterWebNotificationController.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterWebNotificationController.fromPlatformCreationParams({
    required AqutterPlatformWebNotificationControllerCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformWebNotificationController(params));

  /// Constructs a [AqutterWebNotificationController] from a specific platform implementation.
  AqutterWebNotificationController.fromPlatform({required this.platform});

  /// Implementation of [AqutterPlatformWebNotificationController] for the current platform.
  final AqutterPlatformWebNotificationController platform;

  ///{@macro aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.id}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.id.supported_platforms}
  String get id => platform.id;

  ///{@macro aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.notification}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.notification.supported_platforms}
  AqutterWebNotification get notification => platform.notification;

  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.onClose}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.onClose.supported_platforms}
  AqutterWebNotificationCloseHandler? get onClose => platform.onClose;

  void set onClose(AqutterWebNotificationCloseHandler? handler) {
    platform.onClose = handler;
  }

  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.reportShown}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.reportShown.supported_platforms}
  Future<void> reportShown() => platform.reportShown();

  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.reportClicked}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.reportClicked.supported_platforms}
  Future<void> reportClicked() => platform.reportClicked();

  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.reportClosed}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.reportClosed.supported_platforms}
  Future<void> reportClosed() => platform.reportClosed();

  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.dispose}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.dispose.supported_platforms}
  void dispose() => platform.dispose();

  ///{@macro aqutter_core.AqutterPlatformWebNotificationControllerCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformWebNotificationController.static().isClassSupported(
        platform: platform,
      );

  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.isPropertySupported}
  static bool isPropertySupported(
    dynamic property, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebNotificationController.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformWebNotificationController.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformWebNotificationControllerMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebNotificationController.static().isMethodSupported(
    method,
    platform: platform,
  );
}
