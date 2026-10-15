import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'frame_info.dart';
import 'enum_method.dart';

part 'screen_capture_starting_request.g.dart';

///Class that represents the request used by the [AqutterPlatformWebViewCreationParams.onScreenCaptureStarting] event.
@ExchangeableObject()
class AqutterScreenCaptureStartingRequest_ {
  ///The frame that requests screen capture.
  AqutterFrameInfo_? frame;

  ///Whether to cancel the screen capture.
  bool? cancel;

  ///Whether the event has been handled.
  bool? handled;

  AqutterScreenCaptureStartingRequest_({this.frame, this.cancel, this.handled});
}
