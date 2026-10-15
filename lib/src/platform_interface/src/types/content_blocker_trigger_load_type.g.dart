// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_blocker_trigger_load_type.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the possible load type for a [AqutterContentBlockerTrigger].
class AqutterContentBlockerTriggerLoadType {
  final String _value;
  final String? _nativeValue;
  const AqutterContentBlockerTriggerLoadType._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterContentBlockerTriggerLoadType._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterContentBlockerTriggerLoadType._internal(value, nativeValue());

  ///FIRST_PARTY is triggered only if the resource has the same scheme, domain, and port as the main page resource.
  static const FIRST_PARTY = AqutterContentBlockerTriggerLoadType._internal(
    'first-party',
    'first-party',
  );

  ///THIRD_PARTY is triggered if the resource is not from the same domain as the main page resource.
  static const THIRD_PARTY = AqutterContentBlockerTriggerLoadType._internal(
    'third-party',
    'third-party',
  );

  ///Set of all values of [AqutterContentBlockerTriggerLoadType].
  static final Set<AqutterContentBlockerTriggerLoadType> values = [
    AqutterContentBlockerTriggerLoadType.FIRST_PARTY,
    AqutterContentBlockerTriggerLoadType.THIRD_PARTY,
  ].toSet();

  ///Gets a possible [AqutterContentBlockerTriggerLoadType] instance from [String] value.
  static AqutterContentBlockerTriggerLoadType? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterContentBlockerTriggerLoadType.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterContentBlockerTriggerLoadType] instance from a native value.
  static AqutterContentBlockerTriggerLoadType? fromNativeValue(String? value) {
    if (value != null) {
      try {
        return AqutterContentBlockerTriggerLoadType.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterContentBlockerTriggerLoadType] instance value with name [name].
  ///
  /// Goes through [AqutterContentBlockerTriggerLoadType.values] looking for a value with
  /// name [name], as reported by [AqutterContentBlockerTriggerLoadType.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterContentBlockerTriggerLoadType? byName(String? name) {
    if (name != null) {
      try {
        return AqutterContentBlockerTriggerLoadType.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterContentBlockerTriggerLoadType] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterContentBlockerTriggerLoadType> asNameMap() =>
      <String, AqutterContentBlockerTriggerLoadType>{
        for (final value in AqutterContentBlockerTriggerLoadType.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'first-party':
        return 'FIRST_PARTY';
      case 'third-party':
        return 'THIRD_PARTY';
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
