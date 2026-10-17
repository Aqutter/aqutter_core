/// Native view 鏡像：把 Flutter 內容（Widget 或 PlatformView）即時鏡像到網頁的 canvas，
/// 並接收網頁端回傳的手勢，讓網頁能在原生內容之上疊 HTML。網頁端見 `@aqutter/aqutter` 的 `<aqutter-native>`。
library;

export 'native_frame.dart' show AqutterNativeFormat, AqutterNativeFrame, AqutterNativeMessage, aqutterNativeHeaderLength, encodeAqutterNativeFrame;
export 'native_host_io.dart' if (dart.library.js_interop) 'native_host_stub.dart' show AqutterNativeEndpoint, AqutterNativeHost;
export 'native_session.dart' show AqutterNativeCapture, AqutterNativeMessageHandler, AqutterNativeSession;
export 'native_widget.dart' show AqutterNative;
export 'native_capture.dart' show AqutterNativeCapture;
