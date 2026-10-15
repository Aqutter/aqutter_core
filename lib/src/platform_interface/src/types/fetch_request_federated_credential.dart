import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../web_uri.dart';
import 'fetch_request_credential.dart';
import 'enum_method.dart';

part 'fetch_request_federated_credential.g.dart';

///Class that represents a [FederatedCredential](https://developer.mozilla.org/en-US/docs/Web/API/FederatedCredential) type of credentials.
@ExchangeableObject()
class AqutterFetchRequestFederatedCredential_ extends AqutterFetchRequestCredential_ {
  ///Credential's identifier.
  dynamic id;

  ///The name associated with a credential. It should be a human-readable, public name.
  String? name;

  ///Credential's federated identity protocol.
  String? protocol;

  ///Credential's federated identity provider.
  String? provider;

  ///URL pointing to an image for an icon. This image is intended for display in a credential chooser. The URL must be accessible without authentication.
  AqutterWebUri? iconURL;

  AqutterFetchRequestFederatedCredential_({
    type,
    this.id,
    this.name,
    this.protocol,
    this.provider,
    this.iconURL,
  }) : super(type: type);
}
