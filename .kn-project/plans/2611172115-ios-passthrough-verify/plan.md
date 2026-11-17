<!-- REMINDER: Relative Paths Only! No file:///c:/... -->
# Plan: 2611172115 - ios-passthrough-verify
- Created: 2026-11-17
- Branch: feature/2611172115-ios-passthrough-verify
- Issue: Aqutter/aqutter_core#33
- Milestone: N/A（未指定）
- Base Branch: main
- Status: Awaiting Archive
- Completed: [Wait for Finish]

## Goals
穿透模式（`AqutterNative` passthrough，d1c9062 / #32）目前只對 Android 開啟；iOS 因當時用 Windows 開發、沒有設備而先視為不支援（`auto` 一律退回鏡像）。本計畫：
1. 在 iOS 模擬器（iPhone 17 Pro）以**真實整合**（aqutter 殼＋aqutter-js 網頁端＋google-maps plugin，與 Android 實機驗證同一條路徑）驗證穿透是否成立：模式協商、元素矩形定位、WebView 透明、手勢、鏡像與穿透來回切換。
2. 驗證通過後，把 `aqutterNativePassthroughSupported` 對 iOS 開啟，更新測試與文件。
3. 驗證不通過時，依 Open Questions Q1 的決議處理（不得自行擴張）。

## Architecture
- 協商只在原生端決策（`decideAqutterNativeMode`，純函式）：生效模式 = 請求 ∩ widget 允許 ∩ 平台支援 ∩（auto 時）頁面可穿透。`platformSupported` 來自 `aqutterNativePassthroughSupported()`，是 iOS 不開的**唯一**閘門。
- 穿透時原生內容畫在透明 WebView 下面；殼依 `AqutterNativeHost.passthroughSessions` 切換 WebView `transparentBackground`（aqutter#69 已合併）。iOS 的 `AqutterWebView` 已支援 `transparentBackground`（`isOpaque = false`＋clear 背景），需實測是否生效、是否有 Android 那種「掛上前設定不生效」的問題。
- 本計畫對 aqutter／aqutter-js／aqutter-plugins **只讀、只在本機執行驗證**，不改它們；驗證用的本機覆寫（殼以 `pubspec_overrides.yaml` 指向本機 core）為未追蹤檔案，驗證後移除。
- 實作遵守 `kn-project-code-style`。

## Cross-Repo Scope
- **本計畫所屬 repo**: `aqutter_core`
- **共用計畫 ID**: `2611172115-ios-passthrough-verify`　**共用分支名**: `feature/2611172115-ios-passthrough-verify`
- **參與 repo 與職責**:
  - `aqutter_core` — 驗證與開啟 iOS 支援判斷、測試、文件　issue: `Aqutter/aqutter_core#33`
  - `aqutter`、`aqutter-js`、`aqutter-plugins` — 僅作為驗證環境（本機 fast-forward 到各自 origin/main 後執行），不產生變更、不開 issue
- **執行順序相依**: 無（單一 repo 的變更）；驗證需要三個 repo 在 origin/main 的穿透版本。
- **跨 repo 檔案指涉**: 無。
- **合併後的連動**: `aqutter` 的 `manifest/releases.json`（`core.ref`）與 `aqutter-cli` 的 manifest 快照需重新同步，0.0.0 tag 需移動（見 Manual Follow-ups）。

## Contract / 介面契約
無（單一 repo，且不改任何跨端協定：channel、`mode` 訊息、`layout` 訊息、JS 全域名稱皆不變；只改「iOS 是否支援」的判斷）。

## Impact Files
- `lib/src/nativeview/native_mode.dart:82` (`aqutterNativePassthroughSupported`，判斷在 `:87-92`，現只認 `TargetPlatform.android`) — 驗證通過後把 iOS 納入；同步更新 `:81-86` 的注解。
- `lib/src/nativeview/native_host_io.dart:433` (`platformSupported: aqutterNativePassthroughSupported()`) — 閘門的唯一呼叫點，確認不需另改。
- `test/nativeview_passthrough_test.dart:145` (`only Android is supported for now`) — 改為 Android 與 iOS 支援、其餘平台不支援；widget 測試目前只跑 Android 變體（`:361`、`:374`），補 iOS 變體。
- `doc/nativeview.md:172-183`（「顯示模式：鏡像或穿透」）— 補 iOS 的支援狀態與驗證範圍。
- `lib/src/nativeview/native_widget.dart:149`、`lib/src/nativeview/native_mode.dart:34` — 注解的「目前只有 Android」改為 Android 與 iOS（實作時發現，原計畫未列）。
- `README.md:47` — 「目前 Android」改為「Android、iOS」（實作時發現，原計畫未列）。
- `.kn-project/archive/2611172115-ios-passthrough-verify.md` (new) — Phase 5 歸檔。
- 條件式（只在模擬器驗證發現需要時才動，屆時回到本節補列並重新核准，Rule 2）：`ios/aqutter_core/Sources/aqutter_core/AqutterWebView/AqutterWebView.swift:571-574`（初始透明）與 `:1157`（執行期更新）。
- 順帶：先前 `test/nativeview_passthrough_test.dart` 有 2 個 widget 測試因 dispose 留下 5 秒 timer 失敗（`keeps the child mounted…`、`a mirror-only widget never goes passthrough`），本計畫補 iOS 變體時一併修收尾，否則新增的變體也會失敗（Q2）。

## App-Flow Screens
（本 repo 無 `.kn-project/app-flow.json`，不適用。）

