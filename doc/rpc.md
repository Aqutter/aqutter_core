# 網頁與 Dart 的 RPC（`AqutterRpcHost`）

網頁與 Dart 之間的呼叫、回應、事件與二進位共用**一條**本機連線，不經 `callHandler` 的 JSON 字串化，也不用 `evaluateJavascript` 組字串。網頁端見 `@aqutter/aqutter`（`callFlutter`、`callPlugin`、`onFlutterEvent`、`onPluginEvent`）。

建立在 [通用二進位通道](nativeview.md#通用二進位通道) 上：通道名 `aqutter.rpc`，沿用 `AqutterNativeHost` 的伺服器與令牌。網頁以 bridge handler `native_endpoint` 取得埠與令牌後連線：

```
ws://127.0.0.1:<port>/channel/aqutter.rpc?token=<token>
```

網頁的 CSP 需允許 `connect-src ws://127.0.0.1:*`。

## 使用

```dart
final rpc = AqutterRpcHost.instance;

// 登錄 handler（同名取代）；payload 與回傳值可含 Uint8List
rpc.registerHandler('files.read', (payload) async {
  final bytes = await readFile(payload['path'] as String);
  return {'bytes': bytes, 'length': bytes.length};
});

// 回報有明確錯誤碼的失敗；其他例外一律是 HANDLER_FAILED
rpc.registerHandler('files.guarded', (payload) async {
  throw const AqutterRpcException('DENIED', 'not allowed');
});

// 對目前的網頁連線送事件；沒有連線時略過（不排隊）
await rpc.emit('files.changed', {'path': '/a'});
```

## 訊框

每個 WebSocket 二進位訊息一個訊框；文字訊息被忽略。

```
frame  = headerLength(u32, big-endian) | header(UTF-8 JSON) | blob_0 | blob_1 | …
header = { "t", "id"?, "name"?, "ch"?, "p"?, "e"?, "blobs": [長度…] }
```

| `t` | 方向 | 必要欄位 |
|---|---|---|
| `call` | 網頁 → Dart | `id`、`name` |
| `res` | Dart → 網頁 | `id` |
| `err` | Dart → 網頁 | `id`、`e: { code, message }` |
| `evt` | Dart → 網頁 | `ch` |

- 酬載內任何位置的 `{"$bin": i}` 代表第 `i` 個 blob；`$bin` 是保留鍵。`Uint8List`（及其他 `TypedData`）送出時自動抽成 blob，收到時一律是 `Uint8List`。
- 整個訊框 ≤ 64 MiB（`aqutterRpcMaxFrameBytes`）。
- 格式錯誤的訊框或網頁送來不是 `call` 的訊框：以 1002 關閉連線；超過上限以 1009 關閉。

## 錯誤碼

| 錯誤碼 | 觸發 |
|---|---|
| `HANDLER_NOT_FOUND` | 沒有該名稱的 handler |
| `HANDLER_FAILED` | handler 拋出例外、酬載不是物件、結果無法序列化 |
| `PAYLOAD_TOO_LARGE` | 結果超過訊框上限 |

`AqutterRpcException` 的任何其他錯誤碼原樣送給網頁。

## 行為

- 多個呼叫**並行**處理，回應順序不保證。
- 一次頁面載入一條連線；新連線到來時，舊連線以 1000 關閉（最後一條有效）。
- 事件只送給目前的連線；連線關閉後送出的事件直接丟棄。
- `AqutterNativeHost.restart()` 與 `stop()` 會以 1001 關閉連線；網頁端負責重連。
- 不支援 Web 平台（沒有 `dart:io`）：實例可建立，登錄與 `emit` 可安全呼叫，但永遠沒有連線。

測試向量 `test/rpc_frame_vectors.json` 與 `aqutter-js` 共用，兩端的編解碼以它保持一致。
