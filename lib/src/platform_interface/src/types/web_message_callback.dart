import '../web_message/main.dart';

///The listener for handling [AqutterPlatformWebMessagePort] events.
///The message callback methods are called on the main thread.
typedef void AqutterWebMessageCallback(AqutterWebMessage? message);
