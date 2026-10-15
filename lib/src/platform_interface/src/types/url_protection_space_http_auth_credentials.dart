import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'url_protection_space.dart';
import 'url_credential.dart';
import '../platform_http_auth_credentials_database.dart';
import 'enum_method.dart';

part 'url_protection_space_http_auth_credentials.g.dart';

///Class that represents a [AqutterURLProtectionSpace] with all of its [AqutterURLCredential]s.
///It used by [AqutterPlatformHttpAuthCredentialDatabase.getAllAuthCredentials].
@ExchangeableObject()
class AqutterURLProtectionSpaceHttpAuthCredentials_ {
  ///The protection space.
  AqutterURLProtectionSpace_? protectionSpace;

  ///The list of all its http authentication credentials.
  List<AqutterURLCredential_>? credentials;

  AqutterURLProtectionSpaceHttpAuthCredentials_({
    this.protectionSpace,
    this.credentials,
  });
}
