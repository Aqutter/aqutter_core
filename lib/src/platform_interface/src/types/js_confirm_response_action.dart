import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'js_confirm_response.dart';

part 'js_confirm_response_action.g.dart';

///Class used by [AqutterJsConfirmResponse] class.
@ExchangeableEnum()
class AqutterJsConfirmResponseAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterJsConfirmResponseAction_._internal(this._value);

  ///Confirm that the user hit confirm button.
  static const CONFIRM = const AqutterJsConfirmResponseAction_._internal(0);

  ///Confirm that the user hit cancel button.
  static const CANCEL = const AqutterJsConfirmResponseAction_._internal(1);
}
