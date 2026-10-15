// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_cert_response_action.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used by [AqutterClientCertResponse] class.
class AqutterClientCertResponseAction {
  final int _value;
  final int? _nativeValue;
  const AqutterClientCertResponseAction._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterClientCertResponseAction._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterClientCertResponseAction._internal(value, nativeValue());

  ///Cancel this request.
  static const CANCEL = AqutterClientCertResponseAction._internal(0, 0);

  ///Ignore the request for now.
  static const IGNORE = AqutterClientCertResponseAction._internal(2, 2);

  ///Proceed with the specified certificate.
  static const PROCEED = AqutterClientCertResponseAction._internal(1, 1);

  ///Set of all values of [AqutterClientCertResponseAction].
  static final Set<AqutterClientCertResponseAction> values = [
    AqutterClientCertResponseAction.CANCEL,
    AqutterClientCertResponseAction.IGNORE,
    AqutterClientCertResponseAction.PROCEED,
  ].toSet();

  ///Gets a possible [AqutterClientCertResponseAction] instance from [int] value.
  static AqutterClientCertResponseAction? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterClientCertResponseAction.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterClientCertResponseAction] instance from a native value.
  static AqutterClientCertResponseAction? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterClientCertResponseAction.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterClientCertResponseAction] instance value with name [name].
  ///
  /// Goes through [AqutterClientCertResponseAction.values] looking for a value with
  /// name [name], as reported by [AqutterClientCertResponseAction.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterClientCertResponseAction? byName(String? name) {
    if (name != null) {
      try {
        return AqutterClientCertResponseAction.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterClientCertResponseAction] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterClientCertResponseAction> asNameMap() =>
      <String, AqutterClientCertResponseAction>{
        for (final value in AqutterClientCertResponseAction.values)
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
        return 'CANCEL';
      case 2:
        return 'IGNORE';
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
