import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import '../web_uri.dart';
import 'enum_method.dart';

part 'js_confirm_request.g.dart';

///Class that represents the request of the [AqutterPlatformWebViewCreationParams.onJsConfirm] event.
@ExchangeableObject()
class AqutterJsConfirmRequest_ {
  ///The url of the page requesting the dialog.
  AqutterWebUri? url;

  ///Message to be displayed in the window.
  String? message;

  ///Use [isMainFrame] instead.
  @Deprecated("Use isMainFrame instead")
  bool? iosIsMainFrame;

  ///Indicates whether the request was made for the main frame.
  @SupportedPlatforms(platforms: [IOSPlatform(), MacOSPlatform()])
  bool? isMainFrame;

  AqutterJsConfirmRequest_({
    this.url,
    this.message,
    @Deprecated("Use isMainFrame instead") this.iosIsMainFrame,
    this.isMainFrame,
  });
}
