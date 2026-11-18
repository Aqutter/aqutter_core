<!-- REMINDER: Relative Paths Only! No file:///c:/... -->
# Plan: 2611172358 - ios-passthrough-drag-jitter
- Created: 2026-11-17
- Branch: feature/2611172358-ios-passthrough-drag-jitter
- Issue: Aqutter/aqutter_core#35
- Milestone: N/A（未指定）
- Base Branch: main
- Status: In Progress
- Completed: [Wait for Finish]

## Goals
iOS 穿透模式（#34）下，手指拖曳地圖時整張地圖會抖動（模擬器與 iPad 實機都會）。目標：拖曳時地圖跟著手指平順移動。

已知（上一輪量測，見 `.kn-project/archive/2611172115-ios-passthrough-verify.md` 的後續討論）：網頁每 16ms 送一個 `pan`、Dart 每 16ms 呼叫一次 `moveCamera`（每次 0–5ms）、主執行緒閒置，但螢幕上的地圖是停約 265ms 再一次跳 40–64 像素；用網頁合成事件驅動則是即時更新。**根因未確定。**

## Architecture
**已確認的事實**（iPad 實機）：現行穿透手勢路徑「手指 → 上層透明 WebView → 網頁手勢辨識 → `pan` 經 WebSocket → Dart → plugin `moveCamera` → `GMSMapView`」會抖；手指直接拖原生地圖不抖。

**目標行為**：iOS 穿透時，觸控**落在原生元素區域、且該點網頁沒有要接管的內容**，就直接交給原生地圖；落在網頁內容（按鈕、面板等疊在地圖上的 HTML）則照舊交給 WebView。決定以**觸控起點**為準（一個觸控序列從頭到尾歸同一邊）。

**為何需要兩層配合**（見 Key Decisions「設計分析」）：Flutter 手勢競技場（Dart 層）與 UIKit hit test（原生層）是兩件事，兩邊都要讓路，地圖才會收到手指：
1. **Dart 層**：`AqutterWebView` 的 platform view 在「原生觸控區域」內對 Flutter hit test 透明（自訂 `RenderProxyBox` 的 `hitTest`），地圖的 platform view 帶 `EagerGestureRecognizer` 贏得競技場。
2. **UIKit 層**：core 在 iOS 加一個透明的**觸控路由 view**（`NativeTouchRouter`，加在 Flutter 的根 view 最上層）。它的 `hitTest` 只在「原生觸控區域」內回傳底下的地圖 view（暫時關掉 WebView 的互動後以 root view 的 hit test 取得），其他點一律回 `nil`，讓觸控照原本路徑走。

**區域從哪來**：網頁端（`aqutter-js`）對每個穿透元素，在元素矩形內以 `document.elementFromPoint` 取樣：命中元素本身（或其 shadow 內部）的點屬於「原生」，其餘屬於「網頁」。把**網頁區域**以矩形清單隨 `layout` 訊息回報；原生區域 = 元素矩形 − 網頁區域。因此 DOM 的語意（`pointer-events`、堆疊順序、不透明覆蓋）自動成立，不必在元素上逐一標記。
- 不變：Android 與 mirror 模式完全不受影響（Android 不做路由，欄位被忽略）。
- 前置：新 core 配舊 client（沒有 `webRegions`）＝ 維持現行行為（全部走網頁）；新 client 配舊 core ＝ 多出的欄位被忽略。

**分階段**：先在 core 單獨做 spike 驗證「兩層路由」在 iPad 可行（用固定測試區域，不動契約），過關才實作契約與三個 repo；不過關就停下、歸檔結果，不硬做。
- 實作遵守 `kn-project-code-style`。

