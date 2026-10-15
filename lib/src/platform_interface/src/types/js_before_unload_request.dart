import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import '../web_uri.dart';
import 'enum_method.dart';

part 'js_before_unload_request.g.dart';

///Class that represents the request of the [AqutterPlatformWebViewCreationParams.onJsBeforeUnload] event.
@ExchangeableObject()
class AqutterJsBeforeUnloadRequest_ {
  ///The url of the page requesting the dialog.
  AqutterWebUri? url;

  ///Message to be displayed in the window.
  String? message;

  AqutterJsBeforeUnloadRequest_({this.url, this.message});
}
