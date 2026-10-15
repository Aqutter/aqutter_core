import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'js_prompt_response.dart';

part 'js_prompt_response_action.g.dart';

///Class used by [AqutterJsPromptResponse] class.
@ExchangeableEnum()
class AqutterJsPromptResponseAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterJsPromptResponseAction_._internal(this._value);

  ///Confirm that the user hit confirm button.
  static const CONFIRM = const AqutterJsPromptResponseAction_._internal(0);

  ///Confirm that the user hit cancel button.
  static const CANCEL = const AqutterJsPromptResponseAction_._internal(1);
}
