import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../print_job/main.dart';

part 'print_job_dialog_kind.g.dart';

///Class representing the print dialog kind used by a [AqutterPlatformPrintJobController].
@ExchangeableEnum()
class AqutterPrintJobDialogKind_ {
  // ignore: unused_field
  final int _value;
  const AqutterPrintJobDialogKind_._internal(this._value);

  ///Use the browser print dialog UI.
  static const BROWSER = AqutterPrintJobDialogKind_._internal(0);

  ///Use the system print dialog UI.
  static const SYSTEM = AqutterPrintJobDialogKind_._internal(1);
}
