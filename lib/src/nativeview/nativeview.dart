/// Native view 鏡像：把 Flutter 內容（Widget 或 PlatformView）即時鏡像到網頁的 canvas，
/// 並接收網頁端回傳的手勢，讓網頁能在原生內容之上疊 HTML。網頁端見 `@aqutter/aqutter` 的 `<aqutter-native>`。
library;

export 'mirror_frame.dart' show AqutterMirrorFormat, AqutterMirrorFrame, AqutterMirrorMessage, aqutterMirrorHeaderLength, encodeAqutterMirrorFrame;
export 'mirror_host_io.dart' if (dart.library.js_interop) 'mirror_host_stub.dart' show AqutterMirrorEndpoint, AqutterMirrorHost;
export 'mirror_session.dart' show AqutterMirrorCapture, AqutterMirrorMessageHandler, AqutterMirrorSession;
export 'mirror_widget.dart' show AqutterMirror;
export 'native_capture.dart' show AqutterNativeCapture;
