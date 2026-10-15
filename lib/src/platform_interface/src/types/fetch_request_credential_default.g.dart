// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_request_credential_default.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the default credentials used by an [AqutterFetchRequest].
class AqutterFetchRequestCredentialDefault
    extends AqutterFetchRequestCredential {
  ///The value of the credentials.
  String? value;
  AqutterFetchRequestCredentialDefault({this.value, String? type})
    : super(type: type);

  ///Gets a possible [AqutterFetchRequestCredentialDefault] instance from a [Map] value.
  static AqutterFetchRequestCredentialDefault? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterFetchRequestCredentialDefault(value: map['value']);
    instance.type = map['type'];
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"type": type, "value": value};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterFetchRequestCredentialDefault{type: $type, value: $value}';
  }
}
