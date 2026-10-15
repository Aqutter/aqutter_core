import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'url_protection_space.dart';

part 'url_protection_space_authentication_method.g.dart';

///Class that represents the constants describing known values of the [AqutterURLProtectionSpace.authenticationMethod] property.
@ExchangeableEnum()
class AqutterURLProtectionSpaceAuthenticationMethod_ {
  // ignore: unused_field
  final String _value;
  const AqutterURLProtectionSpaceAuthenticationMethod_._internal(this._value);

  ///Use the default authentication method for a protocol.
  static const NSURL_AUTHENTICATION_METHOD_DEFAULT =
      const AqutterURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodDefault",
      );

  ///Use HTTP basic authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_HTTP_BASIC =
      const AqutterURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodHTTPBasic",
      );

  ///Use HTTP digest authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_HTTP_DIGEST =
      const AqutterURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodHTTPDigest",
      );

  ///Use HTML form authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_HTML_FORM =
      const AqutterURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodHTMLForm",
      );

  ///Use client certificate authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_CLIENT_CERTIFICATE =
      const AqutterURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodClientCertificate",
      );

  ///Negotiate whether to use Kerberos or NTLM authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_NEGOTIATE =
      const AqutterURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodNegotiate",
      );

  ///Use NTLM authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_NTLM =
      const AqutterURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodNTLM",
      );

  ///Perform server trust authentication (certificate validation) for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_SERVER_TRUST =
      const AqutterURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodServerTrust",
      );
}

///An iOS-specific Class that represents the constants describing known values of the [AqutterURLProtectionSpace.authenticationMethod] property.
///Use [AqutterURLProtectionSpaceAuthenticationMethod] instead.
@Deprecated("Use AqutterURLProtectionSpaceAuthenticationMethod instead")
@ExchangeableEnum()
class AqutterIOSNSURLProtectionSpaceAuthenticationMethod_ {
  // ignore: unused_field
  final String _value;
  const AqutterIOSNSURLProtectionSpaceAuthenticationMethod_._internal(this._value);

  ///Use the default authentication method for a protocol.
  static const NSURL_AUTHENTICATION_METHOD_DEFAULT =
      const AqutterIOSNSURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodDefault",
      );

  ///Use HTTP basic authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_HTTP_BASIC =
      const AqutterIOSNSURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodHTTPBasic",
      );

  ///Use HTTP digest authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_HTTP_DIGEST =
      const AqutterIOSNSURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodHTTPDigest",
      );

  ///Use HTML form authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_HTML_FORM =
      const AqutterIOSNSURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodHTMLForm",
      );

  ///Use client certificate authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_CLIENT_CERTIFICATE =
      const AqutterIOSNSURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodClientCertificate",
      );

  ///Negotiate whether to use Kerberos or NTLM authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_NEGOTIATE =
      const AqutterIOSNSURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodNegotiate",
      );

  ///Use NTLM authentication for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_NTLM =
      const AqutterIOSNSURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodNTLM",
      );

  ///Perform server trust authentication (certificate validation) for this protection space.
  static const NSURL_AUTHENTICATION_METHOD_SERVER_TRUST =
      const AqutterIOSNSURLProtectionSpaceAuthenticationMethod_._internal(
        "NSURLAuthenticationMethodServerTrust",
      );
}
