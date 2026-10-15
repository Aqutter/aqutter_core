// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_credential.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents an authentication credential consisting of information
///specific to the type of credential and the type of persistent storage to use, if any.
class AqutterURLCredential {
  ///The intermediate certificates of the credential, if it is a client certificate credential.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  List<AqutterX509Certificate>? certificates;

  ///Use [certificates] instead.
  @Deprecated('Use certificates instead')
  List<AqutterX509Certificate>? iosCertificates;

  ///Use [persistence] instead.
  @Deprecated('Use persistence instead')
  AqutterIOSURLCredentialPersistence? iosPersistence;

  ///The credential’s password.
  String? password;

  ///The credential’s persistence setting.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  AqutterURLCredentialPersistence? persistence;

  ///The credential’s user name.
  String? username;
  AqutterURLCredential({
    this.certificates,
    @Deprecated('Use certificates instead') this.iosCertificates,
    @Deprecated('Use persistence instead') this.iosPersistence,
    this.password,
    this.persistence,
    this.username,
  }) {
    certificates = certificates ?? iosCertificates;
    persistence =
        persistence ??
        AqutterURLCredentialPersistence.fromNativeValue(
          iosPersistence?.toNativeValue(),
        );
  }

  ///Gets a possible [AqutterURLCredential] instance from a [Map] value.
  static AqutterURLCredential? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterURLCredential(
      certificates: _certificatesDeserializer(
        map['certificates'],
        enumMethod: enumMethod,
      ),
      iosCertificates: _certificatesDeserializer(
        map['certificates'],
        enumMethod: enumMethod,
      ),
      iosPersistence: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterIOSURLCredentialPersistence.fromNativeValue(
            map['persistence'],
          ),
        AqutterEnumMethod.value => AqutterIOSURLCredentialPersistence.fromValue(
          map['persistence'],
        ),
        AqutterEnumMethod.name => AqutterIOSURLCredentialPersistence.byName(
          map['persistence'],
        ),
      },
      password: map['password'],
      persistence: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterURLCredentialPersistence.fromNativeValue(map['persistence']),
        AqutterEnumMethod.value => AqutterURLCredentialPersistence.fromValue(
          map['persistence'],
        ),
        AqutterEnumMethod.name => AqutterURLCredentialPersistence.byName(
          map['persistence'],
        ),
      },
      username: map['username'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "certificates": certificates
          ?.map((e) => e.toMap(enumMethod: enumMethod))
          .toList(),
      "password": password,
      "persistence": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => persistence?.toNativeValue(),
        AqutterEnumMethod.value => persistence?.toValue(),
        AqutterEnumMethod.name => persistence?.name(),
      },
      "username": username,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterURLCredential{certificates: $certificates, password: $password, persistence: $persistence, username: $username}';
  }
}
