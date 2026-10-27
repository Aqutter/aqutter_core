<!-- REMINDER: Relative Paths Only! No file:///c:/... -->
# Plan: 2610272336 - inject-native-endpoint-remove-callhandler
- Created: 2026-10-27
- Branch: feature/2610272336-inject-native-endpoint-remove-callhandler
- Issue: Aqutter/aqutter_core#10
- Milestone: N/A（未指定）
- Base Branch: main
- Status: Awaiting Archive
- Completed: [Wait for Finish]

## Goals
- 讓殼不必再靠 `callHandler` 取得本機傳輸的埠與令牌：`AqutterNativeHost` 新增 `endpoint`（`ValueListenable<AqutterNativeEndpoint?>`），在伺服器啟動與每次 `restart()` 之後通知監聽者。
- 本 repo 不改 WebView 與 JS 橋接層（那是平台層；框架不再使用它，但不在本次移除範圍）。

## Architecture
- `AqutterNativeHost`（單例，`lib/src/nativeview/native_host_io.dart`）已持有 `_endpoint`；改為以 `ValueNotifier<AqutterNativeEndpoint?>` 保存並對外只暴露 `ValueListenable`。
- `_start()` 在 `server.listen(...)` 之後指派新值；`restart()` 先把值設為 `null`（不通知）、重啟完成後指派新值（通知一次）；`stop()` 設為 `null`。
- `native_host_stub.dart`（Web）提供同名成員，值恆為 `null`，維持介面一致。

## Cross-Repo Scope
- **本計畫所屬 repo**: `aqutter_core`
- **共用計畫 ID**: `2610272336-inject-native-endpoint-remove-callhandler`　**共用分支名**: `feature/2610272336-inject-native-endpoint-remove-callhandler`
- **參與 repo 與職責**（一 repo 一 issue，Rule 20；尚未建立時寫 `待建立`）:
  - `aqutter_core` — 提供 Dart API `AqutterNativeHost.endpoint`（端點啟動／重啟時通知）　issue: `Aqutter/aqutter_core#10`
  - `aqutter` — 殼：移除 `native_endpoint` handler，改以 UserScript 注入 `window.aqutterEndpoint`，端點變更時更新頁面與注入腳本；契約正本　issue: `Aqutter/aqutter#33`
  - `aqutter-js` — client：改讀 `window.aqutterEndpoint`，移除 `callHandler` 與 `NativeEndpoint`　issue: `Aqutter/aqutter-js#12`
- **執行順序相依**: `aqutter_core` 先（契約 #1），再 `aqutter`（契約 #2 的提供方，依賴 #1）；`aqutter-js`（契約 #2 的消費方）在契約凍結後可與 `aqutter` **平行**實作，整合驗證需等待 `aqutter` 與 `aqutter_core` 都完成。三個 PR 建議合併次序：`aqutter_core` → `aqutter` → `aqutter-js`。
- **跨 repo 檔案指涉**: 見 `## Impact Files` 之外的「他 repo」項目：`demo-app/dbltest.html:44`（不在任何 git repo，非治理範圍，見 Q2）。

## Contract / 介面契約
- **契約正本 repo**: `aqutter`　**修訂號**: `rev 3`　**狀態**: `凍結（核准日 2026-10-28）`

### 1. 介面清單
| # | 種類 | 名稱 | 提供方 | 消費方 | 用途 |
|---|---|---|---|---|---|
| 1 | Dart API | `AqutterNativeHost.endpoint`（`ValueListenable<AqutterNativeEndpoint?>`） | `aqutter_core` | `aqutter`（殼） | 本機傳輸的埠與令牌；啟動與每次重啟後通知 |
| 2 | JS 全域 | `window.aqutterEndpoint`（`{ port: number, token: string }`） | `aqutter`（殼注入） | `aqutter-js`（client） | 網頁取得連線資訊；存在即代表運行於殼內 |
| 3 | 移除 | handler `native_endpoint`（`BridgeHandler.nativeEndpoint`／`BridgeHandler.NativeEndpoint`）與框架內對 `window.aqutter.callHandler` 的使用 | `aqutter`、`aqutter-js` | — | 舊引導通道，不保留、不備援 |
| 4 | TS 選項 | `AqutterNativeOptions.resolveEndpoint`（`new AqutterNative({ … })` 的選項）：由必填改為**選填**，省略時讀 `window.aqutterEndpoint` | `aqutter-js` | 直接使用 `AqutterNative` 類別的網頁專案 | 取代文件中的 `callFlutter(BridgeHandler.NativeEndpoint)` 用法；`<aqutter-native>` 元素不受影響 |

### 2. 欄位
**#1 `AqutterNativeHost.endpoint`**
| 欄位 | 型別 | 可空 | 說明 |
|---|---|---|---|
| `value` | `AqutterNativeEndpoint?` | 是 | 伺服器尚未啟動、或 `stop()` 之後為 `null`；`ensureStarted()` 完成後為非 null |
| `value.port` | `int` | 否 | 1–65535，`127.0.0.1` 上的暫時埠 |
| `value.token` | `String` | 否 | base64url（無 padding）32 字元，每次啟動／重啟重新產生 |

