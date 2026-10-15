import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import '../webview/platform_webview.dart';
part 'webview_render_process_action.g.dart';

///Class that represents the action to take used by the [AqutterPlatformWebViewCreationParams.onRenderProcessUnresponsive] and [AqutterPlatformWebViewCreationParams.onRenderProcessResponsive] event
///to terminate the Android [WebViewRenderProcess](https://developer.android.com/reference/android/webkit/WebViewRenderProcess).
@ExchangeableEnum()
class AqutterWebViewRenderProcessAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterWebViewRenderProcessAction_._internal(this._value);

  ///Cause this renderer to terminate.
  @EnumSupportedPlatforms(platforms: [EnumAndroidPlatform()])
  static const TERMINATE = const AqutterWebViewRenderProcessAction_._internal(0);
}
