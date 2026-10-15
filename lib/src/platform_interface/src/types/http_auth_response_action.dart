import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'http_auth_response.dart';

part 'http_auth_response_action.g.dart';

///Class used by [AqutterHttpAuthResponse] class.
@ExchangeableEnum()
class AqutterHttpAuthResponseAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterHttpAuthResponseAction_._internal(this._value);

  ///Instructs the WebView to cancel the authentication request.
  @EnumSupportedPlatforms(
    platforms: [
      EnumAndroidPlatform(),
      EnumIOSPlatform(),
      EnumMacOSPlatform(),
      EnumWindowsPlatform(),
    ],
  )
  static const CANCEL = const AqutterHttpAuthResponseAction_._internal(0);

  ///Instructs the WebView to proceed with the authentication with the given credentials.
  @EnumSupportedPlatforms(
    platforms: [
      EnumAndroidPlatform(),
      EnumIOSPlatform(),
      EnumMacOSPlatform(),
      EnumWindowsPlatform(),
    ],
  )
  static const PROCEED = const AqutterHttpAuthResponseAction_._internal(1);

  ///Uses the credentials stored for the current host.
  @EnumSupportedPlatforms(
    platforms: [EnumAndroidPlatform(), EnumIOSPlatform(), EnumMacOSPlatform()],
  )
  static const USE_SAVED_HTTP_AUTH_CREDENTIALS =
      const AqutterHttpAuthResponseAction_._internal(2);
}
