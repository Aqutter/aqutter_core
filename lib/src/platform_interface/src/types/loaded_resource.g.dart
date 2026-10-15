// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loaded_resource.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class representing a resource response of the `WebView`.
///It is used by the method [AqutterPlatformWebViewCreationParams.onLoadResource].
class AqutterLoadedResource {
  ///Returns the [DOMHighResTimeStamp](https://developer.mozilla.org/en-US/docs/Web/API/DOMHighResTimeStamp) duration to fetch a resource.
  double? duration;

  ///A string representing the type of resource.
  String? initiatorType;

  ///Returns the [DOMHighResTimeStamp](https://developer.mozilla.org/en-US/docs/Web/API/DOMHighResTimeStamp) for the time a resource fetch started.
  double? startTime;

  ///Resource URL.
  AqutterWebUri? url;
  AqutterLoadedResource({
    this.duration,
    this.initiatorType,
    this.startTime,
    this.url,
  });

  ///Gets a possible [AqutterLoadedResource] instance from a [Map] value.
  static AqutterLoadedResource? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterLoadedResource(
      duration: map['duration'],
      initiatorType: map['initiatorType'],
      startTime: map['startTime'],
      url: map['url'] != null ? AqutterWebUri(map['url']) : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "duration": duration,
      "initiatorType": initiatorType,
      "startTime": startTime,
      "url": url?.toString(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterLoadedResource{duration: $duration, initiatorType: $initiatorType, startTime: $startTime, url: $url}';
  }
}
