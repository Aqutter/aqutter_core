// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_usage_target_level.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Constants that describe memory usage target levels.
class AqutterMemoryUsageTargetLevel {
  final int _value;
  final int? _nativeValue;
  const AqutterMemoryUsageTargetLevel._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterMemoryUsageTargetLevel._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterMemoryUsageTargetLevel._internal(value, nativeValue());

  ///Low memory usage target level.
  static const LOW = AqutterMemoryUsageTargetLevel._internal(1, 1);

  ///Normal memory usage target level.
  static const NORMAL = AqutterMemoryUsageTargetLevel._internal(0, 0);

  ///Set of all values of [AqutterMemoryUsageTargetLevel].
  static final Set<AqutterMemoryUsageTargetLevel> values = [
    AqutterMemoryUsageTargetLevel.LOW,
    AqutterMemoryUsageTargetLevel.NORMAL,
  ].toSet();

  ///Gets a possible [AqutterMemoryUsageTargetLevel] instance from [int] value.
  static AqutterMemoryUsageTargetLevel? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterMemoryUsageTargetLevel.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterMemoryUsageTargetLevel] instance from a native value.
  static AqutterMemoryUsageTargetLevel? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterMemoryUsageTargetLevel.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterMemoryUsageTargetLevel] instance value with name [name].
  ///
  /// Goes through [AqutterMemoryUsageTargetLevel.values] looking for a value with
  /// name [name], as reported by [AqutterMemoryUsageTargetLevel.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterMemoryUsageTargetLevel? byName(String? name) {
    if (name != null) {
      try {
        return AqutterMemoryUsageTargetLevel.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterMemoryUsageTargetLevel] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterMemoryUsageTargetLevel> asNameMap() =>
      <String, AqutterMemoryUsageTargetLevel>{
        for (final value in AqutterMemoryUsageTargetLevel.values)
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
        return 'LOW';
      case 0:
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
    return name();
  }
}
