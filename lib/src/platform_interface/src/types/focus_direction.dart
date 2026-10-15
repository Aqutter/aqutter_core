import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'focus_direction.g.dart';

///Class used to indicate the force dark mode.
@ExchangeableEnum()
class AqutterFocusDirection_ {
  // ignore: unused_field
  final String _value;
  // ignore: unused_field
  final int? _nativeValue = null;
  const AqutterFocusDirection_._internal(this._value);

  ///Move focus up.
  @EnumSupportedPlatforms(
    platforms: [
      EnumAndroidPlatform(
        apiName: 'FOCUS_UP',
        apiUrl:
            'https://developer.android.com/reference/android/view/View#FOCUS_UP',
        value: 33,
      ),
    ],
  )
  static const UP = const AqutterFocusDirection_._internal('UP');

  ///Move focus down.
  @EnumSupportedPlatforms(
    platforms: [
      EnumAndroidPlatform(
        apiName: 'FOCUS_DOWN',
        apiUrl:
            'https://developer.android.com/reference/android/view/View#FOCUS_DOWN',
        value: 130,
      ),
    ],
  )
  static const DOWN = const AqutterFocusDirection_._internal('DOWN');

  ///Move focus to the left.
  @EnumSupportedPlatforms(
    platforms: [
      EnumAndroidPlatform(
        apiName: 'FOCUS_LEFT',
        apiUrl:
            'https://developer.android.com/reference/android/view/View#FOCUS_LEFT',
        value: 130,
      ),
    ],
  )
  static const LEFT = const AqutterFocusDirection_._internal('LEFT');

  ///Move focus to the right.
  @EnumSupportedPlatforms(
    platforms: [
      EnumAndroidPlatform(
        apiName: 'FOCUS_RIGHT',
        apiUrl:
            'https://developer.android.com/reference/android/view/View#FOCUS_RIGHT',
        value: 130,
      ),
    ],
  )
  static const RIGHT = const AqutterFocusDirection_._internal('RIGHT');
}
