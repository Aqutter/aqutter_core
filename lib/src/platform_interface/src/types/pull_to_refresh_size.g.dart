// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pull_to_refresh_size.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class representing the size of the refresh indicator.
class AqutterPullToRefreshSize {
  final int _value;
  final int? _nativeValue;
  const AqutterPullToRefreshSize._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterPullToRefreshSize._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterPullToRefreshSize._internal(value, nativeValue());

  ///Default size.
  static const DEFAULT = AqutterPullToRefreshSize._internal(1, 1);

  ///Large size.
  static const LARGE = AqutterPullToRefreshSize._internal(0, 0);

  ///Set of all values of [AqutterPullToRefreshSize].
  static final Set<AqutterPullToRefreshSize> values = [
    AqutterPullToRefreshSize.DEFAULT,
    AqutterPullToRefreshSize.LARGE,
  ].toSet();

  ///Gets a possible [AqutterPullToRefreshSize] instance from [int] value.
  static AqutterPullToRefreshSize? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterPullToRefreshSize.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterPullToRefreshSize] instance from a native value.
  static AqutterPullToRefreshSize? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterPullToRefreshSize.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterPullToRefreshSize] instance value with name [name].
  ///
  /// Goes through [AqutterPullToRefreshSize.values] looking for a value with
  /// name [name], as reported by [AqutterPullToRefreshSize.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterPullToRefreshSize? byName(String? name) {
    if (name != null) {
      try {
        return AqutterPullToRefreshSize.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterPullToRefreshSize] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterPullToRefreshSize> asNameMap() =>
      <String, AqutterPullToRefreshSize>{
        for (final value in AqutterPullToRefreshSize.values)
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
        return 'DEFAULT';
      case 0:
        return 'LARGE';
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

///Android-specific class representing the size of the refresh indicator.
///Use [AqutterPullToRefreshSize] instead.
@Deprecated('Use AqutterPullToRefreshSize instead')
class AqutterAndroidPullToRefreshSize {
  final int _value;
  final int? _nativeValue;
  const AqutterAndroidPullToRefreshSize._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterAndroidPullToRefreshSize._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterAndroidPullToRefreshSize._internal(value, nativeValue());

  ///Default size.
  static const DEFAULT = AqutterAndroidPullToRefreshSize._internal(1, 1);

  ///Large size.
  static const LARGE = AqutterAndroidPullToRefreshSize._internal(0, 0);

  ///Set of all values of [AqutterAndroidPullToRefreshSize].
  static final Set<AqutterAndroidPullToRefreshSize> values = [
    AqutterAndroidPullToRefreshSize.DEFAULT,
    AqutterAndroidPullToRefreshSize.LARGE,
  ].toSet();

  ///Gets a possible [AqutterAndroidPullToRefreshSize] instance from [int] value.
  static AqutterAndroidPullToRefreshSize? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidPullToRefreshSize.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAndroidPullToRefreshSize] instance from a native value.
  static AqutterAndroidPullToRefreshSize? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidPullToRefreshSize.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAndroidPullToRefreshSize] instance value with name [name].
  ///
  /// Goes through [AqutterAndroidPullToRefreshSize.values] looking for a value with
  /// name [name], as reported by [AqutterAndroidPullToRefreshSize.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAndroidPullToRefreshSize? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAndroidPullToRefreshSize.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAndroidPullToRefreshSize] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAndroidPullToRefreshSize> asNameMap() =>
      <String, AqutterAndroidPullToRefreshSize>{
        for (final value in AqutterAndroidPullToRefreshSize.values)
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
        return 'DEFAULT';
      case 0:
        return 'LARGE';
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
