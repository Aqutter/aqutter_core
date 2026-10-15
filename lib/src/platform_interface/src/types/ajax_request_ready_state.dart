import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'ajax_request.dart';

part 'ajax_request_ready_state.g.dart';

///Class used by [AqutterAjaxRequest] class. It represents the state of an [AqutterAjaxRequest].
@ExchangeableEnum()
class AqutterAjaxRequestReadyState_ {
  // ignore: unused_field
  final int _value;
  const AqutterAjaxRequestReadyState_._internal(this._value);

  ///Client has been created. `XMLHttpRequest.open()` not called yet.
  static const UNSENT = const AqutterAjaxRequestReadyState_._internal(0);

  ///`XMLHttpRequest.open()` has been called.
  static const OPENED = const AqutterAjaxRequestReadyState_._internal(1);

  ///`XMLHttpRequest.send()` has been called, and [AqutterAjaxRequest.headers] and [AqutterAjaxRequest.status] are available.
  static const HEADERS_RECEIVED = const AqutterAjaxRequestReadyState_._internal(2);

  ///Downloading; [AqutterAjaxRequest.responseText] holds partial data.
  static const LOADING = const AqutterAjaxRequestReadyState_._internal(3);

  ///The operation is complete.
  static const DONE = const AqutterAjaxRequestReadyState_._internal(4);
}
