// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'console_message.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class representing a JavaScript console message from WebCore.
///This could be a issued by a call to one of the console logging functions (e.g. console.log('...')) or a JavaScript error on the page.
///
///To receive notifications of these messages, use the [AqutterPlatformWebViewCreationParams.onConsoleMessage] event.
class AqutterConsoleMessage {
  ///Console message
  String message;

  ///Console message level
  AqutterConsoleMessageLevel messageLevel;
  AqutterConsoleMessage({
    this.message = "",
    AqutterConsoleMessageLevel? messageLevel,
  }) : messageLevel = messageLevel ?? AqutterConsoleMessageLevel.LOG;

  ///Gets a possible [AqutterConsoleMessage] instance from a [Map] value.
  static AqutterConsoleMessage? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterConsoleMessage();
    if (map['message'] != null) {
      instance.message = map['message'];
    }
    if (map['messageLevel'] != null) {
      instance.messageLevel = switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterConsoleMessageLevel.fromNativeValue(map['messageLevel']),
        AqutterEnumMethod.value => AqutterConsoleMessageLevel.fromValue(
          map['messageLevel'],
        ),
        AqutterEnumMethod.name => AqutterConsoleMessageLevel.byName(
          map['messageLevel'],
        ),
      }!;
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "message": message,
      "messageLevel": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => messageLevel.toNativeValue(),
        AqutterEnumMethod.value => messageLevel.toValue(),
        AqutterEnumMethod.name => messageLevel.name(),
      },
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterConsoleMessage{message: $message, messageLevel: $messageLevel}';
  }
}
