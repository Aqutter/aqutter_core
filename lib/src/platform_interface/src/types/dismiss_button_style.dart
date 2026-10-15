import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'dismiss_button_style.g.dart';

///Class used to set the custom style for the dismiss button.
@ExchangeableEnum()
class AqutterDismissButtonStyle_ {
  // ignore: unused_field
  final int _value;
  const AqutterDismissButtonStyle_._internal(this._value);

  ///Makes the button title the localized string "Done".
  static const DONE = const AqutterDismissButtonStyle_._internal(0);

  ///Makes the button title the localized string "Close".
  static const CLOSE = const AqutterDismissButtonStyle_._internal(1);

  ///Makes the button title the localized string "Cancel".
  static const CANCEL = const AqutterDismissButtonStyle_._internal(2);
}

///An iOS-specific class used to set the custom style for the dismiss button.
///
///**NOTE**: available on iOS 11.0+.
///
///Use [AqutterDismissButtonStyle] instead.
@Deprecated("Use AqutterDismissButtonStyle instead")
@ExchangeableEnum()
class AqutterIOSSafariDismissButtonStyle_ {
  // ignore: unused_field
  final int _value;
  const AqutterIOSSafariDismissButtonStyle_._internal(this._value);

  ///Makes the button title the localized string "Done".
  static const DONE = const AqutterIOSSafariDismissButtonStyle_._internal(0);

  ///Makes the button title the localized string "Close".
  static const CLOSE = const AqutterIOSSafariDismissButtonStyle_._internal(1);

  ///Makes the button title the localized string "Cancel".
  static const CANCEL = const AqutterIOSSafariDismissButtonStyle_._internal(2);
}
