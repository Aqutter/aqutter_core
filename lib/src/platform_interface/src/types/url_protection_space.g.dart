// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_protection_space.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents a protection space requiring authentication.
class AqutterURLProtectionSpace {
  ///The authentication method used by the receiver.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - AqutterURLProtectionSpace.authenticationMethod](https://developer.apple.com/documentation/foundation/urlprotectionspace/1415028-authenticationmethod))
  ///- macOS WKWebView ([Official API - AqutterURLProtectionSpace.authenticationMethod](https://developer.apple.com/documentation/foundation/urlprotectionspace/1415028-authenticationmethod))
  AqutterURLProtectionSpaceAuthenticationMethod? authenticationMethod;

  ///The acceptable certificate-issuing authorities for client certificate authentication.
  ///This value is `null` if the authentication method of the protection space is not client certificate.
  ///The returned issuing authorities are encoded with Distinguished Encoding Rules (DER).
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - AqutterURLProtectionSpace.distinguishedNames](https://developer.apple.com/documentation/foundation/urlprotectionspace/1417061-distinguishednames))
  ///- macOS WKWebView ([Official API - AqutterURLProtectionSpace.distinguishedNames](https://developer.apple.com/documentation/foundation/urlprotectionspace/1417061-distinguishednames))
  List<AqutterX509Certificate>? distinguishedNames;

  ///The hostname of the server.
  String host;

  ///Use [authenticationMethod] instead.
  @Deprecated('Use authenticationMethod instead')
  AqutterIOSNSURLProtectionSpaceAuthenticationMethod? iosAuthenticationMethod;

  ///Use [distinguishedNames] instead.
  @Deprecated('Use distinguishedNames instead')
  List<AqutterX509Certificate>? iosDistinguishedNames;

  ///Use [proxyType] instead.
  @Deprecated('Use proxyType instead')
  AqutterIOSNSURLProtectionSpaceProxyType? iosProxyType;

  ///Use [receivesCredentialSecurely] instead.
  @Deprecated('Use receivesCredentialSecurely instead')
  bool? iosReceivesCredentialSecurely;

  ///The port of the server.
  int? port;

  ///The protocol of the server - e.g. "http", "ftp", "https".
  String? protocol;

  ///The receiver's proxy type.
  ///This value is `null` if the receiver does not represent a proxy protection space.
  ///The supported proxy types are listed in [AqutterURLProtectionSpaceProxyType.values].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - AqutterURLProtectionSpace.proxyType](https://developer.apple.com/documentation/foundation/urlprotectionspace/1411924-proxytype))
  ///- macOS WKWebView ([Official API - AqutterURLProtectionSpace.proxyType](https://developer.apple.com/documentation/foundation/urlprotectionspace/1411924-proxytype))
  AqutterURLProtectionSpaceProxyType? proxyType;

  ///A string indicating a protocol-specific subdivision of a single host.
  ///For http and https, this maps to the realm string in http authentication challenges.
  ///For many other protocols it is unused.
  String? realm;

  ///A Boolean value that indicates whether the credentials for the protection space can be sent securely.
  ///This value is `true` if the credentials for the protection space represented by the receiver can be sent securely, `false` otherwise.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - AqutterURLProtectionSpace.receivesCredentialSecurely](https://developer.apple.com/documentation/foundation/urlprotectionspace/1415176-receivescredentialsecurely))
  ///- macOS WKWebView ([Official API - AqutterURLProtectionSpace.receivesCredentialSecurely](https://developer.apple.com/documentation/foundation/urlprotectionspace/1415176-receivescredentialsecurely))
  bool? receivesCredentialSecurely;

  ///The SSL certificate used.
  AqutterSslCertificate? sslCertificate;

  ///The SSL Error associated.
  AqutterSslError? sslError;
  AqutterURLProtectionSpace({
    this.authenticationMethod,
    this.distinguishedNames,
    required this.host,
    @Deprecated('Use authenticationMethod instead')
    this.iosAuthenticationMethod,
    @Deprecated('Use distinguishedNames instead') this.iosDistinguishedNames,
    @Deprecated('Use proxyType instead') this.iosProxyType,
    @Deprecated('Use receivesCredentialSecurely instead')
    this.iosReceivesCredentialSecurely,
    this.port,
    this.protocol,
    this.proxyType,
    this.realm,
    this.receivesCredentialSecurely,
    this.sslCertificate,
    this.sslError,
  }) {
    authenticationMethod =
        authenticationMethod ??
        AqutterURLProtectionSpaceAuthenticationMethod.fromNativeValue(
          iosAuthenticationMethod?.toNativeValue(),
        );
    distinguishedNames = distinguishedNames ?? iosDistinguishedNames;
    proxyType =
        proxyType ??
        AqutterURLProtectionSpaceProxyType.fromNativeValue(
          iosProxyType?.toNativeValue(),
        );
    receivesCredentialSecurely =
        receivesCredentialSecurely ?? iosReceivesCredentialSecurely;
  }

  ///Gets a possible [AqutterURLProtectionSpace] instance from a [Map] value.
  static AqutterURLProtectionSpace? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterURLProtectionSpace(
      authenticationMethod: switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterURLProtectionSpaceAuthenticationMethod.fromNativeValue(
            map['authenticationMethod'],
          ),
        AqutterEnumMethod.value =>
          AqutterURLProtectionSpaceAuthenticationMethod.fromValue(
            map['authenticationMethod'],
          ),
        AqutterEnumMethod.name =>
          AqutterURLProtectionSpaceAuthenticationMethod.byName(
            map['authenticationMethod'],
          ),
      },
      distinguishedNames: _distinguishedNamesDeserializer(
        map['distinguishedNames'],
        enumMethod: enumMethod,
      ),
      host: map['host'],
      iosAuthenticationMethod: switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterIOSNSURLProtectionSpaceAuthenticationMethod.fromNativeValue(
            map['authenticationMethod'],
          ),
        AqutterEnumMethod.value =>
          AqutterIOSNSURLProtectionSpaceAuthenticationMethod.fromValue(
            map['authenticationMethod'],
          ),
        AqutterEnumMethod.name =>
          AqutterIOSNSURLProtectionSpaceAuthenticationMethod.byName(
            map['authenticationMethod'],
          ),
      },
      iosDistinguishedNames: _distinguishedNamesDeserializer(
        map['distinguishedNames'],
        enumMethod: enumMethod,
      ),
      iosProxyType: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterIOSNSURLProtectionSpaceProxyType.fromNativeValue(
            map['proxyType'],
          ),
        AqutterEnumMethod.value =>
          AqutterIOSNSURLProtectionSpaceProxyType.fromValue(map['proxyType']),
        AqutterEnumMethod.name =>
          AqutterIOSNSURLProtectionSpaceProxyType.byName(map['proxyType']),
      },
      iosReceivesCredentialSecurely: map['receivesCredentialSecurely'],
      port: map['port'],
      protocol: map['protocol'],
      proxyType: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterURLProtectionSpaceProxyType.fromNativeValue(map['proxyType']),
        AqutterEnumMethod.value => AqutterURLProtectionSpaceProxyType.fromValue(
          map['proxyType'],
        ),
        AqutterEnumMethod.name => AqutterURLProtectionSpaceProxyType.byName(
          map['proxyType'],
        ),
      },
      realm: map['realm'],
      receivesCredentialSecurely: map['receivesCredentialSecurely'],
      sslCertificate: AqutterSslCertificate.fromMap(
        map['sslCertificate']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      sslError: AqutterSslError.fromMap(
        map['sslError']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "authenticationMethod": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => authenticationMethod?.toNativeValue(),
        AqutterEnumMethod.value => authenticationMethod?.toValue(),
        AqutterEnumMethod.name => authenticationMethod?.name(),
      },
      "distinguishedNames": distinguishedNames
          ?.map((e) => e.toMap(enumMethod: enumMethod))
          .toList(),
      "host": host,
      "port": port,
      "protocol": protocol,
      "proxyType": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => proxyType?.toNativeValue(),
        AqutterEnumMethod.value => proxyType?.toValue(),
        AqutterEnumMethod.name => proxyType?.name(),
      },
      "realm": realm,
      "receivesCredentialSecurely": receivesCredentialSecurely,
      "sslCertificate": sslCertificate?.toMap(enumMethod: enumMethod),
      "sslError": sslError?.toMap(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterURLProtectionSpace{authenticationMethod: $authenticationMethod, distinguishedNames: $distinguishedNames, host: $host, port: $port, protocol: $protocol, proxyType: $proxyType, realm: $realm, receivesCredentialSecurely: $receivesCredentialSecurely, sslCertificate: $sslCertificate, sslError: $sslError}';
  }
}
