// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_image_ref_result.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the result used by the [AqutterPlatformWebViewController.requestImageRef] method.
class AqutterRequestImageRefResult {
  ///The image's url.
  AqutterWebUri? url;
  AqutterRequestImageRefResult({this.url});

  ///Gets a possible [AqutterRequestImageRefResult] instance from a [Map] value.
  static AqutterRequestImageRefResult? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterRequestImageRefResult(
      url: map['url'] != null ? AqutterWebUri(map['url']) : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"url": url?.toString()};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterRequestImageRefResult{url: $url}';
  }
}
