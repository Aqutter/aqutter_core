# 2611182300-windows-passthrough-spike

- Created: 2026-11-17 / Archived: 2026-11-17
- Issue: Aqutter/aqutter_core#38
- Milestone: N/A / Base Branch: main

## Summary
Windows 穿透 spike 通過，Windows 加入穿透支援平台（`aqutterNativePassthroughSupported`）。實測（Windows 11、debug、顯示縮放 125%，nuxt-app plugins 頁的 mirror-demo，暫時覆寫指向本機 core）：`passthrough` 協商成穿透；透明處透出 Flutter 畫的格線與圓球（貼圖 alpha 保留）；位置與大小與網頁回報的 CSS 像素對得上（DPR 1.25）；點擊（計數 2→4）與拖曳（圓球移動）手勢照常轉給原生內容。
改動只有支援清單、測試與文件（`doc/nativeview.md` 新增 Windows 的驗證範圍與限制）；不需要改 Windows 原生程式、殼或網頁端。

## Cross-Repo Scope
- **本計畫所屬 repo**: `aqutter_core`
- **共用計畫 ID**: `2611182300-windows-passthrough-spike`　**共用分支名**: `feature/2611182300-windows-passthrough-spike`
- **參與 repo 與職責**:
  - `aqutter_core` — 支援清單、測試、文件、實測紀錄　issue: `Aqutter/aqutter_core#38`
- **執行順序相依**: 只改 core；驗證用 nuxt-app 的暫時覆寫（不提交）。
- **後續（通過時，各自另案）**: core tag 移動 → aqutter manifest／aqutter-cli 快照重同步 → nuxt-app 前進鎖定。

## Key Decisions
- **[Phase 0]** 單一 repo；Milestone 不指定；Base Branch = `main`。core 另有 `2610211200-windows-platform-view-perf`（Awaiting Archive），與本計畫無關，不動。
- **[Q1]** 通過才開功能 PR；不通過開只改文件的 PR。
- **[Q2]** 只驗證目前顯示縮放，文件註明其他縮放未驗證。
- **[完成後]** commit + 推送 + 開 PR（base main）— 使用者核准。
- **[範圍]** 只改 core 的支援平台清單、測試與文件；不改殼、不改網頁端、不改 Windows 原生程式（若 alpha 不通過再另開計畫評估貼圖橋接）。

## Deviations
- 第一次以 `pubspec_overrides.yaml` 指向本機 core 跑 Windows 時，Flutter 工具沒有重新 `pub get`，跑的仍是鎖定的 core，結果是 `unsupported-platform`；手動 `flutter pub get` 後才套用覆寫，之後通過。
- 用 WebView2 遠端偵錯（環境變數 `WEBVIEW2_ADDITIONAL_BROWSER_ARGUMENTS`）查模式與矩形，以螢幕擷取視窗確認視覺；手勢用遠端偵錯送滑鼠事件，不是實體滑鼠。
- 沒有驗證：其他顯示縮放（100%、150%、200%）、多螢幕、release 建置與效能；google-maps 在 Windows 走 JS 版地圖（沒有原生地圖可穿透）。以上已寫入文件與計畫的人工收尾事項。
- 本 repo 的 wiki 沿用舊版格式（lint 基準本來就有硬閘違規），沒有新增或修改 wiki 頁。

## Impact Files
- `lib/src/nativeview/native_mode.dart:83-95` (`aqutterNativePassthroughSupported`) — 加入 Windows；更新說明文字。
- `test/nativeview_passthrough_test.dart:147-150` — 支援／不支援平台清單。
- `doc/nativeview.md:98-170`（穿透模式）— 平台列、驗證範圍（寫明 Windows 實測範圍與限制）。