- 通知時機：新伺服器已開始監聽**之後**才指派新值（監聽者收到時，該埠已可連線）；`restart()` 期間舊值先被清為 `null` 不通知，新值指派時通知一次。
- Web 平台（`native_host_stub.dart`）：`endpoint.value` 永遠是 `null`。

**#2 `window.aqutterEndpoint`**
| 欄位 | 型別 | 可空 | 說明 |
|---|---|---|---|
| `port` | `number`（整數） | 否 | 同 #1 `port` |
| `token` | `string` | 否 | 同 #1 `token` |

- 物件以 `Object.freeze` 凍結；變更時**整個物件替換**（新的物件參考），不修改既有物件。
- 屬性本身：`writable: false`、`configurable: true`、`enumerable: false`（殼需要以 `evaluateJavascript` 重新定義它）。
- 注入腳本（`UserScript`，`injectionTime: AT_DOCUMENT_START`、`forMainFrameOnly: true`）的內容形式固定為：`Object.defineProperty(window,"aqutterEndpoint",{value:Object.freeze({port:<整數>,token:<JSON 字串>}),configurable:true,enumerable:false,writable:false});`

### 3. 失敗情況
| 情況 | 觸發條件 | client 預期行為 |
|---|---|---|
| 全域不存在 | 純瀏覽器、SSR、殼尚未注入 | `isFlutter()` 回 `false`；不嘗試連線（與現行非 Flutter 環境相同） |
| 端點過期 | 殼重啟伺服器後，頁面仍持有舊值 | 連線失敗；`Transport` 既有的退避重連（起始 200 ms、每次加倍、上限 5 秒；`<aqutter-native>` 鏡像元素自己的重連間隔預設 800 ms）每次嘗試都**重新讀取** `window.aqutterEndpoint`；進行中的呼叫仍以 `TRANSPORT_CLOSED` 失敗（行為不變） |
| 舊 client 搭新殼 | 舊 client 呼叫 `native_endpoint` | 殼不再註冊該 handler，連線建立不了；不提供相容（見 §5） |

### 4. 狀態與規則
- 殼建立 WebView 前先 `await AqutterNativeHost.instance.ensureStarted()`，以當時的端點組 `initialUserScripts`；`_webViewGeneration` 遞增而重掛 WebView 時使用最新端點。
- 端點變更（`restart()`）時，殼必須同時：(a) 對**目前頁面**以 `evaluateJavascript` 重新定義 `window.aqutterEndpoint`；(b) `removeUserScript` 後 `addUserScript` 更新注入腳本，讓之後的導覽與重新整理拿到新值。
- 不新增「端點已變更」的網頁事件：恢復速度由既有重連間隔決定，client 不需監聽。
- 令牌不得被 client 快取超過一次連線嘗試；每次連線前重新讀取。
- 全平台（iOS、Android、macOS、Windows、Linux）使用同一份腳本；已驗證的平台以各計畫 `## Key Decisions` 記錄為準。

### 5. 相容性
- **不變**：`callFlutter`、`callPlugin`、`onPluginEvent`、`isFlutter`、`<aqutter-native>`、`BridgeHandler` 其餘成員；Dart 端 `AqutterPlugin` 的 `handlers`、`emit`、`supportedPlatforms`、`attach`、`buildUnderlay`。plugin 與使用 SDK 的網頁專案不需修改。
- **移除（不保留）**：`BridgeHandler.nativeEndpoint`（Dart）／`BridgeHandler.NativeEndpoint`（TS）與 `NativeEndpoint` 型別；`aqutter-js` 的 `AqutterBridge.callHandler` 型別與所有呼叫點。
- `window.aqutter`（aqutter_core 平台層的 JS 橋接物件，含 `callHandler`）仍會被核心注入，但**不屬於框架契約**，框架程式碼不得讀取或呼叫它。
- 殼與 client 必須同時升級（命名成對規則）；`manifest/releases.json` 的 `shell.ref`、`core.ref`、`client.spec` 需同步（人工收尾）。

### 6. 變更紀錄
- 2026-10-27　rev 2：新增介面 #4（`AqutterNativeOptions.resolveEndpoint` 改選填，預設讀全域）與 §5 說明。原因：`docs/nativeview.md:67` 的公開用法以 `callFlutter(BridgeHandler.NativeEndpoint)` 作為 `resolveEndpoint`，移除 `NativeEndpoint` 後必須有替代。影響 repo：`aqutter-js`（程式）、`aqutter`（文件）；`aqutter_core` 無程式影響。
- 2026-10-28　rev 3（更正，不改介面）：§3「端點過期」列的重連間隔由「`Transport` 預設 800 ms」更正為 `Transport` 的退避（200 ms 起、上限 5 秒，`transport.ts:63-64`）；800 ms 是鏡像元素的預設。原因：Phase 4 契約一致性檢查發現數字寫錯。影響 repo：無（行為與介面都不變）。

