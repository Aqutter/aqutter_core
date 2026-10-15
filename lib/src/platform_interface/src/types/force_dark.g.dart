// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'force_dark.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to indicate the force dark mode.
class AqutterForceDark {
  final int _value;
  final int? _nativeValue;
  const AqutterForceDark._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterForceDark._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterForceDark._internal(value, nativeValue());

  ///Enable force dark dependent on the state of the WebView parent view.
  static const AUTO = AqutterForceDark._internal(1, 1);

  ///Disable force dark, irrespective of the force dark mode of the WebView parent.
  ///In this mode, WebView content will always be rendered as-is, regardless of whether native views are being automatically darkened.
  static const OFF = AqutterForceDark._internal(0, 0);

  ///Unconditionally enable force dark. In this mode WebView content will always be rendered so as to emulate a dark theme.
  static const ON = AqutterForceDark._internal(2, 2);

  ///Set of all values of [AqutterForceDark].
  static final Set<AqutterForceDark> values = [
    AqutterForceDark.AUTO,
    AqutterForceDark.OFF,
    AqutterForceDark.ON,
  ].toSet();

  ///Gets a possible [AqutterForceDark] instance from [int] value.
  static AqutterForceDark? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterForceDark.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterForceDark] instance from a native value.
  static AqutterForceDark? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterForceDark.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterForceDark] instance value with name [name].
  ///
  /// Goes through [AqutterForceDark.values] looking for a value with
  /// name [name], as reported by [AqutterForceDark.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterForceDark? byName(String? name) {
    if (name != null) {
      try {
        return AqutterForceDark.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterForceDark] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterForceDark> asNameMap() =>
      <String, AqutterForceDark>{
        for (final value in AqutterForceDark.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 1:
        return 'AUTO';
      case 0:
        return 'OFF';
      case 2:
        return 'ON';
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

///An Android-specific class used to indicate the force dark mode.
///
///**NOTE**: available on Android 29+.
///
///Use [AqutterForceDark] instead.
@Deprecated('Use AqutterForceDark instead')
class AqutterAndroidForceDark {
  final int _value;
  final int? _nativeValue;
  const AqutterAndroidForceDark._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterAndroidForceDark._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterAndroidForceDark._internal(value, nativeValue());

  ///Enable force dark dependent on the state of the WebView parent view.
  static const FORCE_DARK_AUTO = AqutterAndroidForceDark._internal(1, 1);

  ///Disable force dark, irrespective of the force dark mode of the WebView parent.
  ///In this mode, WebView content will always be rendered as-is, regardless of whether native views are being automatically darkened.
  static const FORCE_DARK_OFF = AqutterAndroidForceDark._internal(0, 0);

  ///Unconditionally enable force dark. In this mode WebView content will always be rendered so as to emulate a dark theme.
  static const FORCE_DARK_ON = AqutterAndroidForceDark._internal(2, 2);

  ///Set of all values of [AqutterAndroidForceDark].
  static final Set<AqutterAndroidForceDark> values = [
    AqutterAndroidForceDark.FORCE_DARK_AUTO,
    AqutterAndroidForceDark.FORCE_DARK_OFF,
    AqutterAndroidForceDark.FORCE_DARK_ON,
  ].toSet();

  ///Gets a possible [AqutterAndroidForceDark] instance from [int] value.
  static AqutterAndroidForceDark? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidForceDark.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAndroidForceDark] instance from a native value.
  static AqutterAndroidForceDark? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidForceDark.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAndroidForceDark] instance value with name [name].
  ///
  /// Goes through [AqutterAndroidForceDark.values] looking for a value with
  /// name [name], as reported by [AqutterAndroidForceDark.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAndroidForceDark? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAndroidForceDark.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAndroidForceDark] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAndroidForceDark> asNameMap() =>
      <String, AqutterAndroidForceDark>{
        for (final value in AqutterAndroidForceDark.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 1:
        return 'FORCE_DARK_AUTO';
      case 0:
        return 'FORCE_DARK_OFF';
      case 2:
        return 'FORCE_DARK_ON';
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
