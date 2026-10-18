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
  nativeCapture: true, // 原生 view（地圖等）；Flutter 自己畫的內容不需要
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
| `1` | 未壓縮 straight（非預乘）RGBA，`w × h × 4` bytes |
| `2` | JPEG（有損、不含 alpha），只用於原生擷取（`nativeJpegQuality`） |

代碼 0（PNG）、3（WebP）、4／5（H.264）曾經實驗過、已移除（網頁端收到會丟棄）：PNG 與 WebP 的編碼太慢，H.264 的幀率沒有提升，實測見「Android 的其他壓縮」一節。

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
- Flutter 的 `onTap` 在同時註冊 `onDoubleTap` 時會等約 300 ms 才觸發（要確認不是雙擊），這是 Flutter 的標準行為，實測單擊到畫面更新約 395 ms；語意手勢（網頁判斷）沒有這個延遲。
- 要「單擊立即反應、雙擊仍由 Flutter 判斷」：單擊改用 `Listener` 在放開時立刻處理（`Listener` 不進手勢競技場，不會被壓住；自己檢查位移小於 `kTouchSlop`、按住時間小於 `kLongPressTimeout`），雙擊仍用 `GestureDetector.onDoubleTap`（第二下放開時觸發，沒有額外等待）。範例 plugin 就是這樣寫，實測單擊到畫面更新降到約 46 到 69 ms。

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
| 重繪事件驅動的擷取迴圈 | 內容重繪時（`AqutterNative` 內的 `RepaintBoundary`）喚醒擷取迴圈，擷取預設不限制頻率（可用選填的 `maxFps` 當硬上限），由重繪速度與擷取耗時決定；閒置時只留低頻逾時（補定格幀等計時事件用），幾乎不耗 CPU。不用固定週期的輪詢：輪詢頻率若接近內容的重繪頻率（都是 60Hz），相位會慢慢漂移，有時兩輪撞同一幀、有時整個週期沒被碰到，實測漏掉一成到四成的幀。沒有變動通知的來源（自訂擷取、iOS 的 PlatformView）以 `eventDriven: false` 兩倍目標幀率輪詢。 |
| 解析度政策 | `quality: AqutterNativeQuality`：`smooth`（移動中固定在 `minScale`，預設 0.5）、`sharp`（一律基準解析度）、`auto`（依擷取耗時在 `minScale` 與 1.0 之間自適應，每幀預算 `autoBudget`，預設 30 ms，連續幾幀超過才降、連續很多幀都很快才升）。沒指定時，原生擷取（地圖等）用 `smooth`，Flutter 自己畫的內容用 `auto`。內容停止變動 `settleDelay`（250ms）後補一幀完整解析度的定格幀，靜止畫面維持清晰。 |
| 長寬比對齊 | `matchViewportAspect: true`（預設關閉）：子畫面在可用空間內置中，長寬比改成與網頁元素一致。全螢幕的 widget 鏡像到小方框時，不開會多擷取被 `fit` 裁掉的部分、幀也較大；開了之後每個像素都對應網頁上看得到的內容。網頁回報尺寸前維持填滿。 |
| 預設 60 fps | `AqutterNative.fps` 與 `AqutterNativeSession.fps` 預設 60（上限 120）。內容沒重繪、網頁不可見、對方來不及處理時實際幀率會自動更低。 |
| 看不到就暫停 | 所有連線都回報 `visibility: false`（元素捲出視窗、`display: none`、分頁隱藏）時，工作階段停止擷取與送幀；任何一個連線重新看得到時立刻補一幀。新連線預設為看得到。 |
| 只畫最新一幀 | 網頁在每個繪製週期只畫最新收到的一幀；每一幀在收到時就已回 `ack`（不等畫完，否則確認的往返會多出一個繪製週期，卡住原生端的送幀）。JPEG 非同步解碼完成時若已有更新的幀開始繪製就放棄舊的，不會讓舊幀蓋掉新幀。 |
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

- 傳輸為未壓縮 RGBA（預設，所有平台）或 JPEG（只用於原生擷取，`nativeJpegQuality`）；PNG、WebP、H.264 實驗過、已移除。
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

（已經實作並實測、程式碼已移除：Android 硬體編碼的幀率與未壓縮相同，因為瓶頸在擷取，見「Android 的其他壓縮：WebP 與 H.264」一節。）

在那之前，更值得先做的是降低讀回的成本（目前 Android 的真正瓶頸），例如只讀回變動區域，或評估能否避開 CPU 讀回。

## 只傳變動區域與去掉 alpha 的評估（結論：都不值得現在做）

