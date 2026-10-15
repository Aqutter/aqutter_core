import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview_controller.dart';
import 'enum_method.dart';

part 'call_async_javascript_result.g.dart';

///Class that represents either a success or a failure, including an associated value in each case for [AqutterPlatformWebViewController.callAsyncJavaScript].
@ExchangeableObject()
class AqutterCallAsyncJavaScriptResult_ {
  ///It contains the success value.
  dynamic value;

  ///It contains the failure value.
  String? error;

  AqutterCallAsyncJavaScriptResult_({this.value, this.error});
}
