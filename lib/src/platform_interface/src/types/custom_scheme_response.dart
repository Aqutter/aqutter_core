import 'dart:typed_data';

import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import '../webview/platform_webview.dart';
import 'enum_method.dart';

part 'custom_scheme_response.g.dart';

///Class representing the response returned by the [AqutterPlatformWebViewCreationParams.onLoadResourceWithCustomScheme] event.
///It allows to load a specific resource. The resource data must be encoded to `base64`.
@ExchangeableObject()
class AqutterCustomSchemeResponse_ {
  ///Data enconded to 'base64'.
  Uint8List data;

  ///Content-Type of the data, such as `image/png`.
  String contentType;

  ///Content-Encoding of the data, such as `utf-8`.
  String contentEncoding;

  AqutterCustomSchemeResponse_({
    required this.data,
    required this.contentType,
    this.contentEncoding = 'utf-8',
  });
}
