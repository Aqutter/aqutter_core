import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import '../webview/platform_webview.dart';
part 'form_resubmission_action.g.dart';

///Class that represents the action to take used by the [AqutterPlatformWebViewCreationParams.onFormResubmission] event.
@ExchangeableEnum()
class AqutterFormResubmissionAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterFormResubmissionAction_._internal(this._value);

  ///Resend data
  static const RESEND = const AqutterFormResubmissionAction_._internal(0);

  ///Don't resend data
  static const DONT_RESEND = const AqutterFormResubmissionAction_._internal(1);
}
