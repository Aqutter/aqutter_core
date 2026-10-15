// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_received_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the request used by the [AqutterPlatformWebViewCreationParams.onNotificationReceived] event.
///
///This class bundles the [senderOrigin] and the [notificationController] that can be used
///to interact with the web notification (report shown, clicked, closed, etc.).
class AqutterNotificationReceivedRequest {
  ///The notification controller that provides methods to interact with the notification.
  ///
  ///Use this controller to:
  ///- Report when the notification is shown via [AqutterPlatformWebNotificationController.reportShown]
  ///- Report when the notification is clicked via [AqutterPlatformWebNotificationController.reportClicked]
  ///- Report when the notification is closed via [AqutterPlatformWebNotificationController.reportClosed]
  ///- Listen for the close event via [AqutterPlatformWebNotificationController.onClose]
  ///- Access the notification data via [AqutterPlatformWebNotificationController.notification]
  AqutterPlatformWebNotificationController? notificationController;

  ///The origin of the web content that sends the notification.
  AqutterWebUri? senderOrigin;
  AqutterNotificationReceivedRequest({
    this.notificationController,
    this.senderOrigin,
  });

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "notificationController": notificationController,
      "senderOrigin": senderOrigin?.toString(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterNotificationReceivedRequest{notificationController: $notificationController, senderOrigin: $senderOrigin}';
  }
}
