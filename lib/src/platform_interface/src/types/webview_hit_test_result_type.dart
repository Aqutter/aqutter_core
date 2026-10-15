import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'webview_hit_test_result_type.g.dart';

///Class representing the [AqutterWebViewHitTestResult] type.
@ExchangeableEnum()
class AqutterWebViewHitTestResultType_ {
  // ignore: unused_field
  final int _value;
  const AqutterWebViewHitTestResultType_._internal(this._value);

  ///Default [AqutterWebViewHitTestResult], where the target is unknown.
  static const UNKNOWN_TYPE = const AqutterWebViewHitTestResultType_._internal(0);

  ///[AqutterWebViewHitTestResult] for hitting a phone number.
  static const PHONE_TYPE = const AqutterWebViewHitTestResultType_._internal(2);

  ///[AqutterWebViewHitTestResult] for hitting a map address.
  static const GEO_TYPE = const AqutterWebViewHitTestResultType_._internal(3);

  ///[AqutterWebViewHitTestResult] for hitting an email address.
  static const EMAIL_TYPE = const AqutterWebViewHitTestResultType_._internal(4);

  ///[AqutterWebViewHitTestResult] for hitting an HTML::img tag.
  static const IMAGE_TYPE = const AqutterWebViewHitTestResultType_._internal(5);

  ///[AqutterWebViewHitTestResult] for hitting a HTML::a tag with src=http.
  static const SRC_ANCHOR_TYPE = const AqutterWebViewHitTestResultType_._internal(
    7,
  );

  ///[AqutterWebViewHitTestResult] for hitting a HTML::a tag with src=http + HTML::img.
  static const SRC_IMAGE_ANCHOR_TYPE =
      const AqutterWebViewHitTestResultType_._internal(8);

  ///[AqutterWebViewHitTestResult] for hitting an edit text area.
  static const EDIT_TEXT_TYPE = const AqutterWebViewHitTestResultType_._internal(
    9,
  );
}
