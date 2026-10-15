// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_storage_item.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents a single web storage item of the JavaScript `window.sessionStorage` and `window.localStorage` objects.
class AqutterWebStorageItem {
  ///Item key.
  String? key;

  ///Item value.
  dynamic value;
  AqutterWebStorageItem({this.key, this.value});

  ///Gets a possible [AqutterWebStorageItem] instance from a [Map] value.
  static AqutterWebStorageItem? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebStorageItem(
      key: map['key'],
      value: map['value'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"key": key, "value": value};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterWebStorageItem{key: $key, value: $value}';
  }
}
