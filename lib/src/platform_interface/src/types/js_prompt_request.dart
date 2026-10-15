import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import '../web_uri.dart';
import 'enum_method.dart';

part 'js_prompt_request.g.dart';

///Class that represents the request of the [AqutterPlatformWebViewCreationParams.onJsPrompt] event.
@ExchangeableObject()
class AqutterJsPromptRequest_ {
  ///The url of the page requesting the dialog.
  AqutterWebUri? url;

  ///Message to be displayed in the window.
  String? message;

  ///The default value displayed in the prompt dialog.
  String? defaultValue;

  ///Use [isMainFrame] instead.
  @Deprecated("Use isMainFrame instead")
  bool? iosIsMainFrame;

  ///Indicates whether the request was made for the main frame.
  @SupportedPlatforms(platforms: [IOSPlatform(), MacOSPlatform()])
  bool? isMainFrame;

  AqutterJsPromptRequest_({
    this.url,
    this.message,
    this.defaultValue,
    @Deprecated("Use isMainFrame instead") this.iosIsMainFrame,
    this.isMainFrame,
  });
}
