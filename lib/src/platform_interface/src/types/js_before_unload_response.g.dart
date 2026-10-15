// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'js_before_unload_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onJsBeforeUnload] event to control a JavaScript alert dialog.
class AqutterJsBeforeUnloadResponse {
  ///Action used to confirm that the user hit confirm or cancel button.
  AqutterJsBeforeUnloadResponseAction? action;

  ///Title of the cancel button.
  String cancelButtonTitle;

  ///Title of the confirm button.
  String confirmButtonTitle;

  ///Whether the client will handle the alert dialog.
  bool handledByClient;

  ///Message to be displayed in the window.
  String message;
  AqutterJsBeforeUnloadResponse({
    AqutterJsBeforeUnloadResponseAction? action,
    this.cancelButtonTitle = "",
    this.confirmButtonTitle = "",
    this.handledByClient = false,
    this.message = "",
  }) : action = action ?? AqutterJsBeforeUnloadResponseAction.CONFIRM;

  ///Gets a possible [AqutterJsBeforeUnloadResponse] instance from a [Map] value.
  static AqutterJsBeforeUnloadResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterJsBeforeUnloadResponse();
    instance.action = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterJsBeforeUnloadResponseAction.fromNativeValue(map['action']),
      AqutterEnumMethod.value => AqutterJsBeforeUnloadResponseAction.fromValue(
        map['action'],
      ),
      AqutterEnumMethod.name => AqutterJsBeforeUnloadResponseAction.byName(
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
    return 'AqutterJsBeforeUnloadResponse{action: $action, cancelButtonTitle: $cancelButtonTitle, confirmButtonTitle: $confirmButtonTitle, handledByClient: $handledByClient, message: $message}';
  }
}
