import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import 'server_trust_auth_response_action.dart';
import 'enum_method.dart';

part 'server_trust_auth_response.g.dart';

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onReceivedServerTrustAuthRequest] event.
@ExchangeableObject()
class AqutterServerTrustAuthResponse_ {
  ///Indicate the [AqutterServerTrustAuthResponseAction] to take in response of the server trust authentication challenge.
  AqutterServerTrustAuthResponseAction_? action;

  AqutterServerTrustAuthResponse_({
    this.action = AqutterServerTrustAuthResponseAction_.CANCEL,
  });
}
