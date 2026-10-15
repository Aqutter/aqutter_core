// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onPermissionRequest] event.
class AqutterPermissionResponse {
  ///Indicate the [AqutterPermissionResponseAction] to take in response of a permission request.
  AqutterPermissionResponseAction? action;

  ///Resources granted to be accessed by origin.
  ///
  ///**NOTE for iOS, macOS and Windows**: not used. The [action] taken is based on the [AqutterPermissionRequest.resources].
  List<AqutterPermissionResourceType> resources;
  AqutterPermissionResponse({
    AqutterPermissionResponseAction? action,
    this.resources = const [],
  }) : action = action ?? AqutterPermissionResponseAction.DENY;

  ///Gets a possible [AqutterPermissionResponse] instance from a [Map] value.
  static AqutterPermissionResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterPermissionResponse();
    instance.action = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterPermissionResponseAction.fromNativeValue(map['action']),
      AqutterEnumMethod.value => AqutterPermissionResponseAction.fromValue(
        map['action'],
      ),
      AqutterEnumMethod.name => AqutterPermissionResponseAction.byName(
        map['action'],
      ),
    };
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
      "action": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => action?.toNativeValue(),
        AqutterEnumMethod.value => action?.toValue(),
        AqutterEnumMethod.name => action?.name(),
      },
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
    return 'AqutterPermissionResponse{action: $action, resources: $resources}';
  }
}

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.androidOnPermissionRequest] event.
///Use [AqutterPermissionResponse] instead.
@Deprecated('Use AqutterPermissionResponse instead')
class AqutterPermissionRequestResponse {
  ///Indicate the [AqutterPermissionRequestResponseAction] to take in response of a permission request.
  AqutterPermissionRequestResponseAction? action;

  ///Resources granted to be accessed by origin.
  List<String> resources;
  AqutterPermissionRequestResponse({
    AqutterPermissionRequestResponseAction? action,
    this.resources = const [],
  }) : action = action ?? AqutterPermissionRequestResponseAction.DENY;

  ///Gets a possible [AqutterPermissionRequestResponse] instance from a [Map] value.
  static AqutterPermissionRequestResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterPermissionRequestResponse();
    instance.action = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterPermissionRequestResponseAction.fromNativeValue(map['action']),
      AqutterEnumMethod.value =>
        AqutterPermissionRequestResponseAction.fromValue(map['action']),
      AqutterEnumMethod.name => AqutterPermissionRequestResponseAction.byName(
        map['action'],
      ),
    };
    if (map['resources'] != null) {
      instance.resources = List<String>.from(map['resources']!.cast<String>());
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "action": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => action?.toNativeValue(),
        AqutterEnumMethod.value => action?.toValue(),
        AqutterEnumMethod.name => action?.name(),
      },
      "resources": resources,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterPermissionRequestResponse{action: $action, resources: $resources}';
  }
}
