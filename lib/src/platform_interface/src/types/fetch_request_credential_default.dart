import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'fetch_request.dart';
import 'fetch_request_credential.dart';
import 'enum_method.dart';

part 'fetch_request_credential_default.g.dart';

///Class that represents the default credentials used by an [AqutterFetchRequest].
@ExchangeableObject()
class AqutterFetchRequestCredentialDefault_ extends AqutterFetchRequestCredential_ {
  ///The value of the credentials.
  String? value;

  AqutterFetchRequestCredentialDefault_({type, this.value}) : super(type: type);
}
