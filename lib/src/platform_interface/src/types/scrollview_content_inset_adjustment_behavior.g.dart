// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrollview_content_inset_adjustment_behavior.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to configure how safe area insets are added to the adjusted content inset.
class AqutterScrollViewContentInsetAdjustmentBehavior {
  final int _value;
  final int? _nativeValue;
  const AqutterScrollViewContentInsetAdjustmentBehavior._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterScrollViewContentInsetAdjustmentBehavior._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterScrollViewContentInsetAdjustmentBehavior._internal(
    value,
    nativeValue(),
  );

  ///Always include the safe area insets in the content adjustment.
  static const ALWAYS =
      AqutterScrollViewContentInsetAdjustmentBehavior._internal(3, 3);

  ///Automatically adjust the scroll view insets.
  static const AUTOMATIC =
      AqutterScrollViewContentInsetAdjustmentBehavior._internal(0, 0);

  ///Do not adjust the scroll view insets.
  static const NEVER =
      AqutterScrollViewContentInsetAdjustmentBehavior._internal(2, 2);

  ///Adjust the insets only in the scrollable directions.
  static const SCROLLABLE_AXES =
      AqutterScrollViewContentInsetAdjustmentBehavior._internal(1, 1);

  ///Set of all values of [AqutterScrollViewContentInsetAdjustmentBehavior].
  static final Set<AqutterScrollViewContentInsetAdjustmentBehavior> values = [
    AqutterScrollViewContentInsetAdjustmentBehavior.ALWAYS,
    AqutterScrollViewContentInsetAdjustmentBehavior.AUTOMATIC,
    AqutterScrollViewContentInsetAdjustmentBehavior.NEVER,
    AqutterScrollViewContentInsetAdjustmentBehavior.SCROLLABLE_AXES,
  ].toSet();

