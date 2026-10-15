import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'save_as_ui_result.g.dart';

///Constants that describe the result of a programmatic Save As call.
@ExchangeableEnum()
class AqutterSaveAsUIResult_ {
  // ignore: unused_field
  final int _value;
  const AqutterSaveAsUIResult_._internal(this._value);

  ///The Save As operation completed successfully.
  static const SUCCESS = AqutterSaveAsUIResult_._internal(0);

  ///The destination file path is invalid.
  static const INVALID_PATH = AqutterSaveAsUIResult_._internal(1);

  ///The destination file path already exists.
  static const FILE_ALREADY_EXISTS = AqutterSaveAsUIResult_._internal(2);

  ///The selected Save As kind is not supported.
  static const KIND_NOT_SUPPORTED = AqutterSaveAsUIResult_._internal(3);

  ///The user cancelled the Save As operation.
  static const CANCELLED = AqutterSaveAsUIResult_._internal(4);
}
