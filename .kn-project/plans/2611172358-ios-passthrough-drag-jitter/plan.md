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
目前穿透的手勢路徑：手指 → 上層透明 WebView → 網頁手勢辨識（`gestures.ts`）→ `pan` 訊息經 WebSocket → Dart（`AqutterNative.onMessage`）→ plugin 的 `moveCamera(scrollBy)` → 原生 `GMSMapView`。
候選修法（Phase 1 實驗後才決定）：穿透時讓觸控直接交給原生地圖，WebView 在地圖區域不攔截觸控（網頁回報要攔截的區域），繞過上述轉送。
- 實作遵守 `kn-project-code-style`。

## Cross-Repo Scope
- **本計畫所屬 repo**: `aqutter_core`
- **共用計畫 ID**: `2611172358-ios-passthrough-drag-jitter`　**共用分支名**: `feature/2611172358-ios-passthrough-drag-jitter`
- **參與 repo 與職責**:
  - `aqutter_core` — Phase 1 實驗；若採「原生直接接觸控」，iOS 的 WebView 觸控穿透　issue: `Aqutter/aqutter_core#35`
  - `aqutter-js`、`aqutter-plugins` — **目前不改**。Phase 1 實驗若證實方向，需要它們配合（回報攔截區域、打開地圖原生手勢）時，回到本計畫補 `## Cross-Repo Scope`、契約與各 repo 的 issue，並**重新核准**（Rule 2／19／28），不會直接動手。
- **執行順序相依**: 無（Phase 1 只在 `aqutter_core` 本機實驗，不改任何 repo 的程式碼）。
- **跨 repo 檔案指涉**: 實驗要讀的他 repo 檔案：`aqutter-plugins` 的 `packages/google-maps/lib/src/google_maps_plugin.dart:187-199`（`AqutterNative` 建立）、`:235-262`（`_onMessage`／`_applyPending`）；`aqutter-js` 的 `src/nativeview/element.ts:283-330`（指標事件）、`src/nativeview/gestures.ts:195-203`（`pan`）。
- **合併後的連動**: 視最終改動而定。

## Contract / 介面契約
無（Phase 1 不改任何跨端協定）。Phase 1 後若需要新增訊息（例如「攔截區域」），會在重新核准時補上完整契約。

## Impact Files
- `ios/aqutter_core/Sources/aqutter_core/AqutterWebView/AqutterWebView.swift:12` (`AqutterWebView`) — 條件式：若採「WebView 在地圖區域不攔截觸控」，需覆寫 hit test；Phase 1 結果出來前不動，屆時回計畫補列並重新核准。
- `lib/src/nativeview/native_session.dart:55`（`passthrough`）、`lib/src/nativeview/native_host_io.dart:433`（協商）— 條件式：若需要把攔截區域或手勢模式傳到原生端。
- `.kn-project/archive/2611172358-ios-passthrough-drag-jitter.md` (new) — Phase 5 歸檔。
- Phase 1 的實驗只用暫時改動（驗證用環境，結束後還原，不進 commit）。

## App-Flow Screens
（本 repo 無 `.kn-project/app-flow.json`，不適用。）

## Open Questions / 待確認事項
### Q1. Phase 1 實驗證實「原生直接接觸控」平順後，是否在本計畫內繼續實作？ — 影響範圍：aqutter-js、aqutter-plugins、aqutter_core
- [ ] 選項 A：回到本計畫補跨 repo 範圍與契約，重新核准後實作　(建議，理由：它會改三個 repo 的協定)
- [ ] 選項 B：本計畫到實驗結果為止，實作另開計畫
- **決議**：_(待使用者勾選)_　狀態：⏳ 待確認

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
