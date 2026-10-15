import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'ajax_request.dart';

part 'ajax_request_action.g.dart';

///Class used by [AqutterAjaxRequest] class.
@ExchangeableEnum()
class AqutterAjaxRequestAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterAjaxRequestAction_._internal(this._value);

  ///Aborts the current [AqutterAjaxRequest].
  static const ABORT = const AqutterAjaxRequestAction_._internal(0);

  ///Proceeds with the current [AqutterAjaxRequest].
  static const PROCEED = const AqutterAjaxRequestAction_._internal(1);
}
