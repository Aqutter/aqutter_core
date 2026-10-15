// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_action_policy.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that is used by [AqutterPlatformWebViewCreationParams.shouldOverrideUrlLoading] event.
///It represents the policy to pass back to the decision handler.
class AqutterNavigationActionPolicy {
  final int _value;
  final int? _nativeValue;
  const AqutterNavigationActionPolicy._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterNavigationActionPolicy._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterNavigationActionPolicy._internal(value, nativeValue());

  ///Allow the navigation to continue.
  static const ALLOW = AqutterNavigationActionPolicy._internal(1, 1);

  ///Cancel the navigation.
  static const CANCEL = AqutterNavigationActionPolicy._internal(0, 0);

  ///Turn the navigation into a download.
  ///
  ///**NOTE**: available only on iOS 14.5+. It will fallback to [CANCEL].
  static const DOWNLOAD = AqutterNavigationActionPolicy._internal(2, 2);

  ///Set of all values of [AqutterNavigationActionPolicy].
  static final Set<AqutterNavigationActionPolicy> values = [
    AqutterNavigationActionPolicy.ALLOW,
    AqutterNavigationActionPolicy.CANCEL,
    AqutterNavigationActionPolicy.DOWNLOAD,
  ].toSet();

  ///Gets a possible [AqutterNavigationActionPolicy] instance from [int] value.
  static AqutterNavigationActionPolicy? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterNavigationActionPolicy.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterNavigationActionPolicy] instance from a native value.
  static AqutterNavigationActionPolicy? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterNavigationActionPolicy.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterNavigationActionPolicy] instance value with name [name].
  ///
  /// Goes through [AqutterNavigationActionPolicy.values] looking for a value with
  /// name [name], as reported by [AqutterNavigationActionPolicy.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterNavigationActionPolicy? byName(String? name) {
    if (name != null) {
      try {
        return AqutterNavigationActionPolicy.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterNavigationActionPolicy] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterNavigationActionPolicy> asNameMap() =>
      <String, AqutterNavigationActionPolicy>{
        for (final value in AqutterNavigationActionPolicy.values)
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
