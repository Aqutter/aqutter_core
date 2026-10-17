# Native view 鏡像

把 Flutter 內容（Widget 或 PlatformView，如地圖）即時鏡像到網頁的 canvas，並讓網頁的手勢與指令回控原生內容。這讓網頁能在原生內容**之上**疊 HTML、做 z-index 與圖層合成——WebView 與原生 view 本來無法交錯疊放。

```
Flutter：[被鏡像的內容]──擷取──▶ AqutterNativeSession ──▶ AqutterNativeHost（localhost WebSocket）
                                                              │ 二進位幀 ▲ JSON 訊息
網頁：   <aqutter-native session="…"> ◀── AqutterNative（canvas 繪製 + 手勢辨識）
```

## Dart 端

```dart
AqutterNative(
  sessionId: 'map',
  fps: 30,
  onMessage: (message) {
    if (message.type == 'pan') { /* 套用到內容 */ }
  },
  child: SomeWidgetOrPlatformView(),
)
```

| 項目 | 說明 |
|---|---|
| `AqutterNative` | 以 `RepaintBoundary` 包住 `child`，註冊工作階段，依 `fps` 擷取並送出；沒有網頁連線時不擷取 |
| `AqutterNativeHost` | 單例；`ensureStarted()` 以暫時埠啟動 `127.0.0.1` 的 WebSocket 伺服器，回傳 `{port, token}` |
| `AqutterNativeSession` | 自訂擷取來源用（不經 `AqutterNative`）：給 `capture` 回呼即可 |
| `AqutterNativeCapture` | iOS 的 `drawHierarchy` 擷取（PlatformView 用） |

擷取方式：預設 `RenderRepaintBoundary.toImage`（純 Flutter 內容、Android 的 PlatformView）；iOS 的 PlatformView 無法由 Flutter rasterize，設 `nativeCapture: true`（可再給 `nativeViewTypeContains: 'GMSMapView'` 直接擷取該 view，不含疊在其上的網頁）。Web 平台不支援（沒有 `dart:io`）。

## 連線與安全

路徑：`ws://127.0.0.1:<port>/native/<sessionId>?token=<token>`。令牌每次啟動隨機產生，經 bridge handler `native_endpoint` 交給網頁；令牌錯誤或工作階段不存在一律回 403。localhost 上的其他程式因此無法冒連。網頁的 CSP 需允許 `connect-src ws://127.0.0.1:*`。

## 幀格式（Dart → 網頁，二進位）

little-endian：`[w u32 | h u32 | fmt u32 | sentAt f64 (epoch ms)][payload]`，標頭 20 bytes。

| fmt | payload |
|---|---|
| `0` | PNG |
| `1` | 未壓縮 straight（非預乘）RGBA，`w × h × 4` bytes |

## 訊息格式（網頁 → Dart，JSON 文字）

必有 `type`（字串）。座標一律為 0..1 的正規化值（相對鏡像元素的大小）。

| type | 欄位 |
|---|---|
| `tap` / `doubleTap` / `longPress` | `x`, `y` |
| `pan` | `phase`（`start` / `update` / `end`）、`x`, `y`、`dx`, `dy`（自上一個事件的位移） |
| `pinch` | `phase`、`scale`（自 pinch 開始的累計倍率）、`x`, `y`（兩指中心） |
| `command` | `name`、`args`（自訂；網頁以 `send` 送出） |

## 現況與限制

- 傳輸為未壓縮 RGBA / PNG；H.264 + WebCodecs 管線尚未實作。
- 已驗證：macOS、Android 模擬器、iOS 模擬器上鏡像 Flutter widget（`RepaintBoundary` 路徑）、手勢回控。
- 尚未驗證：iOS `drawHierarchy` 與 Android PlatformView 的擷取（需要地圖之類的 PlatformView）、實體裝置。
