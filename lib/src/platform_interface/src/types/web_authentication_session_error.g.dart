// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_authentication_session_error.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the error code for a web authentication session error.
class AqutterWebAuthenticationSessionError {
  final int _value;
  final int? _nativeValue;
  const AqutterWebAuthenticationSessionError._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterWebAuthenticationSessionError._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterWebAuthenticationSessionError._internal(value, nativeValue());

  ///The login has been canceled.
  static const CANCELED_LOGIN = AqutterWebAuthenticationSessionError._internal(
    1,
    1,
  );

  ///The context was invalid.
  static const PRESENTATION_CONTEXT_INVALID =
      AqutterWebAuthenticationSessionError._internal(3, 3);

  ///A context wasn’t provided.
  static const PRESENTATION_CONTEXT_NOT_PROVIDED =
      AqutterWebAuthenticationSessionError._internal(2, 2);

  ///Set of all values of [AqutterWebAuthenticationSessionError].
  static final Set<AqutterWebAuthenticationSessionError> values = [
    AqutterWebAuthenticationSessionError.CANCELED_LOGIN,
    AqutterWebAuthenticationSessionError.PRESENTATION_CONTEXT_INVALID,
    AqutterWebAuthenticationSessionError.PRESENTATION_CONTEXT_NOT_PROVIDED,
  ].toSet();

  ///Gets a possible [AqutterWebAuthenticationSessionError] instance from [int] value.
  static AqutterWebAuthenticationSessionError? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterWebAuthenticationSessionError.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterWebAuthenticationSessionError] instance from a native value.
  static AqutterWebAuthenticationSessionError? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterWebAuthenticationSessionError.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterWebAuthenticationSessionError] instance value with name [name].
  ///
  /// Goes through [AqutterWebAuthenticationSessionError.values] looking for a value with
  /// name [name], as reported by [AqutterWebAuthenticationSessionError.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterWebAuthenticationSessionError? byName(String? name) {
    if (name != null) {
      try {
        return AqutterWebAuthenticationSessionError.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterWebAuthenticationSessionError] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterWebAuthenticationSessionError> asNameMap() =>
      <String, AqutterWebAuthenticationSessionError>{
        for (final value in AqutterWebAuthenticationSessionError.values)
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
        return 'CANCELED_LOGIN';
      case 3:
        return 'PRESENTATION_CONTEXT_INVALID';
      case 2:
        return 'PRESENTATION_CONTEXT_NOT_PROVIDED';
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
