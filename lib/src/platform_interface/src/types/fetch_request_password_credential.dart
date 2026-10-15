import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../web_uri.dart';
import 'fetch_request_credential.dart';
import 'enum_method.dart';

part 'fetch_request_password_credential.g.dart';

///Class that represents a [PasswordCredential](https://developer.mozilla.org/en-US/docs/Web/API/PasswordCredential) type of credentials.
@ExchangeableObject()
class AqutterFetchRequestPasswordCredential_ extends AqutterFetchRequestCredential_ {
  ///Credential's identifier.
  dynamic id;

  ///The name associated with a credential. It should be a human-readable, public name.
  String? name;

  ///The password of the credential.
  String? password;

  ///URL pointing to an image for an icon. This image is intended for display in a credential chooser. The URL must be accessible without authentication.
  AqutterWebUri? iconURL;

  AqutterFetchRequestPasswordCredential_({
    type,
    this.id,
    this.name,
    this.password,
    this.iconURL,
  }) : super(type: type);
}
