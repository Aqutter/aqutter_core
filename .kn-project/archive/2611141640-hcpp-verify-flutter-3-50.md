# 2611141640-hcpp-verify-flutter-3-50

- Created: 2026-11-14 16:40 / Archived: 2026-11-14 16:30
- Issue: Aqutter/aqutter_core#16
- Milestone: N/A / Base Branch: main

## Summary
在 Flutter 3.50.0 下於實機（Android 16）與 API 32 模擬器實測 aqutter_core 的 Android HCPP：自動選擇的探測、manifest 與 `flutter config --enable-hcpp` 兩條 opt-in 路徑、退回 TLHC 都符合預期，且未改任何執行期邏輯。

唯一的修正是文件：3.50 起官方開關 `flutter config --enable-hcpp` 取代隱藏旗標，且 manifest 明寫 `false` 會壓過它；example manifest 註解、兩處原始碼文件註解（含重新生成的 `.g.dart`）與 wiki 一併更新。

## Cross-Repo Scope
無（單一 repo）。與升級 Flutter 至 3.50 的計畫（共用 ID 2611141530-upgrade-flutter-3-50）互相獨立。

## Key Decisions
- **[實測]** Flutter 3.50.0、實機 25097RP43G（Android 16）：manifest `EnableHcpp=true` 且不加旗標 → 探測 true（debug 也生效）；manifest `false` 且不加旗標 → false；manifest `false` + `flutter config --enable-hcpp` → false（manifest 勝）；manifest 無項目 + `flutter config --enable-hcpp` → true。
- **[實測]** HCPP 下載入、點擊、輸入與輸入法、捲動皆正常；API 32 模擬器 opt-in 開著 → 探測 false、退回 TLHC、渲染正常、無崩潰。
- **[實測]** 首次探測 `before=false` 屬預期（早於引擎附著），`precache` 後為 true，與 wiki 描述一致。
- **[發現]** 3.50 建置警告：Flutter 對 AGP 9.3.0 與 Kotlin 2.4.10「即將不再支援」（需 Kotlin ≥ 2.4.20）、app 與 file_picker、flutter_downloader 仍套用 KGP（未來版本會建置失敗）——屬另案優化，不在本計畫。
- **[Phase 3]** 文件修正：`flutter config --enable-hcpp` 取代隱藏旗標（3.50 起），並註明 manifest 明寫 false 會壓過旗標；改來源 `.dart` 後以 build_runner 重新生成兩個 `.g.dart`（Q2）。
- **[核准]** 使用者核准；完成後採預設 commit + 開 PR；Issue 已建立（#16）。
- **[執行模式]** 序列（單一 repo）。
- **[Q1]** 以實機 `25097RP43G`（Android 16）加兩個模擬器驗證 — 理由：使用者已接上實機
- **[Q2]** `android_composition_mode.g.dart` 改來源註解後重新生成，找不到生成指令就不手改 — 理由：生成檔手改會被覆蓋
- **[Phase 0]** 單一 repo `aqutter_core`；證據來源為上列 `path:line`；既有計畫 `2610211200-windows-platform-view-perf`（Awaiting Archive）不涉及 HCPP，無衝突。
- **[Phase 0]** Milestone：不指定（使用者回答）；Base Branch = `main`；已 sync 至 `origin/main`（`8833f94`）。
- **[Phase 0]** 不依賴「升級 Flutter 至 3.50」PR：本機 Flutter 已是 3.50.0，而 `pubspec.yaml` 下限 `>=3.47.8` 已涵蓋。
- **[Phase 0]** 3.50 發佈說明：Android 的 HCPP 可用 `flutter config --enable-hcpp`（需 API 34+、Impeller）；`flutter config` 已列出此旗標。

## Deviations
Impact Files 補列 `webview_settings.dart`（同一個過時說法，Phase 3 才發現）。選文字選單、全螢幕影片、真機滾動效能未驗證；實測用的暫時探測入口已刪除，未進 commit。實測過程暫改的 manifest 與 `flutter config` 已還原。

## Impact Files
- `example/android/app/src/main/AndroidManifest.xml:36-39` — opt-in 註解改述 3.50 行為
- `lib/src/platform_interface/src/types/android_composition_mode.dart:39-43`、`android_composition_mode.g.dart:50-54` — 文件註解（`.g.dart` 重新生成）
- `lib/src/platform_interface/src/webview/webview_settings.dart:1214-1215`、`webview_settings.g.dart` — 文件註解
- `.kn-project/wiki/features/android-platform-view-composition.md` — opt-in 表、驗證涵蓋裝置
- `lib/src/platforms/android/src/webview/webview.dart:38-428` — 實測對象，未改

## Wiki Changes

| 頁面 | 日期 | 版本 | 變動 | Issue | PR |
|---|---|---|---|---|---|
| `features/android-platform-view-composition.md` | 2026-11-14 | — | HCPP opt-in 改為 flutter config --enable-hcpp，驗證涵蓋三台裝置 | [#16](https://github.com/Aqutter/aqutter_core/issues/16) | — |
