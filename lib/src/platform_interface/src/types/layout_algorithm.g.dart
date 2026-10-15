// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_algorithm.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to set the underlying layout algorithm.
class AqutterLayoutAlgorithm {
  final String _value;
  final String? _nativeValue;
  const AqutterLayoutAlgorithm._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterLayoutAlgorithm._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterLayoutAlgorithm._internal(value, nativeValue());

  ///NARROW_COLUMNS makes all columns no wider than the screen if possible. Only use this for API levels prior to `Build.VERSION_CODES.KITKAT`.
  static const NARROW_COLUMNS = AqutterLayoutAlgorithm._internal(
    'NARROW_COLUMNS',
    'NARROW_COLUMNS',
  );

  ///NORMAL means no rendering changes. This is the recommended choice for maximum compatibility across different platforms and Android versions.
  static const NORMAL = AqutterLayoutAlgorithm._internal('NORMAL', 'NORMAL');

  ///TEXT_AUTOSIZING boosts font size of paragraphs based on heuristics to make the text readable when viewing a wide-viewport layout in the overview mode.
  ///It is recommended to enable zoom support [AqutterWebViewSettings.supportZoom] when using this mode.
  ///
  ///**NOTE**: available on Android 19+.
  static const TEXT_AUTOSIZING = AqutterLayoutAlgorithm._internal(
    'TEXT_AUTOSIZING',
    'TEXT_AUTOSIZING',
  );

  ///Set of all values of [AqutterLayoutAlgorithm].
  static final Set<AqutterLayoutAlgorithm> values = [
    AqutterLayoutAlgorithm.NARROW_COLUMNS,
    AqutterLayoutAlgorithm.NORMAL,
    AqutterLayoutAlgorithm.TEXT_AUTOSIZING,
  ].toSet();

  ///Gets a possible [AqutterLayoutAlgorithm] instance from [String] value.
  static AqutterLayoutAlgorithm? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterLayoutAlgorithm.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterLayoutAlgorithm] instance from a native value.
  static AqutterLayoutAlgorithm? fromNativeValue(String? value) {
    if (value != null) {
      try {
        return AqutterLayoutAlgorithm.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterLayoutAlgorithm] instance value with name [name].
  ///
  /// Goes through [AqutterLayoutAlgorithm.values] looking for a value with
  /// name [name], as reported by [AqutterLayoutAlgorithm.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterLayoutAlgorithm? byName(String? name) {
    if (name != null) {
      try {
        return AqutterLayoutAlgorithm.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterLayoutAlgorithm] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterLayoutAlgorithm> asNameMap() =>
      <String, AqutterLayoutAlgorithm>{
        for (final value in AqutterLayoutAlgorithm.values) value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'NARROW_COLUMNS':
        return 'NARROW_COLUMNS';
      case 'NORMAL':
        return 'NORMAL';
      case 'TEXT_AUTOSIZING':
        return 'TEXT_AUTOSIZING';
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

///An Android-specific class used to set the underlying layout algorithm.
///Use [AqutterLayoutAlgorithm] instead.
@Deprecated('Use AqutterLayoutAlgorithm instead')
class AqutterAndroidLayoutAlgorithm {
  final String _value;
  final String? _nativeValue;
  const AqutterAndroidLayoutAlgorithm._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterAndroidLayoutAlgorithm._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterAndroidLayoutAlgorithm._internal(value, nativeValue());

  ///NARROW_COLUMNS makes all columns no wider than the screen if possible. Only use this for API levels prior to `Build.VERSION_CODES.KITKAT`.
  static const NARROW_COLUMNS = AqutterAndroidLayoutAlgorithm._internal(
    'NARROW_COLUMNS',
    'NARROW_COLUMNS',
  );

  ///NORMAL means no rendering changes. This is the recommended choice for maximum compatibility across different platforms and Android versions.
  static const NORMAL = AqutterAndroidLayoutAlgorithm._internal(
    'NORMAL',
    'NORMAL',
  );

  ///TEXT_AUTOSIZING boosts font size of paragraphs based on heuristics to make the text readable when viewing a wide-viewport layout in the overview mode.
  ///It is recommended to enable zoom support [AqutterInAppWebViewOptions.supportZoom] when using this mode.
  ///
  ///**NOTE**: available on Android 19+.
  static const TEXT_AUTOSIZING = AqutterAndroidLayoutAlgorithm._internal(
    'TEXT_AUTOSIZING',
    'TEXT_AUTOSIZING',
  );

  ///Set of all values of [AqutterAndroidLayoutAlgorithm].
  static final Set<AqutterAndroidLayoutAlgorithm> values = [
    AqutterAndroidLayoutAlgorithm.NARROW_COLUMNS,
    AqutterAndroidLayoutAlgorithm.NORMAL,
    AqutterAndroidLayoutAlgorithm.TEXT_AUTOSIZING,
  ].toSet();

  ///Gets a possible [AqutterAndroidLayoutAlgorithm] instance from [String] value.
  static AqutterAndroidLayoutAlgorithm? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterAndroidLayoutAlgorithm.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAndroidLayoutAlgorithm] instance from a native value.
  static AqutterAndroidLayoutAlgorithm? fromNativeValue(String? value) {
    if (value != null) {
      try {
        return AqutterAndroidLayoutAlgorithm.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAndroidLayoutAlgorithm] instance value with name [name].
  ///
  /// Goes through [AqutterAndroidLayoutAlgorithm.values] looking for a value with
  /// name [name], as reported by [AqutterAndroidLayoutAlgorithm.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAndroidLayoutAlgorithm? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAndroidLayoutAlgorithm.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAndroidLayoutAlgorithm] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAndroidLayoutAlgorithm> asNameMap() =>
      <String, AqutterAndroidLayoutAlgorithm>{
        for (final value in AqutterAndroidLayoutAlgorithm.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'NARROW_COLUMNS':
        return 'NARROW_COLUMNS';
      case 'NORMAL':
        return 'NORMAL';
      case 'TEXT_AUTOSIZING':
        return 'TEXT_AUTOSIZING';
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
