// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_auth_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onReceivedHttpAuthRequest] event.
class AqutterHttpAuthResponse {
  ///Indicate the [AqutterHttpAuthResponseAction] to take in response of the authentication challenge.
  AqutterHttpAuthResponseAction? action;

  ///Represents the password used for the authentication if the [action] corresponds to [AqutterHttpAuthResponseAction.PROCEED]
  String password;

  ///Indicate if the given credentials need to be saved permanently.
  bool permanentPersistence;

  ///Represents the username used for the authentication if the [action] corresponds to [AqutterHttpAuthResponseAction.PROCEED]
  String username;
  AqutterHttpAuthResponse({
    AqutterHttpAuthResponseAction? action,
    this.password = "",
    this.permanentPersistence = false,
    this.username = "",
  }) : action = action ?? AqutterHttpAuthResponseAction.CANCEL;

  ///Gets a possible [AqutterHttpAuthResponse] instance from a [Map] value.
  static AqutterHttpAuthResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterHttpAuthResponse();
    instance.action = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterHttpAuthResponseAction.fromNativeValue(map['action']),
      AqutterEnumMethod.value => AqutterHttpAuthResponseAction.fromValue(
        map['action'],
      ),
      AqutterEnumMethod.name => AqutterHttpAuthResponseAction.byName(
        map['action'],
      ),
    };
    if (map['password'] != null) {
      instance.password = map['password'];
    }
    if (map['permanentPersistence'] != null) {
      instance.permanentPersistence = map['permanentPersistence'];
    }
    if (map['username'] != null) {
      instance.username = map['username'];
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
      "password": password,
      "permanentPersistence": permanentPersistence,
      "username": username,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterHttpAuthResponse{action: $action, password: $password, permanentPersistence: $permanentPersistence, username: $username}';
  }
}
