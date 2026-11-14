# 2611142010-kotlin-third-party-plugins

- Created: 2026-11-14 20:10 / Archived: 2026-11-14 21:00
- Issue: Aqutter/aqutter_core#20
- Milestone: N/A / Base Branch: main

## Summary
評估 Flutter 3.50 警告點名的兩個第三方 plugin：移除 example 裡未使用的 flutter_downloader，並把 file_picker 從 10.3.10 升到 12.3.0，aqutter_core example 的 Android 建置因此不再有任何警告。

只動 example 與文件，library 不變。驗證：APK 建置無警告、iOS 模擬器建置通過、flutter analyze 無 error、27 個相關 widget 測試通過、實機開啟並取消檔案選擇器正常。

## Cross-Repo Scope
無（單一 repo）。aqutter-plugins 的 file-manager 只作為「file_picker 12 以上不套用 KGP」的對照證據，未修改。

## Key Decisions
- **[Q1]** 評估結果直接套用，建置與實機啟動通過才保留 — 理由：兩者只在 example，flutter_downloader 無程式碼使用，file_picker 已有 file-manager 的同版本驗證
- **[核准]** 使用者核准；完成後採預設 commit + 開 PR；Issue 已建立（#20）。
- **[Phase 0]** 單一 repo `aqutter_core`；證據：上列 `path:line`、`pub.dev` 版本、前一份 Kotlin/AGP 計畫的建置警告輸出。
- **[Phase 0]** Milestone：不指定（使用者回答）；Base Branch = `main`；已 sync 至 `origin/main` 且工作區乾淨。
- **[Phase 0]** 整合主幹：遠端無 dev／develop 類分支，採 `origin/HEAD`＝`main`，不詢問、不記錄。
- **[範圍]** 承接 `2611141800-upgrade-kotlin-agp-flutter-3-50` 暫定的「第三方 plugin 不動、只列為風險」；其他 repo（範本專案、nuxt-app）建置時沒有這類警告，不在範圍。
- **[執行模式]** 序列（單一 repo）。
- **[評估]** `flutter_downloader`：程式碼無 import、1.12.1 為最新版且仍套用 KGP → 移除（含 manifest provider、iOS 註解殘留）。
- **[評估]** `file_picker`：10.3.10 套用 KGP；升到 12.3.0（與 aqutter-plugins 的 file-manager 同版本）後警告消失。12 版 API 變動：`FilePicker.platform` 移除，改 `FilePicker.pickFile()` 加 `PlatformFile.readAsBytes()`（無 `withData` 參數）。
- **[實測]** 升級後 `flutter build apk --debug` 完全沒有警告；iOS 模擬器建置通過；`flutter analyze` 無 error；`test/widgets/common` 27 項通過；Android 16 實機開啟檔案選擇器、取消後回傳 null、無崩潰。
- **[副作用]** 移除 plugin 後 Flutter 工具自動更新 iOS 專案：`project.pbxproj` 移除 `[CP] Embed Pods Frameworks`（flutter_downloader 是唯一的 CocoaPods 相依）、兩個 `Package.resolved` 移除 file_picker 10 的 iOS 相依（DKCamera 等）；macOS 的 `GeneratedPluginRegistrant.swift` 改用 `file_picker_darwin`。皆為相依變動的直接結果，一併提交。
- **[未驗證]** 以實機實際選一個檔案後 `readAsBytes()` 的結果（我不替你選裝置上的檔案，只驗到開啟與取消）；example 完整測試套件（跑超過 10 分鐘未完成，已停止）；macOS、Windows、Linux 建置。

## Deviations
Impact Files 補列 iOS 的 `project.pbxproj`、兩個 `Package.resolved` 與 macOS 的 `GeneratedPluginRegistrant.swift`（移除 plugin 與升級 file_picker 的直接結果，由工具自動產生）。完整 example 測試套件未能跑完（見 Key Decisions 的未驗證）。

## Impact Files
- `example/pubspec.yaml:25,33` — 移除 `flutter_downloader`；`file_picker` `^10.3.8` → `^12.3.0`
- `example/android/app/src/main/AndroidManifest.xml:68-77` — 移除 flutter_downloader 的 provider
- `example/ios/Runner/AppDelegate.swift:3,12` — 移除已註解的 flutter_downloader 殘留
- `example/lib/widgets/common/parameter_dialog.dart:320-326` — `FilePicker.pickFile()` 加 `readAsBytes()`
- `example/ios/Runner.xcodeproj/project.pbxproj`、`example/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved`、`example/ios/Runner.xcworkspace/xcshareddata/swiftpm/Package.resolved` — 工具自動更新
- `example/macos/Flutter/GeneratedPluginRegistrant.swift` — `file_picker` → `file_picker_darwin`
- `.kn-project/project.md:75` — 平台基準段改寫
