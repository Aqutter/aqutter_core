import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../web_notification/platform_web_notification_controller.dart';
import '../web_uri.dart';
import 'enum_method.dart';

part 'notification_received_request.g.dart';

///Class that represents the request used by the [AqutterPlatformWebViewCreationParams.onNotificationReceived] event.
///
///This class bundles the [senderOrigin] and the [notificationController] that can be used
///to interact with the web notification (report shown, clicked, closed, etc.).
@ExchangeableObject(fromMapFactory: false)
class AqutterNotificationReceivedRequest_ {
  ///The origin of the web content that sends the notification.
  AqutterWebUri? senderOrigin;

  ///The notification controller that provides methods to interact with the notification.
  ///
  ///Use this controller to:
  ///- Report when the notification is shown via [AqutterPlatformWebNotificationController.reportShown]
  ///- Report when the notification is clicked via [AqutterPlatformWebNotificationController.reportClicked]
  ///- Report when the notification is closed via [AqutterPlatformWebNotificationController.reportClosed]
  ///- Listen for the close event via [AqutterPlatformWebNotificationController.onClose]
  ///- Access the notification data via [AqutterPlatformWebNotificationController.notification]
  AqutterPlatformWebNotificationController? notificationController;

  AqutterNotificationReceivedRequest_({
    this.senderOrigin,
    this.notificationController,
  });
}
