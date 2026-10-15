import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../web_uri.dart';
import 'enum_method.dart';

part 'launching_external_uri_scheme_request.g.dart';

///Class that represents the request used by the [AqutterPlatformWebViewCreationParams.onLaunchingExternalUriScheme] event.
@ExchangeableObject()
class AqutterLaunchingExternalUriSchemeRequest_ {
  ///The URI with the external URI scheme to be launched.
  AqutterWebUri uri;

  ///The origin initiating the external URI scheme launch.
  AqutterWebUri? initiatingOrigin;

  ///Whether the external URI scheme request was initiated through a user gesture.
  bool? isUserInitiated;

  AqutterLaunchingExternalUriSchemeRequest_({
    required this.uri,
    this.initiatingOrigin,
    this.isUserInitiated,
  });
}
