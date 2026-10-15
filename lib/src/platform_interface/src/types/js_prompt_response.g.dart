// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'js_prompt_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onJsPrompt] event to control a JavaScript prompt dialog.
class AqutterJsPromptResponse {
  ///Action used to confirm that the user hit confirm or cancel button.
  AqutterJsPromptResponseAction? action;

  ///Title of the cancel button.
  String cancelButtonTitle;

  ///Title of the confirm button.
  String confirmButtonTitle;

  ///The default value displayed in the prompt dialog.
  String defaultValue;

  ///Whether the client will handle the prompt dialog.
  bool handledByClient;

  ///Message to be displayed in the window.
  String message;

  ///Value of the prompt dialog.
  String? value;
  AqutterJsPromptResponse({
    AqutterJsPromptResponseAction? action,
    this.cancelButtonTitle = "",
    this.confirmButtonTitle = "",
    this.defaultValue = "",
    this.handledByClient = false,
    this.message = "",
    this.value,
  }) : action = action ?? AqutterJsPromptResponseAction.CANCEL;

  ///Gets a possible [AqutterJsPromptResponse] instance from a [Map] value.
  static AqutterJsPromptResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterJsPromptResponse(value: map['value']);
    instance.action = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterJsPromptResponseAction.fromNativeValue(map['action']),
      AqutterEnumMethod.value => AqutterJsPromptResponseAction.fromValue(
        map['action'],
      ),
      AqutterEnumMethod.name => AqutterJsPromptResponseAction.byName(
        map['action'],
      ),
    };
    if (map['cancelButtonTitle'] != null) {
      instance.cancelButtonTitle = map['cancelButtonTitle'];
    }
    if (map['confirmButtonTitle'] != null) {
      instance.confirmButtonTitle = map['confirmButtonTitle'];
    }
    if (map['defaultValue'] != null) {
      instance.defaultValue = map['defaultValue'];
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
      "defaultValue": defaultValue,
      "handledByClient": handledByClient,
      "message": message,
      "value": value,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterJsPromptResponse{action: $action, cancelButtonTitle: $cancelButtonTitle, confirmButtonTitle: $confirmButtonTitle, defaultValue: $defaultValue, handledByClient: $handledByClient, message: $message, value: $value}';
  }
}
