import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'script_html_tag_attributes.dart';
import 'css_link_html_tag_attributes.dart';

part 'cross_origin.g.dart';

///Class that represents the `crossorigin` content attribute on media elements, which is a CORS settings attribute.
///It could be used with [AqutterScriptHtmlTagAttributes] and [AqutterCSSLinkHtmlTagAttributes]
///when fetching a resource `<link>` or a `<script>` (or resources fetched by the `<script>`).
@ExchangeableEnum()
class AqutterCrossOrigin_ {
  // ignore: unused_field
  final String _value;
  const AqutterCrossOrigin_._internal(this._value);

  ///CORS requests for this element will have the credentials flag set to 'same-origin'.
  static const ANONYMOUS = const AqutterCrossOrigin_._internal("anonymous");

  ///CORS requests for this element will have the credentials flag set to 'include'.
  static const USE_CREDENTIALS = const AqutterCrossOrigin_._internal(
    "use-credentials",
  );
}
