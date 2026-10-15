import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview_controller.dart';
import '../web_uri.dart';
import 'enum_method.dart';

part 'favicon.g.dart';

///Class that represents a favicon of a website. It is used by [AqutterPlatformWebViewController.getFavicons] method.
@ExchangeableObject()
class AqutterFavicon_ {
  ///The url of the favicon image.
  AqutterWebUri url;

  ///The relationship between the current web page and the favicon image.
  String? rel;

  ///The width of the favicon image.
  int? width;

  ///The height of the favicon image.
  int? height;

  AqutterFavicon_({required this.url, this.rel, this.width, this.height});
}
