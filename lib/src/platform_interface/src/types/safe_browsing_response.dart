import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview_controller.dart';
import '../webview/platform_webview.dart';
import 'safe_browsing_response_action.dart';
import 'enum_method.dart';

part 'safe_browsing_response.g.dart';

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onSafeBrowsingHit] event.
///It is used to indicate an action to take when hitting a malicious URL.
@ExchangeableObject()
class AqutterSafeBrowsingResponse_ {
  ///If reporting is enabled, all reports will be sent according to the privacy policy referenced by [AqutterPlatformWebViewController.getSafeBrowsingPrivacyPolicyUrl].
  bool report;

  ///Indicate the [AqutterSafeBrowsingResponseAction] to take when hitting a malicious URL.
  AqutterSafeBrowsingResponseAction_? action;

  AqutterSafeBrowsingResponse_({
    this.report = true,
    this.action = AqutterSafeBrowsingResponseAction_.SHOW_INTERSTITIAL,
  });
}
