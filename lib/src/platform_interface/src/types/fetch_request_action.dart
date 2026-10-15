import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'fetch_request.dart';

part 'fetch_request_action.g.dart';

///Class used by [AqutterFetchRequest] class.
@ExchangeableEnum()
class AqutterFetchRequestAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterFetchRequestAction_._internal(this._value);

  ///Aborts the fetch request.
  static const ABORT = const AqutterFetchRequestAction_._internal(0);

  ///Proceeds with the fetch request.
  static const PROCEED = const AqutterFetchRequestAction_._internal(1);
}
