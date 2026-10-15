// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launching_external_uri_scheme_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onLaunchingExternalUriScheme] event.
class AqutterLaunchingExternalUriSchemeResponse {
  ///Set to `true` to cancel the external URI scheme launch.
  bool cancel;
  AqutterLaunchingExternalUriSchemeResponse({required this.cancel});

  ///Gets a possible [AqutterLaunchingExternalUriSchemeResponse] instance from a [Map] value.
  static AqutterLaunchingExternalUriSchemeResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterLaunchingExternalUriSchemeResponse(
      cancel: map['cancel'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"cancel": cancel};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterLaunchingExternalUriSchemeResponse{cancel: $cancel}';
  }
}
