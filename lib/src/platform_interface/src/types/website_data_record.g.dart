// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'website_data_record.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents website data, grouped by domain name using the public suffix list.
class AqutterWebsiteDataRecord {
  ///The various types of website data that exist for this data record.
  Set<AqutterWebsiteDataType>? dataTypes;

  ///The display name for the data record. This is usually the domain name.
  String? displayName;
  AqutterWebsiteDataRecord({this.dataTypes, this.displayName});

  ///Gets a possible [AqutterWebsiteDataRecord] instance from a [Map] value.
  static AqutterWebsiteDataRecord? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebsiteDataRecord(
      dataTypes: map['dataTypes'] != null
          ? Set<AqutterWebsiteDataType>.from(
              map['dataTypes'].map(
                (e) => switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
                  AqutterEnumMethod.nativeValue =>
                    AqutterWebsiteDataType.fromNativeValue(e),
                  AqutterEnumMethod.value => AqutterWebsiteDataType.fromValue(
                    e,
                  ),
                  AqutterEnumMethod.name => AqutterWebsiteDataType.byName(e),
                }!,
              ),
            )
          : null,
      displayName: map['displayName'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "dataTypes": dataTypes
          ?.map(
            (e) => switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
              AqutterEnumMethod.nativeValue => e.toNativeValue(),
              AqutterEnumMethod.value => e.toValue(),
              AqutterEnumMethod.name => e.name(),
            },
          )
          .toList(),
      "displayName": displayName,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterWebsiteDataRecord{dataTypes: $dataTypes, displayName: $displayName}';
  }
}

///Class that represents website data, grouped by domain name using the public suffix list.
///
///**NOTE**: available on iOS 9.0+.
///
///Use [AqutterWebsiteDataRecord] instead.
@Deprecated('Use AqutterWebsiteDataRecord instead')
class AqutterIOSWKWebsiteDataRecord {
  ///The various types of website data that exist for this data record.
  Set<AqutterIOSWKWebsiteDataType>? dataTypes;

  ///The display name for the data record. This is usually the domain name.
  String? displayName;
  AqutterIOSWKWebsiteDataRecord({this.dataTypes, this.displayName});

  ///Gets a possible [AqutterIOSWKWebsiteDataRecord] instance from a [Map] value.
  static AqutterIOSWKWebsiteDataRecord? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterIOSWKWebsiteDataRecord(
      dataTypes: map['dataTypes'] != null
          ? Set<AqutterIOSWKWebsiteDataType>.from(
              map['dataTypes'].map(
                (e) => switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
                  AqutterEnumMethod.nativeValue =>
                    AqutterIOSWKWebsiteDataType.fromNativeValue(e),
                  AqutterEnumMethod.value =>
                    AqutterIOSWKWebsiteDataType.fromValue(e),
                  AqutterEnumMethod.name => AqutterIOSWKWebsiteDataType.byName(
                    e,
                  ),
                }!,
              ),
            )
          : null,
      displayName: map['displayName'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "dataTypes": dataTypes
          ?.map(
            (e) => switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
              AqutterEnumMethod.nativeValue => e.toNativeValue(),
              AqutterEnumMethod.value => e.toValue(),
              AqutterEnumMethod.name => e.name(),
            },
          )
          .toList(),
      "displayName": displayName,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterIOSWKWebsiteDataRecord{dataTypes: $dataTypes, displayName: $displayName}';
  }
}
