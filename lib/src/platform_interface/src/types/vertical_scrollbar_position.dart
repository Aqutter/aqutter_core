import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'vertical_scrollbar_position.g.dart';

///Class used to configure the position of the vertical scroll bar.
@ExchangeableEnum()
class AqutterVerticalScrollbarPosition_ {
  // ignore: unused_field
  final int _value;
  const AqutterVerticalScrollbarPosition_._internal(this._value);

  ///Position the scroll bar at the default position as determined by the system.
  static const SCROLLBAR_POSITION_DEFAULT =
      const AqutterVerticalScrollbarPosition_._internal(0);

  ///Position the scroll bar along the left edge.
  static const SCROLLBAR_POSITION_LEFT =
      const AqutterVerticalScrollbarPosition_._internal(1);

  ///Position the scroll bar along the right edge.
  static const SCROLLBAR_POSITION_RIGHT =
      const AqutterVerticalScrollbarPosition_._internal(2);
}

///An Android-specific class used to configure the position of the vertical scroll bar.
///Use [AqutterVerticalScrollbarPosition] instead.
@Deprecated("Use AqutterVerticalScrollbarPosition instead")
@ExchangeableEnum()
class AqutterAndroidVerticalScrollbarPosition_ {
  // ignore: unused_field
  final int _value;
  const AqutterAndroidVerticalScrollbarPosition_._internal(this._value);

  ///Position the scroll bar at the default position as determined by the system.
  static const SCROLLBAR_POSITION_DEFAULT =
      const AqutterAndroidVerticalScrollbarPosition_._internal(0);

  ///Position the scroll bar along the left edge.
  static const SCROLLBAR_POSITION_LEFT =
      const AqutterAndroidVerticalScrollbarPosition_._internal(1);

  ///Position the scroll bar along the right edge.
  static const SCROLLBAR_POSITION_RIGHT =
      const AqutterAndroidVerticalScrollbarPosition_._internal(2);
}