## Cross-Repo Scope
- **本計畫所屬 repo**: `aqutter_core`（契約正本 repo）
- **共用計畫 ID**: `2611172358-ios-passthrough-drag-jitter`　**共用分支名**: `feature/2611172358-ios-passthrough-drag-jitter`
- **參與 repo 與職責**:
  - `aqutter_core` — 解析 `webRegions`、計算原生觸控區域、Dart 層 hit test 閘、iOS `NativeTouchRouter`、對 plugin 暴露「原生觸控是否啟用」；spike 也在此　issue: `Aqutter/aqutter_core#35`
  - `aqutter-js` — 取樣並回報 `webRegions`（`layout` 訊息新增欄位）　issue: 待建立（核准後）
  - `aqutter-plugins`（`packages/google-maps`）— 原生觸控啟用時 `GoogleMap` 帶 `EagerGestureRecognizer`　issue: 待建立（核准後）
  - `aqutter`（殼）— 只改 `lib/aqutter.dart` 的轉出清單，加入 `AqutterNativeTouch`（rev 3，plugin 只依賴殼）；WebView 的 Dart 閘放在 core 的 `AqutterWebView` 內，殼不必動；合併後另需同步 manifest（見 Manual Follow-ups）　issue: 待建立
- **執行順序相依**: spike（core）→ core（契約提供方，先合）→ js、plugins（消費方，可平行，各自依賴 core 的契約但不依賴其程式碼）→ 端到端驗證。
- **跨 repo 檔案指涉**: 無需要讀取他 repo 的檔案才能實作本 repo 的部分（契約已寫死）；端到端驗證用 `aqutter-nuxt-app` 的 `app/pages/map-effects.vue`（只讀、本機覆寫）。
- **合併後的連動**: `aqutter` 的 manifest 同步 core／js／plugins 的新 ref、`aqutter-cli` snapshot、`aqutter-nuxt-app` 鎖定檔前進；文件「穿透的觸控」說明更新。

## Contract / 介面契約
- **契約正本 repo**: `aqutter_core`　**修訂號**: `rev 3`　**狀態**: `凍結（核准日 2026-11-18）`

### 1. 端點
本契約沒有 HTTP 端點。介面是既有的「網頁 → 原生」穿透訊息 `layout`（WebSocket JSON，`aqutter-js` 送、`aqutter_core` 收）新增一個欄位，加上 core 對 plugin 暴露一個旗標。

| # | 介面 | 方向 | 用途 |
|---|---|---|---|
| 1 | `layout` 訊息新增欄位 `webRegions` | `aqutter-js` → `aqutter_core` | 回報元素矩形內「網頁要接管觸控」的區域 |
| 2 | `AqutterNativeTouch.of(BuildContext)`（回傳 `ValueListenable<bool>`，`AqutterNative` 的 child 底下可讀；從 `package:aqutter_core/aqutter_core.dart` 匯出，並由殼 `package:aqutter/aqutter.dart` 轉出；plugin 只依賴殼，從殼取用） | `aqutter_core` → plugin | 告訴 plugin 目前觸控是否直接進原生（plugin 據此在原生 view 的手勢競技場宣告） |

### 2. 欄位
**#1 `layout`（既有欄位不變，僅新增）**
| 欄位 | 型別 | 必填 | 可空 | 預設值 | 單位／格式 | 限制 | 資料來源 | 序列化 |
|---|---|---|---|---|---|---|---|---|
| `type` `left` `top` `width` `height` `visible` `sentAt` | 既有 | 是 | 否 | — | 既有 | 既有 | 元素 `getBoundingClientRect()` | 既有 |
| `webRegions` | `Array<{x:number,y:number,width:number,height:number}>` | 否 | 否（不支援原生觸控的 client 整個省略） | 省略 | CSS 像素，**相對元素左上角**（x、y 可為 0；不得超出 `0..width`／`0..height`） | 至多 64 個矩形、互不要求不重疊；寬高皆 > 0 的有限數；超過 64 個時 client 先合併相鄰格再送 | `document.elementFromPoint` 取樣：命中元素本身或其 shadow 內部＝原生，其餘＝網頁 | 支援原生觸控時**一律輸出**（沒有網頁區域時為 `[]`，不得省略）；與上一則相同的內容不重送（沿用 layout 的去重） |

