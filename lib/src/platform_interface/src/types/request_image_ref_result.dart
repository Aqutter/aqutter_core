import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview_controller.dart';
import '../web_uri.dart';
import 'enum_method.dart';

part 'request_image_ref_result.g.dart';

///Class that represents the result used by the [AqutterPlatformWebViewController.requestImageRef] method.
@ExchangeableObject()
class AqutterRequestImageRefResult_ {
  ///The image's url.
  AqutterWebUri? url;

  AqutterRequestImageRefResult_({this.url});
}
