// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributed_string.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents a string with associated attributes
///used by the [AqutterPlatformPullToRefreshController] and [AqutterPullToRefreshSettings] classes.
class AqutterAttributedString {
  ///The color of the background behind the text.
  ///
  ///The value of this attribute is a [Color] object.
  ///Use this attribute to specify the color of the background area behind the text.
  ///If you do not specify this attribute, no background color is drawn.
  Color? backgroundColor;

  ///The vertical offset for the position of the text.
  ///
  ///The value of this attribute is a number containing a floating point value indicating the character’s offset from the baseline, in points.
  ///The default value is `0`.
  double? baselineOffset;

  ///The expansion factor of the text.
  ///
  ///The value of this attribute is a number containing a floating point value indicating the log of the expansion factor to be applied to glyphs.
  ///The default value is `0`, indicating no expansion.
  double? expansion;

  ///The color of the text.
  ///
  ///The value of this attribute is a [Color] object.
  ///Use this attribute to specify the color of the text during rendering.
  ///If you do not specify this attribute, the text is rendered in black.
  Color? foregroundColor;

  ///The kerning of the text.
  ///
  ///The value of this attribute is a number containing a floating-point value.
  ///This value specifies the number of points by which to adjust kern-pair characters.
  ///Kerning prevents unwanted space from occurring between specific characters and depends on the font.
  ///The value `0` means kerning is disabled. The default value for this attribute is `0`.
  double? kern;

  ///The ligature of the text.
  ///
  ///The value of this attribute is a number containing an integer.
  ///Ligatures cause specific character combinations to be rendered using a single custom glyph that corresponds to those characters.
  ///The value `0` indicates no ligatures. The value `1` indicates the use of the default ligatures.
  ///The value `2` indicates the use of all ligatures.
  ///The default value for this attribute is `1`. (Value `2` is unsupported on iOS.)
  int? ligature;

  ///The obliqueness of the text.
  ///
  ///The value of this attribute is a number containing a floating point value indicating skew to be applied to glyphs.
  ///The default value is `0`, indicating no skew.
  double? obliqueness;

  ///The color of the strikethrough.
  ///
  ///The value of this attribute is a [Color] object. The default value is `null`, indicating same as foreground color.
  Color? strikethroughColor;

  ///The strikethrough style of the text.
  ///
  ///This value indicates whether the text has a line through it and corresponds to one of the constants described in [AqutterUnderlineStyle].
  ///The default value for this attribute is [AqutterUnderlineStyle.STYLE_NONE].
  AqutterUnderlineStyle? strikethroughStyle;

  ///The characters for the new object.
  String string;

  ///The color of the stroke.
  ///
  ///The value of this parameter is a [Color] object.
  ///If it is not defined (which is the case by default), it is assumed to be the same as the value of foregroundColor;
  ///otherwise, it describes the outline color.
  Color? strokeColor;

  ///The width of the stroke.
  ///
  ///The value of this attribute is a number containing a floating-point value.
  ///This value represents the amount to change the stroke width and is specified as a percentage of the font point size.
  ///Specify `0` (the default) for no additional changes.
  ///Specify positive values to change the stroke width alone.
  ///Specify negative values to stroke and fill the text.
  ///For example, a typical value for outlined text would be `3.0`.
  double? strokeWidth;

  ///The text effect.
  ///
  ///The value of this attribute is a [AqutterAttributedStringTextEffectStyle] object.
  ///The default value of this property is `null`, indicating no text effect.
  AqutterAttributedStringTextEffectStyle? textEffect;

  ///The color of the underline.
  ///
  ///The value of this attribute is a [Color] object.
  ///The default value is `null`, indicating same as foreground color.
  Color? underlineColor;

  ///The underline style of the text.
  ///
  ///This value indicates whether the text is underlined and corresponds to one of the constants described in [AqutterUnderlineStyle].
  ///The default value for this attribute is [AqutterUnderlineStyle.STYLE_NONE].
  AqutterUnderlineStyle? underlineStyle;
  AqutterAttributedString({
    this.backgroundColor,
    this.baselineOffset,
    this.expansion,
    this.foregroundColor,
    this.kern,
    this.ligature,
    this.obliqueness,
    this.strikethroughColor,
    this.strikethroughStyle,
    required this.string,
    this.strokeColor,
    this.strokeWidth,
    this.textEffect,
    this.underlineColor,
    this.underlineStyle,
  });

