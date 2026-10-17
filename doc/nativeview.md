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

一幀是**兩則**連續的二進位訊息：先標頭（24 bytes）、再像素（不把像素複製進同一個緩衝區，手機上複製數 MB 要花數毫秒）。WebSocket 保證順序，網頁端嚴格依「標頭、像素、標頭、像素…」交替解讀；重新連線時重新從標頭開始。標頭 little-endian：`[w u32 | h u32 | fmt u32 | seq u32 | sentAt f64 (epoch ms)]`，`seq` 是每個工作階段從 1 遞增的序號。

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
| `pointer` | `phase`（`down` / `move` / `up` / `cancel`）、`id`（網頁的 pointerId）、`x`, `y`、`t`（事件的硬體時間戳，毫秒）、`pointerType`；只在網頁 `input="pointers"`（或 `both`）時送出 |
| `command` | `name`、`args`（自訂；網頁以 `send` 送出） |

### 原始指標事件注入

`AqutterNative(injectPointers: true)` 會把 `pointer` 訊息注入 `child`：只對被鏡像的子樹做 hit test（不走整個 App 的 hit test，鏡像通常墊在 WebView 之下，全域 hit test 會先撞到上面的 WebView），每個指標在按下時 hit test 一次並記住路徑，移動與放開沿用，與 Flutter 自己的行為一致。因此 `GestureDetector`、`ScaleGestureRecognizer`、地圖手勢都照常運作，連點、長按、多指縮放都由 Flutter 判斷。

- 網頁的 pointerId 會對應成不與真實觸控衝突的內部 id；滑鼠與觸控筆以觸控注入（主要按鍵）。
- 與語意手勢（`tap` / `pan` / `pinch`）互斥或並用由網頁的 `input` 屬性決定，見 aqutter 文件。
- Flutter 的 `onTap` 在同時註冊 `onDoubleTap` 時會等約 300 ms 才觸發，這是標準行為，語意手勢（網頁判斷）沒有這個延遲。

另有兩種協定內部訊息，由 host 處理、**不會**轉給 `onMessage`：

| type | 欄位 | 用途 |
|---|---|---|
| `ack` | `seq` | 網頁每**收到**一幀（標頭與像素都到齊時）就回一個，不等畫完 |
| `resize` | `width`、`height`（CSS 像素）、`dpr` | 網頁回報顯示尺寸；連線時與尺寸改變時送 |
| `visibility` | `visible`（bool） | 網頁回報元素是否看得到；連線時與改變時送 |

## 效能設計

