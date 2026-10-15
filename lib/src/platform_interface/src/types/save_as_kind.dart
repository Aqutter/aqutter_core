import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'save_as_kind.g.dart';

///Constants that describe the Save As kind.
@ExchangeableEnum()
class AqutterSaveAsKind_ {
  // ignore: unused_field
  final int _value;
  const AqutterSaveAsKind_._internal(this._value);

  ///Default kind to save non-HTML content.
  static const DEFAULT = AqutterSaveAsKind_._internal(0);

  ///Save the page as HTML only.
  static const HTML_ONLY = AqutterSaveAsKind_._internal(1);

  ///Save the page as a single file (MHTML).
  static const SINGLE_FILE = AqutterSaveAsKind_._internal(2);

  ///Save the page with a resources directory.
  static const COMPLETE = AqutterSaveAsKind_._internal(3);
}
