// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_scheme_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class representing the response returned by the [AqutterPlatformWebViewCreationParams.onLoadResourceWithCustomScheme] event.
///It allows to load a specific resource. The resource data must be encoded to `base64`.
class AqutterCustomSchemeResponse {
  ///Content-Encoding of the data, such as `utf-8`.
  String contentEncoding;

  ///Content-Type of the data, such as `image/png`.
  String contentType;

  ///Data enconded to 'base64'.
  Uint8List data;
  AqutterCustomSchemeResponse({
    this.contentEncoding = 'utf-8',
    required this.contentType,
    required this.data,
  });

  ///Gets a possible [AqutterCustomSchemeResponse] instance from a [Map] value.
  static AqutterCustomSchemeResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterCustomSchemeResponse(
      contentType: map['contentType'],
      data: Uint8List.fromList(map['data'].cast<int>()),
    );
    if (map['contentEncoding'] != null) {
      instance.contentEncoding = map['contentEncoding'];
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "contentEncoding": contentEncoding,
      "contentType": contentType,
      "data": data,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterCustomSchemeResponse{contentEncoding: $contentEncoding, contentType: $contentType, data: $data}';
  }
}