| 機制 | 說明 |
|---|---|
| 沒變就不擷取 | `AqutterNative` 內的 `RepaintBoundary` 會計數「真的重繪了幾次」；子樹沒重繪、也沒有新連線或解析度變動，這一輪就不擷取、不送出。閒置時 CPU 與頻寬接近 0。`skipUnchanged: false` 可關閉（內容以 Flutter 看不到的方式改變時）；`nativeCapture`（PlatformView）一律每輪擷取。 |
| 依網頁尺寸擷取 | 網頁回報顯示尺寸後，擷取成「與網頁元素等面積」的像素數（含 devicePixelRatio；倍率上限 `maxPixelRatio`，預設 3）；回報前用 `pixelRatio`。以面積計算，被鏡像對象與網頁元素長寬比不同時也不會過度擷取；長寬比相同時剛好 1:1，建議兩者長寬比一致。 |
| 流量控制 | 每個連線最多 `aqutterNativeMaxInFlight`（3）幀未被確認；超過就不再送給該連線，所有連線都滿時連擷取都停。網頁慢或分頁不可見（`requestAnimationFrame` 暫停）時不會在記憶體堆積。 |
| 同 id 取代 | 同一個 session id 再次註冊時，新的取代舊的並承接既有連線（Flutter 重建子樹時會短暫出現兩次）；舊的稍後 dispose 不影響新的。 |
| 關閉 WebSocket 壓縮 | dart:io 的 WebSocket 預設會與瀏覽器協商 permessage-deflate，每幀數 MB 的原始像素都被 zlib 壓一次；host 以 `CompressionOptions.compressionOff` 關掉。macOS 實測 `send` 階段每幀 7.8ms → 1.5ms，幀率 42 → 55 fps（小元素）、26 → 48.5 fps（大元素）。 |
| 重繪事件驅動的擷取迴圈 | 內容重繪時（`AqutterNative` 內的 `RepaintBoundary`）喚醒擷取迴圈，擷取以目標幀率為上限；閒置時只留低頻逾時（補定格幀等計時事件用），幾乎不耗 CPU。不用固定週期的輪詢：輪詢頻率若接近內容的重繪頻率（都是 60Hz），相位會慢慢漂移，有時兩輪撞同一幀、有時整個週期沒被碰到，實測漏掉一成到四成的幀。沒有變動通知的來源（自訂擷取、iOS 的 PlatformView）以 `eventDriven: false` 兩倍目標幀率輪詢。 |
| 自適應解析度 | `adaptive: AqutterNativeAdaptive.resolution`（預設關閉）：連續幾幀擷取超過每幀預算才降低解析度倍率（有下限 `minScale`，預設 0.5）、連續很多幀都很快才升回；內容停止變動 `settleDelay`（250ms）後補一幀完整解析度的定格幀，靜止畫面維持清晰。 |
| 長寬比對齊 | `matchViewportAspect: true`（預設關閉）：子畫面在可用空間內置中，長寬比改成與網頁元素一致。全螢幕的 widget 鏡像到小方框時，不開會多擷取被 `fit` 裁掉的部分、幀也較大；開了之後每個像素都對應網頁上看得到的內容。網頁回報尺寸前維持填滿。 |
| 預設 60 fps | `AqutterNative.fps` 與 `AqutterNativeSession.fps` 預設 60（上限 120）。內容沒重繪、網頁不可見、對方來不及處理時實際幀率會自動更低。 |
| 看不到就暫停 | 所有連線都回報 `visibility: false`（元素捲出視窗、`display: none`、分頁隱藏）時，工作階段停止擷取與送幀；任何一個連線重新看得到時立刻補一幀。新連線預設為看得到。 |
| 只畫最新一幀 | 網頁在每個繪製週期只畫最新收到的一幀；每一幀在收到時就已回 `ack`（不等畫完，否則確認的往返會多出一個繪製週期，卡住原生端的送幀）。PNG 非同步解碼完成時若已有更新的幀開始繪製就放棄舊的，不會讓舊幀蓋掉新幀。 |
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
| Android 模擬器（debug） | 356×280 | 2.6MB | 10 | 10 |

實機（Android 平板／手機，release，自適應解析度開啟，內容每個 animation frame 都改變）：

| 版本 | 小元素（1107×280） | 大元素（1107×621） |
|---|---|---|
| 加自適應與定格幀 | 41 fps（3.5MB/幀） | 36 fps（5.1MB/幀） |
| 標頭與像素分兩則、未確認上限 3 | 48 | 41 |
| 收到就確認、事件驅動擷取 | **57** | **53.8**（穩態送出約 57.5，內容重繪約 58／s） |

iPad（iOS 26，release，自適應關閉，同一測試）：小元素（1124×280，4.9MB/幀）**59.5 fps**、大元素（1124×656，11.5MB/幀，約 668MB/s）**59.3 fps**；延遲 11 到 12ms。

穩態下送出端約 57 fps，內容每秒重繪約 59 次，已追上內容的更新速度；平均較低的時段是內容本身只更新 45 到 51 次。

macOS 的測試驅動每個 animation frame（約 60Hz）才改一次內容，所以約 60 fps 是這個測試的上限，不是管線的上限（單幀處理約 8–12ms）。曾試過讓兩個擷取重疊（流水線），macOS 上沒有可量到的差別（小元素 56.7、大元素 46.2 fps），因此沒有保留。

