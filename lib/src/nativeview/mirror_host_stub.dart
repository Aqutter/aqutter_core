import 'mirror_session.dart';

/// 網頁端連線所需的資訊（Web 平台不支援）。
class AqutterMirrorEndpoint {
  const AqutterMirrorEndpoint({required this.port, required this.token});

  final int port;
  final String token;

  Map<String, Object> toJson() => {'port': port, 'token': token};
}

/// Web 平台沒有 `dart:io`，鏡像伺服器不可用；所有方法拋 [UnsupportedError]。
class AqutterMirrorHost {
  AqutterMirrorHost._();

  static final AqutterMirrorHost instance = AqutterMirrorHost._();

  Future<AqutterMirrorEndpoint> ensureStarted() => throw UnsupportedError('Mirror host is not available on web');

  void register(AqutterMirrorSession session) => throw UnsupportedError('Mirror host is not available on web');

  void unregister(AqutterMirrorSession session) {}

  bool hasSession(String id) => false;

  Future<void> stop() async {}
}
