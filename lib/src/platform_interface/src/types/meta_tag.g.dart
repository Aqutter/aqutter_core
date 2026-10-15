// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_tag.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents a `<meta>` HTML tag. It is used by the [AqutterPlatformWebViewController.getMetaTags] method.
class AqutterMetaTag {
  ///The meta tag attributes list.
  List<AqutterMetaTagAttribute>? attrs;

  ///The meta tag content value.
  String? content;

  ///The meta tag name value.
  String? name;
  AqutterMetaTag({this.attrs, this.content, this.name});

  ///Gets a possible [AqutterMetaTag] instance from a [Map] value.
  static AqutterMetaTag? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterMetaTag(
      attrs: map['attrs'] != null
          ? List<AqutterMetaTagAttribute>.from(
              map['attrs'].map(
                (e) => AqutterMetaTagAttribute.fromMap(
                  e?.cast<String, dynamic>(),
                  enumMethod: enumMethod,
                )!,
              ),
            )
          : null,
      content: map['content'],
      name: map['name'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "attrs": attrs?.map((e) => e.toMap(enumMethod: enumMethod)).toList(),
      "content": content,
      "name": name,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterMetaTag{attrs: $attrs, content: $content, name: $name}';
  }
}
