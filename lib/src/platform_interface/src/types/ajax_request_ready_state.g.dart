// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ajax_request_ready_state.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used by [AqutterAjaxRequest] class. It represents the state of an [AqutterAjaxRequest].
class AqutterAjaxRequestReadyState {
  final int _value;
  final int? _nativeValue;
  const AqutterAjaxRequestReadyState._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterAjaxRequestReadyState._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterAjaxRequestReadyState._internal(value, nativeValue());

  ///The operation is complete.
  static const DONE = AqutterAjaxRequestReadyState._internal(4, 4);

  ///`XMLHttpRequest.send()` has been called, and [AqutterAjaxRequest.headers] and [AqutterAjaxRequest.status] are available.
  static const HEADERS_RECEIVED = AqutterAjaxRequestReadyState._internal(2, 2);

  ///Downloading; [AqutterAjaxRequest.responseText] holds partial data.
  static const LOADING = AqutterAjaxRequestReadyState._internal(3, 3);

  ///`XMLHttpRequest.open()` has been called.
  static const OPENED = AqutterAjaxRequestReadyState._internal(1, 1);

  ///Client has been created. `XMLHttpRequest.open()` not called yet.
  static const UNSENT = AqutterAjaxRequestReadyState._internal(0, 0);

  ///Set of all values of [AqutterAjaxRequestReadyState].
  static final Set<AqutterAjaxRequestReadyState> values = [
    AqutterAjaxRequestReadyState.DONE,
    AqutterAjaxRequestReadyState.HEADERS_RECEIVED,
    AqutterAjaxRequestReadyState.LOADING,
    AqutterAjaxRequestReadyState.OPENED,
    AqutterAjaxRequestReadyState.UNSENT,
  ].toSet();

  ///Gets a possible [AqutterAjaxRequestReadyState] instance from [int] value.
  static AqutterAjaxRequestReadyState? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterAjaxRequestReadyState.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAjaxRequestReadyState] instance from a native value.
  static AqutterAjaxRequestReadyState? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterAjaxRequestReadyState.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAjaxRequestReadyState] instance value with name [name].
  ///
  /// Goes through [AqutterAjaxRequestReadyState.values] looking for a value with
  /// name [name], as reported by [AqutterAjaxRequestReadyState.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAjaxRequestReadyState? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAjaxRequestReadyState.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAjaxRequestReadyState] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAjaxRequestReadyState> asNameMap() =>
      <String, AqutterAjaxRequestReadyState>{
        for (final value in AqutterAjaxRequestReadyState.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 4:
        return 'DONE';
      case 2:
        return 'HEADERS_RECEIVED';
      case 3:
        return 'LOADING';
      case 1:
        return 'OPENED';
      case 0:
        return 'UNSENT';
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
