import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'attributed_string_text_effect_style.g.dart';

///Class that represents the supported proxy types.
@ExchangeableEnum()
class AqutterAttributedStringTextEffectStyle_ {
  // ignore: unused_field
  final String _value;
  const AqutterAttributedStringTextEffectStyle_._internal(this._value);

  ///A graphical text effect that gives glyphs the appearance of letterpress printing, which involves pressing the type into the paper.
  static const LETTERPRESS_STYLE =
      const AqutterAttributedStringTextEffectStyle_._internal("letterpressStyle");
}

///An iOS-specific Class that represents the supported proxy types.
///Use [AqutterAttributedStringTextEffectStyle] instead.
@Deprecated("Use AqutterAttributedStringTextEffectStyle instead")
@ExchangeableEnum()
class AqutterIOSNSAttributedStringTextEffectStyle_ {
  // ignore: unused_field
  final String _value;
  const AqutterIOSNSAttributedStringTextEffectStyle_._internal(this._value);

  ///A graphical text effect that gives glyphs the appearance of letterpress printing, which involves pressing the type into the paper.
  static const LETTERPRESS_STYLE =
      const AqutterIOSNSAttributedStringTextEffectStyle_._internal("letterpressStyle");
}
