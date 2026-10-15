// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_mode.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to override the way the cache is used.
class AqutterCacheMode {
  final int _value;
  final int? _nativeValue;
  const AqutterCacheMode._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterCacheMode._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterCacheMode._internal(value, nativeValue());

  ///Use cached resources when they are available, even if they have expired. Otherwise load resources from the network.
  static const LOAD_CACHE_ELSE_NETWORK = AqutterCacheMode._internal(1, 1);

  ///Don't use the network, load from the cache.
  static const LOAD_CACHE_ONLY = AqutterCacheMode._internal(3, 3);

  ///Default cache usage mode. If the navigation type doesn't impose any specific behavior,
  ///use cached resources when they are available and not expired, otherwise load resources from the network.
  static const LOAD_DEFAULT = AqutterCacheMode._internal(-1, -1);

  ///Don't use the cache, load from the network.
  static const LOAD_NO_CACHE = AqutterCacheMode._internal(2, 2);

  ///Set of all values of [AqutterCacheMode].
  static final Set<AqutterCacheMode> values = [
    AqutterCacheMode.LOAD_CACHE_ELSE_NETWORK,
    AqutterCacheMode.LOAD_CACHE_ONLY,
    AqutterCacheMode.LOAD_DEFAULT,
    AqutterCacheMode.LOAD_NO_CACHE,
  ].toSet();

  ///Gets a possible [AqutterCacheMode] instance from [int] value.
  static AqutterCacheMode? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterCacheMode.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterCacheMode] instance from a native value.
  static AqutterCacheMode? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterCacheMode.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterCacheMode] instance value with name [name].
  ///
  /// Goes through [AqutterCacheMode.values] looking for a value with
  /// name [name], as reported by [AqutterCacheMode.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterCacheMode? byName(String? name) {
    if (name != null) {
      try {
        return AqutterCacheMode.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterCacheMode] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterCacheMode> asNameMap() =>
      <String, AqutterCacheMode>{
        for (final value in AqutterCacheMode.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 1:
        return 'LOAD_CACHE_ELSE_NETWORK';
      case 3:
        return 'LOAD_CACHE_ONLY';
      case -1:
        return 'LOAD_DEFAULT';
      case 2:
        return 'LOAD_NO_CACHE';
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

///An Android-specific class used to override the way the cache is used.
///Use [AqutterCacheMode] instead.
@Deprecated('Use AqutterCacheMode instead')
class AqutterAndroidCacheMode {
  final int _value;
  final int? _nativeValue;
  const AqutterAndroidCacheMode._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterAndroidCacheMode._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterAndroidCacheMode._internal(value, nativeValue());

  ///Use cached resources when they are available, even if they have expired. Otherwise load resources from the network.
  static const LOAD_CACHE_ELSE_NETWORK = AqutterAndroidCacheMode._internal(
    1,
    1,
  );

  ///Don't use the network, load from the cache.
  static const LOAD_CACHE_ONLY = AqutterAndroidCacheMode._internal(3, 3);

  ///Default cache usage mode. If the navigation type doesn't impose any specific behavior,
  ///use cached resources when they are available and not expired, otherwise load resources from the network.
  static const LOAD_DEFAULT = AqutterAndroidCacheMode._internal(-1, -1);

  ///Don't use the cache, load from the network.
  static const LOAD_NO_CACHE = AqutterAndroidCacheMode._internal(2, 2);

  ///Set of all values of [AqutterAndroidCacheMode].
  static final Set<AqutterAndroidCacheMode> values = [
    AqutterAndroidCacheMode.LOAD_CACHE_ELSE_NETWORK,
    AqutterAndroidCacheMode.LOAD_CACHE_ONLY,
    AqutterAndroidCacheMode.LOAD_DEFAULT,
    AqutterAndroidCacheMode.LOAD_NO_CACHE,
  ].toSet();

  ///Gets a possible [AqutterAndroidCacheMode] instance from [int] value.
  static AqutterAndroidCacheMode? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidCacheMode.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAndroidCacheMode] instance from a native value.
  static AqutterAndroidCacheMode? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidCacheMode.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAndroidCacheMode] instance value with name [name].
  ///
  /// Goes through [AqutterAndroidCacheMode.values] looking for a value with
  /// name [name], as reported by [AqutterAndroidCacheMode.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAndroidCacheMode? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAndroidCacheMode.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAndroidCacheMode] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAndroidCacheMode> asNameMap() =>
      <String, AqutterAndroidCacheMode>{
        for (final value in AqutterAndroidCacheMode.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 1:
        return 'LOAD_CACHE_ELSE_NETWORK';
      case 3:
        return 'LOAD_CACHE_ONLY';
      case -1:
        return 'LOAD_DEFAULT';
      case 2:
        return 'LOAD_NO_CACHE';
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
