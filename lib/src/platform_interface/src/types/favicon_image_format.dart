import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'favicon_image_format.g.dart';

///Constants that describe the favicon image format.
@ExchangeableEnum()
class AqutterFaviconImageFormat_ {
  // ignore: unused_field
  final int _value;
  const AqutterFaviconImageFormat_._internal(this._value);

  ///PNG image format.
  static const PNG = AqutterFaviconImageFormat_._internal(0);

  ///JPEG image format.
  static const JPEG = AqutterFaviconImageFormat_._internal(1);
}
