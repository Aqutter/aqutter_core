import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'enum_method.dart';

part 'security_origin.g.dart';

///An object that identifies the origin of a particular resource.
@ExchangeableObject()
class AqutterSecurityOrigin_ {
  ///The security origin’s host.
  String host;

  ///The security origin's port.
  int port;

  ///The security origin's protocol.
  String protocol;

  AqutterSecurityOrigin_({
    required this.host,
    required this.port,
    required this.protocol,
  });
}

///An object that identifies the origin of a particular resource.
///
///**NOTE**: available only on iOS 9.0+.
///
///Use [AqutterSecurityOrigin] instead.
@Deprecated("Use AqutterSecurityOrigin instead")
@ExchangeableObject()
class AqutterIOSWKSecurityOrigin_ {
  ///The security origin’s host.
  String host;

  ///The security origin's port.
  int port;

  ///The security origin's protocol.
  String protocol;

  AqutterIOSWKSecurityOrigin_({
    required this.host,
    required this.port,
    required this.protocol,
  });
}