  ///Gets a possible [AqutterScrollViewContentInsetAdjustmentBehavior] instance from [int] value.
  static AqutterScrollViewContentInsetAdjustmentBehavior? fromValue(
    int? value,
  ) {
    if (value != null) {
      try {
        return AqutterScrollViewContentInsetAdjustmentBehavior.values
            .firstWhere((element) => element.toValue() == value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterScrollViewContentInsetAdjustmentBehavior] instance from a native value.
  static AqutterScrollViewContentInsetAdjustmentBehavior? fromNativeValue(
    int? value,
  ) {
    if (value != null) {
      try {
        return AqutterScrollViewContentInsetAdjustmentBehavior.values
            .firstWhere((element) => element.toNativeValue() == value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterScrollViewContentInsetAdjustmentBehavior] instance value with name [name].
  ///
  /// Goes through [AqutterScrollViewContentInsetAdjustmentBehavior.values] looking for a value with
  /// name [name], as reported by [AqutterScrollViewContentInsetAdjustmentBehavior.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterScrollViewContentInsetAdjustmentBehavior? byName(String? name) {
    if (name != null) {
      try {
        return AqutterScrollViewContentInsetAdjustmentBehavior.values
            .firstWhere((element) => element.name() == name);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterScrollViewContentInsetAdjustmentBehavior] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterScrollViewContentInsetAdjustmentBehavior>
  asNameMap() => <String, AqutterScrollViewContentInsetAdjustmentBehavior>{
    for (final value in AqutterScrollViewContentInsetAdjustmentBehavior.values)
      value.name(): value,
  };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 3:
        return 'ALWAYS';
      case 0:
        return 'AUTOMATIC';
      case 2:
        return 'NEVER';
      case 1:
        return 'SCROLLABLE_AXES';
    }
    return _value.toString();
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(value) => value == _value;

  ///Checks if the value is supported by the [defaultTargetPlatform].
  bool isSupported() {
    return _nativeValue != null;
  }

  @override
  String toString() {
    return name();
  }
}

///An iOS-specific class used to configure how safe area insets are added to the adjusted content inset.
///
///**NOTE**: available on iOS 11.0+.
///
///Use [AqutterScrollViewContentInsetAdjustmentBehavior] instead.
@Deprecated('Use AqutterScrollViewContentInsetAdjustmentBehavior instead')
class AqutterIOSUIScrollViewContentInsetAdjustmentBehavior {
  final int _value;
  final int? _nativeValue;
  const AqutterIOSUIScrollViewContentInsetAdjustmentBehavior._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSUIScrollViewContentInsetAdjustmentBehavior._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterIOSUIScrollViewContentInsetAdjustmentBehavior._internal(
    value,
    nativeValue(),
  );

  ///Always include the safe area insets in the content adjustment.
  static const ALWAYS =
      AqutterIOSUIScrollViewContentInsetAdjustmentBehavior._internal(3, 3);

  ///Automatically adjust the scroll view insets.
  static const AUTOMATIC =
      AqutterIOSUIScrollViewContentInsetAdjustmentBehavior._internal(0, 0);

  ///Do not adjust the scroll view insets.
  static const NEVER =
      AqutterIOSUIScrollViewContentInsetAdjustmentBehavior._internal(2, 2);

  ///Adjust the insets only in the scrollable directions.
  static const SCROLLABLE_AXES =
      AqutterIOSUIScrollViewContentInsetAdjustmentBehavior._internal(1, 1);

  ///Set of all values of [AqutterIOSUIScrollViewContentInsetAdjustmentBehavior].
  static final Set<AqutterIOSUIScrollViewContentInsetAdjustmentBehavior>
  values = [
    AqutterIOSUIScrollViewContentInsetAdjustmentBehavior.ALWAYS,
    AqutterIOSUIScrollViewContentInsetAdjustmentBehavior.AUTOMATIC,
    AqutterIOSUIScrollViewContentInsetAdjustmentBehavior.NEVER,
    AqutterIOSUIScrollViewContentInsetAdjustmentBehavior.SCROLLABLE_AXES,
  ].toSet();

  ///Gets a possible [AqutterIOSUIScrollViewContentInsetAdjustmentBehavior] instance from [int] value.
  static AqutterIOSUIScrollViewContentInsetAdjustmentBehavior? fromValue(
    int? value,
  ) {
    if (value != null) {
      try {
        return AqutterIOSUIScrollViewContentInsetAdjustmentBehavior.values
            .firstWhere((element) => element.toValue() == value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSUIScrollViewContentInsetAdjustmentBehavior] instance from a native value.
  static AqutterIOSUIScrollViewContentInsetAdjustmentBehavior? fromNativeValue(
    int? value,
  ) {
    if (value != null) {
      try {
        return AqutterIOSUIScrollViewContentInsetAdjustmentBehavior.values
            .firstWhere((element) => element.toNativeValue() == value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSUIScrollViewContentInsetAdjustmentBehavior] instance value with name [name].
  ///
  /// Goes through [AqutterIOSUIScrollViewContentInsetAdjustmentBehavior.values] looking for a value with
  /// name [name], as reported by [AqutterIOSUIScrollViewContentInsetAdjustmentBehavior.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSUIScrollViewContentInsetAdjustmentBehavior? byName(
    String? name,
  ) {
    if (name != null) {
      try {
        return AqutterIOSUIScrollViewContentInsetAdjustmentBehavior.values
            .firstWhere((element) => element.name() == name);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSUIScrollViewContentInsetAdjustmentBehavior] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSUIScrollViewContentInsetAdjustmentBehavior>
  asNameMap() => <String, AqutterIOSUIScrollViewContentInsetAdjustmentBehavior>{
    for (final value
        in AqutterIOSUIScrollViewContentInsetAdjustmentBehavior.values)
      value.name(): value,
  };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 3:
        return 'ALWAYS';
      case 0:
        return 'AUTOMATIC';
      case 2:
        return 'NEVER';
      case 1:
        return 'SCROLLABLE_AXES';
    }
    return _value.toString();
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(value) => value == _value;

  ///Checks if the value is supported by the [defaultTargetPlatform].
  bool isSupported() {
    return _nativeValue != null;
  }

  @override
  String toString() {
    return name();
  }
}
