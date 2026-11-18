# Tasks for 2611172358

## Phase 1 — 實驗：原生直接接觸控是否平順（已完成）
- [x] 建置驗證環境並實驗；模擬器與 iPad 實機都確認「原生直接接觸控不抖、現行轉送路徑會抖」（見 plan 的 Key Decisions）
- [x] 記錄結果；Q1 已確認為「本計畫實作」

## Phase 2 — Spike：core 單獨驗證兩層路由（不動契約，用固定測試區域）
- [x] Dart 層：`native_touch_gate.dart` 讓 `AqutterWebView` 在測試區域內對 Flutter hit test 透明
- [x] UIKit 層：`NativeTouchRouter` 在測試區域回傳底下的地圖 view，其他點回 `nil`
- [x] 暫時改 plugin 的 `GoogleMap` 帶 `EagerGestureRecognizer`（本機副本，不進 commit）
- [x] iPad 驗證：區域內拖曳走原生且不抖、縮放正常；區域外的 HTML 按鈕仍可點；Flutter 覆蓋層與啟動畫面觸控不受影響
- [x] **過關閘**：任一項不過就停下回報，依 Q2 處理，不進 Phase 3

## Phase 3 — 實作（需 Phase 2 過關；契約 rev 1 凍結後）
- [ ] 建立 `aqutter-js`、`aqutter-plugins` 的 issue 與共用分支，各補自己的計畫（契約逐字相同）
- [ ] `aqutter_core`：`webRegions` 解析與驗證、`nativeTouch` 計算、區域取代 spike 的固定測試區域、測試
- [ ] `aqutter-js`：`elementFromPoint` 取樣、合併成矩形、隨 `layout` 回報、節流、測試
- [ ] `aqutter-plugins`：`nativeTouch` 為真時 `GoogleMap` 帶 `EagerGestureRecognizer`
- [ ] 文件：`doc/nativeview.md`「穿透的觸控」

## Phase 4 — 驗證
- [ ] 契約一致性檢查（Rule 28）與端到端：map-effects 頁在模擬器與 iPad
- [ ] 拖曳、縮放、雙擊、按鈕、連點測試、捲動頁面、模式切換（auto／mirror／passthrough）
- [ ] Android／mirror 不受影響（測試與程式碼核對；無 Android 實機則明講未驗證）
- [ ] `flutter analyze`、各 repo 測試、還原暫時改動、其他 repo 工作區乾淨
