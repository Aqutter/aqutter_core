import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'url_protection_space_proxy_type.g.dart';

///Class that represents the supported proxy types.
@ExchangeableEnum()
class AqutterURLProtectionSpaceProxyType_ {
  // ignore: unused_field
  final String _value;
  const AqutterURLProtectionSpaceProxyType_._internal(this._value);

  ///The proxy type for HTTP proxies.
  static const URL_PROTECTION_SPACE_HTTP_PROXY =
      const AqutterURLProtectionSpaceProxyType_._internal(
        "NSURLProtectionSpaceHTTPProxy",
      );

  ///The proxy type for HTTPS proxies.
  static const URL_PROTECTION_SPACE_HTTPS_PROXY =
      const AqutterURLProtectionSpaceProxyType_._internal(
        "NSURLProtectionSpaceHTTPSProxy",
      );

  ///The proxy type for FTP proxies.
  static const URL_PROTECTION_SPACE_FTP_PROXY =
      const AqutterURLProtectionSpaceProxyType_._internal(
        "NSURLProtectionSpaceFTPProxy",
      );

  ///The proxy type for SOCKS proxies.
  static const URL_PROTECTION_SPACE_SOCKS_PROXY =
      const AqutterURLProtectionSpaceProxyType_._internal(
        "NSURLProtectionSpaceSOCKSProxy",
      );
}

///An iOS-specific Class that represents the supported proxy types.
///Use [AqutterURLProtectionSpaceProxyType] instead.
@Deprecated("Use AqutterURLProtectionSpaceProxyType instead")
@ExchangeableEnum()
class AqutterIOSNSURLProtectionSpaceProxyType_ {
  // ignore: unused_field
  final String _value;
  const AqutterIOSNSURLProtectionSpaceProxyType_._internal(this._value);

  ///The proxy type for HTTP proxies.
  static const NSUR_PROTECTION_SPACE_HTTP_PROXY =
      const AqutterIOSNSURLProtectionSpaceProxyType_._internal(
        "NSURLProtectionSpaceHTTPProxy",
      );

  ///The proxy type for HTTPS proxies.
  static const NSURL_PROTECTION_SPACE_HTTPS_PROXY =
      const AqutterIOSNSURLProtectionSpaceProxyType_._internal(
        "NSURLProtectionSpaceHTTPSProxy",
      );

  ///The proxy type for FTP proxies.
  static const NSURL_PROTECTION_SPACE_FTP_PROXY =
      const AqutterIOSNSURLProtectionSpaceProxyType_._internal(
        "NSURLProtectionSpaceFTPProxy",
      );

  ///The proxy type for SOCKS proxies.
  static const NSURL_PROTECTION_SPACE_SOCKS_PROXY =
      const AqutterIOSNSURLProtectionSpaceProxyType_._internal(
        "NSURLProtectionSpaceSOCKSProxy",
      );
}