  ///Gets a possible [AqutterAttributedString] instance from a [Map] value.
  static AqutterAttributedString? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterAttributedString(
      backgroundColor: map['backgroundColor'] != null
          ? UtilColor.fromStringRepresentation(map['backgroundColor'])
          : null,
      baselineOffset: map['baselineOffset'],
      expansion: map['expansion'],
      foregroundColor: map['foregroundColor'] != null
          ? UtilColor.fromStringRepresentation(map['foregroundColor'])
          : null,
      kern: map['kern'],
      ligature: map['ligature'],
      obliqueness: map['obliqueness'],
      strikethroughColor: map['strikethroughColor'] != null
          ? UtilColor.fromStringRepresentation(map['strikethroughColor'])
          : null,
      strikethroughStyle: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterUnderlineStyle.fromNativeValue(
          map['strikethroughStyle'],
        ),
        AqutterEnumMethod.value => AqutterUnderlineStyle.fromValue(
          map['strikethroughStyle'],
        ),
        AqutterEnumMethod.name => AqutterUnderlineStyle.byName(
          map['strikethroughStyle'],
        ),
      },
      string: map['string'],
      strokeColor: map['strokeColor'] != null
          ? UtilColor.fromStringRepresentation(map['strokeColor'])
          : null,
      strokeWidth: map['strokeWidth'],
      textEffect: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterAttributedStringTextEffectStyle.fromNativeValue(
            map['textEffect'],
          ),
        AqutterEnumMethod.value =>
          AqutterAttributedStringTextEffectStyle.fromValue(map['textEffect']),
        AqutterEnumMethod.name => AqutterAttributedStringTextEffectStyle.byName(
          map['textEffect'],
        ),
      },
      underlineColor: map['underlineColor'] != null
          ? UtilColor.fromStringRepresentation(map['underlineColor'])
          : null,
      underlineStyle: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterUnderlineStyle.fromNativeValue(
          map['underlineStyle'],
        ),
        AqutterEnumMethod.value => AqutterUnderlineStyle.fromValue(
          map['underlineStyle'],
        ),
        AqutterEnumMethod.name => AqutterUnderlineStyle.byName(
          map['underlineStyle'],
        ),
      },
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "backgroundColor": backgroundColor?.toHex(),
      "baselineOffset": baselineOffset,
      "expansion": expansion,
      "foregroundColor": foregroundColor?.toHex(),
      "kern": kern,
      "ligature": ligature,
      "obliqueness": obliqueness,
      "strikethroughColor": strikethroughColor?.toHex(),
      "strikethroughStyle": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => strikethroughStyle?.toNativeValue(),
        AqutterEnumMethod.value => strikethroughStyle?.toValue(),
        AqutterEnumMethod.name => strikethroughStyle?.name(),
      },
      "string": string,
      "strokeColor": strokeColor?.toHex(),
      "strokeWidth": strokeWidth,
      "textEffect": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => textEffect?.toNativeValue(),
        AqutterEnumMethod.value => textEffect?.toValue(),
        AqutterEnumMethod.name => textEffect?.name(),
      },
      "underlineColor": underlineColor?.toHex(),
      "underlineStyle": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => underlineStyle?.toNativeValue(),
        AqutterEnumMethod.value => underlineStyle?.toValue(),
        AqutterEnumMethod.name => underlineStyle?.name(),
      },
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterAttributedString{backgroundColor: $backgroundColor, baselineOffset: $baselineOffset, expansion: $expansion, foregroundColor: $foregroundColor, kern: $kern, ligature: $ligature, obliqueness: $obliqueness, strikethroughColor: $strikethroughColor, strikethroughStyle: $strikethroughStyle, string: $string, strokeColor: $strokeColor, strokeWidth: $strokeWidth, textEffect: $textEffect, underlineColor: $underlineColor, underlineStyle: $underlineStyle}';
  }
}

