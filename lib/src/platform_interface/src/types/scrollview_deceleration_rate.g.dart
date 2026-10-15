// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrollview_deceleration_rate.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents a floating-point value that determines the rate of deceleration after the user lifts their finger.
class AqutterScrollViewDecelerationRate {
  final String _value;
  final String? _nativeValue;
  const AqutterScrollViewDecelerationRate._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterScrollViewDecelerationRate._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterScrollViewDecelerationRate._internal(value, nativeValue());

  ///A fast deceleration rate for a scroll view: `0.99`.
  static const FAST = AqutterScrollViewDecelerationRate._internal(
    'FAST',
    'FAST',
  );

  ///The default deceleration rate for a scroll view: `0.998`.
  static const NORMAL = AqutterScrollViewDecelerationRate._internal(
    'NORMAL',
    'NORMAL',
  );

  ///Set of all values of [AqutterScrollViewDecelerationRate].
  static final Set<AqutterScrollViewDecelerationRate> values = [
    AqutterScrollViewDecelerationRate.FAST,
    AqutterScrollViewDecelerationRate.NORMAL,
  ].toSet();

  ///Gets a possible [AqutterScrollViewDecelerationRate] instance from [String] value.
  static AqutterScrollViewDecelerationRate? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterScrollViewDecelerationRate.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterScrollViewDecelerationRate] instance from a native value.
  static AqutterScrollViewDecelerationRate? fromNativeValue(String? value) {
    if (value != null) {
      try {
        return AqutterScrollViewDecelerationRate.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterScrollViewDecelerationRate] instance value with name [name].
  ///
  /// Goes through [AqutterScrollViewDecelerationRate.values] looking for a value with
  /// name [name], as reported by [AqutterScrollViewDecelerationRate.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterScrollViewDecelerationRate? byName(String? name) {
    if (name != null) {
      try {
        return AqutterScrollViewDecelerationRate.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterScrollViewDecelerationRate] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterScrollViewDecelerationRate> asNameMap() =>
      <String, AqutterScrollViewDecelerationRate>{
        for (final value in AqutterScrollViewDecelerationRate.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'FAST':
        return 'FAST';
      case 'NORMAL':
        return 'NORMAL';
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

///Class that represents a floating-point value that determines the rate of deceleration after the user lifts their finger.
///Use [AqutterScrollViewDecelerationRate] instead.
@Deprecated('Use AqutterScrollViewDecelerationRate instead')
class AqutterIOSUIScrollViewDecelerationRate {
  final String _value;
  final String? _nativeValue;
  const AqutterIOSUIScrollViewDecelerationRate._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSUIScrollViewDecelerationRate._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterIOSUIScrollViewDecelerationRate._internal(value, nativeValue());

  ///A fast deceleration rate for a scroll view: `0.99`.
  static const FAST = AqutterIOSUIScrollViewDecelerationRate._internal(
    'FAST',
    'FAST',
  );

  ///The default deceleration rate for a scroll view: `0.998`.
  static const NORMAL = AqutterIOSUIScrollViewDecelerationRate._internal(
    'NORMAL',
    'NORMAL',
  );

  ///Set of all values of [AqutterIOSUIScrollViewDecelerationRate].
  static final Set<AqutterIOSUIScrollViewDecelerationRate> values = [
    AqutterIOSUIScrollViewDecelerationRate.FAST,
    AqutterIOSUIScrollViewDecelerationRate.NORMAL,
  ].toSet();

  ///Gets a possible [AqutterIOSUIScrollViewDecelerationRate] instance from [String] value.
  static AqutterIOSUIScrollViewDecelerationRate? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterIOSUIScrollViewDecelerationRate.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSUIScrollViewDecelerationRate] instance from a native value.
  static AqutterIOSUIScrollViewDecelerationRate? fromNativeValue(
    String? value,
  ) {
    if (value != null) {
      try {
        return AqutterIOSUIScrollViewDecelerationRate.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSUIScrollViewDecelerationRate] instance value with name [name].
  ///
  /// Goes through [AqutterIOSUIScrollViewDecelerationRate.values] looking for a value with
  /// name [name], as reported by [AqutterIOSUIScrollViewDecelerationRate.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSUIScrollViewDecelerationRate? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSUIScrollViewDecelerationRate.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSUIScrollViewDecelerationRate] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSUIScrollViewDecelerationRate> asNameMap() =>
      <String, AqutterIOSUIScrollViewDecelerationRate>{
        for (final value in AqutterIOSUIScrollViewDecelerationRate.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'FAST':
        return 'FAST';
      case 'NORMAL':
        return 'NORMAL';
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
