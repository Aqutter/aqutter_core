import 'dart:typed_data';

/// 通用二進位通道上的一條連線：網頁以 `ws://127.0.0.1:<port>/channel/<name>?token=<token>` 連上後，
/// 雙方用二進位訊息雙向傳資料，不經 JSON 與 base64。
///
/// 只有二進位訊息：網頁送來的文字訊息一律被忽略。訊息內的結構由使用端自己決定。
/// 沒有背壓：[send] 把資料交給 WebSocket 的送出佇列，下行大量資料時會在記憶體堆積。
abstract class AqutterChannelConnection {
  /// 網頁送來的二進位訊息。單一訂閱，會緩衝到有人監聽為止（處理函式可以晚一點才監聽）。
  Stream<Uint8List> get messages;

  /// 送一則二進位訊息給網頁；連線關閉後呼叫會被忽略。
  void send(Uint8List data);

  /// 連線關閉時完成（網頁關閉、[close]、伺服器重啟或通道被取消註冊）。
  Future<void> get done;

  /// 關閉連線。
  void close([int? code, String? reason]);
}

/// 每條新連線呼叫一次。處理函式拋出例外時，連線以 1011 關閉。
typedef AqutterChannelHandler = void Function(AqutterChannelConnection connection);

/// 通道名稱的格式：`<pluginId>.<channel>`，兩段各自符合 `^[a-z][a-z0-9-]*$`。
final RegExp aqutterChannelNamePattern = RegExp(r'^[a-z][a-z0-9-]*\.[a-z][a-z0-9-]*$');
