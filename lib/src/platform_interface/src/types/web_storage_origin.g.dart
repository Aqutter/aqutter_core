// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_storage_origin.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that encapsulates information about the amount of storage currently used by an origin for the JavaScript storage APIs.
///An origin comprises the host, scheme and port of a URI. See [AqutterPlatformWebStorageManager] for details.
class AqutterWebStorageOrigin {
  ///The string representation of this origin.
  String? origin;

  ///The quota for this origin, for the Web SQL Database API, in bytes.
  int? quota;

  ///The total amount of storage currently being used by this origin, for all JavaScript storage APIs, in bytes.
  int? usage;
  AqutterWebStorageOrigin({this.origin, this.quota, this.usage});

  ///Gets a possible [AqutterWebStorageOrigin] instance from a [Map] value.
  static AqutterWebStorageOrigin? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebStorageOrigin(
      origin: map['origin'],
      quota: map['quota'],
      usage: map['usage'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"origin": origin, "quota": quota, "usage": usage};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterWebStorageOrigin{origin: $origin, quota: $quota, usage: $usage}';
  }
}

///Class that encapsulates information about the amount of storage currently used by an origin for the JavaScript storage APIs.
///An origin comprises the host, scheme and port of a URI. See `AqutterAndroidWebStorageManager` for details.
///Use [AqutterWebStorageOrigin] instead.
@Deprecated('Use AqutterWebStorageOrigin instead')
class AqutterAndroidWebStorageOrigin {
  ///The string representation of this origin.
  String? origin;

  ///The quota for this origin, for the Web SQL Database API, in bytes.
  int? quota;

  ///The total amount of storage currently being used by this origin, for all JavaScript storage APIs, in bytes.
  int? usage;
  AqutterAndroidWebStorageOrigin({this.origin, this.quota, this.usage});

  ///Gets a possible [AqutterAndroidWebStorageOrigin] instance from a [Map] value.
  static AqutterAndroidWebStorageOrigin? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterAndroidWebStorageOrigin(
      origin: map['origin'],
      quota: map['quota'],
      usage: map['usage'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"origin": origin, "quota": quota, "usage": usage};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterAndroidWebStorageOrigin{origin: $origin, quota: $quota, usage: $usage}';
  }
}
