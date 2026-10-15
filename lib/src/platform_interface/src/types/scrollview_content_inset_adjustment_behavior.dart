import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'scrollview_content_inset_adjustment_behavior.g.dart';

///Class used to configure how safe area insets are added to the adjusted content inset.
@ExchangeableEnum()
class AqutterScrollViewContentInsetAdjustmentBehavior_ {
  // ignore: unused_field
  final int _value;
  const AqutterScrollViewContentInsetAdjustmentBehavior_._internal(this._value);

  ///Automatically adjust the scroll view insets.
  static const AUTOMATIC =
      const AqutterScrollViewContentInsetAdjustmentBehavior_._internal(0);

  ///Adjust the insets only in the scrollable directions.
  static const SCROLLABLE_AXES =
      const AqutterScrollViewContentInsetAdjustmentBehavior_._internal(1);

  ///Do not adjust the scroll view insets.
  static const NEVER =
      const AqutterScrollViewContentInsetAdjustmentBehavior_._internal(2);

  ///Always include the safe area insets in the content adjustment.
  static const ALWAYS =
      const AqutterScrollViewContentInsetAdjustmentBehavior_._internal(3);
}

///An iOS-specific class used to configure how safe area insets are added to the adjusted content inset.
///
///**NOTE**: available on iOS 11.0+.
///
///Use [AqutterScrollViewContentInsetAdjustmentBehavior] instead.
@Deprecated("Use AqutterScrollViewContentInsetAdjustmentBehavior instead")
@ExchangeableEnum()
class AqutterIOSUIScrollViewContentInsetAdjustmentBehavior_ {
  // ignore: unused_field
  final int _value;
  const AqutterIOSUIScrollViewContentInsetAdjustmentBehavior_._internal(this._value);

  ///Automatically adjust the scroll view insets.
  static const AUTOMATIC =
      const AqutterIOSUIScrollViewContentInsetAdjustmentBehavior_._internal(0);

  ///Adjust the insets only in the scrollable directions.
  static const SCROLLABLE_AXES =
      const AqutterIOSUIScrollViewContentInsetAdjustmentBehavior_._internal(1);

  ///Do not adjust the scroll view insets.
  static const NEVER =
      const AqutterIOSUIScrollViewContentInsetAdjustmentBehavior_._internal(2);

  ///Always include the safe area insets in the content adjustment.
  static const ALWAYS =
      const AqutterIOSUIScrollViewContentInsetAdjustmentBehavior_._internal(3);
}
