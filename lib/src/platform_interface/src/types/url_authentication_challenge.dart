import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'url_protection_space.dart';
import 'enum_method.dart';

part 'url_authentication_challenge.g.dart';

///Class that represents a challenge from a server requiring authentication from the client.
///It provides all the information about the challenge.
@ExchangeableObject()
class AqutterURLAuthenticationChallenge_ {
  ///The protection space requiring authentication.
  AqutterURLProtectionSpace_ protectionSpace;

  AqutterURLAuthenticationChallenge_({required this.protectionSpace});
}