**#2 `AqutterNativeTouch.of(context)`**
| 項目 | 規則 |
|---|---|
| 值 | `true` 僅當：平台為 iOS、該 session 為穿透、最近一則 `layout` 帶有 `webRegions`（含 `[]`）、且元素可見。其餘（含 Android、mirror、收到不帶 `webRegions` 的 `layout`、元素不可見）為 `false`。 |
| 預設 | `false`；`context` 之上沒有 `AqutterNative` 時回傳恆為 `false` 的 listenable |
| 時機 | 變化時通知；plugin 只據此切換手勢宣告，不自行猜測。 |

### 3. 錯誤碼
無。`webRegions` 格式不合（非陣列、元素缺欄位、負或非有限數、超過 64 個）時，core **忽略整個 `webRegions`**（視為未提供，維持現行行為），不影響 `left/top/width/height/visible` 的解析，不中斷連線。

### 4. 狀態與規則
- 原生觸控區域 = 元素矩形 − `webRegions` 聯集；落點在區域內才走原生。區域邊界上的點屬於哪一邊**不保證**（±1 邏輯像素內），client 取樣已以 8px 為格，不依賴邊界精度。
- 決定以**觸控起點**為準，序列中途不重新決定。
- `webRegions` 與元素移動／捲動同步：`layout` 每次送出都帶最新的區域（相對元素，所以元素單純平移時區域不變、不必重算）。
- 取樣時機：與 `layout` 同一個排程（動畫畫面、`ResizeObserver`、捲動、視窗改變）外，加上元素或其祖先子樹的 DOM／class／style 變動；取樣是相對昂貴的操作，**同一畫面最多一次**，且最多每 100ms 一次（trailing）。
- 取樣解析度：以 **8 CSS px** 為格，格中心取樣，相鄰同類格合併成矩形。
- 網頁覆蓋層一律視為「網頁」，包含沒有 `pointer-events: none` 的裝飾層（與目前行為一致：它們本來就會吃掉事件）。**已知限制**：Flutter 端疊在原生區域之上的 plugin 覆蓋層（非 HTML）在原生觸控區域內不會收到觸控。
- 冪等：`webRegions` 是完整快照，不是增量；後到的覆蓋先到的。

### 5. 相容性
- 舊 client（不送 `webRegions`）＋新 core：行為與現在完全相同（`nativeTouch` 恆為 `false`）。
- 新 client＋舊 core：舊 core 忽略未知欄位，行為與現在相同。
- Android、macOS、Windows、mirror 模式：不得有任何行為改變（Android 即使收到 `webRegions` 也不啟用）。
- 公開 API 只新增，不改既有簽名；`AqutterNativeLayout` 新增的 `webRegions` 欄位納入 `==`／`hashCode`。

### 6. 變更紀錄
- 2026-11-18　rev 1 → rev 2：(1) 介面 #2 由「`AqutterNativeContext.nativeTouch`」改為 `AqutterNativeTouch.of(context)`——plugin 實際拿到的 `AqutterPluginContext` 來自殼套件 `aqutter`，加欄位要動殼；改由 core 以 `InheritedNotifier` 提供，plugin 在 `AqutterNative` 的 child 內讀取，殼維持不動。(2) 區域邊界歸屬改為「不保證（±1px）」（原寫邊界屬於網頁，Dart `Rect.contains` 與 UIKit `CGRect.contains` 都是左上含、右下不含，無法逐字保證）。影響：`aqutter_core`（已依 rev 2 實作）、`aqutter-plugins`（讀取方式）；`aqutter-js` 不受影響。
- 2026-11-18　rev 2 → rev 3：`AqutterNativeTouch` 要能被 plugin 取用，但 plugin 只依賴殼套件 `aqutter`，殼對 core 的轉出是 `show` 清單，沒有列入就看不到。改為由殼在 `lib/aqutter.dart` 把 `AqutterNativeTouch` 加入轉出清單（殼多一行改動，納入本計畫成為第四個 repo）。影響：`aqutter`（新增，issue 另建）、`aqutter-plugins`（從殼取用）；`aqutter_core`、`aqutter-js` 不受影響。

