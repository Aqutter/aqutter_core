import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'ajax_request.dart';
import 'enum_method.dart';

part 'ajax_request_headers.g.dart';

///Class that represents the HTTP headers of an [AqutterAjaxRequest].
@ExchangeableObject()
class AqutterAjaxRequestHeaders_ {
  Map<String, dynamic> _headers;
  Map<String, dynamic> _newHeaders = {};

  @ExchangeableObjectConstructor()
  AqutterAjaxRequestHeaders_(this._headers);

  ///Gets a possible [AqutterAjaxRequestHeaders] instance from a [Map] value.
  static AqutterAjaxRequestHeaders_? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }

    return AqutterAjaxRequestHeaders_(map);
  }

  ///Gets the HTTP headers of the [AqutterAjaxRequest].
  Map<String, dynamic> getHeaders() {
    return this._headers;
  }

  ///Sets/updates an HTTP header of the [AqutterAjaxRequest]. If there is already an existing [header] with the same name, the values are merged into one single request header.
  ///For security reasons, some headers can only be controlled by the user agent.
  ///These headers include the [forbidden header names](https://developer.mozilla.org/en-US/docs/Glossary/Forbidden_header_name)
  ///and [forbidden response header names](https://developer.mozilla.org/en-US/docs/Glossary/Forbidden_response_header_name).
  void setRequestHeader(String header, String value) {
    _newHeaders[header] = value;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return _newHeaders;
  }

  @override
  String toString() {
    return 'AqutterAjaxRequestHeaders{headers: $_headers, requestHeaders: $_newHeaders}';
  }
}
