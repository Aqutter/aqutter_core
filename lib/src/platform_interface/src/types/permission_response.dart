import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import 'permission_resource_type.dart';
import 'permission_response_action.dart';
import 'enum_method.dart';

part 'permission_response.g.dart';

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onPermissionRequest] event.
@ExchangeableObject()
class AqutterPermissionResponse_ {
  ///Resources granted to be accessed by origin.
  ///
  ///**NOTE for iOS, macOS and Windows**: not used. The [action] taken is based on the [AqutterPermissionRequest.resources].
  List<AqutterPermissionResourceType_> resources;

  ///Indicate the [AqutterPermissionResponseAction] to take in response of a permission request.
  AqutterPermissionResponseAction_? action;

  AqutterPermissionResponse_({
    this.resources = const [],
    this.action = AqutterPermissionResponseAction_.DENY,
  });
}

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.androidOnPermissionRequest] event.
///Use [AqutterPermissionResponse] instead.
@Deprecated("Use AqutterPermissionResponse instead")
@ExchangeableObject()
class AqutterPermissionRequestResponse_ {
  ///Resources granted to be accessed by origin.
  List<String> resources;

  ///Indicate the [AqutterPermissionRequestResponseAction] to take in response of a permission request.
  AqutterPermissionRequestResponseAction_? action;

  AqutterPermissionRequestResponse_({
    this.resources = const [],
    this.action = AqutterPermissionRequestResponseAction_.DENY,
  });
}
