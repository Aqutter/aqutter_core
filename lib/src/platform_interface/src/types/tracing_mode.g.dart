// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracing_mode.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Constants that describe the results summary the find panel UI includes.
class AqutterTracingMode {
  final int _value;
  final int? _nativeValue;
  const AqutterTracingMode._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterTracingMode._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterTracingMode._internal(value, nativeValue());

  ///Record trace events continuously using an internal ring buffer.
  ///Default tracing mode.
  ///Overwrites old events if they exceed buffer capacity.
  ///Uses less memory than the [RECORD_UNTIL_FULL] mode.
  ///Depending on the implementation typically allows up to 64k events to be stored.
  static const RECORD_CONTINUOUSLY = AqutterTracingMode._internal(1, 1);

  ///Record trace events until the internal tracing buffer is full.
  ///Typically the buffer memory usage is larger than [RECORD_CONTINUOUSLY].
  ///Depending on the implementation typically allows up to 256k events to be stored.
  static const RECORD_UNTIL_FULL = AqutterTracingMode._internal(0, 0);

  ///Set of all values of [AqutterTracingMode].
  static final Set<AqutterTracingMode> values = [
    AqutterTracingMode.RECORD_CONTINUOUSLY,
    AqutterTracingMode.RECORD_UNTIL_FULL,
  ].toSet();

  ///Gets a possible [AqutterTracingMode] instance from [int] value.
  static AqutterTracingMode? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterTracingMode.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterTracingMode] instance from a native value.
  static AqutterTracingMode? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterTracingMode.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterTracingMode] instance value with name [name].
  ///
  /// Goes through [AqutterTracingMode.values] looking for a value with
  /// name [name], as reported by [AqutterTracingMode.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterTracingMode? byName(String? name) {
    if (name != null) {
      try {
        return AqutterTracingMode.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterTracingMode] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterTracingMode> asNameMap() =>
      <String, AqutterTracingMode>{
        for (final value in AqutterTracingMode.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 1:
        return 'RECORD_CONTINUOUSLY';
      case 0:
        return 'RECORD_UNTIL_FULL';
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
