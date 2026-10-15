// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'js_confirm_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onJsConfirm] event to control a JavaScript confirm dialog.
class AqutterJsConfirmResponse {
  ///Action used to confirm that the user hit confirm or cancel button.
  AqutterJsConfirmResponseAction? action;

  ///Title of the cancel button.
  String cancelButtonTitle;

  ///Title of the confirm button.
  String confirmButtonTitle;

  ///Whether the client will handle the confirm dialog.
  bool handledByClient;

  ///Message to be displayed in the window.
  String message;
  AqutterJsConfirmResponse({
    AqutterJsConfirmResponseAction? action,
    this.cancelButtonTitle = "",
    this.confirmButtonTitle = "",
    this.handledByClient = false,
    this.message = "",
  }) : action = action ?? AqutterJsConfirmResponseAction.CANCEL;

  ///Gets a possible [AqutterJsConfirmResponse] instance from a [Map] value.
  static AqutterJsConfirmResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterJsConfirmResponse();
    instance.action = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterJsConfirmResponseAction.fromNativeValue(map['action']),
      AqutterEnumMethod.value => AqutterJsConfirmResponseAction.fromValue(
        map['action'],
      ),
      AqutterEnumMethod.name => AqutterJsConfirmResponseAction.byName(
        map['action'],
      ),
    };
    if (map['cancelButtonTitle'] != null) {
      instance.cancelButtonTitle = map['cancelButtonTitle'];
    }
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
      "cancelButtonTitle": cancelButtonTitle,
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
    return 'AqutterJsConfirmResponse{action: $action, cancelButtonTitle: $cancelButtonTitle, confirmButtonTitle: $confirmButtonTitle, handledByClient: $handledByClient, message: $message}';
  }
}
