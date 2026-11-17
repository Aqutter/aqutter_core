# 2611171503-native-passthrough-mode

- Created: 2026-11-17 / Archived: 2026-11-17
- Issue: Aqutter/aqutter_core#31
- Milestone: N/A / Base Branch: main

## Summary
`AqutterNative` 新增穿透（passthrough）模式：原生內容直接畫在透明的 WebView 下面，不擷取、不送幀，並能以 `mode` 與鏡像切換，兩種模式共用同一組手勢與事件。
core 負責契約正本與原生端：每次連線的模式協商（決策只在原生端）、依網頁回報的元素矩形定位 child、`passthroughSessions`（殼據此切換 WebView 透明）與 `passthroughAvailable`，並修正 Android 初始透明設定不生效的問題。

## Cross-Repo Scope
- **本計畫所屬 repo**: `aqutter_core`
- **共用計畫 ID**: `2611171503-native-passthrough-mode`　**共用分支名**: `feature/2611171503-native-passthrough-mode`
- **參與 repo 與職責**（一 repo 一 issue，尚未建立時寫 `待建立`）:
  - `aqutter_core` — 契約正本；協定的原生端、`AqutterNative` widget、`passthroughSessions`、Android WebView 透明的行為保證　issue: `Aqutter/aqutter_core#31`
  - `aqutter-js` — 標籤的 `mode` 屬性、模式協商、頁面可穿透偵測、`layout` 追蹤、`aqutter-mode` 事件　issue: `Aqutter/aqutter-js#14`
  - `aqutter` — 殼：監聽 `passthroughSessions` 切換 WebView 透明　issue: `Aqutter/aqutter#68`
  - `aqutter-plugins` — google-maps 等 plugin 沿用同一個標籤與 `AqutterNative`，加上 `mode` 選項、文件　issue: `Aqutter/aqutter-plugins#8`
- **執行順序相依**: `aqutter_core`（協定與 Dart 端）先；`aqutter-js` 在契約凍結後可與 core **平行**（兩端以契約為準，整合驗證需等兩邊都完成）；`aqutter`（殼）與 `aqutter-plugins` 需等待 `aqutter_core` 的 `passthroughSessions` 與透明行為保證完成，plugin 另需等待 `aqutter-js`。
- **跨 repo 檔案指涉**: 無（各 repo 的檔案只列在自己的 `## Impact Files`）。
- **合併後的連動**: 各 repo 合併後，`aqutter` 的 `manifest/releases.json`（`core.ref`、`shell.ref`、`client.spec`）與 `aqutter-cli` 的 manifest 快照需重新同步，0.0.0 tag 需移動，見各份 `## Manual Follow-ups`。
- **契約**：正本 `aqutter_core`，最終 rev 2；介面共 9 項（`mode` 屬性、`mode` 請求與回覆、`layout`、手勢訊息不變、`AqutterNative(mode:)`、`passthroughSessions`、`aqutter-mode` 事件、WebView 透明的行為保證）；全文在 aqutter_core 的 archive 與 PR 說明。

## Key Decisions
- **[Phase 0]** 目標 repo：`aqutter_core`、`aqutter-js`、`aqutter`、`aqutter-plugins`（依據：鏡像實作在 `aqutter_core/lib/src/nativeview/` 與 `aqutter-js/src/nativeview/`；殼的底層與 WebView 在 `aqutter/shell/lib/src/app.dart`；使用端在 `aqutter-plugins/packages/google-maps`）。`aqutter-cli`、`aqutter-nuxt-app` 不在本次範圍（只有合併後的鎖定同步）。
- **[Milestone]** 四個 repo 皆不指定，以 `main` 為 base — 使用者於 Phase 0 選擇。
- **[Q1]** 預設 `mode` 為 `auto` — 使用者決議；已知會改變既有 Android App 的行為，以 `pageReady` 偵測降低風險（契約 §5）。
- **[Q2]** iOS 的 `auto` 先視為不支援 — 理由：沒有 iOS 設備，未驗證。
- **[設計]** 模式決策只在原生端；網頁只回報 `pageReady`。 — 理由：兩端各自決策會不一致。
- **[設計]** 手勢座標維持相對元素 0..1。 — 理由：plugin 的手勢處理不需修改；穿透時原生端以元素大小的 child 承接。
- **[設計]** 底層原生內容與元素同大、同位置（不是螢幕大小）。 — 理由：前置實驗證實螢幕大小的地圖在元素一開始在螢幕外時，捲進來會是空白。
- **[設計]** 殼的 WebView 透明依 `passthroughSessions` 動態切換，不是全域常開。 — 理由：避免啟動時與其他畫面露出底層。
- **[前置實驗]** 透明的初始設定在 Android 不生效（兩段式才生效），列為 aqutter_core 要查根因的工作，不在殼繞過。
- **[程式碼風格]** 實作遵守 `kn-project-code-style`。
- **[契約]** rev 1 凍結（核准日 2026-11-17）。
- **[契約變更]** rev 1 → rev 2（已核准）：child 一律保持掛載，穿透時第一則可見 layout 前以 `Offstage` 隱藏。原因：rev 1 的「不建立 child」與「模式切換期間保持掛載」矛盾（見契約 §6）。
- **[Android 透明根因]** `AqutterWebView.prepare()` 在 WebView 還沒掛上畫面時呼叫 `setBackgroundColor(TRANSPARENT)`，Chromium 的底色沒有跟著變透明；掛上後再設才生效（執行期 `updateSettings` 走的就是這條）。修法：初始設定後用 `post {}`（掛上後才執行）再套用一次。驗證：殼拿掉兩段式繞過，只靠這個修正，Android 實機（ASUS，API 33）初始設定即生效。對照組是前置實驗中同一支手機「只設初始透明」仍是白的。
- **[整合驗證]** 與 aqutter-js 的網頁端串起來，在 Android 實機（ASUS，API 33）以未修改的 google-maps plugin 驗證：預設 `auto` 協商成穿透、屬性改 `mirror` 換成鏡像、改回 `passthrough` 換回；canvas 有無與畫面符合預期。iOS 與桌面平台未驗證（`auto` 在這些平台退回鏡像）。
- **[完成後]** commit + 開 PR（Rule 12 非互動鏈；完成前自動 fetch 後 rebase origin/main 並 push --force-with-lease --force-if-includes）。
- **[實作]** 型別與決策在 `native_mode.dart`；穿透時 child 用 `KeyedSubtree`＋`GlobalKey` 在鏡像與穿透之間換父層不重建；`passthroughAvailable` 只影響之後的協商。
- **[執行模式]** 序列（依據：環境只有單一 agent，沒有獨立子 agent）；順序 aqutter_core → aqutter-js → aqutter → aqutter-plugins。
- **[範圍]** 使用者指示「先定契約」：本次先把契約凍結、建立 issue 與分支並提交計畫，實作（`tasks.md` 的 Phase 1 起）等使用者確認後再開始。

