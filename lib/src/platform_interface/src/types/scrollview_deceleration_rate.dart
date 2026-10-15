import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'scrollview_deceleration_rate.g.dart';

///Class that represents a floating-point value that determines the rate of deceleration after the user lifts their finger.
@ExchangeableEnum()
class AqutterScrollViewDecelerationRate_ {
  // ignore: unused_field
  final String _value;
  const AqutterScrollViewDecelerationRate_._internal(this._value);

  ///The default deceleration rate for a scroll view: `0.998`.
  static const NORMAL = const AqutterScrollViewDecelerationRate_._internal("NORMAL");

  ///A fast deceleration rate for a scroll view: `0.99`.
  static const FAST = const AqutterScrollViewDecelerationRate_._internal("FAST");
}

///Class that represents a floating-point value that determines the rate of deceleration after the user lifts their finger.
///Use [AqutterScrollViewDecelerationRate] instead.
@Deprecated("Use AqutterScrollViewDecelerationRate instead")
@ExchangeableEnum()
class AqutterIOSUIScrollViewDecelerationRate_ {
  // ignore: unused_field
  final String _value;
  const AqutterIOSUIScrollViewDecelerationRate_._internal(this._value);

  ///The default deceleration rate for a scroll view: `0.998`.
  static const NORMAL = const AqutterIOSUIScrollViewDecelerationRate_._internal(
    "NORMAL",
  );

  ///A fast deceleration rate for a scroll view: `0.99`.
  static const FAST = const AqutterIOSUIScrollViewDecelerationRate_._internal("FAST");
}
