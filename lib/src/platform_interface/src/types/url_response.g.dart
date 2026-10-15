// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///The metadata associated with the response to a URL load request, independent of protocol and URL scheme.
class AqutterURLResponse {
  ///The expected length of the response’s content.
  int expectedContentLength;

  ///All HTTP header fields of the response.
  Map<String, String>? headers;

  ///The MIME type of the response.
  String? mimeType;

  ///The response’s HTTP status code.
  int? statusCode;

  ///A suggested filename for the response data.
  String? suggestedFilename;

  ///The name of the text encoding provided by the response’s originating source.
  String? textEncodingName;

  ///The URL for the response.
  AqutterWebUri? url;
  AqutterURLResponse({
    required this.expectedContentLength,
    this.headers,
    this.mimeType,
    this.statusCode,
    this.suggestedFilename,
    this.textEncodingName,
    this.url,
  });

  ///Gets a possible [AqutterURLResponse] instance from a [Map] value.
  static AqutterURLResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterURLResponse(
      expectedContentLength: map['expectedContentLength'],
      headers: map['headers']?.cast<String, String>(),
      mimeType: map['mimeType'],
      statusCode: map['statusCode'],
      suggestedFilename: map['suggestedFilename'],
      textEncodingName: map['textEncodingName'],
      url: map['url'] != null ? AqutterWebUri(map['url']) : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "expectedContentLength": expectedContentLength,
      "headers": headers,
      "mimeType": mimeType,
      "statusCode": statusCode,
      "suggestedFilename": suggestedFilename,
      "textEncodingName": textEncodingName,
      "url": url?.toString(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterURLResponse{expectedContentLength: $expectedContentLength, headers: $headers, mimeType: $mimeType, statusCode: $statusCode, suggestedFilename: $suggestedFilename, textEncodingName: $textEncodingName, url: $url}';
  }
}

///Use [AqutterURLResponse] instead.
@Deprecated('Use AqutterURLResponse instead')
class AqutterIOSURLResponse {
  ///The expected length of the response’s content.
  int expectedContentLength;

  ///All HTTP header fields of the response.
  Map<String, String>? headers;

  ///The MIME type of the response.
  String? mimeType;

  ///The response’s HTTP status code.
  int? statusCode;

  ///A suggested filename for the response data.
  String? suggestedFilename;

  ///The name of the text encoding provided by the response’s originating source.
  String? textEncodingName;

  ///The URL for the response.
  Uri? url;
  AqutterIOSURLResponse({
    required this.expectedContentLength,
    this.headers,
    this.mimeType,
    this.statusCode,
    this.suggestedFilename,
    this.textEncodingName,
    this.url,
  });

  ///Gets a possible [AqutterIOSURLResponse] instance from a [Map] value.
  static AqutterIOSURLResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterIOSURLResponse(
      expectedContentLength: map['expectedContentLength'],
      headers: map['headers']?.cast<String, String>(),
      mimeType: map['mimeType'],
      statusCode: map['statusCode'],
      suggestedFilename: map['suggestedFilename'],
      textEncodingName: map['textEncodingName'],
      url: map['url'] != null ? Uri.tryParse(map['url']) : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "expectedContentLength": expectedContentLength,
      "headers": headers,
      "mimeType": mimeType,
      "statusCode": statusCode,
      "suggestedFilename": suggestedFilename,
      "textEncodingName": textEncodingName,
      "url": url?.toString(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterIOSURLResponse{expectedContentLength: $expectedContentLength, headers: $headers, mimeType: $mimeType, statusCode: $statusCode, suggestedFilename: $suggestedFilename, textEncodingName: $textEncodingName, url: $url}';
  }
}
