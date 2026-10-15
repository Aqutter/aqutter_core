// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_tag_attribute.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents an attribute of a `<meta>` HTML tag. It is used by the [AqutterMetaTag] class.
class AqutterMetaTagAttribute {
  ///The attribute name.
  String? name;

  ///The attribute value.
  String? value;
  AqutterMetaTagAttribute({this.name, this.value});

  ///Gets a possible [AqutterMetaTagAttribute] instance from a [Map] value.
  static AqutterMetaTagAttribute? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterMetaTagAttribute(
      name: map['name'],
      value: map['value'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"name": name, "value": value};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterMetaTagAttribute{name: $name, value: $value}';
  }
}
