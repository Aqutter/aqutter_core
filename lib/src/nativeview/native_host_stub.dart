import 'native_session.dart';

/// 每個連線允許同時未被確認的幀數（Web 平台不支援，僅為與原生版介面一致）。
const int aqutterNativeMaxInFlight = 3;

/// 網頁端連線所需的資訊（Web 平台不支援）。
class AqutterNativeEndpoint {
  const AqutterNativeEndpoint({required this.port, required this.token});

  final int port;
  final String token;

  Map<String, Object> toJson() => {'port': port, 'token': token};
}

/// Web 平台沒有 `dart:io`，鏡像伺服器不可用；所有方法拋 [UnsupportedError]。
class AqutterNativeHost {
  AqutterNativeHost._();

  static final AqutterNativeHost instance = AqutterNativeHost._();

  Future<AqutterNativeEndpoint> ensureStarted() => throw UnsupportedError('Native host is not available on web');

  void register(AqutterNativeSession session) => throw UnsupportedError('Native host is not available on web');

  void unregister(AqutterNativeSession session) {}

  bool hasSession(String id) => false;

  Future<void> stop() async {}
}
