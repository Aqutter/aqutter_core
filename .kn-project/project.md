<!-- REMINDER: Relative Paths Only! No file:///c:/... -->
# aqutter_core

Aqutter 框架（網頁 + Flutter 殼）的 WebView 核心套件：提供 inline WebView、headless WebView 與 in-app browser，涵蓋 Android、iOS、macOS、Windows、Linux 與 Web，供使用端以 **git 依賴**方式使用。

衍生自 `pichillilorenzo/flutter_inappwebview`（Apache-2.0，出處與變更見 `NOTICE`），直接來源為
`KNightING/flutter_inappwebview`（tag `6.2.0-beta.3.6`，commit `1883884f5`）。本 repo 是獨立 repo
（**不是 GitHub fork**），不帶上游 git 歷史。

存在目的不是追隨上游，而是**把使用端反覆重造的原生行為收進套件**——最先處理的是軟鍵盤避讓：
那件事需要同時掌握「鍵盤高度」與「WebView 的原生視圖」，兩者都只有套件層拿得到，
放在模板或 App 層必然重複實作且互相打架。

## 保留鐵則

- **永久分岔，不再同步上游。** 目錄結構與上游不同，無法再 merge；上游日後的修正需手動評估移植。
  本專案不對上游發 PR。
- **對外名稱已定案**：Dart 公開 API、原生類別、channel 前綴、JS 全域名稱與 plugin 類別名皆為 Aqutter 命名，
  與上游名稱的對照見 `doc/dart-rename-map.md`、`doc/native-rename-map.md`。channel 與 JS 名稱由 Dart 與五個原生端
  （以及使用端的 TypeScript）共用同一個字串，改名須逐端同步。
- **以 git 依賴使用，不發佈 pub.dev。** 根 `pubspec.yaml` 設定 `publish_to: none`，實際執行 `flutter pub publish`
  會被 pub 以「A private package cannot be published.」拒絕，repo 也不保留任何發佈腳本；`dev_packages/*` 因此可以使用 `path:` 依賴。
  日後若要改為發佈，須先讓 `aqutter_core_internal_annotations` 與 `generators` 也能從 pub.dev 解析，
  再移除 `publish_to`。
- **網頁⇄Dart RPC**：`AqutterRpcHost`（`lib/src/rpc/`）以通道 `aqutter.rpc` 承載呼叫、回應、事件與二進位；訊框格式與 `Aqutter/aqutter-js` 的 `src/frame.ts` 成對，兩端以 `test/rpc_frame_vectors.json` 保持一致，改一邊必改另一邊。說明見 `doc/rpc.md`。
- **對同 repo 的 `dev_packages` 一律用相對 `path:`**，不帶版本約束（`path` 依賴不得同時帶版本）。
- **版本號以根 `pubspec.yaml` 的 `version` 為唯一來源**，使用端以對應的 git tag 鎖定。

## 開發機設定

本 repo 不是 fork，`gh pr create` 不會誤指向他人的 repo。若想省略 `gh` 指令的 `--repo` 旗標，可在
**各 clone**（設定存於 `.git/config`，不隨 repo 傳遞）執行：

```bash
gh repo set-default Aqutter/aqutter_core
```

## Architecture

單一 Flutter plugin 套件，repo 根目錄即套件根目錄（根 `pubspec.yaml`）：

| 位置 | 職責 |
| :--- | :--- |
| `lib/aqutter_core.dart` | 唯一對外入口 |
| `lib/src/platform_interface/` | 平台無關的介面與設定物件（`AqutterWebViewSettings` 等），含 build_runner 產生的 `*.g.dart` |
| `lib/src/*`（`platform_interface`、`platforms` 以外） | app-facing 類別（`AqutterWebView`、`AqutterBrowser`、`AqutterChromeSafariBrowser` 等） |
| `lib/src/nativeview/` | native view 鏡像（`AqutterNative`、localhost WebSocket host、iOS 原生擷取的 Dart 端）；iOS 原生端在 `ios/…/NativeView/` |
| `lib/src/platforms/<平台>/` | 各平台的 Dart 實作（android、ios、macos、windows、linux、web） |
| `lib/src/platforms/platforms.dart` | 以 `dart.library.js_interop` 條件匯出：原生建置只公開 5 個平台的註冊類別，Web 改由 pubspec 的 `fileName` 註冊 |
| `android/` `ios/` `macos/` `windows/` `linux/` | 各平台原生程式碼（Android 為 Kotlin，位於 `android/src/main/kotlin`，命名空間 `com.github.aqutter.core`） |
| `dev_packages/aqutter_core_internal_annotations` | 程式碼產生用註記 |
| `dev_packages/generators` | 程式碼產生器 |
| `example/` | 範例與整合測試 |
| `web_support/` | Web 端 JS 橋接（TypeScript），建置為 `lib/assets/web/web_support.js` |

