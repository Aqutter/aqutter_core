// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_response_action.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used by [AqutterPermissionResponse] class.
class AqutterPermissionResponseAction {
  final int _value;
  final int? _nativeValue;
  const AqutterPermissionResponseAction._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterPermissionResponseAction._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterPermissionResponseAction._internal(value, nativeValue());

  ///Denies the request.
  static const DENY = AqutterPermissionResponseAction._internal(0, 0);

  ///Grants origin the permission to access the given resources.
  static const GRANT = AqutterPermissionResponseAction._internal(1, 1);

  ///Prompt the user for permission for the requested resource.
  static const PROMPT = AqutterPermissionResponseAction._internal(2, 2);

  ///Set of all values of [AqutterPermissionResponseAction].
  static final Set<AqutterPermissionResponseAction> values = [
    AqutterPermissionResponseAction.DENY,
    AqutterPermissionResponseAction.GRANT,
    AqutterPermissionResponseAction.PROMPT,
  ].toSet();

  ///Gets a possible [AqutterPermissionResponseAction] instance from [int] value.
  static AqutterPermissionResponseAction? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterPermissionResponseAction.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterPermissionResponseAction] instance from a native value.
  static AqutterPermissionResponseAction? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterPermissionResponseAction.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterPermissionResponseAction] instance value with name [name].
  ///
  /// Goes through [AqutterPermissionResponseAction.values] looking for a value with
  /// name [name], as reported by [AqutterPermissionResponseAction.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterPermissionResponseAction? byName(String? name) {
    if (name != null) {
      try {
        return AqutterPermissionResponseAction.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterPermissionResponseAction] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterPermissionResponseAction> asNameMap() =>
      <String, AqutterPermissionResponseAction>{
        for (final value in AqutterPermissionResponseAction.values)
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
        return 'DENY';
      case 1:
        return 'GRANT';
      case 2:
        return 'PROMPT';
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

///Class used by [AqutterPermissionRequestResponse] class.
///Use [AqutterPermissionResponseAction] instead.
@Deprecated('Use AqutterPermissionResponseAction instead')
class AqutterPermissionRequestResponseAction {
  final int _value;
  final int? _nativeValue;
  const AqutterPermissionRequestResponseAction._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterPermissionRequestResponseAction._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterPermissionRequestResponseAction._internal(value, nativeValue());

  ///Denies the request.
  static const DENY = AqutterPermissionRequestResponseAction._internal(0, 0);

  ///Grants origin the permission to access the given resources.
  static const GRANT = AqutterPermissionRequestResponseAction._internal(1, 1);

  ///Set of all values of [AqutterPermissionRequestResponseAction].
  static final Set<AqutterPermissionRequestResponseAction> values = [
    AqutterPermissionRequestResponseAction.DENY,
    AqutterPermissionRequestResponseAction.GRANT,
  ].toSet();

  ///Gets a possible [AqutterPermissionRequestResponseAction] instance from [int] value.
  static AqutterPermissionRequestResponseAction? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterPermissionRequestResponseAction.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterPermissionRequestResponseAction] instance from a native value.
  static AqutterPermissionRequestResponseAction? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterPermissionRequestResponseAction.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterPermissionRequestResponseAction] instance value with name [name].
  ///
  /// Goes through [AqutterPermissionRequestResponseAction.values] looking for a value with
  /// name [name], as reported by [AqutterPermissionRequestResponseAction.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterPermissionRequestResponseAction? byName(String? name) {
    if (name != null) {
      try {
        return AqutterPermissionRequestResponseAction.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterPermissionRequestResponseAction] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterPermissionRequestResponseAction> asNameMap() =>
      <String, AqutterPermissionRequestResponseAction>{
        for (final value in AqutterPermissionRequestResponseAction.values)
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
        return 'DENY';
      case 1:
        return 'GRANT';
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