在 Android 平板（release）上量 `toImage` 與 `toByteData` 的成本，被鏡像內容是 1590×402、約 900 個彩色方塊的畫面。

| 讀回的區域 | toImage | toByteData | 合計 |
|---|---|---|---|
| 全部 64 萬像素 | 13.8 ms | 9.7 ms | 23.5 ms |
| 1/2 面積（整條的一半） | 13.1 ms | 5.6 ms | 18.7 ms |
| 1/4 面積 | 12.3 ms | 4.3 ms | 16.6 ms |
| 1/16 面積的整條 | 12.8 ms | 4.2 ms | 17.0 ms |
| 寬高各 1/4（1/16 面積的方塊） | 10.0 ms | 3.6 ms | 13.6 ms |

| 其他項目 | 成本 |
|---|---|
| 三種輸出格式（straight／premultiplied／unmodified）的讀回 | 24.0 到 27.9 ms，沒有有意義的差異 |
| Dart 端把 RGBA 轉成 RGB（全畫面） | 2.95 ms |
| Dart 端逐像素比對兩幀找變動範圍（全畫面） | 0.96 ms |

**只傳變動區域**：技術上可行，但省得不多。

- `OffsetLayer.toImage(rect)` 是公開 API，可以只讀回一塊區域；變動範圍也能用 1 ms 的逐像素比對在讀回後找出來。
- 但 `toImage` 有約 10 到 14 ms 的固定成本，與區域大小無關（要重放整個圖層並等 GPU），`toByteData` 也有約 4 ms 的底。縮到 1/16 面積，合計仍有 13.6 ms，只比全畫面少約 40%。
- 只在「讀回後比對、只傳變動矩形」時，讀回成本不變，省的是傳輸與網頁 `putImageData`，加起來約 3 ms（全畫面約 30 ms 的 10%），主要好處是少耗記憶體頻寬。
- 要讓讀回也變小，必須由 App 告知哪一塊變了（目前 Flutter 沒有這個資訊），並在協定加入矩形欄位。
- 自適應解析度（降到 0.5 倍就是 1/4 的像素）能拿到同樣量級的收益，且不需要 App 配合，已經有了。

**去掉 alpha**：淨效果是負的。

- 位元組少 25%，但傳輸只占約 2 ms，省下不到 0.5 ms。
- 讀回出來就是 RGBA，去 alpha 要在 Dart 多跑一遍 2.95 ms 的轉換；網頁的 canvas 需要 RGBA，還得再展開一次，並失去目前「直接以收到的緩衝區建立 `ImageData`、不複製」的做法。
- 不影響網頁本身的透明度：網頁端的 HTML 疊在 canvas 上，是否透明跟鏡像幀有沒有 alpha 無關。只有當被鏡像的內容本身有半透明區域、希望網頁畫面透過 canvas 透出下層時，去掉 alpha 才會讓那些區域變成不透明。

兩者的共同結論：這台裝置的瓶頸是 `toImage` 的固定成本，不是位元組數或區域大小；要再往 60 fps 靠，方向是降低固定成本（例如評估 `toImageSync`，或讓內容少重繪），而不是縮小資料。

## toImageSync 評估（結論：無法降低固定成本）

`toImageSync` 呼叫本身立刻返回，GPU 工作延後，看起來能把固定成本移開。在同一台 Android 平板（release）上量同一個畫面（1590×402），每個樣本都包含「內容剛重繪過」的條件，與實際鏡像一致：

| 路徑（內容每次都重繪） | 全畫面 | 1/4 面積 |
|---|---|---|
| `toImage` ＋ `toByteData`（現況） | 13.3 ＋ 9.3 ＝ **22.6 ms** | 13.7 ＋ 4.1 ＝ **17.8 ms** |
| `toImageSync` ＋ `toByteData` | 0.09 ＋ 24.1 ＝ 24.1 ms | 0.13 ＋ 16.9 ＝ 17.0 ms |
| 流水線（下一幀的 `toImageSync` 與上一幀的讀回重疊） | 24.8 ms | 19.6 ms |

- `toImageSync` 只是把 `toImage` 的 13 ms 搬到 `toByteData` 裡，總成本沒有降低（全畫面反而多 7%）。
- 流水線沒有帶來重疊效益：光柵化與讀回在同一個光柵執行緒上排隊，無法並行。
- 對照「內容沒有重繪」的情況：現況路徑只要 12.6 ms，比內容重繪的 22.6 ms 少約 10 ms。也就是說，這個「固定成本」主要是**把剛重繪的內容再光柵化一次**（畫面顯示一次，擷取再一次），與內容複雜度成正比，不是 API 的額外開銷。
- 因此降低成本的方向是減少被鏡像內容的重繪量（例如把不變的部分分到獨立的 `RepaintBoundary`），而不是換擷取 API。目前 Flutter 沒有公開的方法讓擷取重用螢幕顯示用的光柵結果。

