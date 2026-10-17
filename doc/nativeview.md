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

little-endian：`[w u32 | h u32 | fmt u32 | seq u32 | sentAt f64 (epoch ms)][payload]`，標頭 24 bytes。`seq` 是每個工作階段從 1 遞增的序號。

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

另有兩種協定內部訊息，由 host 處理、**不會**轉給 `onMessage`：

| type | 欄位 | 用途 |
|---|---|---|
| `ack` | `seq` | 網頁每處理完一幀（畫出、被較新的幀取代、亂序丟棄、解碼失敗都算）就回一個 |
| `resize` | `width`、`height`（CSS 像素）、`dpr` | 網頁回報顯示尺寸；連線時與尺寸改變時送 |
| `visibility` | `visible`（bool） | 網頁回報元素是否看得到；連線時與改變時送 |

## 效能設計

| 機制 | 說明 |
|---|---|
| 沒變就不擷取 | `AqutterNative` 內的 `RepaintBoundary` 會計數「真的重繪了幾次」；子樹沒重繪、也沒有新連線或解析度變動，這一輪就不擷取、不送出。閒置時 CPU 與頻寬接近 0。`skipUnchanged: false` 可關閉（內容以 Flutter 看不到的方式改變時）；`nativeCapture`（PlatformView）一律每輪擷取。 |
| 依網頁尺寸擷取 | 網頁回報顯示尺寸後，擷取成「與網頁元素等面積」的像素數（含 devicePixelRatio；倍率上限 `maxPixelRatio`，預設 3）；回報前用 `pixelRatio`。以面積計算，被鏡像對象與網頁元素長寬比不同時也不會過度擷取；長寬比相同時剛好 1:1，建議兩者長寬比一致。 |
| 流量控制 | 每個連線最多 `aqutterNativeMaxInFlight`（2）幀未被確認；超過就不再送給該連線，所有連線都滿時連擷取都停。網頁慢或分頁不可見（`requestAnimationFrame` 暫停）時不會在記憶體堆積。 |
| 同 id 取代 | 同一個 session id 再次註冊時，新的取代舊的並承接既有連線（Flutter 重建子樹時會短暫出現兩次）；舊的稍後 dispose 不影響新的。 |
| 關閉 WebSocket 壓縮 | dart:io 的 WebSocket 預設會與瀏覽器協商 permessage-deflate，每幀數 MB 的原始像素都被 zlib 壓一次；host 以 `CompressionOptions.compressionOff` 關掉。macOS 實測 `send` 階段每幀 7.8ms → 1.5ms，幀率 42 → 55 fps（小元素）、26 → 48.5 fps（大元素）。 |
| 擷取流水線 | 最多 `aqutterNativeMaxConcurrentCaptures`（2）個擷取同時進行，讓像素讀回與下一幀的準備重疊；送出順序仍依擷取開始順序。慢 GPU 上讀回耗時（Android 模擬器 13–25ms）才有差別。 |
| 預設 60 fps | `AqutterNative.fps` 與 `AqutterNativeSession.fps` 預設 60（上限 120）。內容沒重繪、網頁不可見、對方來不及處理時實際幀率會自動更低。 |
| 看不到就暫停 | 所有連線都回報 `visibility: false`（元素捲出視窗、`display: none`、分頁隱藏）時，工作階段停止擷取與送幀；任何一個連線重新看得到時立刻補一幀。新連線預設為看得到。 |
| 只畫最新一幀 | 網頁在每個繪製週期只畫最新收到的一幀；被取代的幀立刻回 `ack`。PNG 非同步解碼完成時若已有更新的幀開始繪製就放棄舊的，不會讓舊幀蓋掉新幀。 |
| 不複製像素 | 網頁端 RGBA 的 `ImageData` 直接包住收到的緩衝區。 |

## 量測

以 `--dart-define=AQUTTER_NATIVE_STATS=true`（或寫進 env 檔）開啟，host 每 2 秒印一行各階段平均耗時：

```
[aqutter-native:<id>] 59.8 fps, 3183 KB/frame, 185.8 MB/s | toImage=0.3ms toByteData=4.3ms capture=4.7ms encode=1.4ms send=1.5ms
```

| 階段 | 意義 |
|---|---|
| `toImage` | `RepaintBoundary` 擷取成 `ui.Image` |
| `toByteData` | GPU 像素讀回成位元組 |
| `capture` | 以上合計（含等待） |
| `encode` | 加標頭（複製一份） |
| `send` | `socket.add` |

網頁端 `aqutter-frame` 事件的 `detail` 帶 `bytes`、`latencyMs`、`drawMs`。

實測（macOS release，內容每個 animation frame 都改變；Android 為模擬器 debug，繪製本身就很慢，不代表實機）：

| 環境 | 元素（CSS） | 每幀 | 網頁端 fps | 送出端 fps |
|---|---|---|---|---|
| macOS，關壓縮前 | 727×280 | 3.1MB | 42 | 43 |
| macOS，關壓縮後 | 727×280 | 3.1MB | 55 | 約 60 |
| macOS，關壓縮前 | 727×480 | 5.3MB | 26 | 26 |
| macOS，關壓縮後 | 727×480 | 5.3MB | 48.5 | 約 58 |
| Android 模擬器 | 356×280 | 2.6MB | 10 | 10 |

macOS 的測試驅動每個 animation frame（約 60Hz）才改一次內容，所以約 60 fps 是這個測試的上限，不是管線的上限（單幀處理約 8–12ms）。流水線與預設 60 fps 在螢幕鎖定時無法在 macOS 上量測，未有數據。

## 現況與限制

- 傳輸為未壓縮 RGBA / PNG；H.264 + WebCodecs 管線尚未實作。
- 已驗證：macOS、Android 模擬器、iOS 模擬器上鏡像 Flutter widget（`RepaintBoundary` 路徑）、手勢回控。
- 尚未驗證：iOS `drawHierarchy` 與 Android PlatformView 的擷取（需要地圖之類的 PlatformView）、實體裝置。
