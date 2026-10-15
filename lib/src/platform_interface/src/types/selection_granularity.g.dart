// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection_granularity.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to set the level of granularity with which the user can interactively select content in the web view.
class AqutterSelectionGranularity {
  final int _value;
  final int? _nativeValue;
  const AqutterSelectionGranularity._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterSelectionGranularity._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterSelectionGranularity._internal(value, nativeValue());

  ///Selection endpoints can be placed at any character boundary.
  static const CHARACTER = AqutterSelectionGranularity._internal(1, 1);

  ///Selection granularity varies automatically based on the selection.
  static const DYNAMIC = AqutterSelectionGranularity._internal(0, 0);

  ///Set of all values of [AqutterSelectionGranularity].
  static final Set<AqutterSelectionGranularity> values = [
    AqutterSelectionGranularity.CHARACTER,
    AqutterSelectionGranularity.DYNAMIC,
  ].toSet();

  ///Gets a possible [AqutterSelectionGranularity] instance from [int] value.
  static AqutterSelectionGranularity? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterSelectionGranularity.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterSelectionGranularity] instance from a native value.
  static AqutterSelectionGranularity? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterSelectionGranularity.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterSelectionGranularity] instance value with name [name].
  ///
  /// Goes through [AqutterSelectionGranularity.values] looking for a value with
  /// name [name], as reported by [AqutterSelectionGranularity.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterSelectionGranularity? byName(String? name) {
    if (name != null) {
      try {
        return AqutterSelectionGranularity.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterSelectionGranularity] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterSelectionGranularity> asNameMap() =>
      <String, AqutterSelectionGranularity>{
        for (final value in AqutterSelectionGranularity.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 1:
        return 'CHARACTER';
      case 0:
        return 'DYNAMIC';
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

///An iOS-specific class used to set the level of granularity with which the user can interactively select content in the web view.
///Use [AqutterSelectionGranularity] instead.
@Deprecated('Use AqutterSelectionGranularity instead')
class AqutterIOSWKSelectionGranularity {
  final int _value;
  final int? _nativeValue;
  const AqutterIOSWKSelectionGranularity._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSWKSelectionGranularity._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterIOSWKSelectionGranularity._internal(value, nativeValue());

  ///Selection endpoints can be placed at any character boundary.
  static const CHARACTER = AqutterIOSWKSelectionGranularity._internal(1, 1);

  ///Selection granularity varies automatically based on the selection.
  static const DYNAMIC = AqutterIOSWKSelectionGranularity._internal(0, 0);

  ///Set of all values of [AqutterIOSWKSelectionGranularity].
  static final Set<AqutterIOSWKSelectionGranularity> values = [
    AqutterIOSWKSelectionGranularity.CHARACTER,
    AqutterIOSWKSelectionGranularity.DYNAMIC,
  ].toSet();

  ///Gets a possible [AqutterIOSWKSelectionGranularity] instance from [int] value.
  static AqutterIOSWKSelectionGranularity? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSWKSelectionGranularity.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSWKSelectionGranularity] instance from a native value.
  static AqutterIOSWKSelectionGranularity? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSWKSelectionGranularity.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSWKSelectionGranularity] instance value with name [name].
  ///
  /// Goes through [AqutterIOSWKSelectionGranularity.values] looking for a value with
  /// name [name], as reported by [AqutterIOSWKSelectionGranularity.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSWKSelectionGranularity? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSWKSelectionGranularity.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSWKSelectionGranularity] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSWKSelectionGranularity> asNameMap() =>
      <String, AqutterIOSWKSelectionGranularity>{
        for (final value in AqutterIOSWKSelectionGranularity.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 1:
        return 'CHARACTER';
      case 0:
        return 'DYNAMIC';
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
