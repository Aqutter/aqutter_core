import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'url_authentication_challenge.dart';
import 'url_protection_space.dart';
import 'enum_method.dart';

part 'server_trust_challenge.g.dart';

///Class that represents the challenge of the [AqutterPlatformWebViewCreationParams.onReceivedServerTrustAuthRequest] event.
///It provides all the information about the challenge.
@ExchangeableObject()
class AqutterServerTrustChallenge_ extends AqutterURLAuthenticationChallenge_ {
  AqutterServerTrustChallenge_({required AqutterURLProtectionSpace_ protectionSpace})
    : super(protectionSpace: protectionSpace);
}
