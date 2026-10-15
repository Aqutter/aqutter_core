// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ajax_request_action.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used by [AqutterAjaxRequest] class.
class AqutterAjaxRequestAction {
  final int _value;
  final int? _nativeValue;
  const AqutterAjaxRequestAction._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterAjaxRequestAction._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterAjaxRequestAction._internal(value, nativeValue());

  ///Aborts the current [AqutterAjaxRequest].
  static const ABORT = AqutterAjaxRequestAction._internal(0, 0);

  ///Proceeds with the current [AqutterAjaxRequest].
  static const PROCEED = AqutterAjaxRequestAction._internal(1, 1);

  ///Set of all values of [AqutterAjaxRequestAction].
  static final Set<AqutterAjaxRequestAction> values = [
    AqutterAjaxRequestAction.ABORT,
    AqutterAjaxRequestAction.PROCEED,
  ].toSet();

  ///Gets a possible [AqutterAjaxRequestAction] instance from [int] value.
  static AqutterAjaxRequestAction? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterAjaxRequestAction.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAjaxRequestAction] instance from a native value.
  static AqutterAjaxRequestAction? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterAjaxRequestAction.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAjaxRequestAction] instance value with name [name].
  ///
  /// Goes through [AqutterAjaxRequestAction.values] looking for a value with
  /// name [name], as reported by [AqutterAjaxRequestAction.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAjaxRequestAction? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAjaxRequestAction.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAjaxRequestAction] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAjaxRequestAction> asNameMap() =>
      <String, AqutterAjaxRequestAction>{
        for (final value in AqutterAjaxRequestAction.values)
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
        return 'ABORT';
      case 1:
        return 'PROCEED';
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
