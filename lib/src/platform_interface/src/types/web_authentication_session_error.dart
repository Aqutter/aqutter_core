import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'web_authentication_session_error.g.dart';

///Class that represents the error code for a web authentication session error.
@ExchangeableEnum()
class AqutterWebAuthenticationSessionError_ {
  // ignore: unused_field
  final int _value;
  const AqutterWebAuthenticationSessionError_._internal(this._value);

  ///The login has been canceled.
  static const CANCELED_LOGIN = AqutterWebAuthenticationSessionError_._internal(1);

  ///A context wasn’t provided.
  static const PRESENTATION_CONTEXT_NOT_PROVIDED =
      AqutterWebAuthenticationSessionError_._internal(2);

  ///The context was invalid.
  static const PRESENTATION_CONTEXT_INVALID =
      AqutterWebAuthenticationSessionError_._internal(3);
}
