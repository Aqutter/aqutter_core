import '../web_message/main.dart';
import '../web_uri.dart';

///The listener for handling [AqutterPlatformWebMessageListener] events sent by a `postMessage()` on the injected JavaScript object.
typedef void AqutterOnPostMessageCallback(
  AqutterWebMessage? message,
  AqutterWebUri? sourceOrigin,
  bool isMainFrame,
  AqutterPlatformJavaScriptReplyProxy replyProxy,
);
