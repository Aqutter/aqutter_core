# Tasks for 2611172115

## Phase 1 — 準備驗證環境（只讀其他 repo）
- [x] 將 `aqutter`、`aqutter-js`、`aqutter-plugins` 本機 fast-forward 到 origin/main（工作區必須乾淨，否則停下回報）
- [x] 殼以未追蹤的 `pubspec_overrides.yaml` 指向本機 `aqutter_core`（驗證後移除）
- [x] 建置並在 iPhone 17 Pro 模擬器啟動殼，載入含 google-maps plugin 的網頁

## Phase 2 — 模擬器驗證穿透（未改 core 前的基線）
- [x] 暫時視為支援的做法：在驗證環境以 debug 方式讓 iOS 通過平台閘門（不進 commit），觀察 `auto` 協商結果
- [x] 驗證：協商成穿透、地圖位置與網頁元素矩形一致、WebView 透明、拖曳／縮放手勢、`mirror`↔`passthrough` 切換、捲動進入畫面
- [x] 記錄結果（成功／失敗與現象，附截圖）；失敗時依 Q1 處理

## Phase 3 — 開啟 iOS 支援（僅 Phase 2 通過）
- [x] `lib/src/nativeview/native_mode.dart`：`aqutterNativePassthroughSupported` 納入 iOS，更新注解
- [x] `test/nativeview_passthrough_test.dart`：平台支援表測試與 iOS 變體；依 Q2 修既有 2 個失敗測試
- [x] `doc/nativeview.md`：補 iOS 支援狀態與驗證範圍（模擬器；實機待驗）

## Phase 4 — 驗證
- [x] `flutter analyze` 與 nativeview 相關測試全過
- [x] 以正式（非 debug）路徑在模擬器再跑一次主流程
- [x] 移除驗證用的 `pubspec_overrides.yaml`，確認其他 repo 工作區乾淨
