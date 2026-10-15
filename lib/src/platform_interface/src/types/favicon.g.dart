// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favicon.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents a favicon of a website. It is used by [AqutterPlatformWebViewController.getFavicons] method.
class AqutterFavicon {
  ///The height of the favicon image.
  int? height;

  ///The relationship between the current web page and the favicon image.
  String? rel;

  ///The url of the favicon image.
  AqutterWebUri url;

  ///The width of the favicon image.
  int? width;
  AqutterFavicon({this.height, this.rel, required this.url, this.width});

  ///Gets a possible [AqutterFavicon] instance from a [Map] value.
  static AqutterFavicon? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterFavicon(
      height: map['height'],
      rel: map['rel'],
      url: AqutterWebUri(map['url']),
      width: map['width'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "height": height,
      "rel": rel,
      "url": url.toString(),
      "width": width,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterFavicon{height: $height, rel: $rel, url: $url, width: $width}';
  }
}
