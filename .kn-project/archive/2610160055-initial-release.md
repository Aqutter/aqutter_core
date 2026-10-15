# 2610160055 - initial-release

- Created: 2026-10-16 / Archived: 2026-10-16
- Issue: N/A
- Milestone: N/A / Base Branch: main

## Summary
`aqutter_core` 0.1.0：Aqutter 框架的 WebView 核心套件，衍生自 `flutter_inappwebview`，整合為單一 Flutter plugin 套件，涵蓋 Android、iOS、macOS、Windows、Linux 與 Web，並完成 Aqutter 命名（Dart 公開 API、原生類別、channel、JS 橋接、plugin 類別）與 Android 原生端的 Kotlin 化。
repo 為獨立 repo（非 fork），以單一初始 commit 建立、不帶上游歷史；直接推送 `main`，未使用 issue、PR、milestone 或版本分支。

## Cross-Repo Scope
無（單一 repo）。之後的 `aqutter`（殼、CLI、client）與範例 App 以 git tag 依賴本套件。

## Key Decisions
- **命名**：Dart 型別前綴 `Aqutter`、移除 `InApp`；channel 前綴 `com.github.aqutter/`；JS 全域 `window.aqutter`；plugin `AqutterCorePlugin`（Windows `AqutterCorePluginCApi`）；Android 命名空間 `com.github.aqutter.core` — 對照見 `doc/dart-rename-map.md`、`doc/native-rename-map.md`。
- **以 git 依賴使用、不發佈 pub.dev**（`publish_to: none`）；`dev_packages/*` 以相對 `path:` 依賴。
- **永久分岔**：不再同步上游，上游修正需手動評估移植。
- **Android 原生端全數為 Kotlin**，Kotlin `jvmTarget` 17；子套件名稱維持（`browser`、`headless_webview`、`webview.webview` 等）。
- **持久化名稱**：Android 資料庫 `aqutter_credential_database.db`；FileProvider authority 與 intent key 採 `aqutter` 命名。
- **版本** `0.1.0`，以 tag 鎖定。

## Deviations
- 驗證：`flutter analyze` 4,062 項（皆為既有 info／warning，0 error）；build_runner 重新產生無漂移；Android debug／release（R8）、iOS 模擬器、macOS、Web 建置通過；macOS 整合測試 `getTitle`、`JavaScript Handler`、`evaluateJavascript` 通過；`example` 單元測試 274 通過、4 個既有 UI 測試失敗；channel 字串集合在 Dart 與五個原生端逐一相同（114／24／21／18／19／21 處），Dart 與 Windows／Linux 共用的 channel 方法名（`createAqutterWebView`）一致；Windows／Linux 的 `#include` 與 CMake 來源清單皆指向存在的檔案，Flutter 產生的 registrant 所需標頭與註冊函式皆存在。
- **未能驗證**：Windows、Linux 的 C++ 實際編譯與執行（僅靜態檢查）；Android 實際載入網頁（模擬器 WebView 載入逾時）；實體 iOS 裝置；Android `CredentialDatabase` 舊資料搬移的執行期行為。
- `example/integration_test/env.dart` 為 gitignored 的本機檔案（內容 `final environment = {"NODE_SERVER_IP":"127.0.0.1"};`），新 clone 需自行建立才能分析整合測試。
- 既有問題：`example/test` 4 個 UI 測試失敗。

## Impact Files
- 全 repo（初始匯入）：`lib/**`、`android/**`（Kotlin）、`ios/**`、`macos/**`、`windows/**`、`linux/**`、`web_support/**`、`dev_packages/**`、`example/**`、`doc/**`
- `pubspec.yaml`（套件名、版本、`pluginClass`／`dartPluginClass`）、`NOTICE`（上游出處）、`AGENTS.md`、`.kn-project/project.md`、`.kn-project/wiki/**`
