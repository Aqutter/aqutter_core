// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_focus_node_href_result.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the result used by the [AqutterPlatformWebViewController.requestFocusNodeHref] method.
class AqutterRequestFocusNodeHrefResult {
  ///The image's src attribute.
  String? src;

  ///The anchor's text.
  String? title;

  ///The anchor's href attribute.
  AqutterWebUri? url;
  AqutterRequestFocusNodeHrefResult({this.src, this.title, this.url});

  ///Gets a possible [AqutterRequestFocusNodeHrefResult] instance from a [Map] value.
  static AqutterRequestFocusNodeHrefResult? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterRequestFocusNodeHrefResult(
      src: map['src'],
      title: map['title'],
      url: map['url'] != null ? AqutterWebUri(map['url']) : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"src": src, "title": title, "url": url?.toString()};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterRequestFocusNodeHrefResult{src: $src, title: $title, url: $url}';
  }
}
