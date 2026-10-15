// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'underline_style.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the constants for the underline style and strikethrough style attribute keys.
class AqutterUnderlineStyle {
  final int _value;
  final int? _nativeValue;
  const AqutterUnderlineStyle._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterUnderlineStyle._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterUnderlineStyle._internal(value, nativeValue());

  ///Draw the line only beneath or through words, not whitespace.
  static const BY_WORD = AqutterUnderlineStyle._internal(32768, 32768);

  ///Draw a double line.
  static const DOUBLE = AqutterUnderlineStyle._internal(9, 9);

  ///Draw a line of dashes.
  static const PATTERN_DASH = AqutterUnderlineStyle._internal(512, 512);

  ///Draw a line of alternating dashes and dots.
  static const PATTERN_DASH_DOT = AqutterUnderlineStyle._internal(768, 768);

  ///Draw a line of alternating dashes and two dots.
  static const PATTERN_DASH_DOT_DOT = AqutterUnderlineStyle._internal(
    1024,
    1024,
  );

  ///Draw a line of dots.
  static const PATTERN_DOT = AqutterUnderlineStyle._internal(256, 256);

  ///Draw a single line.
  static const SINGLE = AqutterUnderlineStyle._internal(1, 1);

  ///Do not draw a line.
  static const STYLE_NONE = AqutterUnderlineStyle._internal(0, 0);

  ///Draw a thick line.
  static const THICK = AqutterUnderlineStyle._internal(2, 2);

  ///Set of all values of [AqutterUnderlineStyle].
  static final Set<AqutterUnderlineStyle> values = [
    AqutterUnderlineStyle.BY_WORD,
    AqutterUnderlineStyle.DOUBLE,
    AqutterUnderlineStyle.PATTERN_DASH,
    AqutterUnderlineStyle.PATTERN_DASH_DOT,
    AqutterUnderlineStyle.PATTERN_DASH_DOT_DOT,
    AqutterUnderlineStyle.PATTERN_DOT,
    AqutterUnderlineStyle.SINGLE,
    AqutterUnderlineStyle.STYLE_NONE,
    AqutterUnderlineStyle.THICK,
  ].toSet();

  ///Gets a possible [AqutterUnderlineStyle] instance from [int] value.
  static AqutterUnderlineStyle? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterUnderlineStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterUnderlineStyle] instance from a native value.
  static AqutterUnderlineStyle? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterUnderlineStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterUnderlineStyle] instance value with name [name].
  ///
  /// Goes through [AqutterUnderlineStyle.values] looking for a value with
  /// name [name], as reported by [AqutterUnderlineStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterUnderlineStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterUnderlineStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterUnderlineStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterUnderlineStyle> asNameMap() =>
      <String, AqutterUnderlineStyle>{
        for (final value in AqutterUnderlineStyle.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 32768:
        return 'BY_WORD';
      case 9:
        return 'DOUBLE';
      case 512:
        return 'PATTERN_DASH';
      case 768:
        return 'PATTERN_DASH_DOT';
      case 1024:
        return 'PATTERN_DASH_DOT_DOT';
      case 256:
        return 'PATTERN_DOT';
      case 1:
        return 'SINGLE';
      case 0:
        return 'STYLE_NONE';
      case 2:
        return 'THICK';
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

///An iOS-specific Class that represents the constants for the underline style and strikethrough style attribute keys.
///Use [AqutterUnderlineStyle] instead.
@Deprecated('Use AqutterUnderlineStyle instead')
class AqutterIOSNSUnderlineStyle {
  final int _value;
  final int? _nativeValue;
  const AqutterIOSNSUnderlineStyle._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterIOSNSUnderlineStyle._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterIOSNSUnderlineStyle._internal(value, nativeValue());

  ///Draw the line only beneath or through words, not whitespace.
  static const BY_WORD = AqutterIOSNSUnderlineStyle._internal(32768, 32768);

  ///Draw a double line.
  static const DOUBLE = AqutterIOSNSUnderlineStyle._internal(9, 9);

  ///Draw a line of dashes.
  static const PATTERN_DASH = AqutterIOSNSUnderlineStyle._internal(512, 512);

  ///Draw a line of alternating dashes and dots.
  static const PATTERN_DASH_DOT = AqutterIOSNSUnderlineStyle._internal(
    768,
    768,
  );

  ///Draw a line of alternating dashes and two dots.
  static const PATTERN_DASH_DOT_DOT = AqutterIOSNSUnderlineStyle._internal(
    1024,
    1024,
  );

  ///Draw a line of dots.
  static const PATTERN_DOT = AqutterIOSNSUnderlineStyle._internal(256, 256);

  ///Draw a single line.
  static const SINGLE = AqutterIOSNSUnderlineStyle._internal(1, 1);

  ///Do not draw a line.
  static const STYLE_NONE = AqutterIOSNSUnderlineStyle._internal(0, 0);

  ///Draw a thick line.
  static const THICK = AqutterIOSNSUnderlineStyle._internal(2, 2);

  ///Set of all values of [AqutterIOSNSUnderlineStyle].
  static final Set<AqutterIOSNSUnderlineStyle> values = [
    AqutterIOSNSUnderlineStyle.BY_WORD,
    AqutterIOSNSUnderlineStyle.DOUBLE,
    AqutterIOSNSUnderlineStyle.PATTERN_DASH,
    AqutterIOSNSUnderlineStyle.PATTERN_DASH_DOT,
    AqutterIOSNSUnderlineStyle.PATTERN_DASH_DOT_DOT,
    AqutterIOSNSUnderlineStyle.PATTERN_DOT,
    AqutterIOSNSUnderlineStyle.SINGLE,
    AqutterIOSNSUnderlineStyle.STYLE_NONE,
    AqutterIOSNSUnderlineStyle.THICK,
  ].toSet();

  ///Gets a possible [AqutterIOSNSUnderlineStyle] instance from [int] value.
  static AqutterIOSNSUnderlineStyle? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSNSUnderlineStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSNSUnderlineStyle] instance from a native value.
  static AqutterIOSNSUnderlineStyle? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSNSUnderlineStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSNSUnderlineStyle] instance value with name [name].
  ///
  /// Goes through [AqutterIOSNSUnderlineStyle.values] looking for a value with
  /// name [name], as reported by [AqutterIOSNSUnderlineStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSNSUnderlineStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSNSUnderlineStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSNSUnderlineStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSNSUnderlineStyle> asNameMap() =>
      <String, AqutterIOSNSUnderlineStyle>{
        for (final value in AqutterIOSNSUnderlineStyle.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 32768:
        return 'BY_WORD';
      case 9:
        return 'DOUBLE';
      case 512:
        return 'PATTERN_DASH';
      case 768:
        return 'PATTERN_DASH_DOT';
      case 1024:
        return 'PATTERN_DASH_DOT_DOT';
      case 256:
        return 'PATTERN_DOT';
      case 1:
        return 'SINGLE';
      case 0:
        return 'STYLE_NONE';
      case 2:
        return 'THICK';
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
