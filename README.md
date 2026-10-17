# aqutter_core

Aqutter 框架（網頁 + Flutter 殼）的 WebView 核心套件：提供 inline WebView、headless WebView 與 in-app browser，涵蓋 Android、iOS、macOS、Windows、Linux 與 Web。

本套件衍生自 [flutter_inappwebview](https://github.com/pichillilorenzo/flutter_inappwebview)（Apache-2.0），出處與變更見 [NOTICE](NOTICE)。各 API 的用法可參考 [inappwebview.dev](https://inappwebview.dev/docs/intro/)，類別名請依 [doc/dart-rename-map.md](doc/dart-rename-map.md) 換算；原生端、channel 與 JS 橋接的名稱對照見 [doc/native-rename-map.md](doc/native-rename-map.md)（channel 前綴 `com.github.aqutter/`、JS 全域 `window.aqutter`）。

## 平台需求

| 平台 | 需求 |
| :--- | :--- |
| Dart／Flutter | Dart `^3.8.0`、Flutter `>=3.32.0` |
| Android | `minSdk 24` |
| iOS | 15.0 以上 |
| macOS | 12.0 以上 |
| Windows | `PATH` 中需有 [NuGet CLI](https://learn.microsoft.com/en-us/nuget/install-nuget-client-tools?tabs=windows#nugetexe-cli) |
| Linux | 需 WPE 2.0 WebKit，見 [doc/linux-wpe-backend.md](doc/linux-wpe-backend.md) |
| Web | 見下方「Web 使用端設定」 |

## 安裝

本套件不發佈到 pub.dev，以 git 依賴引用：

```yaml
dependencies:
  aqutter_core:
    git:
      url: https://github.com/Aqutter/aqutter_core.git
      ref: 0.0.0 # 鎖定 tag
```

```dart
import 'package:aqutter_core/aqutter_core.dart';
```

各平台的環境設定（Android、iOS、macOS、Windows）請參考 [inappwebview.dev 的安裝說明](https://inappwebview.dev/docs/intro/)，流程與來源套件相同。

### Web 使用端設定

`index.html` 若載入 `web_support.js`，路徑應為：

```
assets/packages/aqutter_core/assets/web/web_support.js
```

## Native view 鏡像

把 Flutter 內容（Widget 或 PlatformView，如地圖）即時鏡像到網頁 canvas，並接收網頁手勢回控，讓網頁能在原生內容之上疊 HTML。Dart 端 `AqutterNative`，網頁端是 `@aqutter/aqutter` 的 `<aqutter-native>`；協定與限制見 [doc/nativeview.md](doc/nativeview.md)。

## 目錄結構

```
lib/                  Dart：aqutter_core.dart 為唯一入口
  src/platform_interface/   平台介面與型別（含 build_runner 產生的 *.g.dart）
  src/platforms/<平台>/     各平台的 Dart 實作
android/ ios/ macos/ windows/ linux/   各平台原生程式碼
example/              範例與整合測試
dev_packages/         產生器（generators）與其註解套件
web_support/          Web 端 JS 橋接（TypeScript，建置為 lib/assets/web/web_support.js）
test_node_server/     整合測試用的 Node 伺服器
doc/                  名稱對照、Linux WPE 說明與上游 CHANGELOG
```

## 開發

```bash
# 重新產生 *.g.dart（改動 platform_interface 內帶註解的型別後）
npm run build

# 範例 App
cd example && flutter run

# 整合測試（需先設定 Node 測試伺服器，見 scripts/test.sh）
scripts/test.sh
```

`web_support/` 需要 Node.js：在該資料夾 `npm ci` 後執行 `npm run build`，輸出到 `lib/assets/web/web_support.js`。

## 授權

Apache License 2.0，見 [LICENSE](LICENSE) 與 [NOTICE](NOTICE)。
