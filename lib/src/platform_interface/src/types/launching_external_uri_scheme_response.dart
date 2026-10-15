import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'enum_method.dart';

part 'launching_external_uri_scheme_response.g.dart';

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onLaunchingExternalUriScheme] event.
@ExchangeableObject()
class AqutterLaunchingExternalUriSchemeResponse_ {
  ///Set to `true` to cancel the external URI scheme launch.
  bool cancel;

  AqutterLaunchingExternalUriSchemeResponse_({required this.cancel});
}
