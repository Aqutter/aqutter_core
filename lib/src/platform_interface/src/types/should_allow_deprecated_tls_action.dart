import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import '../webview/platform_webview.dart';
part 'should_allow_deprecated_tls_action.g.dart';

///Class that is used by [AqutterPlatformWebViewCreationParams.shouldAllowDeprecatedTLS] event.
///It represents the policy to pass back to the decision handler.
@ExchangeableEnum()
class AqutterShouldAllowDeprecatedTLSAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterShouldAllowDeprecatedTLSAction_._internal(this._value);

  ///Cancel the navigation.
  static const CANCEL = const AqutterShouldAllowDeprecatedTLSAction_._internal(0);

  ///Allow the navigation to continue.
  static const ALLOW = const AqutterShouldAllowDeprecatedTLSAction_._internal(1);
}

///Class that is used by [AqutterPlatformWebViewCreationParams.shouldAllowDeprecatedTLS] event.
///It represents the policy to pass back to the decision handler.
///Use [AqutterShouldAllowDeprecatedTLSAction] instead.
@Deprecated("Use AqutterShouldAllowDeprecatedTLSAction instead")
@ExchangeableEnum()
class AqutterIOSShouldAllowDeprecatedTLSAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterIOSShouldAllowDeprecatedTLSAction_._internal(this._value);

  ///Cancel the navigation.
  static const CANCEL = const AqutterIOSShouldAllowDeprecatedTLSAction_._internal(0);

  ///Allow the navigation to continue.
  static const ALLOW = const AqutterIOSShouldAllowDeprecatedTLSAction_._internal(1);
}
