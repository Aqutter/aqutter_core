// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launching_external_uri_scheme_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the request used by the [AqutterPlatformWebViewCreationParams.onLaunchingExternalUriScheme] event.
class AqutterLaunchingExternalUriSchemeRequest {
  ///The origin initiating the external URI scheme launch.
  AqutterWebUri? initiatingOrigin;

  ///Whether the external URI scheme request was initiated through a user gesture.
  bool? isUserInitiated;

  ///The URI with the external URI scheme to be launched.
  AqutterWebUri uri;
  AqutterLaunchingExternalUriSchemeRequest({
    this.initiatingOrigin,
    this.isUserInitiated,
    required this.uri,
  });

  ///Gets a possible [AqutterLaunchingExternalUriSchemeRequest] instance from a [Map] value.
  static AqutterLaunchingExternalUriSchemeRequest? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterLaunchingExternalUriSchemeRequest(
      initiatingOrigin: map['initiatingOrigin'] != null
          ? AqutterWebUri(map['initiatingOrigin'])
          : null,
      isUserInitiated: map['isUserInitiated'],
      uri: AqutterWebUri(map['uri']),
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "initiatingOrigin": initiatingOrigin?.toString(),
      "isUserInitiated": isUserInitiated,
      "uri": uri.toString(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterLaunchingExternalUriSchemeRequest{initiatingOrigin: $initiatingOrigin, isUserInitiated: $isUserInitiated, uri: $uri}';
  }
}
