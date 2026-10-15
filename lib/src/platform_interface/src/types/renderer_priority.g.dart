// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'renderer_priority.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used by [AqutterRendererPriorityPolicy] class.
class AqutterRendererPriority {
  final int _value;
  final int? _nativeValue;
  const AqutterRendererPriority._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterRendererPriority._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterRendererPriority._internal(value, nativeValue());

  ///The renderer associated with this WebView is bound with the default priority for services.
  static const RENDERER_PRIORITY_BOUND = AqutterRendererPriority._internal(
    1,
    1,
  );

  ///The renderer associated with this WebView is bound with Android `Context#BIND_IMPORTANT`.
  static const RENDERER_PRIORITY_IMPORTANT = AqutterRendererPriority._internal(
    2,
    2,
  );

  ///The renderer associated with this WebView is bound with Android `Context#BIND_WAIVE_PRIORITY`.
  ///At this priority level WebView renderers will be strong targets for out of memory killing.
  static const RENDERER_PRIORITY_WAIVED = AqutterRendererPriority._internal(
    0,
    0,
  );

  ///Set of all values of [AqutterRendererPriority].
  static final Set<AqutterRendererPriority> values = [
    AqutterRendererPriority.RENDERER_PRIORITY_BOUND,
    AqutterRendererPriority.RENDERER_PRIORITY_IMPORTANT,
    AqutterRendererPriority.RENDERER_PRIORITY_WAIVED,
  ].toSet();

  ///Gets a possible [AqutterRendererPriority] instance from [int] value.
  static AqutterRendererPriority? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterRendererPriority.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterRendererPriority] instance from a native value.
  static AqutterRendererPriority? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterRendererPriority.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterRendererPriority] instance value with name [name].
  ///
  /// Goes through [AqutterRendererPriority.values] looking for a value with
  /// name [name], as reported by [AqutterRendererPriority.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterRendererPriority? byName(String? name) {
    if (name != null) {
      try {
        return AqutterRendererPriority.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterRendererPriority] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterRendererPriority> asNameMap() =>
      <String, AqutterRendererPriority>{
        for (final value in AqutterRendererPriority.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 1:
        return 'RENDERER_PRIORITY_BOUND';
      case 2:
        return 'RENDERER_PRIORITY_IMPORTANT';
      case 0:
        return 'RENDERER_PRIORITY_WAIVED';
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
