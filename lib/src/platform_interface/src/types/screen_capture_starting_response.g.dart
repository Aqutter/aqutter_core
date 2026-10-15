// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_capture_starting_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onScreenCaptureStarting] event.
class AqutterScreenCaptureStartingResponse {
  ///Whether to cancel the screen capture.
  bool? cancel;

  ///Whether the event has been handled.
  bool? handled;
  AqutterScreenCaptureStartingResponse({this.cancel, this.handled});

  ///Gets a possible [AqutterScreenCaptureStartingResponse] instance from a [Map] value.
  static AqutterScreenCaptureStartingResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterScreenCaptureStartingResponse(
      cancel: map['cancel'],
      handled: map['handled'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"cancel": cancel, "handled": handled};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterScreenCaptureStartingResponse{cancel: $cancel, handled: $handled}';
  }
}
