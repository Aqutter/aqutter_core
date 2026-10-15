// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dismiss_button_style.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to set the custom style for the dismiss button.
class AqutterDismissButtonStyle {
  final int _value;
  final int? _nativeValue;
  const AqutterDismissButtonStyle._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterDismissButtonStyle._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterDismissButtonStyle._internal(value, nativeValue());

  ///Makes the button title the localized string "Cancel".
  static const CANCEL = AqutterDismissButtonStyle._internal(2, 2);

  ///Makes the button title the localized string "Close".
  static const CLOSE = AqutterDismissButtonStyle._internal(1, 1);

  ///Makes the button title the localized string "Done".
  static const DONE = AqutterDismissButtonStyle._internal(0, 0);

  ///Set of all values of [AqutterDismissButtonStyle].
  static final Set<AqutterDismissButtonStyle> values = [
    AqutterDismissButtonStyle.CANCEL,
    AqutterDismissButtonStyle.CLOSE,
    AqutterDismissButtonStyle.DONE,
  ].toSet();

  ///Gets a possible [AqutterDismissButtonStyle] instance from [int] value.
  static AqutterDismissButtonStyle? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterDismissButtonStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterDismissButtonStyle] instance from a native value.
  static AqutterDismissButtonStyle? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterDismissButtonStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterDismissButtonStyle] instance value with name [name].
  ///
  /// Goes through [AqutterDismissButtonStyle.values] looking for a value with
  /// name [name], as reported by [AqutterDismissButtonStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterDismissButtonStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterDismissButtonStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterDismissButtonStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterDismissButtonStyle> asNameMap() =>
      <String, AqutterDismissButtonStyle>{
        for (final value in AqutterDismissButtonStyle.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 2:
        return 'CANCEL';
      case 1:
        return 'CLOSE';
      case 0:
        return 'DONE';
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

///An iOS-specific class used to set the custom style for the dismiss button.
///
///**NOTE**: available on iOS 11.0+.
///
///Use [AqutterDismissButtonStyle] instead.
@Deprecated('Use AqutterDismissButtonStyle instead')
class AqutterIOSSafariDismissButtonStyle {
  final int _value;
  final int? _nativeValue;
  const AqutterIOSSafariDismissButtonStyle._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSSafariDismissButtonStyle._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterIOSSafariDismissButtonStyle._internal(value, nativeValue());

  ///Makes the button title the localized string "Cancel".
  static const CANCEL = AqutterIOSSafariDismissButtonStyle._internal(2, 2);

  ///Makes the button title the localized string "Close".
  static const CLOSE = AqutterIOSSafariDismissButtonStyle._internal(1, 1);

  ///Makes the button title the localized string "Done".
  static const DONE = AqutterIOSSafariDismissButtonStyle._internal(0, 0);

  ///Set of all values of [AqutterIOSSafariDismissButtonStyle].
  static final Set<AqutterIOSSafariDismissButtonStyle> values = [
    AqutterIOSSafariDismissButtonStyle.CANCEL,
    AqutterIOSSafariDismissButtonStyle.CLOSE,
    AqutterIOSSafariDismissButtonStyle.DONE,
  ].toSet();

  ///Gets a possible [AqutterIOSSafariDismissButtonStyle] instance from [int] value.
  static AqutterIOSSafariDismissButtonStyle? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSSafariDismissButtonStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSSafariDismissButtonStyle] instance from a native value.
  static AqutterIOSSafariDismissButtonStyle? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSSafariDismissButtonStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSSafariDismissButtonStyle] instance value with name [name].
  ///
  /// Goes through [AqutterIOSSafariDismissButtonStyle.values] looking for a value with
  /// name [name], as reported by [AqutterIOSSafariDismissButtonStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSSafariDismissButtonStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSSafariDismissButtonStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSSafariDismissButtonStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSSafariDismissButtonStyle> asNameMap() =>
      <String, AqutterIOSSafariDismissButtonStyle>{
        for (final value in AqutterIOSSafariDismissButtonStyle.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 2:
        return 'CANCEL';
      case 1:
        return 'CLOSE';
      case 0:
        return 'DONE';
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
