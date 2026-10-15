// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'should_allow_deprecated_tls_action.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that is used by [AqutterPlatformWebViewCreationParams.shouldAllowDeprecatedTLS] event.
///It represents the policy to pass back to the decision handler.
class AqutterShouldAllowDeprecatedTLSAction {
  final int _value;
  final int? _nativeValue;
  const AqutterShouldAllowDeprecatedTLSAction._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterShouldAllowDeprecatedTLSAction._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterShouldAllowDeprecatedTLSAction._internal(value, nativeValue());

  ///Allow the navigation to continue.
  static const ALLOW = AqutterShouldAllowDeprecatedTLSAction._internal(1, 1);

  ///Cancel the navigation.
  static const CANCEL = AqutterShouldAllowDeprecatedTLSAction._internal(0, 0);

  ///Set of all values of [AqutterShouldAllowDeprecatedTLSAction].
  static final Set<AqutterShouldAllowDeprecatedTLSAction> values = [
    AqutterShouldAllowDeprecatedTLSAction.ALLOW,
    AqutterShouldAllowDeprecatedTLSAction.CANCEL,
  ].toSet();

  ///Gets a possible [AqutterShouldAllowDeprecatedTLSAction] instance from [int] value.
  static AqutterShouldAllowDeprecatedTLSAction? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterShouldAllowDeprecatedTLSAction.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterShouldAllowDeprecatedTLSAction] instance from a native value.
  static AqutterShouldAllowDeprecatedTLSAction? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterShouldAllowDeprecatedTLSAction.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterShouldAllowDeprecatedTLSAction] instance value with name [name].
  ///
  /// Goes through [AqutterShouldAllowDeprecatedTLSAction.values] looking for a value with
  /// name [name], as reported by [AqutterShouldAllowDeprecatedTLSAction.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterShouldAllowDeprecatedTLSAction? byName(String? name) {
    if (name != null) {
      try {
        return AqutterShouldAllowDeprecatedTLSAction.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterShouldAllowDeprecatedTLSAction] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterShouldAllowDeprecatedTLSAction> asNameMap() =>
      <String, AqutterShouldAllowDeprecatedTLSAction>{
        for (final value in AqutterShouldAllowDeprecatedTLSAction.values)
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
        return 'ALLOW';
      case 0:
        return 'CANCEL';
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

///Class that is used by [AqutterPlatformWebViewCreationParams.shouldAllowDeprecatedTLS] event.
///It represents the policy to pass back to the decision handler.
///Use [AqutterShouldAllowDeprecatedTLSAction] instead.
@Deprecated('Use AqutterShouldAllowDeprecatedTLSAction instead')
class AqutterIOSShouldAllowDeprecatedTLSAction {
  final int _value;
  final int? _nativeValue;
  const AqutterIOSShouldAllowDeprecatedTLSAction._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSShouldAllowDeprecatedTLSAction._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterIOSShouldAllowDeprecatedTLSAction._internal(value, nativeValue());

  ///Allow the navigation to continue.
  static const ALLOW = AqutterIOSShouldAllowDeprecatedTLSAction._internal(1, 1);

  ///Cancel the navigation.
  static const CANCEL = AqutterIOSShouldAllowDeprecatedTLSAction._internal(
    0,
    0,
  );

  ///Set of all values of [AqutterIOSShouldAllowDeprecatedTLSAction].
  static final Set<AqutterIOSShouldAllowDeprecatedTLSAction> values = [
    AqutterIOSShouldAllowDeprecatedTLSAction.ALLOW,
    AqutterIOSShouldAllowDeprecatedTLSAction.CANCEL,
  ].toSet();

  ///Gets a possible [AqutterIOSShouldAllowDeprecatedTLSAction] instance from [int] value.
  static AqutterIOSShouldAllowDeprecatedTLSAction? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSShouldAllowDeprecatedTLSAction.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSShouldAllowDeprecatedTLSAction] instance from a native value.
  static AqutterIOSShouldAllowDeprecatedTLSAction? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSShouldAllowDeprecatedTLSAction.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSShouldAllowDeprecatedTLSAction] instance value with name [name].
  ///
  /// Goes through [AqutterIOSShouldAllowDeprecatedTLSAction.values] looking for a value with
  /// name [name], as reported by [AqutterIOSShouldAllowDeprecatedTLSAction.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSShouldAllowDeprecatedTLSAction? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSShouldAllowDeprecatedTLSAction.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSShouldAllowDeprecatedTLSAction] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSShouldAllowDeprecatedTLSAction> asNameMap() =>
      <String, AqutterIOSShouldAllowDeprecatedTLSAction>{
        for (final value in AqutterIOSShouldAllowDeprecatedTLSAction.values)
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
        return 'ALLOW';
      case 0:
        return 'CANCEL';
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
