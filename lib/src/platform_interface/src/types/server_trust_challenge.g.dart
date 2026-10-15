// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_trust_challenge.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the challenge of the [AqutterPlatformWebViewCreationParams.onReceivedServerTrustAuthRequest] event.
///It provides all the information about the challenge.
class AqutterServerTrustChallenge extends AqutterURLAuthenticationChallenge {
  AqutterServerTrustChallenge({
    required AqutterURLProtectionSpace protectionSpace,
  }) : super(protectionSpace: protectionSpace);

  ///Gets a possible [AqutterServerTrustChallenge] instance from a [Map] value.
  static AqutterServerTrustChallenge? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterServerTrustChallenge(
      protectionSpace: AqutterURLProtectionSpace.fromMap(
        map['protectionSpace']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      )!,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"protectionSpace": protectionSpace.toMap(enumMethod: enumMethod)};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterServerTrustChallenge{protectionSpace: $protectionSpace}';
  }
}
