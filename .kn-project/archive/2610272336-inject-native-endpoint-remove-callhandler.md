# 2610272336 - inject-native-endpoint-remove-callhandler

- Created: 2026-10-27 23:36 / Archived: 2026-10-28 00:10
- Issue: Aqutter/aqutter_core#10
- Milestone: N/A / Base Branch: main

## Summary
`AqutterNativeHost` 新增 `endpoint`（`ValueListenable<AqutterNativeEndpoint?>`），在本機傳輸伺服器啟動與每次 `restart()` 之後通知新的埠與令牌，讓殼不必再靠舊的 `callHandler`（`native_endpoint`）把它交給網頁。
`restart()` 期間先靜默清空、完成後只通知一次新端點；`stop()` 清空並通知；Web stub 提供同名成員（恆為 null）。這是三個 repo 合作的一環：殼負責注入、client 負責讀取。文件與一處註解不再提 `native_endpoint`。

## Cross-Repo Scope
- 參與 repo 與職責：`aqutter_core`（提供 `AqutterNativeHost.endpoint`，issue Aqutter/aqutter_core#10）、`aqutter`（殼：移除 `native_endpoint`、注入 `window.aqutterEndpoint`，契約正本，issue Aqutter/aqutter#33）、`aqutter-js`（client：改讀全域、移除 `callHandler`，issue Aqutter/aqutter-js#12）。
- 共用計畫 ID `2610272336-inject-native-endpoint-remove-callhandler`，共用分支名 `feature/2610272336-inject-native-endpoint-remove-callhandler`，三份計畫都 `base = main`。
- 執行順序：`aqutter_core` → `aqutter` → `aqutter-js`（序列執行）；建議合併次序同。契約介面 #1–#4（`AqutterNativeHost.endpoint`、`window.aqutterEndpoint`、移除 `native_endpoint`／`callHandler`、`resolveEndpoint` 選填），最終 rev 3，提供方與正本 repo 為 `aqutter`。

## Key Decisions
- **[範圍]** 使用者要求「完全移除舊通道寫法，未來只會有新通道」；引導方式選「改由殼注入」（來源：對話，Phase 0）。
- **[repo]** 目標 repo 清單 = `aqutter`、`aqutter-js`、`aqutter_core`（來源：使用者確認，Phase 0 步驟 0）。
- **[Milestone]** 不指定，`Base Branch` = `main`（來源：使用者於 Phase 0 選擇；AGENTS.md 寫明開發階段版本一律 `0.0.0`）。
- **[整合主幹]** 遠端無 `dev`／`develop`／`development` 分支，採 `origin/HEAD` = `main`，依規定不詢問、不記錄。
- **[設計]** 不新增「端點已變更」的網頁事件：重啟後的恢復靠 `Transport` 既有重連（800 ms）重新讀取全域，避免多一個介面。
- **[設計]** `isFlutter()` 改以 `window.aqutterEndpoint` 是否存在判斷，不再看 `window.aqutter`（否則仍依賴舊橋接物件）。
- **[Q1]** 全域名稱採 `window.aqutterEndpoint` — 理由：不受核心橋接腳本 `window.aqutter = {}`（`aqutter_core` 的 `android/src/main/kotlin/com/github/aqutter/core/plugin_scripts_js/JavaScriptBridgeJS.kt:301`）覆蓋影響，注入順序不重要。
- **[Q2]** `demo-app/dbltest.html` 直接刪除（使用者選擇）— 理由：該頁只為雙擊測試，且依賴舊的 `callHandler`；`demo-app` 非 git repo，刪除前備份到暫存區，由 `aqutter` 那份計畫的執行者處理。
- **[契約]** rev 1 凍結（使用者於 Phase 2 核准閘核准）。
- **[完成後]** commit + 開 PR（預設；自動歸檔＋wiki，Rule 12 非互動鏈）；完成前將 `git fetch` 後 `git rebase origin/main` 並 `git push --force-with-lease --force-if-includes`，重寫的是遠端工作分支（來源：核准閘，僅本計畫生效）。
- **[執行模式]** 序列（依據：契約 #1 先於 #2，`aqutter` 依賴 `aqutter_core`；整合驗證需要三個 repo 都完成；無法確認可派出獨立子 agent）。順序：`aqutter_core` → `aqutter` → `aqutter-js`。
- **[契約變更]** rev 1 → 2（已核准並凍結）：新增 #4 `AqutterNativeOptions.resolveEndpoint` 改選填 — 原因：`docs/nativeview.md:67` 的公開用法依賴 `BridgeHandler.NativeEndpoint`（來源：執行中發現，Rule 29）。
- **[補列]** 計畫執行中發現未列的檔案，已補進 `## Impact Files`，並於 2026-10-27 重新核准（Rule 18/2）。
- **[契約]** rev 2 凍結（使用者於重新核准閘核准）。
- **[契約變更]** rev 2 → 3（已核准並凍結，2026-10-28）：更正 §3 的重連間隔數字（Phase 4 契約一致性檢查發現，Rule 29）；介面與行為不變。
- **[契約]** rev 3 凍結（使用者於 2026-10-28 核准，只更正 §3 的重連間隔數字）。

