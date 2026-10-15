import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/webview_settings.dart';

part 'layout_algorithm.g.dart';

///Class used to set the underlying layout algorithm.
@ExchangeableEnum()
class AqutterLayoutAlgorithm_ {
  // ignore: unused_field
  final String _value;
  const AqutterLayoutAlgorithm_._internal(this._value);

  ///NORMAL means no rendering changes. This is the recommended choice for maximum compatibility across different platforms and Android versions.
  static const NORMAL = const AqutterLayoutAlgorithm_._internal("NORMAL");

  ///TEXT_AUTOSIZING boosts font size of paragraphs based on heuristics to make the text readable when viewing a wide-viewport layout in the overview mode.
  ///It is recommended to enable zoom support [AqutterWebViewSettings.supportZoom] when using this mode.
  ///
  ///**NOTE**: available on Android 19+.
  static const TEXT_AUTOSIZING = const AqutterLayoutAlgorithm_._internal(
    "TEXT_AUTOSIZING",
  );

  ///NARROW_COLUMNS makes all columns no wider than the screen if possible. Only use this for API levels prior to `Build.VERSION_CODES.KITKAT`.
  static const NARROW_COLUMNS = const AqutterLayoutAlgorithm_._internal(
    "NARROW_COLUMNS",
  );
}

///An Android-specific class used to set the underlying layout algorithm.
///Use [AqutterLayoutAlgorithm] instead.
@Deprecated("Use AqutterLayoutAlgorithm instead")
@ExchangeableEnum()
class AqutterAndroidLayoutAlgorithm_ {
  // ignore: unused_field
  final String _value;
  const AqutterAndroidLayoutAlgorithm_._internal(this._value);

  ///NORMAL means no rendering changes. This is the recommended choice for maximum compatibility across different platforms and Android versions.
  static const NORMAL = const AqutterAndroidLayoutAlgorithm_._internal("NORMAL");

  ///TEXT_AUTOSIZING boosts font size of paragraphs based on heuristics to make the text readable when viewing a wide-viewport layout in the overview mode.
  ///It is recommended to enable zoom support [AqutterInAppWebViewOptions.supportZoom] when using this mode.
  ///
  ///**NOTE**: available on Android 19+.
  static const TEXT_AUTOSIZING = const AqutterAndroidLayoutAlgorithm_._internal(
    "TEXT_AUTOSIZING",
  );

  ///NARROW_COLUMNS makes all columns no wider than the screen if possible. Only use this for API levels prior to `Build.VERSION_CODES.KITKAT`.
  static const NARROW_COLUMNS = const AqutterAndroidLayoutAlgorithm_._internal(
    "NARROW_COLUMNS",
  );
}
