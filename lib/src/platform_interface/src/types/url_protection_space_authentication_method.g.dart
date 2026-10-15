// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_protection_space_authentication_method.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the constants describing known values of the [AqutterURLProtectionSpace.authenticationMethod] property.
class AqutterURLProtectionSpaceAuthenticationMethod {
  final String _value;
  final String? _nativeValue;
  const AqutterURLProtectionSpaceAuthenticationMethod._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterURLProtectionSpaceAuthenticationMethod._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterURLProtectionSpaceAuthenticationMethod._internal(
    value,
    nativeValue(),
  );

  ///Use client certificate authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_CLIENT_CERTIFICATE =
      AqutterURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodClientCertificate',
        'NSURLAuthenticationMethodClientCertificate',
      );

  ///Use the default authentication method for a protocol.
  static const NSURL_AUTHENTICATION_METHOD_DEFAULT =
      AqutterURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodDefault',
        'NSURLAuthenticationMethodDefault',
      );

  ///Use HTML form authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_HTML_FORM =
      AqutterURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodHTMLForm',
        'NSURLAuthenticationMethodHTMLForm',
      );

  ///Use HTTP basic authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_HTTP_BASIC =
      AqutterURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodHTTPBasic',
        'NSURLAuthenticationMethodHTTPBasic',
      );

  ///Use HTTP digest authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_HTTP_DIGEST =
      AqutterURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodHTTPDigest',
        'NSURLAuthenticationMethodHTTPDigest',
      );

  ///Negotiate whether to use Kerberos or NTLM authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_NEGOTIATE =
      AqutterURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodNegotiate',
        'NSURLAuthenticationMethodNegotiate',
      );

  ///Use NTLM authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_NTLM =
      AqutterURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodNTLM',
        'NSURLAuthenticationMethodNTLM',
      );

  ///Perform server trust authentication (certificate validation) for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_SERVER_TRUST =
      AqutterURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodServerTrust',
        'NSURLAuthenticationMethodServerTrust',
      );

  ///Set of all values of [AqutterURLProtectionSpaceAuthenticationMethod].
  static final Set<AqutterURLProtectionSpaceAuthenticationMethod> values = [
    AqutterURLProtectionSpaceAuthenticationMethod
        .NSURL_AUTHENTICATION_METHOD_CLIENT_CERTIFICATE,
    AqutterURLProtectionSpaceAuthenticationMethod
        .NSURL_AUTHENTICATION_METHOD_DEFAULT,
    AqutterURLProtectionSpaceAuthenticationMethod
        .NSURL_AUTHENTICATION_METHOD_HTML_FORM,
    AqutterURLProtectionSpaceAuthenticationMethod
        .NSURL_AUTHENTICATION_METHOD_HTTP_BASIC,
    AqutterURLProtectionSpaceAuthenticationMethod
        .NSURL_AUTHENTICATION_METHOD_HTTP_DIGEST,
    AqutterURLProtectionSpaceAuthenticationMethod
        .NSURL_AUTHENTICATION_METHOD_NEGOTIATE,
    AqutterURLProtectionSpaceAuthenticationMethod
        .NSURL_AUTHENTICATION_METHOD_NTLM,
    AqutterURLProtectionSpaceAuthenticationMethod
        .NSURL_AUTHENTICATION_METHOD_SERVER_TRUST,
  ].toSet();

  ///Gets a possible [AqutterURLProtectionSpaceAuthenticationMethod] instance from [String] value.
  static AqutterURLProtectionSpaceAuthenticationMethod? fromValue(
    String? value,
  ) {
    if (value != null) {
      try {
        return AqutterURLProtectionSpaceAuthenticationMethod.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterURLProtectionSpaceAuthenticationMethod] instance from a native value.
  static AqutterURLProtectionSpaceAuthenticationMethod? fromNativeValue(
    String? value,
  ) {
    if (value != null) {
      try {
        return AqutterURLProtectionSpaceAuthenticationMethod.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterURLProtectionSpaceAuthenticationMethod] instance value with name [name].
  ///
  /// Goes through [AqutterURLProtectionSpaceAuthenticationMethod.values] looking for a value with
  /// name [name], as reported by [AqutterURLProtectionSpaceAuthenticationMethod.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterURLProtectionSpaceAuthenticationMethod? byName(String? name) {
    if (name != null) {
      try {
        return AqutterURLProtectionSpaceAuthenticationMethod.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterURLProtectionSpaceAuthenticationMethod] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterURLProtectionSpaceAuthenticationMethod>
  asNameMap() => <String, AqutterURLProtectionSpaceAuthenticationMethod>{
    for (final value in AqutterURLProtectionSpaceAuthenticationMethod.values)
      value.name(): value,
  };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'NSURLAuthenticationMethodClientCertificate':
        return 'NSURL_AUTHENTICATION_METHOD_CLIENT_CERTIFICATE';
      case 'NSURLAuthenticationMethodDefault':
        return 'NSURL_AUTHENTICATION_METHOD_DEFAULT';
      case 'NSURLAuthenticationMethodHTMLForm':
        return 'NSURL_AUTHENTICATION_METHOD_HTML_FORM';
      case 'NSURLAuthenticationMethodHTTPBasic':
        return 'NSURL_AUTHENTICATION_METHOD_HTTP_BASIC';
      case 'NSURLAuthenticationMethodHTTPDigest':
        return 'NSURL_AUTHENTICATION_METHOD_HTTP_DIGEST';
      case 'NSURLAuthenticationMethodNegotiate':
        return 'NSURL_AUTHENTICATION_METHOD_NEGOTIATE';
      case 'NSURLAuthenticationMethodNTLM':
        return 'NSURL_AUTHENTICATION_METHOD_NTLM';
      case 'NSURLAuthenticationMethodServerTrust':
        return 'NSURL_AUTHENTICATION_METHOD_SERVER_TRUST';
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

///An iOS-specific Class that represents the constants describing known values of the [AqutterURLProtectionSpace.authenticationMethod] property.
///Use [AqutterURLProtectionSpaceAuthenticationMethod] instead.
@Deprecated('Use AqutterURLProtectionSpaceAuthenticationMethod instead')
class AqutterIOSNSURLProtectionSpaceAuthenticationMethod {
  final String _value;
  final String? _nativeValue;
  const AqutterIOSNSURLProtectionSpaceAuthenticationMethod._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSNSURLProtectionSpaceAuthenticationMethod._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterIOSNSURLProtectionSpaceAuthenticationMethod._internal(
    value,
    nativeValue(),
  );

  ///Use client certificate authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_CLIENT_CERTIFICATE =
      AqutterIOSNSURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodClientCertificate',
        'NSURLAuthenticationMethodClientCertificate',
      );

  ///Use the default authentication method for a protocol.
  static const NSURL_AUTHENTICATION_METHOD_DEFAULT =
      AqutterIOSNSURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodDefault',
        'NSURLAuthenticationMethodDefault',
      );

  ///Use HTML form authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_HTML_FORM =
      AqutterIOSNSURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodHTMLForm',
        'NSURLAuthenticationMethodHTMLForm',
      );

  ///Use HTTP basic authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_HTTP_BASIC =
      AqutterIOSNSURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodHTTPBasic',
        'NSURLAuthenticationMethodHTTPBasic',
      );

  ///Use HTTP digest authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_HTTP_DIGEST =
      AqutterIOSNSURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodHTTPDigest',
        'NSURLAuthenticationMethodHTTPDigest',
      );

  ///Negotiate whether to use Kerberos or NTLM authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_NEGOTIATE =
      AqutterIOSNSURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodNegotiate',
        'NSURLAuthenticationMethodNegotiate',
      );

  ///Use NTLM authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_NTLM =
      AqutterIOSNSURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodNTLM',
        'NSURLAuthenticationMethodNTLM',
      );

  ///Perform server trust authentication (certificate validation) for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_SERVER_TRUST =
      AqutterIOSNSURLProtectionSpaceAuthenticationMethod._internal(
        'NSURLAuthenticationMethodServerTrust',
        'NSURLAuthenticationMethodServerTrust',
      );

  ///Set of all values of [AqutterIOSNSURLProtectionSpaceAuthenticationMethod].
  static final Set<AqutterIOSNSURLProtectionSpaceAuthenticationMethod> values =
      [
        AqutterIOSNSURLProtectionSpaceAuthenticationMethod
            .NSURL_AUTHENTICATION_METHOD_CLIENT_CERTIFICATE,
        AqutterIOSNSURLProtectionSpaceAuthenticationMethod
            .NSURL_AUTHENTICATION_METHOD_DEFAULT,
        AqutterIOSNSURLProtectionSpaceAuthenticationMethod
            .NSURL_AUTHENTICATION_METHOD_HTML_FORM,
        AqutterIOSNSURLProtectionSpaceAuthenticationMethod
            .NSURL_AUTHENTICATION_METHOD_HTTP_BASIC,
        AqutterIOSNSURLProtectionSpaceAuthenticationMethod
            .NSURL_AUTHENTICATION_METHOD_HTTP_DIGEST,
        AqutterIOSNSURLProtectionSpaceAuthenticationMethod
            .NSURL_AUTHENTICATION_METHOD_NEGOTIATE,
        AqutterIOSNSURLProtectionSpaceAuthenticationMethod
            .NSURL_AUTHENTICATION_METHOD_NTLM,
        AqutterIOSNSURLProtectionSpaceAuthenticationMethod
            .NSURL_AUTHENTICATION_METHOD_SERVER_TRUST,
      ].toSet();

  ///Gets a possible [AqutterIOSNSURLProtectionSpaceAuthenticationMethod] instance from [String] value.
  static AqutterIOSNSURLProtectionSpaceAuthenticationMethod? fromValue(
    String? value,
  ) {
    if (value != null) {
      try {
        return AqutterIOSNSURLProtectionSpaceAuthenticationMethod.values
            .firstWhere((element) => element.toValue() == value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSNSURLProtectionSpaceAuthenticationMethod] instance from a native value.
  static AqutterIOSNSURLProtectionSpaceAuthenticationMethod? fromNativeValue(
    String? value,
  ) {
    if (value != null) {
      try {
        return AqutterIOSNSURLProtectionSpaceAuthenticationMethod.values
            .firstWhere((element) => element.toNativeValue() == value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSNSURLProtectionSpaceAuthenticationMethod] instance value with name [name].
  ///
  /// Goes through [AqutterIOSNSURLProtectionSpaceAuthenticationMethod.values] looking for a value with
  /// name [name], as reported by [AqutterIOSNSURLProtectionSpaceAuthenticationMethod.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSNSURLProtectionSpaceAuthenticationMethod? byName(
    String? name,
  ) {
    if (name != null) {
      try {
        return AqutterIOSNSURLProtectionSpaceAuthenticationMethod.values
            .firstWhere((element) => element.name() == name);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSNSURLProtectionSpaceAuthenticationMethod] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSNSURLProtectionSpaceAuthenticationMethod>
  asNameMap() => <String, AqutterIOSNSURLProtectionSpaceAuthenticationMethod>{
    for (final value
        in AqutterIOSNSURLProtectionSpaceAuthenticationMethod.values)
      value.name(): value,
  };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'NSURLAuthenticationMethodClientCertificate':
        return 'NSURL_AUTHENTICATION_METHOD_CLIENT_CERTIFICATE';
      case 'NSURLAuthenticationMethodDefault':
        return 'NSURL_AUTHENTICATION_METHOD_DEFAULT';
      case 'NSURLAuthenticationMethodHTMLForm':
        return 'NSURL_AUTHENTICATION_METHOD_HTML_FORM';
      case 'NSURLAuthenticationMethodHTTPBasic':
        return 'NSURL_AUTHENTICATION_METHOD_HTTP_BASIC';
      case 'NSURLAuthenticationMethodHTTPDigest':
        return 'NSURL_AUTHENTICATION_METHOD_HTTP_DIGEST';
      case 'NSURLAuthenticationMethodNegotiate':
        return 'NSURL_AUTHENTICATION_METHOD_NEGOTIATE';
      case 'NSURLAuthenticationMethodNTLM':
        return 'NSURL_AUTHENTICATION_METHOD_NTLM';
      case 'NSURLAuthenticationMethodServerTrust':
        return 'NSURL_AUTHENTICATION_METHOD_SERVER_TRUST';
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