## Deviations
- 契約 rev 1 → 2（2026-10-27）：新增介面 #4（`AqutterNativeOptions.resolveEndpoint` 改選填，預設讀全域）。原因：`aqutter` 的 `docs/nativeview.md:67` 公開範例把 `callFlutter(BridgeHandler.NativeEndpoint)` 傳給它，移除 `NativeEndpoint` 後必須有替代。
- 契約 rev 2 → 3（2026-10-28）：更正 §3 的重連間隔（`Transport` 是 200 ms 起、每次加倍、上限 5 秒，不是 800 ms；800 ms 是鏡像元素的預設）。介面與行為不變。
- 契約 #1 以外沒有行為變更；`aqutter_core` 的平台層 JS 橋接（`window.aqutter.callHandler`，繼承自 flutter_inappwebview）原封不動，框架不再使用它。
- 實作中補列兩個只改文字的檔案（`doc/rpc.md:5`、`lib/src/rpc/rpc_host.dart:35`），已重新核准。
- 未驗證：實體 iPad、Windows、Linux；macOS 的「回前景換新埠」；release 版（只驗證了 Android 手機上 `demo-app` 的 release 版可獨立開啟）。

## Impact Files
- `lib/src/nativeview/native_host_io.dart:55` (`_endpoint`)、`:72` (`ensureStarted`)、`:112` (`restart`)、`:97` (`didChangeAppLifecycleState`) — 改以 `ValueNotifier` 保存端點並對外暴露 `endpoint`；重啟後通知。
- `lib/src/nativeview/native_host_stub.dart:23` (`ensureStarted`)、`:39` (`restart`) — Web stub 補上同名 `endpoint`（恆為 null）。
- `lib/src/nativeview/nativeview.dart:5` — 匯出清單確認 `AqutterNativeEndpoint`、`AqutterNativeHost` 已匯出，必要時補匯出。
- `test/nativeview_test.dart:116` (`host.restart()` 既有案例旁) — 新增：啟動後 `endpoint.value` 非 null、`restart()` 後通知且值（埠、令牌）改變、`stop()` 後為 null。
- `doc/nativeview.md:27,35` — 兩處提到「經 bridge handler `native_endpoint`」改寫為「由殼注入 `window.aqutterEndpoint`，Dart 端以 `AqutterNativeHost.endpoint` 取得」。
- `doc/rpc.md:80` — 重啟後網頁重連的說明補上「重連時重新讀取 `window.aqutterEndpoint`」。
- `doc/rpc.md:5` — 「網頁以 bridge handler `native_endpoint` 取得埠與令牌後連線」改為殼注入 `window.aqutterEndpoint`（Rule 18/2：計畫執行中發現，補列）。
- `lib/src/rpc/rpc_host.dart:35` — 註解同上，僅文字（補列）。

## Details
不相容升級：舊網頁包搭新殼不能用（新殼不再回應 `native_endpoint`、也不注入給舊 client 判斷是否在殼內的物件），網頁包必須用新 client 重打（`aqutter seed`）。`window.aqutter`（平台層橋接物件）仍由核心注入，但已不屬於框架契約。
