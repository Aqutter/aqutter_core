import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import 'js_before_unload_response_action.dart';
import 'enum_method.dart';

part 'js_before_unload_response.g.dart';

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onJsBeforeUnload] event to control a JavaScript alert dialog.
@ExchangeableObject()
class AqutterJsBeforeUnloadResponse_ {
  ///Message to be displayed in the window.
  String message;

  ///Title of the confirm button.
  String confirmButtonTitle;

  ///Title of the cancel button.
  String cancelButtonTitle;

  ///Whether the client will handle the alert dialog.
  bool handledByClient;

  ///Action used to confirm that the user hit confirm or cancel button.
  AqutterJsBeforeUnloadResponseAction_? action;

  AqutterJsBeforeUnloadResponse_({
    this.message = "",
    this.handledByClient = false,
    this.confirmButtonTitle = "",
    this.cancelButtonTitle = "",
    this.action = AqutterJsBeforeUnloadResponseAction_.CONFIRM,
  });
}
