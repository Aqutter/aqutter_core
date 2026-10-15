// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_scheme_filter.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represent scheme filters used by [AqutterPlatformProxyController].
class AqutterProxySchemeFilter {
  final String _value;
  final String? _nativeValue;
  const AqutterProxySchemeFilter._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterProxySchemeFilter._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterProxySchemeFilter._internal(value, nativeValue());

  ///Matches all schemes.
  static const MATCH_ALL_SCHEMES = AqutterProxySchemeFilter._internal('*', '*');

  ///HTTP scheme.
  static const MATCH_HTTP = AqutterProxySchemeFilter._internal('http', 'http');

  ///HTTPS scheme.
  static const MATCH_HTTPS = AqutterProxySchemeFilter._internal(
    'https',
    'https',
  );

  ///Set of all values of [AqutterProxySchemeFilter].
  static final Set<AqutterProxySchemeFilter> values = [
    AqutterProxySchemeFilter.MATCH_ALL_SCHEMES,
    AqutterProxySchemeFilter.MATCH_HTTP,
    AqutterProxySchemeFilter.MATCH_HTTPS,
  ].toSet();

  ///Gets a possible [AqutterProxySchemeFilter] instance from [String] value.
  static AqutterProxySchemeFilter? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterProxySchemeFilter.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterProxySchemeFilter] instance from a native value.
  static AqutterProxySchemeFilter? fromNativeValue(String? value) {
    if (value != null) {
      try {
        return AqutterProxySchemeFilter.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterProxySchemeFilter] instance value with name [name].
  ///
  /// Goes through [AqutterProxySchemeFilter.values] looking for a value with
  /// name [name], as reported by [AqutterProxySchemeFilter.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterProxySchemeFilter? byName(String? name) {
    if (name != null) {
      try {
        return AqutterProxySchemeFilter.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterProxySchemeFilter] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterProxySchemeFilter> asNameMap() =>
      <String, AqutterProxySchemeFilter>{
        for (final value in AqutterProxySchemeFilter.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case '*':
        return 'MATCH_ALL_SCHEMES';
      case 'http':
        return 'MATCH_HTTP';
      case 'https':
        return 'MATCH_HTTPS';
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
    return _value;
  }
}
