// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_file_security_check_starting_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onSaveFileSecurityCheckStarting] event.
class AqutterSaveFileSecurityCheckStartingResponse {
  ///Whether to cancel the save operation.
  bool? cancelSave;

  ///Whether to suppress the default policy check.
  bool? suppressDefaultPolicy;
  AqutterSaveFileSecurityCheckStartingResponse({
    this.cancelSave,
    this.suppressDefaultPolicy,
  });

  ///Gets a possible [AqutterSaveFileSecurityCheckStartingResponse] instance from a [Map] value.
  static AqutterSaveFileSecurityCheckStartingResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterSaveFileSecurityCheckStartingResponse(
      cancelSave: map['cancelSave'],
      suppressDefaultPolicy: map['suppressDefaultPolicy'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "cancelSave": cancelSave,
      "suppressDefaultPolicy": suppressDefaultPolicy,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterSaveFileSecurityCheckStartingResponse{cancelSave: $cancelSave, suppressDefaultPolicy: $suppressDefaultPolicy}';
  }
}
