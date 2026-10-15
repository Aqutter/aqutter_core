// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safe_browsing_threat.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the reason the resource was caught by Safe Browsing.
class AqutterSafeBrowsingThreat {
  final int _value;
  final int? _nativeValue;
  const AqutterSafeBrowsingThreat._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterSafeBrowsingThreat._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterSafeBrowsingThreat._internal(value, nativeValue());

  ///The resource was blocked because it may trick the user into a billing agreement.
  ///
  ///This constant is only used when `targetSdkVersion` is at least Android 29.
  ///Otherwise, [SAFE_BROWSING_THREAT_UNKNOWN] is used instead.
  static const SAFE_BROWSING_THREAT_BILLING =
      AqutterSafeBrowsingThreat._internal(4, 4);

  ///The resource was blocked because it contains malware.
  static const SAFE_BROWSING_THREAT_MALWARE =
      AqutterSafeBrowsingThreat._internal(1, 1);

  ///The resource was blocked because it contains deceptive content.
  static const SAFE_BROWSING_THREAT_PHISHING =
      AqutterSafeBrowsingThreat._internal(2, 2);

  ///The resource was blocked for an unknown reason.
  static const SAFE_BROWSING_THREAT_UNKNOWN =
      AqutterSafeBrowsingThreat._internal(0, 0);

  ///The resource was blocked because it contains unwanted software.
  static const SAFE_BROWSING_THREAT_UNWANTED_SOFTWARE =
      AqutterSafeBrowsingThreat._internal(3, 3);

  ///Set of all values of [AqutterSafeBrowsingThreat].
  static final Set<AqutterSafeBrowsingThreat> values = [
    AqutterSafeBrowsingThreat.SAFE_BROWSING_THREAT_BILLING,
    AqutterSafeBrowsingThreat.SAFE_BROWSING_THREAT_MALWARE,
    AqutterSafeBrowsingThreat.SAFE_BROWSING_THREAT_PHISHING,
    AqutterSafeBrowsingThreat.SAFE_BROWSING_THREAT_UNKNOWN,
    AqutterSafeBrowsingThreat.SAFE_BROWSING_THREAT_UNWANTED_SOFTWARE,
  ].toSet();

  ///Gets a possible [AqutterSafeBrowsingThreat] instance from [int] value.
  static AqutterSafeBrowsingThreat? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterSafeBrowsingThreat.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterSafeBrowsingThreat] instance from a native value.
  static AqutterSafeBrowsingThreat? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterSafeBrowsingThreat.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterSafeBrowsingThreat] instance value with name [name].
  ///
  /// Goes through [AqutterSafeBrowsingThreat.values] looking for a value with
  /// name [name], as reported by [AqutterSafeBrowsingThreat.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterSafeBrowsingThreat? byName(String? name) {
    if (name != null) {
      try {
        return AqutterSafeBrowsingThreat.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterSafeBrowsingThreat] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterSafeBrowsingThreat> asNameMap() =>
      <String, AqutterSafeBrowsingThreat>{
        for (final value in AqutterSafeBrowsingThreat.values)
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
        return 'SAFE_BROWSING_THREAT_BILLING';
      case 1:
        return 'SAFE_BROWSING_THREAT_MALWARE';
      case 2:
        return 'SAFE_BROWSING_THREAT_PHISHING';
      case 0:
        return 'SAFE_BROWSING_THREAT_UNKNOWN';
      case 3:
        return 'SAFE_BROWSING_THREAT_UNWANTED_SOFTWARE';
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
