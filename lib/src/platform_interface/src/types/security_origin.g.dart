// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_origin.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///An object that identifies the origin of a particular resource.
class AqutterSecurityOrigin {
  ///The security origin’s host.
  String host;

  ///The security origin's port.
  int port;

  ///The security origin's protocol.
  String protocol;
  AqutterSecurityOrigin({
    required this.host,
    required this.port,
    required this.protocol,
  });

  ///Gets a possible [AqutterSecurityOrigin] instance from a [Map] value.
  static AqutterSecurityOrigin? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterSecurityOrigin(
      host: map['host'],
      port: map['port'],
      protocol: map['protocol'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"host": host, "port": port, "protocol": protocol};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterSecurityOrigin{host: $host, port: $port, protocol: $protocol}';
  }
}

///An object that identifies the origin of a particular resource.
///
///**NOTE**: available only on iOS 9.0+.
///
///Use [AqutterSecurityOrigin] instead.
@Deprecated('Use AqutterSecurityOrigin instead')
class AqutterIOSWKSecurityOrigin {
  ///The security origin’s host.
  String host;

  ///The security origin's port.
  int port;

  ///The security origin's protocol.
  String protocol;
  AqutterIOSWKSecurityOrigin({
    required this.host,
    required this.port,
    required this.protocol,
  });

  ///Gets a possible [AqutterIOSWKSecurityOrigin] instance from a [Map] value.
  static AqutterIOSWKSecurityOrigin? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterIOSWKSecurityOrigin(
      host: map['host'],
      port: map['port'],
      protocol: map['protocol'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"host": host, "port": port, "protocol": protocol};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterIOSWKSecurityOrigin{host: $host, port: $port, protocol: $protocol}';
  }
}