## 降低擷取成本的後續實驗（結論：都沒有效果）

接續 toImageSync 的結論，在同一台 Android 平板（release、1590×402、內容每次擷取前都重繪）驗證三個可能降低擷取成本的做法，皆不成立：

| 實驗 | 結果（toImage ＋ toByteData） |
|---|---|
| 不變的複雜背景拆到獨立 `RepaintBoundary`（只重繪小圓） | 25.8 ms，與同一張畫布整個重繪的 25.4 ms 相同（再跑一輪 24.6 對 26.1 ms） |
| 被鏡像的內容畫在視窗之外（螢幕上那一份不用畫） | 25.0 與 26.9 ms，沒有比放在螢幕內的 20.2 與 24.5 ms 低 |
| 渲染後端改用 Skia（`--no-enable-impeller`） | 22.5 與 25.1 ms；Impeller 為 20.2 與 24.5 ms，總成本相同（Skia 的 `toImage` 較慢、`toByteData` 較快）；而且 Impeller 的選擇退出已被標示為棄用 |

- `toImage` 每次都會重新光柵化整個被擷取的子樹，不重用已快取的圖層，所以「拆分內容」不降低成本。
- 排除了「擷取與螢幕上同一幀搶光柵執行緒」的假設：內容移出視窗後成本沒有下降。
- 擷取成本因此主要取決於被擷取區域的像素數與內容複雜度。已有的手段是自適應解析度（降低像素數）；除此之外，剩下的是降低內容本身的繪製量。
- 尚未驗證：被鏡像的是 Android PlatformView（例如地圖）時，改用 `PixelCopy` 之類的原生擷取，可能比 `toImage` 快，但只適用於 PlatformView，不適用於 Flutter widget。


## 自訂畫面來源（`captureOverride`）

