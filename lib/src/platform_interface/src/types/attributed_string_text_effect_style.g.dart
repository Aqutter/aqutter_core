// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributed_string_text_effect_style.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the supported proxy types.
class AqutterAttributedStringTextEffectStyle {
  final String _value;
  final String? _nativeValue;
  const AqutterAttributedStringTextEffectStyle._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterAttributedStringTextEffectStyle._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterAttributedStringTextEffectStyle._internal(value, nativeValue());

  ///A graphical text effect that gives glyphs the appearance of letterpress printing, which involves pressing the type into the paper.
  static const LETTERPRESS_STYLE =
      AqutterAttributedStringTextEffectStyle._internal(
        'letterpressStyle',
        'letterpressStyle',
      );

  ///Set of all values of [AqutterAttributedStringTextEffectStyle].
  static final Set<AqutterAttributedStringTextEffectStyle> values = [
    AqutterAttributedStringTextEffectStyle.LETTERPRESS_STYLE,
  ].toSet();

  ///Gets a possible [AqutterAttributedStringTextEffectStyle] instance from [String] value.
  static AqutterAttributedStringTextEffectStyle? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterAttributedStringTextEffectStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAttributedStringTextEffectStyle] instance from a native value.
  static AqutterAttributedStringTextEffectStyle? fromNativeValue(
    String? value,
  ) {
    if (value != null) {
      try {
        return AqutterAttributedStringTextEffectStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAttributedStringTextEffectStyle] instance value with name [name].
  ///
  /// Goes through [AqutterAttributedStringTextEffectStyle.values] looking for a value with
  /// name [name], as reported by [AqutterAttributedStringTextEffectStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAttributedStringTextEffectStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAttributedStringTextEffectStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAttributedStringTextEffectStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAttributedStringTextEffectStyle> asNameMap() =>
      <String, AqutterAttributedStringTextEffectStyle>{
        for (final value in AqutterAttributedStringTextEffectStyle.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'letterpressStyle':
        return 'LETTERPRESS_STYLE';
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
    return _value;
  }
}

///An iOS-specific Class that represents the supported proxy types.
///Use [AqutterAttributedStringTextEffectStyle] instead.
@Deprecated('Use AqutterAttributedStringTextEffectStyle instead')
class AqutterIOSNSAttributedStringTextEffectStyle {
  final String _value;
  final String? _nativeValue;
  const AqutterIOSNSAttributedStringTextEffectStyle._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSNSAttributedStringTextEffectStyle._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterIOSNSAttributedStringTextEffectStyle._internal(
    value,
    nativeValue(),
  );

  ///A graphical text effect that gives glyphs the appearance of letterpress printing, which involves pressing the type into the paper.
  static const LETTERPRESS_STYLE =
      AqutterIOSNSAttributedStringTextEffectStyle._internal(
        'letterpressStyle',
        'letterpressStyle',
      );

  ///Set of all values of [AqutterIOSNSAttributedStringTextEffectStyle].
  static final Set<AqutterIOSNSAttributedStringTextEffectStyle> values = [
    AqutterIOSNSAttributedStringTextEffectStyle.LETTERPRESS_STYLE,
  ].toSet();

  ///Gets a possible [AqutterIOSNSAttributedStringTextEffectStyle] instance from [String] value.
  static AqutterIOSNSAttributedStringTextEffectStyle? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterIOSNSAttributedStringTextEffectStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSNSAttributedStringTextEffectStyle] instance from a native value.
  static AqutterIOSNSAttributedStringTextEffectStyle? fromNativeValue(
    String? value,
  ) {
    if (value != null) {
      try {
        return AqutterIOSNSAttributedStringTextEffectStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSNSAttributedStringTextEffectStyle] instance value with name [name].
  ///
  /// Goes through [AqutterIOSNSAttributedStringTextEffectStyle.values] looking for a value with
  /// name [name], as reported by [AqutterIOSNSAttributedStringTextEffectStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSNSAttributedStringTextEffectStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSNSAttributedStringTextEffectStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSNSAttributedStringTextEffectStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSNSAttributedStringTextEffectStyle> asNameMap() =>
      <String, AqutterIOSNSAttributedStringTextEffectStyle>{
        for (final value in AqutterIOSNSAttributedStringTextEffectStyle.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'letterpressStyle':
        return 'LETTERPRESS_STYLE';
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
    return _value;
  }
}