## Impact Files
（本 repo 自己的檔案；路徑相對 `aqutter_core` 根目錄。**spike 通過前，以下為預計，spike 若改變做法需回計畫更新。**）
- `lib/src/nativeview/native_mode.dart:140`（`AqutterNativeLayout`、`tryParse`）— 新增 `webRegions` 解析與驗證、納入 `==`／`hashCode`
- `lib/src/nativeview/native_session.dart:55`（`passthrough`）、`:161`（`updateLayout`）— 保存區域、計算 `nativeTouch`
- `lib/src/nativeview/native_host_io.dart:401`（layout 解析處）— 傳遞 `webRegions`；彙整各 session 的原生觸控區域
- `lib/src/nativeview/native_widget.dart:573`（`_buildPassthrough`）— 暴露 `nativeTouch` 給 plugin（`AqutterNativeContext`）
- `lib/src/webview/webview.dart:20`（`AqutterWebView`）— Dart 層 hit test 閘（區域內對 Flutter 透明）
- `ios/aqutter_core/Sources/aqutter_core/AqutterCorePlugin.swift`、`ios/aqutter_core/Sources/aqutter_core/NativeView/`（目錄）— iOS `NativeTouchRouter`（透明路由 view）與註冊；區域經 method channel 由 Dart 推下來
- `lib/src/nativeview/native_touch_gate.dart` (new) — hit test 閘的 RenderObject（獨立檔，避免 `webview.dart` 再變大）
- `test/nativeview_passthrough_test.dart` — `webRegions` 解析、`nativeTouch` 條件、舊 client 相容
- `doc/nativeview.md` — 「穿透的觸控」章節（行為、限制、驗證範圍）
- `.kn-project/archive/2611172358-ios-passthrough-drag-jitter.md` (new) — Phase 5 歸檔
- 其他 repo 的檔案不在此列，屬 `aqutter-js`、`aqutter-plugins` 各自的計畫。

## App-Flow Screens
（本 repo 無 `.kn-project/app-flow.json`，不適用。）

## Open Questions / 待確認事項
### Q1. 實驗證實後，是否在本計畫內繼續實作？ — ✅ 已確認
- **決議**：使用者回覆「本計畫實作」（2026-11-18）：在本計畫實作，補跨 repo 範圍與契約並重新核准。

### Q2. spike（core 單獨驗證兩層路由）在 iPad 上不過關時怎麼辦？ — 影響範圍：整個計畫
- [x] 選項 A：停下，把結果歸檔、開 PR（只含文件），修法另議　(建議，理由：不為了完成而硬做一個可能不能用的觸控層；iOS 觸控路由改壞會影響所有 iOS 穿透)
- [ ] 選項 B：改試其他做法再回來請示
- **決議**：選項 A　狀態：✅ 已確認

### Q3. 網頁覆蓋層（沒有 `pointer-events: none` 的裝飾層）算網頁區域是否可接受？ — 影響範圍：aqutter-js 的取樣語意
- [x] 選項 A：是，照 DOM 語意（建議，理由：與現在行為一致，不需要在元素上額外標記）
- [ ] 選項 B：加一個屬性（例如 `data-aqutter-native-through`）讓某個覆蓋層明確「穿過去給原生」
- **決議**：選項 A　狀態：✅ 已確認

## Manual Follow-ups / 人工收尾事項
- **[合併後]** 實機驗證 — 在 iPad 實機確認拖曳不再抖 — agent 無法觀察實機畫面，需要你回報

