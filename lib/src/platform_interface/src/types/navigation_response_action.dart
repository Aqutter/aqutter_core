import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import '../webview/platform_webview.dart';
part 'navigation_response_action.g.dart';

///Class that is used by [AqutterPlatformWebViewCreationParams.onNavigationResponse] event.
///It represents the policy to pass back to the decision handler.
@ExchangeableEnum()
class AqutterNavigationResponseAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterNavigationResponseAction_._internal(this._value);

  ///Cancel the navigation.
  static const CANCEL = const AqutterNavigationResponseAction_._internal(0);

  ///Allow the navigation to continue.
  static const ALLOW = const AqutterNavigationResponseAction_._internal(1);

  ///Turn the navigation into a download.
  ///
  ///**NOTE**: available only on iOS 14.5+. It will fallback to [CANCEL].
  static const DOWNLOAD = const AqutterNavigationResponseAction_._internal(2);
}

///Class that is used by [AqutterPlatformWebViewCreationParams.onNavigationResponse] event.
///It represents the policy to pass back to the decision handler.
///Use [AqutterNavigationResponseAction] instead.
@Deprecated("Use AqutterNavigationResponseAction instead")
@ExchangeableEnum()
class AqutterIOSNavigationResponseAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterIOSNavigationResponseAction_._internal(this._value);

  ///Cancel the navigation.
  static const CANCEL = const AqutterIOSNavigationResponseAction_._internal(0);

  ///Allow the navigation to continue.
  static const ALLOW = const AqutterIOSNavigationResponseAction_._internal(1);
}
