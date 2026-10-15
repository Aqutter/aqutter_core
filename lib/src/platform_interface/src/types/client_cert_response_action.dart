import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'client_cert_response.dart';

part 'client_cert_response_action.g.dart';

///Class used by [AqutterClientCertResponse] class.
@ExchangeableEnum()
class AqutterClientCertResponseAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterClientCertResponseAction_._internal(this._value);

  ///Cancel this request.
  static const CANCEL = const AqutterClientCertResponseAction_._internal(0);

  ///Proceed with the specified certificate.
  static const PROCEED = const AqutterClientCertResponseAction_._internal(1);

  ///Ignore the request for now.
  static const IGNORE = const AqutterClientCertResponseAction_._internal(2);
}
