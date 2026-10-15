import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../web_uri.dart';
import 'enum_method.dart';

part 'url_response.g.dart';

///The metadata associated with the response to a URL load request, independent of protocol and URL scheme.
@ExchangeableObject()
class AqutterURLResponse_ {
  ///The URL for the response.
  AqutterWebUri? url;

  ///The expected length of the response’s content.
  int expectedContentLength;

  ///The MIME type of the response.
  String? mimeType;

  ///A suggested filename for the response data.
  String? suggestedFilename;

  ///The name of the text encoding provided by the response’s originating source.
  String? textEncodingName;

  ///All HTTP header fields of the response.
  Map<String, String>? headers;

  ///The response’s HTTP status code.
  int? statusCode;

  AqutterURLResponse_({
    this.url,
    required this.expectedContentLength,
    this.mimeType,
    this.suggestedFilename,
    this.textEncodingName,
    this.headers,
    this.statusCode,
  });
}

///Use [AqutterURLResponse] instead.
@Deprecated("Use AqutterURLResponse instead")
@ExchangeableObject()
class AqutterIOSURLResponse_ {
  ///The URL for the response.
  Uri? url;

  ///The expected length of the response’s content.
  int expectedContentLength;

  ///The MIME type of the response.
  String? mimeType;

  ///A suggested filename for the response data.
  String? suggestedFilename;

  ///The name of the text encoding provided by the response’s originating source.
  String? textEncodingName;

  ///All HTTP header fields of the response.
  Map<String, String>? headers;

  ///The response’s HTTP status code.
  int? statusCode;

  AqutterIOSURLResponse_({
    this.url,
    required this.expectedContentLength,
    this.mimeType,
    this.suggestedFilename,
    this.textEncodingName,
    this.headers,
    this.statusCode,
  });
}
