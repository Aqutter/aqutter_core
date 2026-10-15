import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'over_scroll_mode.g.dart';

///Class used to configure the `WebView`'s over-scroll mode.
///Setting the over-scroll mode of a WebView will have an effect only if the `WebView` is capable of scrolling.
@ExchangeableEnum()
class AqutterOverScrollMode_ {
  // ignore: unused_field
  final int _value;
  const AqutterOverScrollMode_._internal(this._value);

  ///Always allow a user to over-scroll this view, provided it is a view that can scroll.
  static const ALWAYS = const AqutterOverScrollMode_._internal(0);

  ///Allow a user to over-scroll this view only if the content is large enough to meaningfully scroll, provided it is a view that can scroll.
  static const IF_CONTENT_SCROLLS = const AqutterOverScrollMode_._internal(1);

  ///Never allow a user to over-scroll this view.
  static const NEVER = const AqutterOverScrollMode_._internal(2);
}

///An Android-specific class used to configure the `WebView`'s over-scroll mode.
///Setting the over-scroll mode of a WebView will have an effect only if the `WebView` is capable of scrolling.
///Use [AqutterOverScrollMode] instead.
@Deprecated("Use AqutterOverScrollMode instead")
@ExchangeableEnum()
class AqutterAndroidOverScrollMode_ {
  // ignore: unused_field
  final int _value;
  const AqutterAndroidOverScrollMode_._internal(this._value);

  ///Always allow a user to over-scroll this view, provided it is a view that can scroll.
  static const OVER_SCROLL_ALWAYS = const AqutterAndroidOverScrollMode_._internal(0);

  ///Allow a user to over-scroll this view only if the content is large enough to meaningfully scroll, provided it is a view that can scroll.
  static const OVER_SCROLL_IF_CONTENT_SCROLLS =
      const AqutterAndroidOverScrollMode_._internal(1);

  ///Never allow a user to over-scroll this view.
  static const OVER_SCROLL_NEVER = const AqutterAndroidOverScrollMode_._internal(2);
}
