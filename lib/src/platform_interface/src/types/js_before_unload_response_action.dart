import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'js_before_unload_response.dart';

part 'js_before_unload_response_action.g.dart';

///Class used by [AqutterJsBeforeUnloadResponse] class.
@ExchangeableEnum()
class AqutterJsBeforeUnloadResponseAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterJsBeforeUnloadResponseAction_._internal(this._value);

  ///Confirm that the user hit confirm button.
  static const CONFIRM = const AqutterJsBeforeUnloadResponseAction_._internal(0);

  ///Confirm that the user hit cancel button.
  static const CANCEL = const AqutterJsBeforeUnloadResponseAction_._internal(1);
}
