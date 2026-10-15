// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_protection_space_proxy_type.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the supported proxy types.
class AqutterURLProtectionSpaceProxyType {
  final String _value;
  final String? _nativeValue;
  const AqutterURLProtectionSpaceProxyType._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterURLProtectionSpaceProxyType._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterURLProtectionSpaceProxyType._internal(value, nativeValue());

  ///The proxy type for FTP proxies.
  static const URL_PROTECTION_SPACE_FTP_PROXY =
      AqutterURLProtectionSpaceProxyType._internal(
        'NSURLProtectionSpaceFTPProxy',
        'NSURLProtectionSpaceFTPProxy',
      );

  ///The proxy type for HTTPS proxies.
  static const URL_PROTECTION_SPACE_HTTPS_PROXY =
      AqutterURLProtectionSpaceProxyType._internal(
        'NSURLProtectionSpaceHTTPSProxy',
        'NSURLProtectionSpaceHTTPSProxy',
      );

  ///The proxy type for HTTP proxies.
  static const URL_PROTECTION_SPACE_HTTP_PROXY =
      AqutterURLProtectionSpaceProxyType._internal(
        'NSURLProtectionSpaceHTTPProxy',
        'NSURLProtectionSpaceHTTPProxy',
      );

  ///The proxy type for SOCKS proxies.
  static const URL_PROTECTION_SPACE_SOCKS_PROXY =
      AqutterURLProtectionSpaceProxyType._internal(
        'NSURLProtectionSpaceSOCKSProxy',
        'NSURLProtectionSpaceSOCKSProxy',
      );

  ///Set of all values of [AqutterURLProtectionSpaceProxyType].
  static final Set<AqutterURLProtectionSpaceProxyType> values = [
    AqutterURLProtectionSpaceProxyType.URL_PROTECTION_SPACE_FTP_PROXY,
    AqutterURLProtectionSpaceProxyType.URL_PROTECTION_SPACE_HTTPS_PROXY,
    AqutterURLProtectionSpaceProxyType.URL_PROTECTION_SPACE_HTTP_PROXY,
    AqutterURLProtectionSpaceProxyType.URL_PROTECTION_SPACE_SOCKS_PROXY,
  ].toSet();

