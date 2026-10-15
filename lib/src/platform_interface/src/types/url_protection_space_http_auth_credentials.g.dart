// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_protection_space_http_auth_credentials.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents a [AqutterURLProtectionSpace] with all of its [AqutterURLCredential]s.
///It used by [AqutterPlatformHttpAuthCredentialDatabase.getAllAuthCredentials].
class AqutterURLProtectionSpaceHttpAuthCredentials {
  ///The list of all its http authentication credentials.
  List<AqutterURLCredential>? credentials;

  ///The protection space.
  AqutterURLProtectionSpace? protectionSpace;
  AqutterURLProtectionSpaceHttpAuthCredentials({
    this.credentials,
    this.protectionSpace,
  });

  ///Gets a possible [AqutterURLProtectionSpaceHttpAuthCredentials] instance from a [Map] value.
  static AqutterURLProtectionSpaceHttpAuthCredentials? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterURLProtectionSpaceHttpAuthCredentials(
      credentials: map['credentials'] != null
          ? List<AqutterURLCredential>.from(
              map['credentials'].map(
                (e) => AqutterURLCredential.fromMap(
                  e?.cast<String, dynamic>(),
                  enumMethod: enumMethod,
                )!,
              ),
            )
          : null,
      protectionSpace: AqutterURLProtectionSpace.fromMap(
        map['protectionSpace']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "credentials": credentials
          ?.map((e) => e.toMap(enumMethod: enumMethod))
          .toList(),
      "protectionSpace": protectionSpace?.toMap(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterURLProtectionSpaceHttpAuthCredentials{credentials: $credentials, protectionSpace: $protectionSpace}';
  }
}
