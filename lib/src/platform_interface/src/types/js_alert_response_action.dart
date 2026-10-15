import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'js_alert_response.dart';

part 'js_alert_response_action.g.dart';

///Class used by [AqutterJsAlertResponse] class.
@ExchangeableEnum()
class AqutterJsAlertResponseAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterJsAlertResponseAction_._internal(this._value);

  ///Confirm that the user hit confirm button.
  static const CONFIRM = const AqutterJsAlertResponseAction_._internal(0);
}