///An iOS-specific class that represents a string with associated attributes
///used by the [AqutterPlatformPullToRefreshController] and [AqutterPullToRefreshOptions] classes.
///Use [AqutterAttributedString] instead.
@Deprecated('Use AqutterAttributedString instead')
class AqutterIOSNSAttributedString {
  ///The color of the background behind the text.
  ///
  ///The value of this attribute is a [Color] object.
  ///Use this attribute to specify the color of the background area behind the text.
  ///If you do not specify this attribute, no background color is drawn.
  Color? backgroundColor;

  ///The vertical offset for the position of the text.
  ///
  ///The value of this attribute is a number containing a floating point value indicating the character’s offset from the baseline, in points.
  ///The default value is `0`.
  double? baselineOffset;

  ///The expansion factor of the text.
  ///
  ///The value of this attribute is a number containing a floating point value indicating the log of the expansion factor to be applied to glyphs.
  ///The default value is `0`, indicating no expansion.
  double? expansion;

  ///The color of the text.
  ///
  ///The value of this attribute is a [Color] object.
  ///Use this attribute to specify the color of the text during rendering.
  ///If you do not specify this attribute, the text is rendered in black.
  Color? foregroundColor;

  ///The kerning of the text.
  ///
  ///The value of this attribute is a number containing a floating-point value.
  ///This value specifies the number of points by which to adjust kern-pair characters.
  ///Kerning prevents unwanted space from occurring between specific characters and depends on the font.
  ///The value `0` means kerning is disabled. The default value for this attribute is `0`.
  double? kern;

  ///The ligature of the text.
  ///
  ///The value of this attribute is a number containing an integer.
  ///Ligatures cause specific character combinations to be rendered using a single custom glyph that corresponds to those characters.
  ///The value `0` indicates no ligatures. The value `1` indicates the use of the default ligatures.
  ///The value `2` indicates the use of all ligatures.
  ///The default value for this attribute is `1`. (Value `2` is unsupported on iOS.)
  int? ligature;

  ///The obliqueness of the text.
  ///
  ///The value of this attribute is a number containing a floating point value indicating skew to be applied to glyphs.
  ///The default value is `0`, indicating no skew.
  double? obliqueness;

  ///The color of the strikethrough.
  ///
  ///The value of this attribute is a [Color] object. The default value is `null`, indicating same as foreground color.
  Color? strikethroughColor;

  ///The strikethrough style of the text.
  ///
  ///This value indicates whether the text has a line through it and corresponds to one of the constants described in [AqutterIOSNSUnderlineStyle].
  ///The default value for this attribute is [AqutterIOSNSUnderlineStyle.STYLE_NONE].
  AqutterIOSNSUnderlineStyle? strikethroughStyle;

  ///The characters for the new object.
  String string;

  ///The color of the stroke.
  ///
  ///The value of this parameter is a [Color] object.
  ///If it is not defined (which is the case by default), it is assumed to be the same as the value of foregroundColor;
  ///otherwise, it describes the outline color.
  Color? strokeColor;

  ///The width of the stroke.
  ///
  ///The value of this attribute is a number containing a floating-point value.
  ///This value represents the amount to change the stroke width and is specified as a percentage of the font point size.
  ///Specify `0` (the default) for no additional changes.
  ///Specify positive values to change the stroke width alone.
  ///Specify negative values to stroke and fill the text.
  ///For example, a typical value for outlined text would be `3.0`.
  double? strokeWidth;

  ///The text effect.
  ///
  ///The value of this attribute is a [AqutterIOSNSAttributedStringTextEffectStyle] object.
  ///The default value of this property is `null`, indicating no text effect.
  AqutterIOSNSAttributedStringTextEffectStyle? textEffect;

  ///The color of the underline.
  ///
  ///The value of this attribute is a [Color] object.
  ///The default value is `null`, indicating same as foreground color.
  Color? underlineColor;

  ///The underline style of the text.
  ///
  ///This value indicates whether the text is underlined and corresponds to one of the constants described in [AqutterIOSNSUnderlineStyle].
  ///The default value for this attribute is [AqutterIOSNSUnderlineStyle.STYLE_NONE].
  AqutterIOSNSUnderlineStyle? underlineStyle;
  AqutterIOSNSAttributedString({
    this.backgroundColor,
    this.baselineOffset,
    this.expansion,
    this.foregroundColor,
    this.kern,
    this.ligature,
    this.obliqueness,
    this.strikethroughColor,
    this.strikethroughStyle,
    required this.string,
    this.strokeColor,
    this.strokeWidth,
    this.textEffect,
    this.underlineColor,
    this.underlineStyle,
  });