macOS release 最終：小元素 59.7 fps、大元素 59.5 fps（網頁端實測）；閒置 0。

## 量測要用 release

debug 版在持續重繪時 `debugNeedsPaint` 常落在「已標記、尚未繪製」的空檔，擷取會被一再跳過（曾使實機 debug 只有 3 到 5 fps）；現在遇到會先等下一幀畫完再試一次（實機 debug：小元素 45 fps、大元素 32 fps），但 debug 版仍有額外檢查與 JIT 成本，與 release 的 57 / 54 fps 有差距。效能數字一律以 release 為準。

## 現況與限制

- 傳輸為未壓縮 RGBA / PNG；H.264 + WebCodecs 管線尚未實作。
- 已驗證：macOS、Android 模擬器、iOS 模擬器上鏡像 Flutter widget（`RepaintBoundary` 路徑）、手勢回控。
- 尚未驗證：iOS `drawHierarchy` 與 Android PlatformView 的擷取（需要地圖之類的 PlatformView）、實體裝置。

## H.264 評估（結論：目前不做）

把 RGBA 原始像素換成 H.264 串流，能省多少、要付出什麼。數據來自 Android 平板（Brave，Chromium 155）上的 WebCodecs 實測，用瀏覽器端的硬體編碼器近似原生端的編碼成本；不是 App 內的 WebView，也不是原生 MediaCodec，只能當量級參考。

| 項目 | 現況（RGBA） | H.264（12 Mbps、硬體、即時） |
|---|---|---|
| 每幀大小 | 2.5 到 5 MB | 簡單畫面 2 到 3 KB；地圖類複雜畫面平均 26 KB，關鍵幀 130 到 150 KB |
| 網頁端繪製 | `putImageData` 0.2 到 2.2 ms | 解碼＋`drawImage` 約 3 到 5 ms（管線化後的吞吐） |
| 加進來的延遲 | 0 | 編碼 31 到 41 ms ＋ 解碼繪製 9 到 12 ms（逐幀、不排隊） |
| 解析度限制 | 無 | 寬高須為偶數（實測奇數寬 1523 無法編碼），編碼前要補齊 |

這個鏡像的瓶頸不在傳輸或網頁繪製，所以換 H.264 不會讓幀率變高：

- Android 每幀約 27 到 37 ms 的擷取，其中把畫面從 GPU 讀回記憶體（`toByteData`）占 19 到 26 ms。H.264 仍要先拿到像素才能編碼，這段不會消失。
- localhost 傳輸約 2 ms，網頁 `putImageData` 約 1 ms，省下的只有這兩項。
- 延遲反而增加約 25 到 35 ms，對「點擊要立刻有回應」的互動不利。

何時值得做：

- 鏡像要走**網路**（遠端除錯、非 localhost）時，每幀幾 MB 不可行，壓縮是必要的。
- 元素接近全螢幕或 4K，原始像素的記憶體頻寬與耗電成為問題時。
- 目標是降低手機的耗電與發熱，而不是提高 fps。

若要做，建議的設計：

1. 協定新增 `fmt=2`（H.264 Annex B）；網頁在連線時以 `capabilities` 告知是否支援 WebCodecs，不支援就維持 RGBA。
2. 只在 Android（MediaCodec）與 iOS／macOS（VideoToolbox）實作；Windows 與 Linux 維持 RGBA（編碼器要另外整合，且 WPE 的 WebCodecs 支援未驗證）。
3. 現有的「停止變動後補一幀完整解析度」改成補一幀無損（RGBA 或 PNG），文字邊緣不會殘留壓縮痕跡。
4. 新連線、尺寸改變時強制關鍵幀；寬高補成偶數，網頁端裁回。

在那之前，更值得先做的是降低讀回的成本（目前 Android 的真正瓶頸），例如只讀回變動區域，或評估能否避開 CPU 讀回。
