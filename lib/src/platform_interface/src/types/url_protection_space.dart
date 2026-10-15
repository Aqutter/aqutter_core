import 'dart:typed_data';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../x509_certificate/x509_certificate.dart';
import 'url_protection_space_proxy_type.dart';
import 'url_protection_space_authentication_method.dart';
import 'ssl_error.dart';
import 'ssl_certificate.dart';
import 'enum_method.dart';

part 'url_protection_space.g.dart';

List<AqutterX509Certificate>? _distinguishedNamesDeserializer(
  dynamic value, {
  AqutterEnumMethod? enumMethod,
}) {
  List<AqutterX509Certificate>? distinguishedNames;
  if (value != null) {
    distinguishedNames = <AqutterX509Certificate>[];
    (value.cast<Uint8List>() as List<Uint8List>).forEach((data) {
      try {
        distinguishedNames!.add(AqutterX509Certificate.fromData(data: data));
      } catch (e, stacktrace) {
        print(e);
        print(stacktrace);
      }
    });
  }
  return distinguishedNames;
}

///Class that represents a protection space requiring authentication.
@ExchangeableObject()
class AqutterURLProtectionSpace_ {
  ///The hostname of the server.
  String host;

  ///The protocol of the server - e.g. "http", "ftp", "https".
  String? protocol;

  ///A string indicating a protocol-specific subdivision of a single host.
  ///For http and https, this maps to the realm string in http authentication challenges.
  ///For many other protocols it is unused.
  String? realm;

  ///The port of the server.
  int? port;

  ///The SSL certificate used.
  AqutterSslCertificate_? sslCertificate;

  ///The SSL Error associated.
  AqutterSslError_? sslError;

  ///Use [authenticationMethod] instead.
  @Deprecated("Use authenticationMethod instead")
  AqutterIOSNSURLProtectionSpaceAuthenticationMethod_? iosAuthenticationMethod;

  ///The authentication method used by the receiver.
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: "AqutterURLProtectionSpace.authenticationMethod",
        apiUrl:
            "https://developer.apple.com/documentation/foundation/urlprotectionspace/1415028-authenticationmethod",
      ),
      MacOSPlatform(
        apiName: "AqutterURLProtectionSpace.authenticationMethod",
        apiUrl:
            "https://developer.apple.com/documentation/foundation/urlprotectionspace/1415028-authenticationmethod",
      ),
    ],
  )
  AqutterURLProtectionSpaceAuthenticationMethod_? authenticationMethod;

  ///Use [distinguishedNames] instead.
  @Deprecated("Use distinguishedNames instead")
  @ExchangeableObjectProperty(deserializer: _distinguishedNamesDeserializer)
  List<AqutterX509Certificate>? iosDistinguishedNames;

  ///The acceptable certificate-issuing authorities for client certificate authentication.
  ///This value is `null` if the authentication method of the protection space is not client certificate.
  ///The returned issuing authorities are encoded with Distinguished Encoding Rules (DER).
  @ExchangeableObjectProperty(deserializer: _distinguishedNamesDeserializer)
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: "AqutterURLProtectionSpace.distinguishedNames",
        apiUrl:
            "https://developer.apple.com/documentation/foundation/urlprotectionspace/1417061-distinguishednames",
      ),
      MacOSPlatform(
        apiName: "AqutterURLProtectionSpace.distinguishedNames",
        apiUrl:
            "https://developer.apple.com/documentation/foundation/urlprotectionspace/1417061-distinguishednames",
      ),
    ],
  )
  List<AqutterX509Certificate>? distinguishedNames;

  ///Use [receivesCredentialSecurely] instead.
  @Deprecated("Use receivesCredentialSecurely instead")
  bool? iosReceivesCredentialSecurely;

  ///A Boolean value that indicates whether the credentials for the protection space can be sent securely.
  ///This value is `true` if the credentials for the protection space represented by the receiver can be sent securely, `false` otherwise.
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: "AqutterURLProtectionSpace.receivesCredentialSecurely",
        apiUrl:
            "https://developer.apple.com/documentation/foundation/urlprotectionspace/1415176-receivescredentialsecurely",
      ),
      MacOSPlatform(
        apiName: "AqutterURLProtectionSpace.receivesCredentialSecurely",
        apiUrl:
            "https://developer.apple.com/documentation/foundation/urlprotectionspace/1415176-receivescredentialsecurely",
      ),
    ],
  )
  bool? receivesCredentialSecurely;

  ///Use [proxyType] instead.
  @Deprecated("Use proxyType instead")
  AqutterIOSNSURLProtectionSpaceProxyType_? iosProxyType;

  ///The receiver's proxy type.
  ///This value is `null` if the receiver does not represent a proxy protection space.
  ///The supported proxy types are listed in [AqutterURLProtectionSpaceProxyType.values].
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: "AqutterURLProtectionSpace.proxyType",
        apiUrl:
            "https://developer.apple.com/documentation/foundation/urlprotectionspace/1411924-proxytype",
      ),
      MacOSPlatform(
        apiName: "AqutterURLProtectionSpace.proxyType",
        apiUrl:
            "https://developer.apple.com/documentation/foundation/urlprotectionspace/1411924-proxytype",
      ),
    ],
  )
  AqutterURLProtectionSpaceProxyType_? proxyType;

  AqutterURLProtectionSpace_({
    required this.host,
    this.protocol,
    this.realm,
    this.port,
    this.sslCertificate,
    this.sslError,
    @Deprecated("Use authenticationMethod instead")
    this.iosAuthenticationMethod,
    this.authenticationMethod,
    @Deprecated("Use distinguishedNames instead") this.iosDistinguishedNames,
    this.distinguishedNames,
    @Deprecated("Use receivesCredentialSecurely instead")
    this.iosReceivesCredentialSecurely,
    this.receivesCredentialSecurely,
    @Deprecated("Use proxyType instead") this.iosProxyType,
    this.proxyType,
  });
}