  ///Gets a possible [AqutterIOSNSAttributedString] instance from a [Map] value.
  static AqutterIOSNSAttributedString? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterIOSNSAttributedString(
      backgroundColor: map['backgroundColor'] != null
          ? UtilColor.fromStringRepresentation(map['backgroundColor'])
          : null,
      baselineOffset: map['baselineOffset'],
      expansion: map['expansion'],
      foregroundColor: map['foregroundColor'] != null
          ? UtilColor.fromStringRepresentation(map['foregroundColor'])
          : null,
      kern: map['kern'],
      ligature: map['ligature'],
      obliqueness: map['obliqueness'],
      strikethroughColor: map['strikethroughColor'] != null
          ? UtilColor.fromStringRepresentation(map['strikethroughColor'])
          : null,
      strikethroughStyle: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterIOSNSUnderlineStyle.fromNativeValue(map['strikethroughStyle']),
        AqutterEnumMethod.value => AqutterIOSNSUnderlineStyle.fromValue(
          map['strikethroughStyle'],
        ),
        AqutterEnumMethod.name => AqutterIOSNSUnderlineStyle.byName(
          map['strikethroughStyle'],
        ),
      },
      string: map['string'],
      strokeColor: map['strokeColor'] != null
          ? UtilColor.fromStringRepresentation(map['strokeColor'])
          : null,
      strokeWidth: map['strokeWidth'],
      textEffect: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterIOSNSAttributedStringTextEffectStyle.fromNativeValue(
            map['textEffect'],
          ),
        AqutterEnumMethod.value =>
          AqutterIOSNSAttributedStringTextEffectStyle.fromValue(
            map['textEffect'],
          ),
        AqutterEnumMethod.name =>
          AqutterIOSNSAttributedStringTextEffectStyle.byName(map['textEffect']),
      },
      underlineColor: map['underlineColor'] != null
          ? UtilColor.fromStringRepresentation(map['underlineColor'])
          : null,
      underlineStyle: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterIOSNSUnderlineStyle.fromNativeValue(map['underlineStyle']),
        AqutterEnumMethod.value => AqutterIOSNSUnderlineStyle.fromValue(
          map['underlineStyle'],
        ),
        AqutterEnumMethod.name => AqutterIOSNSUnderlineStyle.byName(
          map['underlineStyle'],
        ),
      },
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "backgroundColor": backgroundColor?.toHex(),
      "baselineOffset": baselineOffset,
      "expansion": expansion,
      "foregroundColor": foregroundColor?.toHex(),
      "kern": kern,
      "ligature": ligature,
      "obliqueness": obliqueness,
      "strikethroughColor": strikethroughColor?.toHex(),
      "strikethroughStyle": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => strikethroughStyle?.toNativeValue(),
        AqutterEnumMethod.value => strikethroughStyle?.toValue(),
        AqutterEnumMethod.name => strikethroughStyle?.name(),
      },
      "string": string,
      "strokeColor": strokeColor?.toHex(),
      "strokeWidth": strokeWidth,
      "textEffect": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => textEffect?.toNativeValue(),
        AqutterEnumMethod.value => textEffect?.toValue(),
        AqutterEnumMethod.name => textEffect?.name(),
      },
      "underlineColor": underlineColor?.toHex(),
      "underlineStyle": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => underlineStyle?.toNativeValue(),
        AqutterEnumMethod.value => underlineStyle?.toValue(),
        AqutterEnumMethod.name => underlineStyle?.name(),
      },
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterIOSNSAttributedString{backgroundColor: $backgroundColor, baselineOffset: $baselineOffset, expansion: $expansion, foregroundColor: $foregroundColor, kern: $kern, ligature: $ligature, obliqueness: $obliqueness, strikethroughColor: $strikethroughColor, strikethroughStyle: $strikethroughStyle, string: $string, strokeColor: $strokeColor, strokeWidth: $strokeWidth, textEffect: $textEffect, underlineColor: $underlineColor, underlineStyle: $underlineStyle}';
  }
}
