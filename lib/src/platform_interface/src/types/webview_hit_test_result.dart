import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'webview_hit_test_result_type.dart';
import 'enum_method.dart';

part 'webview_hit_test_result.g.dart';

///Class that represents the hit result for hitting an HTML elements.
@ExchangeableObject()
class AqutterWebViewHitTestResult_ {
  ///The type of the hit test result.
  AqutterWebViewHitTestResultType_? type;

  ///Additional type-dependant information about the result.
  String? extra;

  AqutterWebViewHitTestResult_({this.type, this.extra});
}
