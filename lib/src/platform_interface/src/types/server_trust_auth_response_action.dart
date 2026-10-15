import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'server_trust_auth_response.dart';

part 'server_trust_auth_response_action.g.dart';

///Class used by [AqutterServerTrustAuthResponse] class.
@ExchangeableEnum()
class AqutterServerTrustAuthResponseAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterServerTrustAuthResponseAction_._internal(this._value);

  ///Instructs the WebView to cancel the authentication challenge.
  static const CANCEL = const AqutterServerTrustAuthResponseAction_._internal(0);

  ///Instructs the WebView to proceed with the authentication challenge.
  static const PROCEED = const AqutterServerTrustAuthResponseAction_._internal(1);
}