## Deviations
- **契約 rev 1 → rev 2（已核准）**：§4「原生端的版面」——child 一律保持掛載，穿透時第一則可見的 `layout` 之前以 `Offstage` 隱藏，取代 rev 1 的「第一則可見 layout 前不建立 child」。原因：rev 1 與「模式切換期間 child 保持掛載」自相矛盾，widget 在協商前先當鏡像建好 child，換成穿透時拆掉重建會讓 PlatformView（例如地圖）狀態遺失；以 `initState` 計數的測試證實。
- **Android 透明根因已查明並修在 core**（計畫原寫「查根因」）：`AqutterWebView.prepare()` 在 WebView 掛上畫面前設透明，Chromium 的底色沒有跟著變；改為掛上後再套用一次。
- **Wiki 未更新**：本 repo 的 wiki 沿用舊版格式，lint 基準本來就有 30 個硬閘違規，與本計畫無關；新增頁無法通過 lint 與 build，故沒有新增或修改 wiki 頁。穿透模式的文件放在 `doc/nativeview.md`。建議另開計畫把 wiki 遷移到現行規格。
- 實機驗證只在 Android（ASUS，API 33）；iOS 與桌面平台未驗證（`auto` 在這些平台退回鏡像）。

## Impact Files
- `lib/src/nativeview/native_widget.dart:25` (`AqutterNative` 建構子)、`:147` (`_AqutterNativeState`)、`:204` (`initState`) — 新增 `mode` 參數；穿透時不擷取、依 `layout` 定位 child、`visible: false` 時 `Offstage`。
- `lib/src/nativeview/native_host_io.dart:340-381` (`_onData`) — 處理 `mode`（協商與回覆）、`layout`；維護 `passthroughSessions`；沒有 `mode` 訊息的連線視為鏡像。
- `lib/src/nativeview/native_session.dart:66-124` (`viewport`、`viewportListenable`) — 加入穿透狀態與 `layout` 的 `ValueListenable`。
- `lib/src/nativeview/native_mode.dart` (new) — `AqutterNativeMode`、`AqutterNativeModeReason`、`AqutterNativeModeDecision`、`decideAqutterNativeMode`（純函式決策）、`aqutterNativePassthroughSupported`、`AqutterNativeLayout`（計畫原寫「同檔或新檔」，實作選新檔）。
- `lib/src/nativeview/native_host_stub.dart` — Web 端 stub 對 `passthroughSessions` 與 `mode` 的對應（一律鏡像／不支援）。
- `lib/src/nativeview/nativeview.dart` — 匯出新型別。
- `android/src/main/kotlin/com/github/aqutter/core/webview/webview/AqutterWebView.kt:364`、`:940` — 讓初始與執行期的透明設定等效；根因於實作時查明，記入 `## Key Decisions`。
- `doc/nativeview.md` — 新增「穿透模式」章節（模式、訊息、頁面責任、退回規則）。
- `test/nativeview_widget_test.dart`、`test/nativeview_test.dart` — 補穿透與模式協商的測試；`test/nativeview_passthrough_test.dart` (new) — 模式決策表與 `layout` 定位。
