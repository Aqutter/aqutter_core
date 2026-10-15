import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview_controller.dart';
import 'meta_tag_attribute.dart';
import 'enum_method.dart';

part 'meta_tag.g.dart';

///Class that represents a `<meta>` HTML tag. It is used by the [AqutterPlatformWebViewController.getMetaTags] method.
@ExchangeableObject()
class AqutterMetaTag_ {
  ///The meta tag name value.
  String? name;

  ///The meta tag content value.
  String? content;

  ///The meta tag attributes list.
  List<AqutterMetaTagAttribute_>? attrs;

  AqutterMetaTag_({this.name, this.content, this.attrs});
}
