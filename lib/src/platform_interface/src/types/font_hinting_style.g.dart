// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'font_hinting_style.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Font hinting style used for text rendering on Linux.
class AqutterFontHintingStyle {
  final int _value;
  final int? _nativeValue;
  const AqutterFontHintingStyle._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterFontHintingStyle._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterFontHintingStyle._internal(value, nativeValue());

  ///Full hinting. Maximum hinting is applied for crispest text.
  static const FULL = AqutterFontHintingStyle._internal(3, 3);

  ///Medium hinting. A moderate amount of hinting is applied.
  static const MEDIUM = AqutterFontHintingStyle._internal(2, 2);

  ///No hinting. Text is rendered without any hinting.
  static const NONE = AqutterFontHintingStyle._internal(0, 0);

  ///Slight hinting. A minimal amount of hinting is applied.
  static const SLIGHT = AqutterFontHintingStyle._internal(1, 1);

  ///Set of all values of [AqutterFontHintingStyle].
  static final Set<AqutterFontHintingStyle> values = [
    AqutterFontHintingStyle.FULL,
    AqutterFontHintingStyle.MEDIUM,
    AqutterFontHintingStyle.NONE,
    AqutterFontHintingStyle.SLIGHT,
  ].toSet();

  ///Gets a possible [AqutterFontHintingStyle] instance from [int] value.
  static AqutterFontHintingStyle? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterFontHintingStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterFontHintingStyle] instance from a native value.
  static AqutterFontHintingStyle? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterFontHintingStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterFontHintingStyle] instance value with name [name].
  ///
  /// Goes through [AqutterFontHintingStyle.values] looking for a value with
  /// name [name], as reported by [AqutterFontHintingStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterFontHintingStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterFontHintingStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterFontHintingStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterFontHintingStyle> asNameMap() =>
      <String, AqutterFontHintingStyle>{
        for (final value in AqutterFontHintingStyle.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 3:
        return 'FULL';
      case 2:
        return 'MEDIUM';
      case 0:
        return 'NONE';
      case 1:
        return 'SLIGHT';
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
