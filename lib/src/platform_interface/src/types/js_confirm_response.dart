import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import 'js_confirm_response_action.dart';
import 'enum_method.dart';

part 'js_confirm_response.g.dart';

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onJsConfirm] event to control a JavaScript confirm dialog.
@ExchangeableObject()
class AqutterJsConfirmResponse_ {
  ///Message to be displayed in the window.
  String message;

  ///Title of the confirm button.
  String confirmButtonTitle;

  ///Title of the cancel button.
  String cancelButtonTitle;

  ///Whether the client will handle the confirm dialog.
  bool handledByClient;

  ///Action used to confirm that the user hit confirm or cancel button.
  AqutterJsConfirmResponseAction_? action;

  AqutterJsConfirmResponse_({
    this.message = "",
    this.handledByClient = false,
    this.confirmButtonTitle = "",
    this.cancelButtonTitle = "",
    this.action = AqutterJsConfirmResponseAction_.CANCEL,
  });
}
