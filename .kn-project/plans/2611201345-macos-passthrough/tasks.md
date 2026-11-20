# Tasks for 2611201345

## Phase 1 — 驗證 macOS 現況（暫時覆寫，不提交）
- [x] nuxt-app 以 `pubspec_overrides.yaml` 指向本機 core，加入 macOS 支援（暫時），`flutter pub get` 並以 `.dart_tool/package_config.json` 確認覆寫生效
- [x] `aqutter dev macos` 跑 plugins 頁的 mirror-demo：確認 `auto` 協商成穿透、洞裡看得到底下 Flutter 格線與圓球、位置大小對得上
- [x] 確認拖曳（圓球移動）、點擊（計數）、疊在上面的 HTML 照常顯示；切 mirror 再切回穿透

## Phase 2 — 依驗證結果補原生（僅在 Phase 1 透明不通過時）
- [x] `macos/.../AqutterWebView.swift` 執行期 `setSettings` 補 `transparentBackground` 切換，重跑 Phase 1 驗證

## Phase 3 — 正式改動與文件
- [x] `native_mode.dart`：支援清單加入 macOS、更新注解
- [x] `test/nativeview_passthrough_test.dart`：平台清單、不支援平台的 widget 測試改用 Linux
- [x] `doc/nativeview.md`（與 README 若有敘述）：支援平台列、驗證範圍與限制
- [x] 還原 nuxt-app 暫時覆寫與重新產生的鎖定檔

## Phase 4 — 驗證
- [x] `flutter analyze`、全部測試
- [x] 不帶覆寫再跑一次 macOS 主流程（正式路徑）— 未做：原生修正只存在於本機 core，合併前沒有可用的鎖定版本；最終程式碼與驗證時相同（見 plan Deviations）
