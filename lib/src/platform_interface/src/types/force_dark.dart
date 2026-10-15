import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'force_dark.g.dart';

///Class used to indicate the force dark mode.
@ExchangeableEnum()
class AqutterForceDark_ {
  // ignore: unused_field
  final int _value;
  const AqutterForceDark_._internal(this._value);

  ///Disable force dark, irrespective of the force dark mode of the WebView parent.
  ///In this mode, WebView content will always be rendered as-is, regardless of whether native views are being automatically darkened.
  static const OFF = const AqutterForceDark_._internal(0);

  ///Enable force dark dependent on the state of the WebView parent view.
  static const AUTO = const AqutterForceDark_._internal(1);

  ///Unconditionally enable force dark. In this mode WebView content will always be rendered so as to emulate a dark theme.
  static const ON = const AqutterForceDark_._internal(2);
}

///An Android-specific class used to indicate the force dark mode.
///
///**NOTE**: available on Android 29+.
///
///Use [AqutterForceDark] instead.
@Deprecated("Use AqutterForceDark instead")
@ExchangeableEnum()
class AqutterAndroidForceDark_ {
  // ignore: unused_field
  final int _value;
  const AqutterAndroidForceDark_._internal(this._value);

  ///Disable force dark, irrespective of the force dark mode of the WebView parent.
  ///In this mode, WebView content will always be rendered as-is, regardless of whether native views are being automatically darkened.
  static const FORCE_DARK_OFF = const AqutterAndroidForceDark_._internal(0);

  ///Enable force dark dependent on the state of the WebView parent view.
  static const FORCE_DARK_AUTO = const AqutterAndroidForceDark_._internal(1);

  ///Unconditionally enable force dark. In this mode WebView content will always be rendered so as to emulate a dark theme.
  static const FORCE_DARK_ON = const AqutterAndroidForceDark_._internal(2);
}
