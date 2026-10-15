// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'js_alert_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onJsAlert] event to control a JavaScript alert dialog.
class AqutterJsAlertResponse {
  ///Action used to confirm that the user hit confirm button.
  AqutterJsAlertResponseAction? action;

  ///Title of the confirm button.
  String confirmButtonTitle;

  ///Whether the client will handle the alert dialog.
  bool handledByClient;

  ///Message to be displayed in the window.
  String message;
  AqutterJsAlertResponse({
    AqutterJsAlertResponseAction? action,
    this.confirmButtonTitle = "",
    this.handledByClient = false,
    this.message = "",
  }) : action = action ?? AqutterJsAlertResponseAction.CONFIRM;

  ///Gets a possible [AqutterJsAlertResponse] instance from a [Map] value.
  static AqutterJsAlertResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterJsAlertResponse();
    instance.action = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterJsAlertResponseAction.fromNativeValue(map['action']),
      AqutterEnumMethod.value => AqutterJsAlertResponseAction.fromValue(
        map['action'],
      ),
      AqutterEnumMethod.name => AqutterJsAlertResponseAction.byName(
        map['action'],
      ),
    };
    if (map['confirmButtonTitle'] != null) {
      instance.confirmButtonTitle = map['confirmButtonTitle'];
    }
    if (map['handledByClient'] != null) {
      instance.handledByClient = map['handledByClient'];
    }
    if (map['message'] != null) {
      instance.message = map['message'];
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "action": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => action?.toNativeValue(),
        AqutterEnumMethod.value => action?.toValue(),
        AqutterEnumMethod.name => action?.name(),
      },
      "confirmButtonTitle": confirmButtonTitle,
      "handledByClient": handledByClient,
      "message": message,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterJsAlertResponse{action: $action, confirmButtonTitle: $confirmButtonTitle, handledByClient: $handledByClient, message: $message}';
  }
}
