// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_trust_auth_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onReceivedServerTrustAuthRequest] event.
class AqutterServerTrustAuthResponse {
  ///Indicate the [AqutterServerTrustAuthResponseAction] to take in response of the server trust authentication challenge.
  AqutterServerTrustAuthResponseAction? action;
  AqutterServerTrustAuthResponse({AqutterServerTrustAuthResponseAction? action})
    : action = action ?? AqutterServerTrustAuthResponseAction.CANCEL;

  ///Gets a possible [AqutterServerTrustAuthResponse] instance from a [Map] value.
  static AqutterServerTrustAuthResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterServerTrustAuthResponse();
    instance.action = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterServerTrustAuthResponseAction.fromNativeValue(map['action']),
      AqutterEnumMethod.value => AqutterServerTrustAuthResponseAction.fromValue(
        map['action'],
      ),
      AqutterEnumMethod.name => AqutterServerTrustAuthResponseAction.byName(
        map['action'],
      ),
    };
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
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterServerTrustAuthResponse{action: $action}';
  }
}