## Key Decisions
- **[Phase 0]** 目標 repo：`aqutter_core`（依據：穿透時手勢路徑與 iOS WebView 都在此；`aqutter-js`、`aqutter-plugins` 只讀）。
- **[Milestone]** 不指定，base `main`；整合主幹只有 `main`。
- **[方向]** 使用者選擇「直接開計畫修抖動」（不先單獨做實驗），所以實驗納入本計畫第一階段；實驗結果可能改變範圍，需重新核准。
- **[Q1 暫定]** Q1 的答案取決於 Phase 1 結果，使用者核准時未另行勾選；Phase 1 結束時再請示，Phase 2 之前必須已確認。
- **[完成後]** commit + 開 PR（使用者核准）。
- **[Phase 1 結果：沒有證實也沒有推翻]** 模擬器上，把觸控交給原生地圖的實驗**沒能讓原生地圖收到拖曳**：依序做了 (1) 隱藏原生 WebView＋打開 `GMSMapView` 的 scroll／zoom 手勢；(2) 再讓 plugin 的 `GoogleMap` 帶 `EagerGestureRecognizer`；(3) 再讓殼把 WebView 包進 `IgnorePointer`。每一步都用 `swipe` 拖曳後截圖比對，地圖都沒有移動。原因未確定，推測是 Flutter 端的 platform view 觸控仲裁（`FlutterTouchInterceptingView` 在 Flutter 手勢競技場決定前不放行）還有其他攔截者。因此「原生直接接觸控是否平順」**沒有驗證到**。
- **[Phase 1 續：觸控查到哪一層]** 未改任何檔案，以 `lldb` 在執行中的模擬器 app 查（WebView 原生層隱藏）：UIKit hit test 在地圖點 (200,500) 落在 `GMSVectorMapView`（地圖的 view 階層）；觸控事件有到 `ForwardingGestureRecognizer`、`GMSBlockingGestureRecognizer`；Flutter 端同一次觸控先後呼叫了 `blockGesture` 與 `releaseGesture`（Flutter 手勢競技場的輸贏回報）；`GMSMapView.settings` 的 `scrollGestures`／`zoomGestures` 與 `userInteractionEnabled` 都是開的，但拖曳後相機位置沒變（25.033, 121.565 z12 不變）。**推論（已於下一條確認）**：殼底層 Stack 裡同時有地圖與 WebView 兩個 platform view，Flutter 的手勢競技場把觸控判給最上層的 WebView 的 platform view、封鎖地圖那個，所以地圖永遠收不到拖曳；與前一輪「IgnorePointer 包 WebView 也沒用」的結果不矛盾（該實驗是否真的讓 WebView 退出競技場沒有驗證）。
- **[Phase 1 更正與確認：競技場推論成立]** 先更正：前面「三種暫時改法地圖都不動」的實驗，其中殼的 `IgnorePointer` 與 core 的覆寫**根本沒有被編進 app**（`pubspec_overrides.yaml` 寫了但沒重跑 `flutter pub get`，`package_config.json` 仍指向 pub cache），所以那次的負面結果不成立。重做並確認覆寫生效（`flutter pub get` 後 `package_config` 指向本機殼與 core）：
  - 不改（WebView 在競技場）：同一次拖曳，`blockGesture` 打在**地圖**的 `FlutterTouchInterceptingView`、`releaseGesture` 打在 **WebView** 的 → 競技場判給 WebView，封鎖地圖。
  - 殼把 WebView 包進 `IgnorePointer`、plugin 的 `GoogleMap` 帶 `EagerGestureRecognizer`、並隱藏原生 WebView：`blockGesture` 變成打在 **WebView**、`releaseGesture` 打在**地圖**；相機經度 121.565 → 121.665，**原生地圖被拖動**。
  - 平順度（模擬器錄影逐幀）：原生直接接觸控時，地圖在整段拖曳期間持續更新（約 0.6 秒內數十次、間隔 3–60ms），沒有先前「停約 265ms 再一次跳 40–64 像素」的現象。
  - 結論：**抖動來自現行路徑（網頁轉送 `pan` → Dart → `moveCamera`），原生直接接觸控是平順的**。實機（iPad）未驗證。
