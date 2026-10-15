// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_trust_auth_response_action.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used by [AqutterServerTrustAuthResponse] class.
class AqutterServerTrustAuthResponseAction {
  final int _value;
  final int? _nativeValue;
  const AqutterServerTrustAuthResponseAction._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterServerTrustAuthResponseAction._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterServerTrustAuthResponseAction._internal(value, nativeValue());

  ///Instructs the WebView to cancel the authentication challenge.
  static const CANCEL = AqutterServerTrustAuthResponseAction._internal(0, 0);

  ///Instructs the WebView to proceed with the authentication challenge.
  static const PROCEED = AqutterServerTrustAuthResponseAction._internal(1, 1);

  ///Set of all values of [AqutterServerTrustAuthResponseAction].
  static final Set<AqutterServerTrustAuthResponseAction> values = [
    AqutterServerTrustAuthResponseAction.CANCEL,
    AqutterServerTrustAuthResponseAction.PROCEED,
  ].toSet();

  ///Gets a possible [AqutterServerTrustAuthResponseAction] instance from [int] value.
  static AqutterServerTrustAuthResponseAction? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterServerTrustAuthResponseAction.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterServerTrustAuthResponseAction] instance from a native value.
  static AqutterServerTrustAuthResponseAction? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterServerTrustAuthResponseAction.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterServerTrustAuthResponseAction] instance value with name [name].
  ///
  /// Goes through [AqutterServerTrustAuthResponseAction.values] looking for a value with
  /// name [name], as reported by [AqutterServerTrustAuthResponseAction.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterServerTrustAuthResponseAction? byName(String? name) {
    if (name != null) {
      try {
        return AqutterServerTrustAuthResponseAction.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterServerTrustAuthResponseAction] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterServerTrustAuthResponseAction> asNameMap() =>
      <String, AqutterServerTrustAuthResponseAction>{
        for (final value in AqutterServerTrustAuthResponseAction.values)
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
