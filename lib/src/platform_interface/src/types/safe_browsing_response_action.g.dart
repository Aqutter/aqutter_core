// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safe_browsing_response_action.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used by [AqutterSafeBrowsingResponse] class.
class AqutterSafeBrowsingResponseAction {
  final int _value;
  final int? _nativeValue;
  const AqutterSafeBrowsingResponseAction._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterSafeBrowsingResponseAction._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterSafeBrowsingResponseAction._internal(value, nativeValue());

  ///Act as if the user clicked the "back to safety" button.
  static const BACK_TO_SAFETY = AqutterSafeBrowsingResponseAction._internal(
    0,
    0,
  );

  ///Act as if the user clicked the "visit this unsafe site" button.
  static const PROCEED = AqutterSafeBrowsingResponseAction._internal(1, 1);

  ///Display the default interstitial.
  static const SHOW_INTERSTITIAL = AqutterSafeBrowsingResponseAction._internal(
    2,
    2,
  );

  ///Set of all values of [AqutterSafeBrowsingResponseAction].
  static final Set<AqutterSafeBrowsingResponseAction> values = [
    AqutterSafeBrowsingResponseAction.BACK_TO_SAFETY,
    AqutterSafeBrowsingResponseAction.PROCEED,
    AqutterSafeBrowsingResponseAction.SHOW_INTERSTITIAL,
  ].toSet();

  ///Gets a possible [AqutterSafeBrowsingResponseAction] instance from [int] value.
  static AqutterSafeBrowsingResponseAction? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterSafeBrowsingResponseAction.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterSafeBrowsingResponseAction] instance from a native value.
  static AqutterSafeBrowsingResponseAction? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterSafeBrowsingResponseAction.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterSafeBrowsingResponseAction] instance value with name [name].
  ///
  /// Goes through [AqutterSafeBrowsingResponseAction.values] looking for a value with
  /// name [name], as reported by [AqutterSafeBrowsingResponseAction.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterSafeBrowsingResponseAction? byName(String? name) {
    if (name != null) {
      try {
        return AqutterSafeBrowsingResponseAction.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterSafeBrowsingResponseAction] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterSafeBrowsingResponseAction> asNameMap() =>
      <String, AqutterSafeBrowsingResponseAction>{
        for (final value in AqutterSafeBrowsingResponseAction.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 0:
        return 'BACK_TO_SAFETY';
      case 1:
        return 'PROCEED';
      case 2:
        return 'SHOW_INTERSTITIAL';
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
