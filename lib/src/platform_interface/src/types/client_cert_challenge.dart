import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'url_authentication_challenge.dart';
import 'url_protection_space.dart';
import '../webview/platform_webview.dart';
import '../types/ssl_certificate.dart';
import 'enum_method.dart';

part 'client_cert_challenge.g.dart';

///Class that represents the challenge of the [AqutterPlatformWebViewCreationParams.onReceivedClientCertRequest] event.
///It provides all the information about the challenge.
@ExchangeableObject()
class AqutterClientCertChallenge_ extends AqutterURLAuthenticationChallenge_ {
  ///Use [principals] instead.
  @Deprecated('Use principals instead')
  List<String>? androidPrincipals;

  ///The acceptable certificate issuers for the certificate matching the private key.
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: "ClientCertRequest.getPrincipals",
        apiUrl:
            "https://developer.android.com/reference/android/webkit/ClientCertRequest#getPrincipals()",
        available: "21",
      ),
    ],
  )
  List<String>? principals;

  ///Use [keyTypes] instead.
  @Deprecated('Use keyTypes instead')
  List<String>? androidKeyTypes;

  ///Returns the acceptable types of asymmetric keys.
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: "ClientCertRequest.getKeyTypes",
        apiUrl:
            "https://developer.android.com/reference/android/webkit/ClientCertRequest#getKeyTypes()",
        available: "21",
      ),
    ],
  )
  List<String>? keyTypes;

  ///The collection contains Base64 encoding of DER encoded distinguished names
  ///of certificate authorities allowed by the server.
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  List<String>? allowedCertificateAuthorities;

  ///If the server that issued this request is an http proxy.
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  bool? isProxy;

  ///The collection contains mutually trusted CA certificates.
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  List<AqutterSslCertificate_>? mutuallyTrustedCertificates;

  AqutterClientCertChallenge_({
    required AqutterURLProtectionSpace_ protectionSpace,
    @Deprecated('Use principals instead') this.androidPrincipals,
    this.principals,
    @Deprecated('Use keyTypes instead') this.androidKeyTypes,
    this.keyTypes,
    this.allowedCertificateAuthorities,
    this.isProxy,
    this.mutuallyTrustedCertificates,
  }) : super(protectionSpace: protectionSpace);
}
