import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'action_mode_menu_item.g.dart';

///Class used to disable the action mode menu items.
@ExchangeableEnum(bitwiseOrOperator: true)
class AqutterActionModeMenuItem_ {
  // ignore: unused_field
  final int _value;
  const AqutterActionModeMenuItem_._internal(this._value);

  ///No menu items should be disabled.
  static const MENU_ITEM_NONE = AqutterActionModeMenuItem_._internal(0);

  ///Disable menu item "Share".
  static const MENU_ITEM_SHARE = AqutterActionModeMenuItem_._internal(1);

  ///Disable menu item "Web Search".
  static const MENU_ITEM_WEB_SEARCH = AqutterActionModeMenuItem_._internal(2);

  ///Disable all the action mode menu items for text processing.
  static const MENU_ITEM_PROCESS_TEXT = AqutterActionModeMenuItem_._internal(4);
}

///An Android-specific class used to disable the action mode menu items.
///
///**NOTE**: available on Android 24+.
///
///Use [AqutterActionModeMenuItem] instead.
@Deprecated("Use AqutterActionModeMenuItem instead")
@ExchangeableEnum(bitwiseOrOperator: true)
class AqutterAndroidActionModeMenuItem_ {
  // ignore: unused_field
  final int _value;
  const AqutterAndroidActionModeMenuItem_._internal(this._value);

  ///No menu items should be disabled.
  static const MENU_ITEM_NONE = const AqutterAndroidActionModeMenuItem_._internal(0);

  ///Disable menu item "Share".
  static const MENU_ITEM_SHARE = const AqutterAndroidActionModeMenuItem_._internal(1);

  ///Disable menu item "Web Search".
  static const MENU_ITEM_WEB_SEARCH =
      const AqutterAndroidActionModeMenuItem_._internal(2);

  ///Disable all the action mode menu items for text processing.
  static const MENU_ITEM_PROCESS_TEXT =
      const AqutterAndroidActionModeMenuItem_._internal(4);
}
