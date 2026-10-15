// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_response_action.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that is used by [AqutterPlatformWebViewCreationParams.onNavigationResponse] event.
///It represents the policy to pass back to the decision handler.
class AqutterNavigationResponseAction {
  final int _value;
  final int? _nativeValue;
  const AqutterNavigationResponseAction._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterNavigationResponseAction._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterNavigationResponseAction._internal(value, nativeValue());

  ///Allow the navigation to continue.
  static const ALLOW = AqutterNavigationResponseAction._internal(1, 1);

  ///Cancel the navigation.
  static const CANCEL = AqutterNavigationResponseAction._internal(0, 0);

  ///Turn the navigation into a download.
  ///
  ///**NOTE**: available only on iOS 14.5+. It will fallback to [CANCEL].
  static const DOWNLOAD = AqutterNavigationResponseAction._internal(2, 2);

  ///Set of all values of [AqutterNavigationResponseAction].
  static final Set<AqutterNavigationResponseAction> values = [
    AqutterNavigationResponseAction.ALLOW,
    AqutterNavigationResponseAction.CANCEL,
    AqutterNavigationResponseAction.DOWNLOAD,
  ].toSet();

  ///Gets a possible [AqutterNavigationResponseAction] instance from [int] value.
  static AqutterNavigationResponseAction? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterNavigationResponseAction.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterNavigationResponseAction] instance from a native value.
  static AqutterNavigationResponseAction? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterNavigationResponseAction.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterNavigationResponseAction] instance value with name [name].
  ///
  /// Goes through [AqutterNavigationResponseAction.values] looking for a value with
  /// name [name], as reported by [AqutterNavigationResponseAction.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterNavigationResponseAction? byName(String? name) {
    if (name != null) {
      try {
        return AqutterNavigationResponseAction.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterNavigationResponseAction] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterNavigationResponseAction> asNameMap() =>
      <String, AqutterNavigationResponseAction>{
        for (final value in AqutterNavigationResponseAction.values)
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
      case 2:
        return 'DOWNLOAD';
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

///Class that is used by [AqutterPlatformWebViewCreationParams.onNavigationResponse] event.
///It represents the policy to pass back to the decision handler.
///Use [AqutterNavigationResponseAction] instead.
@Deprecated('Use AqutterNavigationResponseAction instead')
class AqutterIOSNavigationResponseAction {
  final int _value;
  final int? _nativeValue;
  const AqutterIOSNavigationResponseAction._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSNavigationResponseAction._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterIOSNavigationResponseAction._internal(value, nativeValue());

  ///Allow the navigation to continue.
  static const ALLOW = AqutterIOSNavigationResponseAction._internal(1, 1);

  ///Cancel the navigation.
  static const CANCEL = AqutterIOSNavigationResponseAction._internal(0, 0);

  ///Set of all values of [AqutterIOSNavigationResponseAction].
  static final Set<AqutterIOSNavigationResponseAction> values = [
    AqutterIOSNavigationResponseAction.ALLOW,
    AqutterIOSNavigationResponseAction.CANCEL,
  ].toSet();

  ///Gets a possible [AqutterIOSNavigationResponseAction] instance from [int] value.
  static AqutterIOSNavigationResponseAction? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSNavigationResponseAction.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSNavigationResponseAction] instance from a native value.
  static AqutterIOSNavigationResponseAction? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSNavigationResponseAction.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSNavigationResponseAction] instance value with name [name].
  ///
  /// Goes through [AqutterIOSNavigationResponseAction.values] looking for a value with
  /// name [name], as reported by [AqutterIOSNavigationResponseAction.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSNavigationResponseAction? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSNavigationResponseAction.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSNavigationResponseAction] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSNavigationResponseAction> asNameMap() =>
      <String, AqutterIOSNavigationResponseAction>{
        for (final value in AqutterIOSNavigationResponseAction.values)
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
