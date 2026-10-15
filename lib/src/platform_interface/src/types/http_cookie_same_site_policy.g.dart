// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_cookie_same_site_policy.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the same site policy of a cookie. Used by the [AqutterCookie] class.
class AqutterHTTPCookieSameSitePolicy {
  final String _value;
  final String? _nativeValue;
  const AqutterHTTPCookieSameSitePolicy._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterHTTPCookieSameSitePolicy._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterHTTPCookieSameSitePolicy._internal(value, nativeValue());

  ///SameSite=Lax;
  ///
  ///Cookies are allowed to be sent with top-level navigations and will be sent along with GET
  ///request initiated by third party website. This is the default value in modern browsers.
  static const LAX = AqutterHTTPCookieSameSitePolicy._internal('Lax', 'Lax');

  ///SameSite=None;
  ///
  ///Cookies will be sent in all contexts, i.e sending cross-origin is allowed.
  ///`None` requires the `Secure` attribute in latest browser versions.
  static const NONE = AqutterHTTPCookieSameSitePolicy._internal('None', 'None');

  ///SameSite=Strict;
  ///
  ///Cookies will only be sent in a first-party context and not be sent along with requests initiated by third party websites.
  static const STRICT = AqutterHTTPCookieSameSitePolicy._internal(
    'Strict',
    'Strict',
  );

  ///Set of all values of [AqutterHTTPCookieSameSitePolicy].
  static final Set<AqutterHTTPCookieSameSitePolicy> values = [
    AqutterHTTPCookieSameSitePolicy.LAX,
    AqutterHTTPCookieSameSitePolicy.NONE,
    AqutterHTTPCookieSameSitePolicy.STRICT,
  ].toSet();

  ///Gets a possible [AqutterHTTPCookieSameSitePolicy] instance from [String] value.
  static AqutterHTTPCookieSameSitePolicy? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterHTTPCookieSameSitePolicy.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterHTTPCookieSameSitePolicy] instance from a native value.
  static AqutterHTTPCookieSameSitePolicy? fromNativeValue(String? value) {
    if (value != null) {
      try {
        return AqutterHTTPCookieSameSitePolicy.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterHTTPCookieSameSitePolicy] instance value with name [name].
  ///
  /// Goes through [AqutterHTTPCookieSameSitePolicy.values] looking for a value with
  /// name [name], as reported by [AqutterHTTPCookieSameSitePolicy.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterHTTPCookieSameSitePolicy? byName(String? name) {
    if (name != null) {
      try {
        return AqutterHTTPCookieSameSitePolicy.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterHTTPCookieSameSitePolicy] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterHTTPCookieSameSitePolicy> asNameMap() =>
      <String, AqutterHTTPCookieSameSitePolicy>{
        for (final value in AqutterHTTPCookieSameSitePolicy.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'Lax':
        return 'LAX';
      case 'None':
        return 'NONE';
      case 'Strict':
        return 'STRICT';
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
