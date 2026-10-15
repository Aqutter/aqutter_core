import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'enum_method.dart';

part 'screen_capture_starting_response.g.dart';

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onScreenCaptureStarting] event.
@ExchangeableObject()
class AqutterScreenCaptureStartingResponse_ {
  ///Whether to cancel the screen capture.
  bool? cancel;

  ///Whether the event has been handled.
  bool? handled;

  AqutterScreenCaptureStartingResponse_({this.cancel, this.handled});
}
