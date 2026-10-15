import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'scrollbar_style.g.dart';

///Class used to configure the style of the scrollbars.
///The scrollbars can be overlaid or inset.
///When inset, they add to the padding of the view. And the scrollbars can be drawn inside the padding area or on the edge of the view.
///For example, if a view has a background drawable and you want to draw the scrollbars inside the padding specified by the drawable,
///you can use [AqutterScrollBarStyle.SCROLLBARS_INSIDE_OVERLAY] or [AqutterScrollBarStyle.SCROLLBARS_INSIDE_INSET].
///If you want them to appear at the edge of the view, ignoring the padding,
///then you can use [AqutterScrollBarStyle.SCROLLBARS_OUTSIDE_OVERLAY] or [AqutterScrollBarStyle.SCROLLBARS_OUTSIDE_INSET].
@ExchangeableEnum()
class AqutterScrollBarStyle_ {
  // ignore: unused_field
  final int _value;
  const AqutterScrollBarStyle_._internal(this._value);

  ///The scrollbar style to display the scrollbars inside the content area, without increasing the padding.
  ///The scrollbars will be overlaid with translucency on the view's content.
  static const SCROLLBARS_INSIDE_OVERLAY = const AqutterScrollBarStyle_._internal(0);

  ///The scrollbar style to display the scrollbars inside the padded area, increasing the padding of the view.
  ///The scrollbars will not overlap the content area of the view.
  static const SCROLLBARS_INSIDE_INSET = const AqutterScrollBarStyle_._internal(
    16777216,
  );

  ///The scrollbar style to display the scrollbars at the edge of the view, without increasing the padding.
  ///The scrollbars will be overlaid with translucency.
  static const SCROLLBARS_OUTSIDE_OVERLAY = const AqutterScrollBarStyle_._internal(
    33554432,
  );

  ///The scrollbar style to display the scrollbars at the edge of the view, increasing the padding of the view.
  ///The scrollbars will only overlap the background, if any.
  static const SCROLLBARS_OUTSIDE_INSET = const AqutterScrollBarStyle_._internal(
    50331648,
  );
}

///An Android-specific class used to configure the style of the scrollbars.
///The scrollbars can be overlaid or inset.
///When inset, they add to the padding of the view. And the scrollbars can be drawn inside the padding area or on the edge of the view.
///For example, if a view has a background drawable and you want to draw the scrollbars inside the padding specified by the drawable,
///you can use [AqutterAndroidScrollBarStyle.SCROLLBARS_INSIDE_OVERLAY] or [AqutterAndroidScrollBarStyle.SCROLLBARS_INSIDE_INSET].
///If you want them to appear at the edge of the view, ignoring the padding,
///then you can use [AqutterAndroidScrollBarStyle.SCROLLBARS_OUTSIDE_OVERLAY] or [AqutterAndroidScrollBarStyle.SCROLLBARS_OUTSIDE_INSET].
///
///Use [AqutterScrollBarStyle] instead.
@Deprecated("Use AqutterScrollBarStyle instead")
@ExchangeableEnum()
class AqutterAndroidScrollBarStyle_ {
  // ignore: unused_field
  final int _value;
  const AqutterAndroidScrollBarStyle_._internal(this._value);

  ///The scrollbar style to display the scrollbars inside the content area, without increasing the padding.
  ///The scrollbars will be overlaid with translucency on the view's content.
  static const SCROLLBARS_INSIDE_OVERLAY =
      const AqutterAndroidScrollBarStyle_._internal(0);

  ///The scrollbar style to display the scrollbars inside the padded area, increasing the padding of the view.
  ///The scrollbars will not overlap the content area of the view.
  static const SCROLLBARS_INSIDE_INSET = const AqutterAndroidScrollBarStyle_._internal(
    16777216,
  );

  ///The scrollbar style to display the scrollbars at the edge of the view, without increasing the padding.
  ///The scrollbars will be overlaid with translucency.
  static const SCROLLBARS_OUTSIDE_OVERLAY =
      const AqutterAndroidScrollBarStyle_._internal(33554432);

  ///The scrollbar style to display the scrollbars at the edge of the view, increasing the padding of the view.
  ///The scrollbars will only overlap the background, if any.
  static const SCROLLBARS_OUTSIDE_INSET =
      const AqutterAndroidScrollBarStyle_._internal(50331648);
}
