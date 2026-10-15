import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview_controller.dart';
import '../web_uri.dart';
import 'enum_method.dart';

part 'request_focus_node_href_result.g.dart';

///Class that represents the result used by the [AqutterPlatformWebViewController.requestFocusNodeHref] method.
@ExchangeableObject()
class AqutterRequestFocusNodeHrefResult_ {
  ///The anchor's href attribute.
  AqutterWebUri? url;

  ///The anchor's text.
  String? title;

  ///The image's src attribute.
  String? src;

  AqutterRequestFocusNodeHrefResult_({this.url, this.title, this.src});
}
