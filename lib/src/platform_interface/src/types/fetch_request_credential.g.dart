// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_request_credential.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that is an interface for [AqutterFetchRequestCredentialDefault], [AqutterFetchRequestFederatedCredential] and [AqutterFetchRequestPasswordCredential] classes.
class AqutterFetchRequestCredential {
  ///Type of credentials.
  String? type;
  AqutterFetchRequestCredential({this.type});

  ///Gets a possible [AqutterFetchRequestCredential] instance from a [Map] value.
  static AqutterFetchRequestCredential? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterFetchRequestCredential(type: map['type']);
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"type": type};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterFetchRequestCredential{type: $type}';
  }
}
