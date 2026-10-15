// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_blocker_trigger_load_context.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the kind of load context that can be used with a [AqutterContentBlockerTrigger].
class AqutterContentBlockerTriggerLoadContext {
  final String _value;
  final String? _nativeValue;
  const AqutterContentBlockerTriggerLoadContext._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterContentBlockerTriggerLoadContext._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterContentBlockerTriggerLoadContext._internal(value, nativeValue());

  ///Child frame load context
  static const CHILD_FRAME = AqutterContentBlockerTriggerLoadContext._internal(
    'child-frame',
    'child-frame',
  );

  ///Top frame load context
  static const TOP_FRAME = AqutterContentBlockerTriggerLoadContext._internal(
    'top-frame',
    'top-frame',
  );

  ///Set of all values of [AqutterContentBlockerTriggerLoadContext].
  static final Set<AqutterContentBlockerTriggerLoadContext> values = [
    AqutterContentBlockerTriggerLoadContext.CHILD_FRAME,
    AqutterContentBlockerTriggerLoadContext.TOP_FRAME,
  ].toSet();

  ///Gets a possible [AqutterContentBlockerTriggerLoadContext] instance from [String] value.
  static AqutterContentBlockerTriggerLoadContext? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterContentBlockerTriggerLoadContext.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterContentBlockerTriggerLoadContext] instance from a native value.
  static AqutterContentBlockerTriggerLoadContext? fromNativeValue(
    String? value,
  ) {
    if (value != null) {
      try {
        return AqutterContentBlockerTriggerLoadContext.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterContentBlockerTriggerLoadContext] instance value with name [name].
  ///
  /// Goes through [AqutterContentBlockerTriggerLoadContext.values] looking for a value with
  /// name [name], as reported by [AqutterContentBlockerTriggerLoadContext.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterContentBlockerTriggerLoadContext? byName(String? name) {
    if (name != null) {
      try {
        return AqutterContentBlockerTriggerLoadContext.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterContentBlockerTriggerLoadContext] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterContentBlockerTriggerLoadContext> asNameMap() =>
      <String, AqutterContentBlockerTriggerLoadContext>{
        for (final value in AqutterContentBlockerTriggerLoadContext.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'child-frame':
        return 'CHILD_FRAME';
      case 'top-frame':
        return 'TOP_FRAME';
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
