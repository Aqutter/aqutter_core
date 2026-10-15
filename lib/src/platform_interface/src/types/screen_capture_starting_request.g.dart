// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_capture_starting_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the request used by the [AqutterPlatformWebViewCreationParams.onScreenCaptureStarting] event.
class AqutterScreenCaptureStartingRequest {
  ///Whether to cancel the screen capture.
  bool? cancel;

  ///The frame that requests screen capture.
  AqutterFrameInfo? frame;

  ///Whether the event has been handled.
  bool? handled;
  AqutterScreenCaptureStartingRequest({this.cancel, this.frame, this.handled});

  ///Gets a possible [AqutterScreenCaptureStartingRequest] instance from a [Map] value.
  static AqutterScreenCaptureStartingRequest? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterScreenCaptureStartingRequest(
      cancel: map['cancel'],
      frame: AqutterFrameInfo.fromMap(
        map['frame']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      handled: map['handled'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "cancel": cancel,
      "frame": frame?.toMap(enumMethod: enumMethod),
      "handled": handled,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterScreenCaptureStartingRequest{cancel: $cancel, frame: $frame, handled: $handled}';
  }
}
