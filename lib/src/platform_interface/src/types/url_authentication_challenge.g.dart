// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_authentication_challenge.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents a challenge from a server requiring authentication from the client.
///It provides all the information about the challenge.
class AqutterURLAuthenticationChallenge {
  ///The protection space requiring authentication.
  AqutterURLProtectionSpace protectionSpace;
  AqutterURLAuthenticationChallenge({required this.protectionSpace});

  ///Gets a possible [AqutterURLAuthenticationChallenge] instance from a [Map] value.
  static AqutterURLAuthenticationChallenge? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterURLAuthenticationChallenge(
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
    return 'AqutterURLAuthenticationChallenge{protectionSpace: $protectionSpace}';
  }
}
