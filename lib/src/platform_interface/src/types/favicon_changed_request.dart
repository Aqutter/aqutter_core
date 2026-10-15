import 'dart:typed_data';

import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../web_uri.dart';
import 'enum_method.dart';

part 'favicon_changed_request.g.dart';

///Class that represents the request used by the [AqutterPlatformWebViewCreationParams.onFaviconChanged] event.
@ExchangeableObject()
class AqutterFaviconChangedRequest_ {
  ///The favicon URL for the current page, if available.
  AqutterWebUri? url;

  ///The favicon bytes for the current page, if available.
  Uint8List? icon;

  AqutterFaviconChangedRequest_({this.url, this.icon});
}
