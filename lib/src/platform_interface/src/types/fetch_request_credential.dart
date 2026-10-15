import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'fetch_request_credential_default.dart';
import 'fetch_request_federated_credential.dart';
import 'fetch_request_password_credential.dart';
import 'enum_method.dart';

part 'fetch_request_credential.g.dart';

///Class that is an interface for [AqutterFetchRequestCredentialDefault], [AqutterFetchRequestFederatedCredential] and [AqutterFetchRequestPasswordCredential] classes.
@ExchangeableObject()
class AqutterFetchRequestCredential_ {
  ///Type of credentials.
  String? type;

  AqutterFetchRequestCredential_({this.type});
}
