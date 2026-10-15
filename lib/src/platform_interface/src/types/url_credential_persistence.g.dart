// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_credential_persistence.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the constants that specify how long the credential will be kept.
class AqutterURLCredentialPersistence {
  final int _value;
  final int? _nativeValue;
  const AqutterURLCredentialPersistence._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterURLCredentialPersistence._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterURLCredentialPersistence._internal(value, nativeValue());

  ///The credential should be stored only for this session
  static const FOR_SESSION = AqutterURLCredentialPersistence._internal(1, 1);

  ///The credential should not be stored.
  static const NONE = AqutterURLCredentialPersistence._internal(0, 0);

  ///The credential should be stored in the keychain.
  static const PERMANENT = AqutterURLCredentialPersistence._internal(2, 2);

  ///The credential should be stored permanently in the keychain,
  ///and in addition should be distributed to other devices based on the owning Apple ID.
  static const SYNCHRONIZABLE = AqutterURLCredentialPersistence._internal(3, 3);

  ///Set of all values of [AqutterURLCredentialPersistence].
  static final Set<AqutterURLCredentialPersistence> values = [
    AqutterURLCredentialPersistence.FOR_SESSION,
    AqutterURLCredentialPersistence.NONE,
    AqutterURLCredentialPersistence.PERMANENT,
    AqutterURLCredentialPersistence.SYNCHRONIZABLE,
  ].toSet();

  ///Gets a possible [AqutterURLCredentialPersistence] instance from [int] value.
  static AqutterURLCredentialPersistence? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterURLCredentialPersistence.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterURLCredentialPersistence] instance from a native value.
  static AqutterURLCredentialPersistence? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterURLCredentialPersistence.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterURLCredentialPersistence] instance value with name [name].
  ///
  /// Goes through [AqutterURLCredentialPersistence.values] looking for a value with
  /// name [name], as reported by [AqutterURLCredentialPersistence.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterURLCredentialPersistence? byName(String? name) {
    if (name != null) {
      try {
        return AqutterURLCredentialPersistence.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterURLCredentialPersistence] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterURLCredentialPersistence> asNameMap() =>
      <String, AqutterURLCredentialPersistence>{
        for (final value in AqutterURLCredentialPersistence.values)
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
        return 'FOR_SESSION';
      case 0:
        return 'NONE';
      case 2:
        return 'PERMANENT';
      case 3:
        return 'SYNCHRONIZABLE';
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

///An iOS-specific class that represents the constants that specify how long the credential will be kept.
///Use [AqutterURLCredentialPersistence] instead.
@Deprecated('Use AqutterURLCredentialPersistence instead')
class AqutterIOSURLCredentialPersistence {
  final int _value;
  final int? _nativeValue;
  const AqutterIOSURLCredentialPersistence._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSURLCredentialPersistence._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterIOSURLCredentialPersistence._internal(value, nativeValue());

  ///The credential should be stored only for this session
  static const FOR_SESSION = AqutterIOSURLCredentialPersistence._internal(1, 1);

  ///The credential should not be stored.
  static const NONE = AqutterIOSURLCredentialPersistence._internal(0, 0);

  ///The credential should be stored in the keychain.
  static const PERMANENT = AqutterIOSURLCredentialPersistence._internal(2, 2);

  ///The credential should be stored permanently in the keychain,
  ///and in addition should be distributed to other devices based on the owning Apple ID.
  static const SYNCHRONIZABLE = AqutterIOSURLCredentialPersistence._internal(
    3,
    3,
  );

  ///Set of all values of [AqutterIOSURLCredentialPersistence].
  static final Set<AqutterIOSURLCredentialPersistence> values = [
    AqutterIOSURLCredentialPersistence.FOR_SESSION,
    AqutterIOSURLCredentialPersistence.NONE,
    AqutterIOSURLCredentialPersistence.PERMANENT,
    AqutterIOSURLCredentialPersistence.SYNCHRONIZABLE,
  ].toSet();

  ///Gets a possible [AqutterIOSURLCredentialPersistence] instance from [int] value.
  static AqutterIOSURLCredentialPersistence? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSURLCredentialPersistence.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSURLCredentialPersistence] instance from a native value.
  static AqutterIOSURLCredentialPersistence? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSURLCredentialPersistence.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSURLCredentialPersistence] instance value with name [name].
  ///
  /// Goes through [AqutterIOSURLCredentialPersistence.values] looking for a value with
  /// name [name], as reported by [AqutterIOSURLCredentialPersistence.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSURLCredentialPersistence? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSURLCredentialPersistence.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSURLCredentialPersistence] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSURLCredentialPersistence> asNameMap() =>
      <String, AqutterIOSURLCredentialPersistence>{
        for (final value in AqutterIOSURLCredentialPersistence.values)
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
        return 'FOR_SESSION';
      case 0:
        return 'NONE';
      case 2:
        return 'PERMANENT';
      case 3:
        return 'SYNCHRONIZABLE';
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