新增一個跨平台設定的路徑固定為：`lib/src/platform_interface` 宣告 → `lib/src/platforms/<平台>/`
各平台實作解析 → `lib/src/` 下的 app-facing 類別透傳（`*.g.dart` 以 `npm run build` 重新產生）。

原生建置識別字（podspec、Swift Package、CMake 目標與 `include/` 目錄）一律與套件名 `aqutter_core`
一致——Flutter 產生的 registrant 與 `generated_plugins.cmake` 以套件名解析它們；
`pluginClass`（`AqutterCorePlugin`、Windows 為 `AqutterCorePluginCApi`）決定標頭與註冊函式名，不得更動。

### Android 的 WebView 層次

`FlutterWebView`（`public class`，`implements PlatformWebView`）
→ `AqutterWebView`（`final public class`）
→ `InputAwareWebView`（`public class`，**非 final**）
→ `android.webkit.WebView`。

`InputAwareWebView` 未被 final 修飾，是掛 window insets 監聽最自然的位置。

### 平台基準

對齊 **Flutter 3.47.8 / Dart 3.13.7**。

| 項目 | 現值 |
| :--- | :--- |
| AGP | **9.3.0**；Gradle wrapper 9.5.0 |
| Kotlin Gradle Plugin | **2.4.0**（Flutter 3.47 的 template 值） |
| `compileSdk` / `targetSdk` | 取 `flutter.compileSdkVersion`（跟隨 Flutter SDK，非硬寫）=36 |
| `minSdkVersion` | **24**（Flutter 支援下限；app 端低於 23 即建置失敗） |
| iOS 部署目標 | **15.0**（套件 SPM/podspec 與 example 專案一致） |
| macOS 部署目標 | **12.0**（同上） |

- iOS / macOS **同時**提供 `Package.swift`（SPM）與 `.podspec`（CocoaPods），兩者並存。
  **Flutter 3.47 起 SPM 於 stable 預設啟用**，故套件的 `Package.swift` 會被拉進 app 建置。
- **macOS 部署目標勿降回 10.14**：新版 Xcode 對 `ASWebAuthentication` 的可用性檢查會令 10.14
  直接建置失敗。
- iOS example 已採用 **UIScene 生命週期**（`UISceneDelegateClassName` 用 engine 內建的
  `FlutterSceneDelegate`，未新增 Swift 檔案、未改 `project.pbxproj` 結構）。
- **已知未驗證**：實體 iOS 裝置、Linux。native view 鏡像已在 macOS、Android 模擬器與 iOS 模擬器驗證（鏡像 Flutter widget 的 `RepaintBoundary` 路徑）；iOS `drawHierarchy` 擷取只確認編譯通過，尚未對 PlatformView 實跑。

### JS 橋接名稱

注入於網頁的全域物件名**是執行期可設定的**，非寫死常數：
`JavaScriptBridgeJS.set_JAVASCRIPT_BRIDGE_NAME()` / `get_JAVASCRIPT_BRIDGE_NAME()`，
Android / iOS / macOS 三平台的宣告皆位於各自的 `plugin_scripts_js` / `PluginScriptsJS`
目錄下的 `JavaScriptBridgeJS`。預設值 `aqutter`，使用端的
`window.aqutter.callHandler(...)` 依此。

## 待移植（來自 `KNightING/camelot_inappwebview`）

該 fork（`arrrrny/zikzak_inappwebview` 的下游）已停止作為開發基底，但有三項上游沒有、
本專案需要的東西待移植：

- **Windows virtual host mappings** — 繞過本地 CORS，約 414 行，跨 `lib/src/platform_interface`
  與 Windows 實作（`lib/src/platforms/windows`、`windows/`）。
- **`ZikZakSecurityManager`** — 憑證釘選、HTTPS-only、fetch/XHR 請求攔截，661 行（Android）。
  移植時需重新命名（不沿用 ZikZak 字樣）。
- **macOS popup window 修正** — `window.open` 的 popup 視窗與事件遞送。移植前需先確認上游是否已修。

## 版本紀錄

開發階段版本固定為 `0.0.0`，以 git tag `0.0.0` 作為使用端的鎖定點（有變更時移到最新的 `main`）；正式版本號待釋出時再定。

- 0.0.0 — 單一 Flutter plugin 套件提供 WebView 核心（六個平台）、native view 鏡像

---
[🏠 Wiki](./wiki/index.md)