`RepaintBoundary.toImage` **擷取不到 Texture 與 PlatformView 的內容**：實測 Android 上的 Google 地圖（texture 模式）鏡像出來是完全透明的，連標記都沒有。這類內容若有自己的快照 API，用 `AqutterNative(captureOverride: …)` 把快照包成 `AqutterNativeFrame`（`format: rgba` 的未壓縮像素，或 `format: jpeg` 的 JPEG 位元組）回傳；擷取迴圈改成依 `fps` 輪詢，回傳 null 代表這一輪沒有新畫面。範例：[aqutter-plugin-google-maps](https://github.com/Aqutter/aqutter-plugin-google-maps) 用 `GoogleMapController.takeSnapshot()`。

> 上文「Android 上的 PlatformView 可用 `RepaintBoundary` 擷取」的說法是錯的：它從未被驗證，現在實測證明擷取不到。


## Android 原生擷取（`nativeCapture`）

`AqutterNative(nativeCapture: true)` 在 Android 直接擷取被鏡像的 `TextureView` 或 `SurfaceView`：在視窗的 view 階層裡找與目標區域重疊最多者（不含 WebView 內部），`TextureView` 用 `getBitmap`、`SurfaceView` 用 `PixelCopy`。實測 Google 地圖（texture 模式）可用，約 15 fps、每幀約 10 MB（滿版 3200 像素寬）。

- **不能複製 Flutter 自己的繪圖表面**：Impeller 以 Vulkan 呈現時，對它做 `PixelCopy` 回 `ERROR_SOURCE_NO_DATA`。
- **不能靠類名找 view**：release 版 R8 會把 Flutter 的類別混淆（實測 `FlutterSurfaceView` 變成 `rk`），所以只用型別與位置判斷。
- 需要 API 26 以上（`PixelCopy`）。輸出是預乘 alpha 的 ARGB_8888，被擷取的 view 本身不透明時與 straight alpha 相同。

## 原生擷取的 JPEG 幀與滿版地圖壓力測試

原生擷取（`nativeCapture: true`）時，畫面在動的幀可選擇在原生端壓成 JPEG（`AqutterNative.nativeJpegQuality`；`null` 或 0 以下（預設）不壓縮，所有平台都傳未壓縮的 RGBA）：每幀小一個數量級（iOS 模擬器滿版地圖：5.8 MB 的 RGBA 變 0.1 到 0.4 MB），傳輸與網頁端解碼都省。畫面停下來補的定格幀用 `nativeSettleJpegQuality`（預設 0.92，接近無損；`null` 才傳未壓縮的 RGBA，滿版時一張 27 MB 以上，Android 平板實測會讓接著的操作多卡約 0.4 秒）。iOS 與 Android 都支援；`skipUnchanged`（畫面與上一張相同就不回傳像素）iOS 與 Android 都有。

iOS 的原生擷取各階段耗時隨結果回傳（`draw`、`compare`、`encode`，毫秒），可從 plugin 的診斷讀到。iPad 模擬器滿版地圖實測：`drawHierarchy` 約 75 到 85 ms，與解析度幾乎無關（0.25 倍與 0.5 倍一樣），是這條管線的固定成本；比對 0.2 到 0.9 ms，JPEG 編碼 3 到 14 ms。`afterScreenUpdates: false` 只快約一成、幀率沒有改善，沒有採用。模擬器是軟體渲染，實機的數字要另外量。

demo-app 的 `map.html` 是滿版地圖加壓力測試：用合成的指標事件（與真實觸控走同一個辨識器）跑甩動、繞圈、雙指縮放加旋轉、連續張合、雙擊穿插與混戰，量 fps、幀間隔、延遲、每幀大小與各階段耗時，結果寫進 `probe.jsonl`。網址加 `?stress=1` 會自動開跑。

### Android 實機（平板，滿版地圖）

壓力測試實測：修正前 0 fps——滿版時目標區域與 Flutter 自己的（滿版）繪圖表面一樣大，原生擷取挑到後者，`PixelCopy` 回 `ERROR_SOURCE_NO_DATA`；現在有 `TextureView` 與目標重疊就優先用它，沒有才退回 `SurfaceView`。修正後：甩動、繞圈、雙指縮放、連續張合、雙擊穿插與混戰各場景 12 到 23 fps，每幀 59 到 150 KB（JPEG），畫面延遲約 15 到 20 ms，幀間隔 p95 約 70 到 110 ms。加上 Android 的 `skipUnchanged` 之後，手勢結束後約 0.6 到 1 秒就不再送幀（之前靜止時仍持續約 24 fps）。

雙擊放大場景的幀間隔最大值（約 560 ms）是壓力測試每次點擊之間刻意等的 0.5 秒：地圖沒在動，所以 `skipUnchanged` 不送幀，不是卡頓。

### 畫質與幀率、iOS 主執行緒占用

移動中的畫質是取捨：Android 平板滿版地圖實測，解析度下限 0.25 倍加 JPEG 0.7 是 14 到 25 fps、每幀 40 到 160 KB，但移動時畫面糊；0.7 倍加 JPEG 0.85 是 8 到 9 fps、每幀 420 到 750 KB，清楚但明顯變慢；現在的預設 0.5 倍加 JPEG 0.85 是 10 到 16 fps、每幀 110 到 460 KB。`AqutterNative.nativeJpegQuality` 與 google-maps 外掛的 `minScale` 可調。連續在動時「畫面沒變」的比對改成每 4 幀做一次（Android 一次約 10 到 15 ms），確認靜止後才每幀比。

iOS 的原生擷取在主執行緒，一次約 40 ms；連續擷取會把主執行緒吃滿，網頁每秒卡約 1 秒、甩動時幀間隔 1.2 秒（iPad 實機）。`nativeMaxDuty`（iOS 預設 0.7）每次擷取後讓出 `耗時 × (1/上限 − 1)`：上限 0.6 時 7 到 10 fps、卡頓約 110 ms；0.8 時 7 到 14 fps，但又偶爾卡約 1 秒；0.7 時 9 到 12 fps。混戰場景仍偶爾出現約 1.1 秒的卡頓，原因未查。

### 各平台的預設與 A/B 對照（實機，滿版地圖，3 輪平均）

JPEG 預設不開（所有平台，後來的雙機對照見下面「乾淨的 RGBA 對 JPEG 對照」一節；iOS 原本預設是 JPEG，現已改為 RGBA）。以下是當時的對照（`--dart-define=AQUTTER_MAP_BASELINE=true` 會關掉占用上限）：

- iPad：改進前 5 到 9 fps、幀間隔 p95 250 到 770 ms、JS 卡頓 400 到 1100 ms、每幀 3.8 到 9.4 MB；現在 9 到 11 fps、p95 150 到 175 ms、卡頓約 100 ms、每幀 0.19 到 0.5 MB。
- Android 平板：未壓縮 RGBA（現在的預設）13.5 到 17.6 fps、延遲 63 到 74 ms；JPEG 0.85 只有 8.6 到 14 fps（軟體編碼每幀 20 到 30 ms，比傳 7 MB 還慢）。

Flutter 自己畫的內容（`toImage` 路徑，不是原生擷取）快得多：全螢幕、每幀整個畫面都在變的動畫，iPad 實機 56 到 58 fps、延遲 18 到 20 ms（每幀 11 到 12 MB）；Android 平板 23 到 27 fps。所以瓶頸是原生擷取（iOS `drawHierarchy` 約 40 ms），不是 WebSocket 傳輸。

網頁內的 YouTube 影片（IFrame API，1080p）與右下角的鏡像同時跑：Android 平板影片每秒前進 1.0 秒、鏡像約 50 fps；iPad 影片同樣穩定播放，鏡像 60 fps、延遲約 11 ms。iOS 預設需要使用者手勢才播放影片；殼提供 `--dart-define=AQUTTER_MEDIA_AUTOPLAY=true` 供自動化測試放行，預設關閉。

### iPad 偶發的 1 秒卡頓

iPad 實機「混戰」場景（隨機甩動、縮放、點擊）約每 7 到 10 輪出現一次約 1013 ms 的網頁卡頓。同一時間 Flutter 的 UI 執行緒也量到 1012 到 1015 ms 的停頓（`--dart-define=AQUTTER_NATIVE_DIAG=true` 的監看），而原生擷取沒有任何單次超過 300 ms，所以是 App 的主執行緒被其他工作擋住，不是鏡像管線造成的；懷疑是 Google Maps SDK 在密集縮放時的主執行緒工作，沒有再往下查。iOS 結束後是否還能操作，改用「原生端現算地圖中心的經緯度，拖曳前後比較」判斷（iOS 的 `moveCamera` 不更新相機回報，不能只看相機）。

### 傳輸方式評估：WebSocket、自訂 URL scheme、WebRTC（實測）

用合成的固定大小幀（走現行 WebSocket 鏡像管線）對照「網頁用 `fetch` 向 App 拉資料」（iOS 自訂 scheme `WKURLSchemeHandler`；Android 虛擬 https 主機加 `shouldInterceptRequest`），各 6 秒：

| 幀大小 | Android WebSocket | Android 拉取（1／2 個同時） | iPad WebSocket | iPad 拉取（1／2 個同時） |
|---|---|---|---|---|
| 1 MB | 109 MB/s、7 ms | 70／117 MB/s、14／16 ms | 57 MB/s（60 fps 上限）、6 ms | 709／888 MB/s、1.3／2 ms |
| 3.8 MB | 270 MB/s、42 ms | 111／150 MB/s、34／51 ms | 229 MB/s（上限）、6 ms | 771／801 MB/s、5／10 ms |
| 7.6 MB | 278 MB/s、81 ms | 109／159 MB/s、70／96 ms | 458 MB/s（上限）、10 ms | 531／616 MB/s、14／25 ms |
| 11.5 MB | 273 MB/s、125 ms | 119／179 MB/s、97／128 ms | 691 MB/s（上限）、16 ms | 491／618 MB/s、23／37 ms |

- WebSocket 在 iPad 被「每個顯示幀只畫一次」限制在 60 fps（欄位是下限）；拉取沒有這個限制，所以小幀的吞吐看起來高，不代表傳輸更快。
- Android 拉取慢 2 到 2.5 倍：每個請求都要經過 Dart 回呼。大幀時兩個平台的拉取都不比 WebSocket 快。
- 拉取在 iOS 要讓 `fetch` 能讀，自訂 scheme 的回應必須是 `HTTPURLResponse` 並帶 `Access-Control-Allow-Origin`（現行 `CustomSchemeHandler` 回的是不帶標頭的 `URLResponse`，頁面來自 http 時 `fetch` 一律失敗）；Android 的自訂 scheme 不能 `fetch`，要改用虛擬 https 主機。
- 「不排隊」的好處來自未確認幀數，不是傳輸方式：`AQUTTER_NATIVE_MAX_INFLIGHT`（預設 3）調成 1，Android 平板 11.5 MB 的延遲從 125 ms 降到 44 ms、幀率 23.8 降到 22；7.6 MB 延遲 81 降到 33 ms、幀率 36.5 降到 29；3.8 MB 延遲 42 降到 19 ms、幀率 70.7 降到 50。吞吐在大幀幾乎不變，中小幀會掉。
- 但地圖是擷取受限：Android 滿版地圖壓力測試（3 輪）上限 2 與預設 3 幾乎一樣（13.6 到 18.6 對 13.5 到 17.6 fps、延遲 62 到 73 對 63 到 74 ms），所以地圖不受這個值影響。
- WebRTC：Android arm64 release APK 實測從 36.7 MB 變 72.2 MB（加 `flutter_webrtc 1.6.2`，+35.5 MB）；iOS 沒量。傳輸不是瓶頸，不建議採用。

### 每個鏡像各自設定在途幀數

在途（已送出、未被確認）幀數的上限可以**每個鏡像各自設定、執行中隨時改**：App 端 `AqutterNative(maxInFlight: 1)`，網頁端 `<aqutter-native max-in-flight="1">`（改屬性立即生效，重連時補送；底層是 `{"type":"config","maxInFlight":N}` 控制訊息，1 到 8，其他值被忽略）。兩邊都設時後設的覆蓋先設的；不設用預設 3，`--dart-define=AQUTTER_NATIVE_MAX_INFLIGHT=N` 只改這個預設。

Android 平板、合成幀（傳輸受限），同一個建置：預設 3 對 `max-in-flight="1"`：3.8 MB 80 fps／36.8 ms 對 70 fps／15.1 ms；7.6 MB 38.7 fps／76 ms 對 37.3 fps／27 ms；11.5 MB 24.7 fps／119.8 ms 對 27 fps／35.5 ms。延遲降到約三分之一到一半，幀率差不多；另一次用編譯時設定 1 量到中小幀幀率會掉（3.8 MB 70.7 變 50 fps），兩次建置與時間不同，不確定是波動還是設定路徑差異。擷取受限的內容（例如地圖）調這個值沒有差別。

### 自動調節在途幀數（實驗，預設關閉）

`<aqutter-native max-in-flight="auto">` 或 `AqutterNative(autoMaxInFlight: true)`：每個鏡像的在途幀數由控制器探測決定（`native_inflight.dart`）——每秒檢查一次，各候選值試 3 秒（先 3、再 1，必要時 2），1 的實際幀率達到 3 的 90%（2 要 95%）就採用較小的值；選定後維持 30 秒再重新探測，內容靜止（低於 2 fps）不探測。

Android 平板實測（同一個建置，執行中改屬性，每個設定量 20 秒）：

- 全螢幕、每幀都在變的動畫（Flutter `toImage` 路徑，6.7 MB 的幀）：預設 3 是 24.1 fps、延遲平均 67 ms（最大 407 ms）、網頁卡頓 284 ms；固定 1 是 13.6 到 14.2 fps（掉 42%）、延遲 33 到 36 ms；自動是 21.6 到 23.6 fps、延遲 48 到 64 ms（最大 165 到 230 ms）、卡頓 95 到 112 ms。自動保住幀率，同時壓低最大延遲與卡頓。
- 滿版地圖壓力測試（3 輪）：自動反而較差，11.2 到 15.1 fps，預設 3 是 14.6 到 19.4 fps（約低 15 到 20%），且輪與輪之間的差距大。手勢內容會變、試 3 秒的幀率噪音大，探測可能選到不合適的值，探測當中的 1 也會讓擷取與傳輸無法重疊。

所以自動模式目前只適合內容穩定的畫面（例如持續播放的動畫），**不要用在手勢互動的地圖**，預設維持 3。要改進的方向是只在內容穩定時探測、或用多次量測的中位數。

### Android 的其他壓縮：WebP 與 H.264（實測）

滿版地圖壓力測試，Android 平板，解析度下限 0.5：

| 傳輸 | fps（3 輪平均範圍） | 延遲 | 每幀大小 | 備註 |
|---|---|---|---|---|
| 未壓縮 RGBA（預設） | 13.5 到 17.6 | 63 到 74 ms | 約 7 MB | |
| JPEG 0.85 | 8.6 到 14 | 約 60 到 90 ms | 120 到 480 KB | 軟體編碼每幀 20 到 30 ms |
| WebP 0.85 | 2.9 到 4.8 | 125 到 225 ms | 120 到 330 KB | 軟體編碼每幀約 300 ms，不可行，已移除 |
| H.264（硬體編碼，12 Mbps） | 13 到 16 | 61 到 76 ms | 65 到 258 KB | 幀率與未壓縮相同，每幀小 30 到 100 倍 |

（以下 H.264 的實驗程式碼已從 repo 移除，保留結果供參考。）

- H.264 實作：`AqutterH264Encoder`（`MediaCodec` Surface 輸入、輸出走非同步回呼，關鍵幀前補 SPS／PPS）；協定 `fmt=4`（關鍵幀）、`fmt=5`（非關鍵幀）；網頁端用 WebCodecs `VideoDecoder`（`avc: {format: 'annexb'}`），需要安全情境（https 或 `localhost`，Android 的 `localhost` 符合）。以 `--dart-define=AQUTTER_NATIVE_COMPRESS=h264` 在 Android 開啟，預設關閉。硬體編碼本身只要 5 到 7 ms，幀率沒有提升是因為瓶頸在擷取（約 25 到 40 ms 的 `getBitmap`）；它的價值是頻寬（例如遠端或較慢的傳輸）。
- **H.264 的每一幀都必須依序送到解碼器**：網頁端「只畫最新一幀」的合併、原生端「在途幀數達上限就丟幀」的流量控制對它都不能用，丟任何一幀後面的幀就解不出來，畫面會破碎或整片綠色。實作上 H.264 幀在網頁端收到就直接解碼、原生端不丟 H.264 幀（來不及時是擷取端不再擷取）。第一版沒處理，畫面破圖嚴重。
- 第一版 H.264 還有兩個效能問題：在主執行緒同步等編碼器輸出（每次最多 40 ms）、每幀多複製 7 MB 未壓縮像素做比對；改成非同步輸出、只在需要比對「畫面沒變」時才複製之後，幀率從 4 到 9 升到 13 到 16。

### 乾淨的 RGBA 對 JPEG 對照與在途幀數 auto（雙機同時測，滿版地圖，3 輪）

畫面左上角的 HUD 會顯示目前的模式（傳輸格式、定格幀格式、解析度下限、主執行緒占用上限、在途幀數；auto 時顯示目前選到的值），每一筆測試結果也帶這個模式。`--dart-define=AQUTTER_NATIVE_COMPRESS=none` 讓 iOS 也傳未壓縮的 RGBA（保留主執行緒占用上限，只改壓縮）。

| 平台 | 模式 | 在途 | fps | 幀間隔 p95 | 延遲 | 每幀 | 超過 0.5 秒的停頓 |
|---|---|---|---|---|---|---|---|
| iPad | JPEG 0.85 | 3 | 9.9 | 159 ms | 43 ms | 344 KB | 0／21 |
| iPad | JPEG 0.85 | auto | 8.9 到 10.5 | 145 到 161 ms | 31 到 44 ms | 310 到 346 KB | 0 |
| iPad | RGBA | 3 | **13.2** | 103 ms | 51 ms | 4000 KB | 2／21 |
| iPad | RGBA | auto | 11.3 到 13.2 | 89 到 112 ms | 24 到 47 ms | 3930 到 4011 KB | 1 |
| Android 平板 | RGBA | 3 | **15.8** | 98 ms | 68 ms | 6965 KB | 2／22 |
| Android 平板 | RGBA | auto | 10.7 到 15.9 | 87 到 134 ms | 56 到 71 ms | 6841 到 7168 KB | 8 |
| Android 平板 | JPEG 0.85 | 3 | 11.6 | 154 ms | 38 ms | 387 KB | 5／21 |
| Android 平板 | JPEG 0.85 | auto | 9.4 到 11.5 | 138 到 201 ms | 35 到 47 ms | 370 到 435 KB | 0 到 7 |

- **iPad 的 RGBA 比 JPEG 快約 33%**（13.2 對 9.9 fps）。先前「iPad 用 RGBA 比較差」的印象來自「改進前」基準：它同時關掉了壓縮、定格幀壓縮與主執行緒占用上限，iPad 當時的 1 秒卡頓與低幀率主要是缺少占用上限造成的，不是 RGBA。代價是每幀 4 MB 對 344 KB、延遲高約 8 ms、21 個回合裡出現 2 次超過 0.5 秒的停頓（JPEG 沒有）。iOS 預設目前仍是 JPEG。
- **auto 在兩個平台、兩種格式都沒有提升幀率**，只把延遲降了一些，Android 的 RGBA 還多出長停頓。auto 選到的值在各場景間不固定。
- 兩個平台上，每格的幀率範圍都很寬（例如 Android RGBA 11.6 到 20.3），不同場景之間差別比格與格之間的差別還大。

### 現行預設（RGBA）

- 所有平台預設傳未壓縮的 RGBA；JPEG 要用 `AqutterNative(nativeJpegQuality: …)` 明確開啟（0.85 是實測用的值）。依據是上面的雙機對照：iPad RGBA 13.2 fps 對 JPEG 9.9 fps、Android 平板 15.8 對 11.6 fps；代價是每幀大很多（iPad 約 4 MB、Android 約 7 MB），頻寬或記憶體受限時才值得開 JPEG。
- 原生擷取佔用主執行緒的上限預設 0.7（`nativeMaxDuty`，iOS 與 Android 都是）；在途幀數預設 3，`max-in-flight` 可每個鏡像各自設定。Android 平板量測：0.7 的幀率與不限制差不多（14.4 對 14.7 到 15.8 fps），延遲約少 20 ms（50 對 68 到 72 ms）；單次量測。
- 在途幀數 2 與 3 在兩個平台上幾乎沒有差別（Android 15.1 對 14.7 fps、iPad 13.0 對 12.8 fps，在量測波動之內）。

### 去掉 alpha：原生擷取上實測（實驗已移除）

前面「去掉 alpha」的評估量的是 Flutter 路徑；後來在原生擷取（滿版地圖，RGB 每像素 3 bytes，原生端轉換、網頁端展開回 RGBA）上實測，兩台同時、同一個時段、各 21 個回合：

| 平台 | 模式 | fps | 延遲 | 每幀 | 網頁卡頓 | 原生端轉換 |
|---|---|---|---|---|---|---|
| iPad | RGB | 13.2 | 52 ms | 2969 KB | 101 ms | 0.1 到 0.2 ms |
| iPad | RGBA | 13.1 | 51 ms | 4016 KB | 101 ms | — |
| Android 平板 | RGB | 11.5（8.4 到 15.9） | 70 ms | 5297 KB | 232 ms | 7 到 8 ms |
| Android 平板 | RGBA | 14.1（9.2 到 18.5） | 51 ms | 7005 KB | 181 ms | — |

- iPad：位元組少約 26%，幀率與延遲都沒有差別（13.2 對 13.1 fps、52 對 51 ms）。
- Android：轉換要約 7 到 8 ms（在主執行緒）、位元組少約 24%，結果幀率反而低 18%、延遲高約 19 ms，更差。
- 結論與先前的推論一致：瓶頸是讀回，不是傳輸，少傳 25% 的位元組沒有好處；Android 上轉換的成本還是淨損失。程式碼已移除。

### 幀率目標 `fps` 設得很大（240）對照 60（簡單測試）

Flutter 自己畫的全螢幕動畫（`toImage` 路徑），每個設定 2 回合 × 20 秒，兩台同時：

| 平台 | `fps` | 畫出的 fps | 原生端送出（每秒） | 延遲 | 每幀 | 幀間隔 p95 |
|---|---|---|---|---|---|---|
| iPad | 60 | 39.3、53（暖機不穩） | 60.0 | 8.4、17.3 ms | 10.9 MB | 33 到 34 ms |
| iPad | 240 | 60、60 | 60.0 | 9.8 ms | **3.8 MB** | 17 ms |
| Android 平板 | 60 | 29.6、29.1 | 29.9、29.6 | 50.7 到 54.2 ms | 6.7 MB | 51 到 55 ms |
| Android 平板 | 240 | 29.7、28.6 | 29.7、28.8 | 48.1 到 52 ms | 6.7 MB | 51 到 57 ms |

- 上限沒有綁住：兩台送出的幀數都不隨 `fps` 變（iPad 固定 60 次每秒，等於這個動畫的重繪速率；Android 約 30 次每秒）。沒有量到「沒有上限就失控」；iPad 的重繪只有 60 次每秒，我沒有在 120 Hz 的重繪下測。
- 有影響的是自適應預算（`1000 / fps × 0.9` ms）：iPad 設 240 時預算很緊（約 3.8 ms），解析度被壓低，每幀從 10.9 MB 降到 3.8 MB，反而穩穩跑到 60 fps、p95 17 ms；設 60 時維持全解析度，但前一回合只有 39 fps。Android 本來就在解析度下限，兩者幀大小相同。
- 沒有量 CPU 與耗電；每格只有 2 回合，iPad 的 60 設定第一回合偏低可能是暖機。

### 解析度政策取代 `fps` 與 `adaptive`

`AqutterNative` 原本的 `fps`（目標幀率）與 `adaptive`（自適應開關）已移除，改成：

- `quality`：`smooth`／`sharp`／`auto`（見上表）。原因是 `fps` 在量測裡從來沒有綁住過擷取頻率（地圖的擷取要 40 ms 以上），它真正的作用是間接決定自適應的時間預算（`1000 / fps × 0.9` ms），也就是解析度，這個關係藏得太深；把解析度的決定改成明確的政策。
- `maxFps`：選填的擷取頻率硬上限，預設不限制；沒設時 `AqutterNativeSession` 以固定 16 ms 輪詢（沒有重繪事件的來源）。
- `autoBudget`：`auto` 政策的每幀預算，預設 30 ms（等於原本地圖外掛 `fps` 30 的預算）。
- `minScale` 仍是解析度倍率下限（線性，預設 0.5）：`smooth` 的固定倍率、`auto` 的下限。

上面「`fps` 設得很大（240）對照 60」那一節是在這個改動之前用舊參數量的，保留當作紀錄。
