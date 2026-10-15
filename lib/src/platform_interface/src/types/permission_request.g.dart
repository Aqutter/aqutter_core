// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onPermissionRequest] event.
class AqutterPermissionRequest {
  ///The frame that initiates the request in the web view.
  AqutterFrameInfo? frame;

  ///The origin of web content which attempt to access the restricted resources.
  AqutterWebUri origin;

  ///List of resources the web content wants to access.
  ///
  ///**NOTE for iOS, macOS and Windows**: this list will have only 1 element and will be used by the [AqutterPermissionResponse.action]
  ///as the resource to consider when applying the corresponding action.
  List<AqutterPermissionResourceType> resources;
  AqutterPermissionRequest({
    this.frame,
    required this.origin,
    this.resources = const [],
  });

  ///Gets a possible [AqutterPermissionRequest] instance from a [Map] value.
  static AqutterPermissionRequest? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterPermissionRequest(
      frame: AqutterFrameInfo.fromMap(
        map['frame']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      origin: AqutterWebUri(map['origin']),
    );
    if (map['resources'] != null) {
      instance.resources = List<AqutterPermissionResourceType>.from(
        map['resources'].map(
          (e) => switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
            AqutterEnumMethod.nativeValue =>
              AqutterPermissionResourceType.fromNativeValue(e),
            AqutterEnumMethod.value => AqutterPermissionResourceType.fromValue(
              e,
            ),
            AqutterEnumMethod.name => AqutterPermissionResourceType.byName(e),
          }!,
        ),
      );
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "frame": frame?.toMap(enumMethod: enumMethod),
      "origin": origin.toString(),
      "resources": resources
          .map(
            (e) => switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
              AqutterEnumMethod.nativeValue => e.toNativeValue(),
              AqutterEnumMethod.value => e.toValue(),
              AqutterEnumMethod.name => e.name(),
            },
          )
          .toList(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterPermissionRequest{frame: $frame, origin: $origin, resources: $resources}';
  }
}