## Impact Files
- `lib/src/nativeview/native_host_io.dart:55` (`_endpoint`)、`:72` (`ensureStarted`)、`:112` (`restart`)、`:97` (`didChangeAppLifecycleState`) — 改以 `ValueNotifier` 保存端點並對外暴露 `endpoint`；重啟後通知。
- `lib/src/nativeview/native_host_stub.dart:23` (`ensureStarted`)、`:39` (`restart`) — Web stub 補上同名 `endpoint`（恆為 null）。
- `lib/src/nativeview/nativeview.dart:5` — 匯出清單確認 `AqutterNativeEndpoint`、`AqutterNativeHost` 已匯出，必要時補匯出。
- `test/nativeview_test.dart:116` (`host.restart()` 既有案例旁) — 新增：啟動後 `endpoint.value` 非 null、`restart()` 後通知且值（埠、令牌）改變、`stop()` 後為 null。
- `doc/nativeview.md:27,35` — 兩處提到「經 bridge handler `native_endpoint`」改寫為「由殼注入 `window.aqutterEndpoint`，Dart 端以 `AqutterNativeHost.endpoint` 取得」。
- `doc/rpc.md:80` — 重啟後網頁重連的說明補上「重連時重新讀取 `window.aqutterEndpoint`」。
- `doc/rpc.md:5` — 「網頁以 bridge handler `native_endpoint` 取得埠與令牌後連線」改為殼注入 `window.aqutterEndpoint`（Rule 18/2：計畫執行中發現，補列）。
- `lib/src/rpc/rpc_host.dart:35` — 註解同上，僅文字（補列）。

## Open Questions / 待確認事項
> 全部釐清前不得進入 Phase 3。

### Q1. 注入的 JS 全域名稱 — 影響範圍：契約 #2、`aqutter`、`aqutter-js`
- [x] `window.aqutterEndpoint`　(建議：與既有 `window.aqutter` 同前綴；核心的橋接腳本會無條件執行 `window.aqutter = {};`（`aqutter_core` 的 `android/src/main/kotlin/com/github/aqutter/core/plugin_scripts_js/JavaScriptBridgeJS.kt:301`），把端點放在 `window.aqutter.endpoint` 底下可能被它覆蓋，視注入順序而定)
- [ ] `window.aqutter.endpoint`　(與既有全域同一物件，但有被覆蓋風險，需在各平台逐一驗證注入順序)
- **決議**：`window.aqutterEndpoint`（使用者於對話選擇）　狀態：✅ 已確認

### Q2. `demo-app/dbltest.html:44` 的 `bridge.callHandler('app_ready')` 怎麼處理 — 影響範圍：`demo-app`（不是 git repo，不在治理範圍）
- [ ] 改成 module，`import { callFlutter } from '@aqutter/aqutter'` 後呼叫 `callFlutter(BridgeHandler.AppReady)`　(建議：該頁由 vite 提供，可以用 SDK；與 `main.js` 寫法一致)
- [x] 直接刪除 `dbltest.html`
- [ ] 本次不處理，由我自己改
- **決議**：直接刪除 `dbltest.html`（使用者於對話選擇；`demo-app` 不是 git repo，刪除前先備份到暫存區）　狀態：✅ 已確認

## Manual Follow-ups / 人工收尾事項
- **[合併後]** 依 `aqutter/AGENTS.md` 把 git tag `0.0.0` 移到本 repo 最新的 `main` — `git tag -f 0.0.0 && git push -f origin 0.0.0`（先確認 `aqutter/manifest/releases.json` 要引用的 commit）— 移動遠端 tag 會改寫共用參照，不代做。
- **[合併後]** 更新 `aqutter/manifest/releases.json` 的 `core.ref` 為合併後的 commit — 需要本 PR 合併後才有 commit — 由 `aqutter` 那份計畫的後續 PR 處理。

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

## Git Completion Policy
- PR 一律以 `--base main` 顯式指定 base，不依賴 `gh` 的預設值 (Rule 23)。
- Issue 綁定時，每個 commit 訊息與 PR body 都含 `Closes #${N}`（`${N}` 取自上方 `- Issue:`，不是計畫 ID）。
- commit 一律自動 (Rule 17)；完成時依核准閘的「完成後」選項決定是否 `git fetch` 後 `git rebase origin/main` 並 `git push --force-with-lease --force-if-includes`。
- 跨 repo 時，本 repo 自己開自己的 PR；不存在橫跨多 repo 的單一 PR (Rule 19)。建議合併次序見 `## Cross-Repo Scope`。

## References
- Aqutter/aqutter#21（統一傳輸在 macOS／iOS 實機驗證）——本計畫的動機來自其測試中發現：框架內仍殘留舊的 `callHandler` 引導通道。
- `.kn-project/archive/2610271120-unified-bridge-transport.md`（統一傳輸計畫；「開發介面不變」的來源）。
