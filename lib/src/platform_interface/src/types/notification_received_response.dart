import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'enum_method.dart';

part 'notification_received_response.g.dart';

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onNotificationReceived] event.
@ExchangeableObject()
class AqutterNotificationReceivedResponse_ {
  ///Set to `true` to indicate the notification has been handled by the host.
  bool handled;

  AqutterNotificationReceivedResponse_({required this.handled});
}