  ///Gets a possible [AqutterURLProtectionSpaceProxyType] instance from [String] value.
  static AqutterURLProtectionSpaceProxyType? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterURLProtectionSpaceProxyType.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterURLProtectionSpaceProxyType] instance from a native value.
  static AqutterURLProtectionSpaceProxyType? fromNativeValue(String? value) {
    if (value != null) {
      try {
        return AqutterURLProtectionSpaceProxyType.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterURLProtectionSpaceProxyType] instance value with name [name].
  ///
  /// Goes through [AqutterURLProtectionSpaceProxyType.values] looking for a value with
  /// name [name], as reported by [AqutterURLProtectionSpaceProxyType.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterURLProtectionSpaceProxyType? byName(String? name) {
    if (name != null) {
      try {
        return AqutterURLProtectionSpaceProxyType.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterURLProtectionSpaceProxyType] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterURLProtectionSpaceProxyType> asNameMap() =>
      <String, AqutterURLProtectionSpaceProxyType>{
        for (final value in AqutterURLProtectionSpaceProxyType.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'NSURLProtectionSpaceFTPProxy':
        return 'URL_PROTECTION_SPACE_FTP_PROXY';
      case 'NSURLProtectionSpaceHTTPSProxy':
        return 'URL_PROTECTION_SPACE_HTTPS_PROXY';
      case 'NSURLProtectionSpaceHTTPProxy':
        return 'URL_PROTECTION_SPACE_HTTP_PROXY';
      case 'NSURLProtectionSpaceSOCKSProxy':
        return 'URL_PROTECTION_SPACE_SOCKS_PROXY';
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

///An iOS-specific Class that represents the supported proxy types.
///Use [AqutterURLProtectionSpaceProxyType] instead.
@Deprecated('Use AqutterURLProtectionSpaceProxyType instead')
class AqutterIOSNSURLProtectionSpaceProxyType {
  final String _value;
  final String? _nativeValue;
  const AqutterIOSNSURLProtectionSpaceProxyType._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSNSURLProtectionSpaceProxyType._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterIOSNSURLProtectionSpaceProxyType._internal(value, nativeValue());

  ///The proxy type for FTP proxies.
  static const NSURL_PROTECTION_SPACE_FTP_PROXY =
      AqutterIOSNSURLProtectionSpaceProxyType._internal(
        'NSURLProtectionSpaceFTPProxy',
        'NSURLProtectionSpaceFTPProxy',
      );

  ///The proxy type for HTTPS proxies.
  static const NSURL_PROTECTION_SPACE_HTTPS_PROXY =
      AqutterIOSNSURLProtectionSpaceProxyType._internal(
        'NSURLProtectionSpaceHTTPSProxy',
        'NSURLProtectionSpaceHTTPSProxy',
      );

  ///The proxy type for SOCKS proxies.
  static const NSURL_PROTECTION_SPACE_SOCKS_PROXY =
      AqutterIOSNSURLProtectionSpaceProxyType._internal(
        'NSURLProtectionSpaceSOCKSProxy',
        'NSURLProtectionSpaceSOCKSProxy',
      );

  ///The proxy type for HTTP proxies.
  static const NSUR_PROTECTION_SPACE_HTTP_PROXY =
      AqutterIOSNSURLProtectionSpaceProxyType._internal(
        'NSURLProtectionSpaceHTTPProxy',
        'NSURLProtectionSpaceHTTPProxy',
      );

  ///Set of all values of [AqutterIOSNSURLProtectionSpaceProxyType].
  static final Set<AqutterIOSNSURLProtectionSpaceProxyType> values = [
    AqutterIOSNSURLProtectionSpaceProxyType.NSURL_PROTECTION_SPACE_FTP_PROXY,
    AqutterIOSNSURLProtectionSpaceProxyType.NSURL_PROTECTION_SPACE_HTTPS_PROXY,
    AqutterIOSNSURLProtectionSpaceProxyType.NSURL_PROTECTION_SPACE_SOCKS_PROXY,
    AqutterIOSNSURLProtectionSpaceProxyType.NSUR_PROTECTION_SPACE_HTTP_PROXY,
  ].toSet();

  ///Gets a possible [AqutterIOSNSURLProtectionSpaceProxyType] instance from [String] value.
  static AqutterIOSNSURLProtectionSpaceProxyType? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterIOSNSURLProtectionSpaceProxyType.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSNSURLProtectionSpaceProxyType] instance from a native value.
  static AqutterIOSNSURLProtectionSpaceProxyType? fromNativeValue(
    String? value,
  ) {
    if (value != null) {
      try {
        return AqutterIOSNSURLProtectionSpaceProxyType.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSNSURLProtectionSpaceProxyType] instance value with name [name].
  ///
  /// Goes through [AqutterIOSNSURLProtectionSpaceProxyType.values] looking for a value with
  /// name [name], as reported by [AqutterIOSNSURLProtectionSpaceProxyType.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSNSURLProtectionSpaceProxyType? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSNSURLProtectionSpaceProxyType.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSNSURLProtectionSpaceProxyType] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSNSURLProtectionSpaceProxyType> asNameMap() =>
      <String, AqutterIOSNSURLProtectionSpaceProxyType>{
        for (final value in AqutterIOSNSURLProtectionSpaceProxyType.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'NSURLProtectionSpaceFTPProxy':
        return 'NSURL_PROTECTION_SPACE_FTP_PROXY';
      case 'NSURLProtectionSpaceHTTPSProxy':
        return 'NSURL_PROTECTION_SPACE_HTTPS_PROXY';
      case 'NSURLProtectionSpaceSOCKSProxy':
        return 'NSURL_PROTECTION_SPACE_SOCKS_PROXY';
      case 'NSURLProtectionSpaceHTTPProxy':
        return 'NSUR_PROTECTION_SPACE_HTTP_PROXY';
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