## Open Questions / 待確認事項
### Q1. 模擬器驗證不通過時怎麼辦？ — 影響範圍：iOS 原生端、`native_mode.dart`
- [ ] 選項 A：停下回報，保持 iOS 退回鏡像（不改支援判斷），結果記入計畫與文件，由你決定下一步
- [x] 選項 B：在 core 內嘗試修（限 `AqutterWebView.swift` 的透明套用），修好再開 iOS
- **決議**：選項 B（使用者選擇；修復範圍限 iOS 原生端的 WebView 透明套用，若需動其他檔案須回計畫補列並重新核准）　狀態：✅ 已確認

### Q2. 順帶修掉那 2 個既有失敗的 widget 測試？ — 影響範圍：`test/nativeview_passthrough_test.dart`
- [x] 是　(建議，理由：同檔、要補 iOS 變體，不修會跟著失敗)
- [ ] 否，另案處理
- **決議**：是　狀態：✅ 已確認

## Manual Follow-ups / 人工收尾事項
- **[合併後]** 重新同步 manifest — 在 `aqutter` 更新 `manifest/releases.json` 的 `core.ref`、在 `aqutter-cli` 重新同步 manifest 快照，並移動 0.0.0 tag — 各在對應 repo 以其自身流程進行，不屬本 repo 的變更
- **[合併後]** 更新其他 repo 文件中的「目前只有 Android」— `aqutter/docs/nativeview.md`（穿透模式表）、aqutter-js 與 aqutter-plugins 的穿透說明若有同樣寫法 — 各在對應 repo 以其自身流程進行，不屬本 repo 的變更
- **[合併後]** 實機驗證 iOS — 模擬器通過不等於實機；以 iPhone／iPad 實機跑一次穿透（地圖拖曳、縮放、模式切換、效能） — agent 無實體 iOS 設備

## Key Decisions
- **[Phase 0]** 目標 repo：`aqutter_core`（依據：`lib/src/nativeview/native_mode.dart:87-92` 是 iOS 不開的唯一閘門；`aqutter`／`aqutter-js`／`aqutter-plugins` 的穿透改動今天（11/17）皆已合併到 origin/main，本計畫不改它們）。
- **[Milestone]** 不指定，`${BASE_BRANCH}` = `main` — 使用者於 Phase 0 選擇；整合主幹只有 `main`，不詢問。
- **[驗證方式]** 真實整合（殼＋aqutter-js＋google-maps plugin，iPhone 17 Pro 模擬器）— 使用者選擇；與 Android 實機驗證同一路徑。
- **[Q1]** 驗證不通過時在 core 嘗試修（限 iOS `AqutterWebView.swift` 透明套用）— 使用者選擇（未採建議的「停下回報」）；範圍擴大須重新核准。
- **[Q2]** 順帶修 2 個既有失敗的 widget 測試 — 同檔，補 iOS 變體會連帶失敗。
- **[驗證結果]** iPhone 17 Pro 模擬器（iOS 26.4），aqutter-nuxt-app（殼＋aqutter-js 171a95a＋google-maps plugin）暫時指向本機 core：`auto` 協商成穿透；網頁回報的 layout（0,0,402×874）到達、地圖底層與元素同位置同大小（lldb 檢視 view 階層確認 GMSMapView 在 WebView 之下）；執行期透明（AqutterWebView `isOpaque=false`）有效；拖曳與 `Tokyo` 指令有效；用 JS 把標籤 `mode` 改 `mirror` 協商成鏡像、改回 `passthrough` 協商成穿透。
- **[驗證中發現，不是 core 的問題]** 地圖一開始沒有出現：(1) nuxt-app 的 `mirror-demo` plugin 底層是不透明的 Flutter 內容，疊在 google-maps 底層上面蓋住地圖；(2) 頁面的兄弟元素有不透明背景（`auto` 只偵測祖先）。兩者清掉後地圖正常；已寫進 `doc/nativeview.md`。
- **[驗證用暫時改動已全部還原]** nuxt-app 的 `pubspec_overrides.yaml`、`GoogleMap.vue`、`aqutter_plugins.dart` 與重新產生的鎖定檔；core 的診斷 `debugPrint`。其他三個 repo 只做了 fast-forward，工作區乾淨。
- **[Q2 結果]** 2 個既有失敗的 widget 測試以 `_unmount`（在真實非同步區域卸載 widget）修好；widget 測試改跑 Android 與 iOS 變體。
- **[限制]** 模擬器驗證不代表實機（效能、觸控與 Metal 渲染差異）；實機驗證列入 Manual Follow-ups。
- **[程式碼風格]** 遵守 `kn-project-code-style`。

## Git Completion Policy
- PR 一律以 `--base main` 顯式指定 base，不依賴 `gh` 的預設值 (Rule 23)。
- Issue 綁定時，每個 commit 訊息與 PR body 都含 `Closes #${N}`（`${N}` 取自 `- Issue:`）。歸檔完成後於該 issue 張貼由 archive 蒸餾的結案留言。
- Issue 的關閉發生在合併後清理，不在歸檔當下。
- commit 一律自動；完成時依核准閘的「完成後」選項處理 rebase／push（`git push --force-with-lease --force-if-includes`）。
- 本計畫只有 `aqutter_core` 一個 repo，PR 只開在本 repo。

## References
- `.kn-project/archive/2611171503-native-passthrough-mode.md` — 穿透模式計畫與契約 rev 2（`## Key Decisions` 的 Q2：iOS 先視為不支援）
- `doc/nativeview.md:172-183` — 穿透模式的使用說明
