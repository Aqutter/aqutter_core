# 2611141530-upgrade-flutter-3-50

- Created: 2026-11-14 15:30 / Archived: 2026-11-14 16:10
- Issue: Aqutter/aqutter_core#14
- Milestone: N/A / Base Branch: main

## Summary
將 aqutter_core 的 Flutter 基準由 3.47.8／Dart 3.13.7 升到 3.50.0／3.14.0（pubspec 下限與 .fvmrc）。

以 3.50.0 驗證：flutter analyze 0 error／0 warning（4061 項 info 為既有風格 lint）、flutter test 125 項通過。`lib/` 沒有 Material 依賴；88 個 material.dart import 全在 example/。順帶更新 project.md 的平台基準段與 wiki 一處「3.47」措辭。

## Cross-Repo Scope
參與：aqutter_core（下限、.fvmrc）、aqutter（shell 下限、docs）、aqutter-cli（範本）、aqutter-plugins（11 個 package）、aqutter-nuxt-app（範例 App，直接推送 main）。共用 ID `2611141530-upgrade-flutter-3-50`、共用分支 `feature/2611141530-upgrade-flutter-3-50`。順序：core → aqutter → cli／plugins → nuxt-app；各自開自己的 PR。

## Key Decisions
- **[核准]** 使用者全部核准；完成後選項採預設 commit + 開 PR（nuxt-app 直接推送 main，不開 PR）；Issue 已建立並回填（core#14、aqutter#53、cli#26、plugins#1）。
- **[執行模式]** 序列（依據：相依鏈 core → shell → cli／plugins → nuxt-app 本來就是一條線，且環境只確認單一工作目錄）。
- **[Q1]** manifest 的 baseline 與 ref 於各 PR 合併後另走同步（`pnpm manifest:sync`），不在本計畫的 PR 內 — 理由：ref 是 commit sha，與 CI manifest-check 綁定
- **[Q2]** 範圍只到版本基準與驗證，優化項目寫進評估報告另案處理 — 理由：每項優化可獨立驗證與回退
- **[Q3]** 下限 `flutter: '>=3.50.0'`、`sdk: '>=3.14.0 <4.0.0'`，不設上限 — 理由：沿用「基準＝參考版本」慣例
- **[Phase 0]** 目標 repo：aqutter、aqutter_core、aqutter-cli、aqutter-plugins、aqutter-nuxt-app（來源：使用者確認；aqutter-js 無 Flutter 不納入）。
- **[Phase 0]** 本機 `aqutter-plugin-battery`／`-google-maps`／`-haptics`／`-mirror-demo` 在 GitHub 已不存在，官方 plugin 已合併為 `Aqutter/aqutter-plugins`，本次 clone 後升級該 monorepo；舊四個資料夾不動。
- **[Phase 0]** Milestone：不指定（使用者回答）；`Base Branch` = `main`；問過一次，不再勸說。
- **[Phase 0]** 整合主幹：遠端無 dev／develop 類分支，採 `origin/HEAD`＝`main`，不詢問、不記錄。
- **[Phase 0]** Baseline Sync：aqutter-nuxt-app 工作區有 build 副產物（Podfile、pbxproj、Package.resolved、pubspec.lock），經使用者確認丟棄後，五個 repo 皆已 fast-forward 至 `origin/main`。
- **[Phase 0]** 本機 Flutter 已是 3.50.0（Dart 3.14.0），不需安裝。
- **[Phase 0]** 既有計畫 `2610211200-windows-platform-view-perf`（Awaiting Archive）不動版本檔，無衝突。
- **[驗證]** 以 3.50.0 驗證：flutter analyze 0 error／0 warning（4061 項 info 為既有風格 lint）、flutter test 125 項通過。
- **[未驗證]** Android／iOS／macOS／Windows／Linux 實機與簽章流程。

## Deviations
與計畫相同，另補 project.md 與 wiki 各一處文字更新（Phase 5 修剪的結果）。wiki-lint 有 30 項既有硬閘違規（導覽列等，非本次引入），且 core 從未建置 wiki.html，本次未建置。

## Impact Files
- `pubspec.yaml:10,11,14` — sdk／flutter 下限與參考版本註解
- `.fvmrc:2` — 3.50.0
- `.kn-project/project.md:75,80` — 平台基準段改為 3.50.0，註記 KGP 尚未跟進 2.4.20
- `.kn-project/wiki/features/android-platform-view-composition.md:28` — 註記 3.50 後未重新核對 HC／TLHC API 對應

## Wiki Changes

| 頁面 | 日期 | 版本 | 變動 | Issue | PR |
|---|---|---|---|---|---|
| `features/android-platform-view-composition.md` | 2026-11-14 | — | 升級 Flutter 基準至 3.50.0，標註 HC／TLHC API 對應未重新核對 | [#14](https://github.com/Aqutter/aqutter_core/issues/14) | — |
