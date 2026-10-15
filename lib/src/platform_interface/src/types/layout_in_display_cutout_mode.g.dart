// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_in_display_cutout_mode.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class representing the share state that should be applied to the custom tab.
class AqutterLayoutInDisplayCutoutMode {
  final int _value;
  final int? _nativeValue;
  const AqutterLayoutInDisplayCutoutMode._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterLayoutInDisplayCutoutMode._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterLayoutInDisplayCutoutMode._internal(value, nativeValue());

  ///The window is always allowed to extend into the DisplayCutout areas on the all edges of the screen.
  ///
  ///**NOTE**: available on Android 30+.
  static const ALWAYS = AqutterLayoutInDisplayCutoutMode._internal(3, 3);

  ///With this default setting, content renders into the cutout area when displayed in portrait mode, but content is letterboxed when displayed in landscape mode.
  ///
  ///**NOTE**: available on Android 28+.
  static const DEFAULT = AqutterLayoutInDisplayCutoutMode._internal(0, 0);

  ///Content never renders into the cutout area.
  ///
  ///**NOTE**: available on Android 28+.
  static const NEVER = AqutterLayoutInDisplayCutoutMode._internal(2, 2);

  ///Content renders into the cutout area in both portrait and landscape modes.
  ///
  ///**NOTE**: available on Android 28+.
  static const SHORT_EDGES = AqutterLayoutInDisplayCutoutMode._internal(1, 1);

  ///Set of all values of [AqutterLayoutInDisplayCutoutMode].
  static final Set<AqutterLayoutInDisplayCutoutMode> values = [
    AqutterLayoutInDisplayCutoutMode.ALWAYS,
    AqutterLayoutInDisplayCutoutMode.DEFAULT,
    AqutterLayoutInDisplayCutoutMode.NEVER,
    AqutterLayoutInDisplayCutoutMode.SHORT_EDGES,
  ].toSet();

  ///Gets a possible [AqutterLayoutInDisplayCutoutMode] instance from [int] value.
  static AqutterLayoutInDisplayCutoutMode? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterLayoutInDisplayCutoutMode.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterLayoutInDisplayCutoutMode] instance from a native value.
  static AqutterLayoutInDisplayCutoutMode? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterLayoutInDisplayCutoutMode.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterLayoutInDisplayCutoutMode] instance value with name [name].
  ///
  /// Goes through [AqutterLayoutInDisplayCutoutMode.values] looking for a value with
  /// name [name], as reported by [AqutterLayoutInDisplayCutoutMode.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterLayoutInDisplayCutoutMode? byName(String? name) {
    if (name != null) {
      try {
        return AqutterLayoutInDisplayCutoutMode.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterLayoutInDisplayCutoutMode] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterLayoutInDisplayCutoutMode> asNameMap() =>
      <String, AqutterLayoutInDisplayCutoutMode>{
        for (final value in AqutterLayoutInDisplayCutoutMode.values)
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
        return 'DEFAULT';
      case 2:
        return 'NEVER';
      case 1:
        return 'SHORT_EDGES';
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

///Android-specific class representing the share state that should be applied to the custom tab.
///
///**NOTE**: available on Android 28+.
///
///Use [AqutterLayoutInDisplayCutoutMode] instead.
@Deprecated('Use AqutterLayoutInDisplayCutoutMode instead')
class AqutterAndroidLayoutInDisplayCutoutMode {
  final int _value;
  final int? _nativeValue;
  const AqutterAndroidLayoutInDisplayCutoutMode._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterAndroidLayoutInDisplayCutoutMode._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterAndroidLayoutInDisplayCutoutMode._internal(value, nativeValue());

  ///The window is always allowed to extend into the DisplayCutout areas on the all edges of the screen.
  ///
  ///**NOTE**: available on Android 30+.
  static const ALWAYS = AqutterAndroidLayoutInDisplayCutoutMode._internal(3, 3);

  ///With this default setting, content renders into the cutout area when displayed in portrait mode, but content is letterboxed when displayed in landscape mode.
  ///
  ///**NOTE**: available on Android 28+.
  static const DEFAULT = AqutterAndroidLayoutInDisplayCutoutMode._internal(
    0,
    0,
  );

  ///Content never renders into the cutout area.
  ///
  ///**NOTE**: available on Android 28+.
  static const NEVER = AqutterAndroidLayoutInDisplayCutoutMode._internal(2, 2);

  ///Content renders into the cutout area in both portrait and landscape modes.
  ///
  ///**NOTE**: available on Android 28+.
  static const SHORT_EDGES = AqutterAndroidLayoutInDisplayCutoutMode._internal(
    1,
    1,
  );

  ///Set of all values of [AqutterAndroidLayoutInDisplayCutoutMode].
  static final Set<AqutterAndroidLayoutInDisplayCutoutMode> values = [
    AqutterAndroidLayoutInDisplayCutoutMode.ALWAYS,
    AqutterAndroidLayoutInDisplayCutoutMode.DEFAULT,
    AqutterAndroidLayoutInDisplayCutoutMode.NEVER,
    AqutterAndroidLayoutInDisplayCutoutMode.SHORT_EDGES,
  ].toSet();

  ///Gets a possible [AqutterAndroidLayoutInDisplayCutoutMode] instance from [int] value.
  static AqutterAndroidLayoutInDisplayCutoutMode? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidLayoutInDisplayCutoutMode.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAndroidLayoutInDisplayCutoutMode] instance from a native value.
  static AqutterAndroidLayoutInDisplayCutoutMode? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidLayoutInDisplayCutoutMode.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAndroidLayoutInDisplayCutoutMode] instance value with name [name].
  ///
  /// Goes through [AqutterAndroidLayoutInDisplayCutoutMode.values] looking for a value with
  /// name [name], as reported by [AqutterAndroidLayoutInDisplayCutoutMode.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAndroidLayoutInDisplayCutoutMode? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAndroidLayoutInDisplayCutoutMode.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAndroidLayoutInDisplayCutoutMode] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAndroidLayoutInDisplayCutoutMode> asNameMap() =>
      <String, AqutterAndroidLayoutInDisplayCutoutMode>{
        for (final value in AqutterAndroidLayoutInDisplayCutoutMode.values)
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
        return 'DEFAULT';
      case 2:
        return 'NEVER';
      case 1:
        return 'SHORT_EDGES';
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
