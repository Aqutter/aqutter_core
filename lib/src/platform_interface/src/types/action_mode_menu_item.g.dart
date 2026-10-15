// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_mode_menu_item.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to disable the action mode menu items.
class AqutterActionModeMenuItem {
  final int _value;
  final int? _nativeValue;
  const AqutterActionModeMenuItem._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterActionModeMenuItem._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterActionModeMenuItem._internal(value, nativeValue());

  ///No menu items should be disabled.
  static const MENU_ITEM_NONE = AqutterActionModeMenuItem._internal(0, 0);

  ///Disable all the action mode menu items for text processing.
  static const MENU_ITEM_PROCESS_TEXT = AqutterActionModeMenuItem._internal(
    4,
    4,
  );

  ///Disable menu item "Share".
  static const MENU_ITEM_SHARE = AqutterActionModeMenuItem._internal(1, 1);

  ///Disable menu item "Web Search".
  static const MENU_ITEM_WEB_SEARCH = AqutterActionModeMenuItem._internal(2, 2);

  ///Set of all values of [AqutterActionModeMenuItem].
  static final Set<AqutterActionModeMenuItem> values = [
    AqutterActionModeMenuItem.MENU_ITEM_NONE,
    AqutterActionModeMenuItem.MENU_ITEM_PROCESS_TEXT,
    AqutterActionModeMenuItem.MENU_ITEM_SHARE,
    AqutterActionModeMenuItem.MENU_ITEM_WEB_SEARCH,
  ].toSet();

  ///Gets a possible [AqutterActionModeMenuItem] instance from [int] value.
  static AqutterActionModeMenuItem? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterActionModeMenuItem.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return AqutterActionModeMenuItem._internal(value, value);
      }
    }
    return null;
  }

  ///Gets a possible [AqutterActionModeMenuItem] instance from a native value.
  static AqutterActionModeMenuItem? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterActionModeMenuItem.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterActionModeMenuItem] instance value with name [name].
  ///
  /// Goes through [AqutterActionModeMenuItem.values] looking for a value with
  /// name [name], as reported by [AqutterActionModeMenuItem.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterActionModeMenuItem? byName(String? name) {
    if (name != null) {
      try {
        return AqutterActionModeMenuItem.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterActionModeMenuItem] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterActionModeMenuItem> asNameMap() =>
      <String, AqutterActionModeMenuItem>{
        for (final value in AqutterActionModeMenuItem.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 0:
        return 'MENU_ITEM_NONE';
      case 4:
        return 'MENU_ITEM_PROCESS_TEXT';
      case 1:
        return 'MENU_ITEM_SHARE';
      case 2:
        return 'MENU_ITEM_WEB_SEARCH';
    }
    return _value.toString();
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(value) => value == _value;

  AqutterActionModeMenuItem operator |(AqutterActionModeMenuItem value) =>
      AqutterActionModeMenuItem._internal(
        value.toValue() | _value,
        value.toNativeValue() != null && _nativeValue != null
            ? value.toNativeValue()! | _nativeValue!
            : null,
      );

  ///Checks if the value is supported by the [defaultTargetPlatform].
  bool isSupported() {
    return _nativeValue != null;
  }

  @override
  String toString() {
    return name();
  }
}

///An Android-specific class used to disable the action mode menu items.
///
///**NOTE**: available on Android 24+.
///
///Use [AqutterActionModeMenuItem] instead.
@Deprecated('Use AqutterActionModeMenuItem instead')
class AqutterAndroidActionModeMenuItem {
  final int _value;
  final int? _nativeValue;
  const AqutterAndroidActionModeMenuItem._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterAndroidActionModeMenuItem._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterAndroidActionModeMenuItem._internal(value, nativeValue());

  ///No menu items should be disabled.
  static const MENU_ITEM_NONE = AqutterAndroidActionModeMenuItem._internal(
    0,
    0,
  );

  ///Disable all the action mode menu items for text processing.
  static const MENU_ITEM_PROCESS_TEXT =
      AqutterAndroidActionModeMenuItem._internal(4, 4);

  ///Disable menu item "Share".
  static const MENU_ITEM_SHARE = AqutterAndroidActionModeMenuItem._internal(
    1,
    1,
  );

  ///Disable menu item "Web Search".
  static const MENU_ITEM_WEB_SEARCH =
      AqutterAndroidActionModeMenuItem._internal(2, 2);

  ///Set of all values of [AqutterAndroidActionModeMenuItem].
  static final Set<AqutterAndroidActionModeMenuItem> values = [
    AqutterAndroidActionModeMenuItem.MENU_ITEM_NONE,
    AqutterAndroidActionModeMenuItem.MENU_ITEM_PROCESS_TEXT,
    AqutterAndroidActionModeMenuItem.MENU_ITEM_SHARE,
    AqutterAndroidActionModeMenuItem.MENU_ITEM_WEB_SEARCH,
  ].toSet();

  ///Gets a possible [AqutterAndroidActionModeMenuItem] instance from [int] value.
  static AqutterAndroidActionModeMenuItem? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidActionModeMenuItem.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return AqutterAndroidActionModeMenuItem._internal(value, value);
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAndroidActionModeMenuItem] instance from a native value.
  static AqutterAndroidActionModeMenuItem? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidActionModeMenuItem.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAndroidActionModeMenuItem] instance value with name [name].
  ///
  /// Goes through [AqutterAndroidActionModeMenuItem.values] looking for a value with
  /// name [name], as reported by [AqutterAndroidActionModeMenuItem.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAndroidActionModeMenuItem? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAndroidActionModeMenuItem.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAndroidActionModeMenuItem] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAndroidActionModeMenuItem> asNameMap() =>
      <String, AqutterAndroidActionModeMenuItem>{
        for (final value in AqutterAndroidActionModeMenuItem.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 0:
        return 'MENU_ITEM_NONE';
      case 4:
        return 'MENU_ITEM_PROCESS_TEXT';
      case 1:
        return 'MENU_ITEM_SHARE';
      case 2:
        return 'MENU_ITEM_WEB_SEARCH';
    }
    return _value.toString();
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(value) => value == _value;

  AqutterAndroidActionModeMenuItem operator |(
    AqutterAndroidActionModeMenuItem value,
  ) => AqutterAndroidActionModeMenuItem._internal(
    value.toValue() | _value,
    value.toNativeValue() != null && _nativeValue != null
        ? value.toNativeValue()! | _nativeValue!
        : null,
  );

  ///Checks if the value is supported by the [defaultTargetPlatform].
  bool isSupported() {
    return _nativeValue != null;
  }

  @override
  String toString() {
    return name();
  }
}
