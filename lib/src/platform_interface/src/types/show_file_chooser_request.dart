import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import 'show_file_chooser_request_mode.dart';
import 'enum_method.dart';

part 'show_file_chooser_request.g.dart';

///Class used in the [AqutterPlatformWebViewCreationParams.onShowFileChooser] method.
@ExchangeableObject()
class AqutterShowFileChooserRequest_ {
  ///The file chooser mode.
  final AqutterShowFileChooserRequestMode_ mode;

  ///An array of acceptable MIME types.
  ///The returned MIME type could be partial such as audio/*.
  ///The array will be empty if no acceptable types are specified.
  final List<String> acceptTypes;

  ///Preference for a live media captured value (e. g. Camera, Microphone).
  ///True indicates capture is enabled, false disabled.
  ///Use [acceptTypes] to determine suitable capture devices.
  final bool isCaptureEnabled;

  ///The title to use for this file selector.
  ///If `null` a default title should be used.
  final String? title;

  ///The file name of a default selection if specified, or `null`.
  final String? filenameHint;

  AqutterShowFileChooserRequest_({
    required this.mode,
    required this.acceptTypes,
    required this.isCaptureEnabled,
    this.title,
    this.filenameHint,
  });
}
