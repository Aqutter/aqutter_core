import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import 'console_message_level.dart';
import 'enum_method.dart';

part 'console_message.g.dart';

///Class representing a JavaScript console message from WebCore.
///This could be a issued by a call to one of the console logging functions (e.g. console.log('...')) or a JavaScript error on the page.
///
///To receive notifications of these messages, use the [AqutterPlatformWebViewCreationParams.onConsoleMessage] event.
@ExchangeableObject()
class AqutterConsoleMessage_ {
  ///Console message
  String message;

  ///Console message level
  AqutterConsoleMessageLevel_ messageLevel;

  AqutterConsoleMessage_({
    this.message = "",
    this.messageLevel = AqutterConsoleMessageLevel_.LOG,
  });
}
