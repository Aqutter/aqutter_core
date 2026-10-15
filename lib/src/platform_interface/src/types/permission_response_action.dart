import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'permission_response.dart';

part 'permission_response_action.g.dart';

///Class used by [AqutterPermissionResponse] class.
@ExchangeableEnum()
class AqutterPermissionResponseAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterPermissionResponseAction_._internal(this._value);

  ///Denies the request.
  static const DENY = const AqutterPermissionResponseAction_._internal(0);

  ///Grants origin the permission to access the given resources.
  static const GRANT = const AqutterPermissionResponseAction_._internal(1);

  ///Prompt the user for permission for the requested resource.
  static const PROMPT = const AqutterPermissionResponseAction_._internal(2);
}

///Class used by [AqutterPermissionRequestResponse] class.
///Use [AqutterPermissionResponseAction] instead.
@Deprecated("Use AqutterPermissionResponseAction instead")
@ExchangeableEnum()
class AqutterPermissionRequestResponseAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterPermissionRequestResponseAction_._internal(this._value);

  ///Denies the request.
  static const DENY = const AqutterPermissionRequestResponseAction_._internal(0);

  ///Grants origin the permission to access the given resources.
  static const GRANT = const AqutterPermissionRequestResponseAction_._internal(1);
}
