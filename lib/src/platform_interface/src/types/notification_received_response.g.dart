// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_received_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onNotificationReceived] event.
class AqutterNotificationReceivedResponse {
  ///Set to `true` to indicate the notification has been handled by the host.
  bool handled;
  AqutterNotificationReceivedResponse({required this.handled});

  ///Gets a possible [AqutterNotificationReceivedResponse] instance from a [Map] value.
  static AqutterNotificationReceivedResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterNotificationReceivedResponse(
      handled: map['handled'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"handled": handled};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterNotificationReceivedResponse{handled: $handled}';
  }
}
