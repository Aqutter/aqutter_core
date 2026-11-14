# 2611142100-example-material-ui-migration

- Created: 2026-11-14 21:00 / Archived: 2026-11-14 22:00
- Issue: Aqutter/aqutter_core#23
- Milestone: N/A / Base Branch: main

## Summary
aqutter_core 的 example 從 Flutter 3.50 已棄用的 package:flutter/material.dart 遷到 package:material_ui/material_ui.dart，88 個檔案、88 筆棄用警告歸零，library 不受影響。

連同 intl 升到 0.20.3（material_ui 的需求）。驗證：analyze 無 error、Android 與 iOS 模擬器建置通過、Android 16 實機啟動 example 畫面正常；widget 測試 75 通過、3 失敗，與 origin/main 完全相同。

## Cross-Repo Scope
無（單一 repo）。

## Key Decisions
- **[Q1]** example 的 `deprecated_member_use` 維持 ignore — 理由：打開會浮出與本遷移無關的警告（如 `clearCache`），屬另案
- **[核准]** 使用者核准；完成後採預設 commit + 開 PR；Issue 已建立（#23）。
- **[Phase 0]** 單一 repo `aqutter_core`；證據：上列實測與 `pub add --dry-run`、`dart fix --dry-run` 輸出；已 sync 至 `origin/main` 且工作區乾淨。
- **[Phase 0]** Milestone：不指定（使用者回答）；Base Branch = `main`。
- **[Phase 0]** 整合主幹：遠端無 dev／develop 類分支，採 `origin/HEAD`＝`main`，不詢問、不記錄。
- **[範圍]** 只遷 example；library、shell、範本、nuxt-app、plugins 的 Material 與 Cupertino import 已是 0，不在範圍。
- **[執行模式]** 序列（單一 repo）。
- **[實測]** `dart fix --apply --code=migrate_design_widgets` 改了 88 個檔案（每檔 1 處，只換 import）；`material.dart` import 剩 0；暫時打開 `deprecated_member_use` 後 Material 棄用警告為 0（遷移前 88），`flutter analyze` 無 error。
- **[實測]** 相依：`material_ui` 1.11.0、`cupertino_ui` 1.1.6（material_ui 的相依）、`intl` 0.18.1 → 0.20.3；用 `intl` 的兩個檔案（`DateFormat('HH:mm:ss…')`）在實機上時間戳顯示正常。
- **[實測]** Android debug APK 建置無警告；iOS 模擬器建置通過；example 在 Android 16 實機啟動並載入 flutter.dev，畫面（AppBar、輸入框、分頁、卡片）正常。
- **[既有失敗]** `test/widgets` 為 75 項通過、3 項失敗（`EventConsoleWidget` 兩項、`MethodTesterWidget` 一項，找不到預期的 widget）；用乾淨的 `origin/main` 副本對照結果完全相同，**非本遷移造成**，未處理。
- **[發現，不處理]** 打開棄用警告後另浮出約 90 筆與 Material 無關的棄用（`WidgetTester.window`、`withOpacity`、`aqutter_core` 自己的 `clearCache` 等）— 依 Q1 維持 ignore，屬另案。
- **[未驗證]** example 完整測試套件與 integration_test 的實際執行（僅確認能編譯）；macOS、Windows、Linux 建置；實機上逐一走過所有 example 畫面。

## Deviations
無。計畫 Impact Files 預估的 88 個檔案與實際一致。

## Impact Files
- `example/pubspec.yaml:31` — `intl` `^0.18.1` → `^0.20.2`；新增 `material_ui: ^1.11.0`
- `example/lib/**`（51 個檔案）、`example/test/**`（32 個）、`example/integration_test/**`（5 個）— `package:flutter/material.dart` → `package:material_ui/material_ui.dart`
- `example/lib/widgets/webview/network_monitor_widget.dart:2`、`event_console_widget.dart:2` — 用 `intl`，經確認相容（未改）
- `.kn-project/project.md:75` — 補上 material_ui 遷移結果