- **[Phase 1 其他量測]** 以 `sample` 抓拖曳期間主執行緒：幾乎閒置；以 `lldb` 確認 `GMSMapView.preferredFrameRate` 已是最大值。
- **[2026-11-18 拉取最新]** 各 repo 已 fast-forward 到遠端 main，本計畫分支已 rebase 到 `aqutter_core` `origin/main`（含 #37 無網頁連線時隱藏、#39 Windows 穿透）。`aqutter-nuxt-app` 新增 `app/pages/map-effects.vue`（自動挖洞、含疊在地圖上的互動 HTML 按鈕，按鈕自己 `pointer-events-auto` 並 `pointerdown.stop`）——可直接當本計畫的驗證頁：拖曳地圖區域要走原生，按鈕要仍能點。
- **[2026-11-18 新實驗：關掉 WKWebView 捲動與拖曳追蹤，沒有差別]** 假設「WKWebView 的捲動追蹤讓 run loop 進入 tracking 模式、節流地圖渲染」。暫時在 `AqutterWebView` 設 `scrollView.isScrollEnabled = false` 與 `scrollView.panGestureRecognizer.isEnabled = false`（本地 core 覆寫，`package_config` 已確認指向本機），在 map-effects 頁同一道 swipe 錄影逐幀比對：基準與改後都是穩定 26px／幀的位移夾雜 1–2 幀停頓、結尾一次跳 3 幀的位移，無差異。**假設不成立**，暫時改動已還原。附帶觀察：這次在新 main＋新頁面、模擬器合成 swipe 下，抖動比先前量到的（停約 265ms 再跳 40–64px）輕微得多，模擬器合成 swipe 不一定能重現使用者實機上的抖動；實機（iPad）仍是唯一可信的判準。
- **[2026-11-18 設計分析：競技場只解決一半]** 先前確認的是「Flutter 手勢競技場把地圖封鎖」，但要讓地圖真的收到手指，還需要 **UIKit 層**的 hit test 讓觸控落在地圖的 view 上。穿透時 WebView 的 platform view 疊在地圖之上，UIKit 把整個 WebView 範圍的觸控交給它外面的 `FlutterTouchInterceptingView`；Flutter 沒有提供「這個 platform view 在某些點對 UIKit 透明」的機制（`PlatformViewHitTestBehavior.transparent` 只管 Dart 端的 hit test）。先前實驗之所以成功，是因為把**原生 WebView 整個隱藏**。所以「地圖區域走原生、按鈕區域走網頁」不是只改手勢宣告就能做到，需要能依區域切換的 UIKit 層做法，目前沒有已驗證可行的方案。
- **[候選修法，皆未驗證]** (a) 區域切換：回報互動區域，依觸控落點動態切換 WebView 平台 view 的 `isUserInteractionEnabled`／隱藏（難點：touchesBegan 前就要決定，且會有 Flutter 與 UIKit 兩層狀態）；(b) 穿透時整頁地圖手勢走原生、HTML 按鈕改成「只在不被地圖覆蓋的區域可點」（行為變更，與 map-effects 頁疊在地圖上的按鈕衝突）；(c) 不改觸控路由，改查轉送路徑本身為何在真實觸控下出現停頓（目前未定位）。
- **[2026-11-18 iPad 實機重測：最新版仍會抖]** 以各 repo 最新 main（core 含 #37／#39、js 含 #19、plugin 含 #11，未做任何覆寫或補丁）裝到 iPad，在 map-effects 頁以 `auto`（穿透）拖曳地圖，使用者回報**仍然會抖**。結論：問題在實機與最新版都存在，不是舊版或模擬器合成 swipe 的假象；模擬器合成 swipe 不能當判準，後續驗證以實機為準。簽署團隊的暫時改動已還原，dev server 已停。
- **[2026-11-18 iPad 實機驗證：原生直接接觸控不抖]** 在 iPad 上套暫時補丁（殼把 WebView 包進 `IgnorePointer`、plugin 的 `GoogleMap` 帶 `EagerGestureRecognizer`、core 把 `AqutterWebView` 設 `isHidden`，本地覆寫已確認生效），手指直接拖曳原生地圖，使用者回報**不抖**。與前一條「最新版仍會抖」對照：**抖動來自現行「網頁轉送手勢 → Dart → moveCamera」路徑，原生直接接觸控在實機上平順，修法方向（讓觸控走原生）成立**。尚未解決的是如何在保留 HTML 按鈕可點的前提下做區域切換（見設計分析）。補丁、簽署團隊與覆寫已全數還原。
- **[2026-11-18 設計與契約草擬]** Q1 使用者回覆「本計畫實作」。補了 `## Architecture`、`## Cross-Repo Scope`、`## Contract`（rev 1，草擬）、`## Impact Files`，並新增 Q2、Q3。設計重點：以觸控起點決定走原生或網頁；Dart 層 hit test 閘＋UIKit 層路由 view 兩層配合；網頁區域由 `aqutter-js` 以 `elementFromPoint` 取樣回報；殼不動；先做 core 單獨 spike，過關才實作契約。**依 Rule 2／19／28，需使用者核准後才動程式碼；核准時 Q2、Q3 一併拍板。**
- **[2026-11-18 核准]** 使用者核准設計與契約 rev 1（凍結），並決議：Q2＝spike 不過關就停下、只歸檔文件開 PR；Q3＝照 DOM 語意；完成後＝commit + 開 PR（base main）。先做 Phase 2 spike（core 單獨）；過關後才為 `aqutter-js`、`aqutter-plugins` 建 issue 與共用分支。
- **[2026-11-18 Phase 2 spike 過關]** core 單獨實作兩層路由（Dart `NativeTouchGate`＋UIKit `NativeTouchRouter`），區域用測試值（元素矩形扣掉底部 120）、plugin 用本機暫時補丁（`GoogleMap` 帶 `EagerGestureRecognizer`），**iPad 實機**驗證：區域內拖曳、縮放走原生**不抖**；底部 HTML 按鈕照常可點；切 mirror 後觸控正常（修了一個 spike 缺陷：離開穿透與 session 釋放時沒清區域，路由 view 繼續攔截，現於 `setPassthrough(false)`／`dispose` 清除）。模擬器同樣通過，且拖曳後網頁端相機狀態（label）有同步。**實作時學到的兩點**：(1) 只關掉 WebView 外層 `FlutterTouchInterceptingView` 不夠，要連最外層 `ChildClippingView`（整個畫面大小）一併略過，hit test 才會落到地圖；(2) 實機 debug 版只能由 `flutter run` 啟動，從主畫面圖示重開會白屏，且重裝後要在 iPad 上重新信任開發者。
- **[暫時改動已全部還原]** nuxt-app、`aqutter` 殼、plugin 的 `node_modules` 副本、core 皆乾淨。
- **[程式碼風格]** 遵守 `kn-project-code-style`。

## Git Completion Policy
- PR 一律以 `--base main` 顯式指定 base (Rule 23)。
- Issue 綁定時，每個 commit 訊息與 PR body 都含 `Closes #${N}`。歸檔完成後於該 issue 張貼結案留言。
- Issue 的關閉發生在合併後清理，不在歸檔當下。
- commit 一律自動；完成時依核准閘的「完成後」選項處理 rebase／push。

## References
- `.kn-project/archive/2611172115-ios-passthrough-verify.md` — iOS 穿透驗證與開啟
- 上一輪量測：模擬器逐幀錄影、`sample` 主執行緒、`moveCamera` 計時（只在對話中，未入檔）
