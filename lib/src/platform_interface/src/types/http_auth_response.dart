import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import 'http_auth_response_action.dart';
import 'enum_method.dart';

part 'http_auth_response.g.dart';

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onReceivedHttpAuthRequest] event.
@ExchangeableObject()
class AqutterHttpAuthResponse_ {
  ///Represents the username used for the authentication if the [action] corresponds to [AqutterHttpAuthResponseAction.PROCEED]
  String username;

  ///Represents the password used for the authentication if the [action] corresponds to [AqutterHttpAuthResponseAction.PROCEED]
  String password;

  ///Indicate if the given credentials need to be saved permanently.
  bool permanentPersistence;

  ///Indicate the [AqutterHttpAuthResponseAction] to take in response of the authentication challenge.
  AqutterHttpAuthResponseAction_? action;

  AqutterHttpAuthResponse_({
    this.username = "",
    this.password = "",
    this.permanentPersistence = false,
    this.action = AqutterHttpAuthResponseAction_.CANCEL,
  });
}
