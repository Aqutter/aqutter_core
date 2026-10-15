// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favicon_changed_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the request used by the [AqutterPlatformWebViewCreationParams.onFaviconChanged] event.
class AqutterFaviconChangedRequest {
  ///The favicon bytes for the current page, if available.
  Uint8List? icon;

  ///The favicon URL for the current page, if available.
  AqutterWebUri? url;
  AqutterFaviconChangedRequest({this.icon, this.url});

  ///Gets a possible [AqutterFaviconChangedRequest] instance from a [Map] value.
  static AqutterFaviconChangedRequest? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterFaviconChangedRequest(
      icon: map['icon'] != null
          ? Uint8List.fromList(map['icon'].cast<int>())
          : null,
      url: map['url'] != null ? AqutterWebUri(map['url']) : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"icon": icon, "url": url?.toString()};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterFaviconChangedRequest{icon: $icon, url: $url}';
  }
}
