# Tasks for 2611171503

## Phase 1 — 契約與型別
- [x] [aqutter_core] 契約定案（本計畫 `## Contract`），核准後凍結為 rev 1
- [x] [aqutter_core] `AqutterNativeMode`、`AqutterNativeLayout` 型別；模式決策函式（純邏輯）與單元測試　依賴 Contract §2、§3、§4

## Phase 2 — 原生端協議
- [x] [aqutter_core] `native_host_io.dart` 處理 `mode`／`layout`，回覆 `mode`；沒有 `mode` 訊息視為鏡像　依賴 Contract §2
- [x] [aqutter_core] `passthroughSessions` 計數（連線關閉時扣回）
- [x] [aqutter_core] Web stub 對應

## Phase 3 — widget 與 WebView
- [x] [aqutter_core] `AqutterNative(mode:)`；穿透時不擷取、child 依 `layout` 定位、`visible: false` 時 `Offstage`
- [x] [aqutter_core] Android 透明設定：查根因並修，使初始與執行期等效
- [x] [aqutter_core] widget 測試、`flutter analyze`、`flutter test`；`doc/nativeview.md`

## Phase 4 — 整合驗證
- [ ] [aqutter_core] 需等待 [aqutter-js]：元素端完成後，在實機（Android）以兩種模式各跑一次地圖，確認切換與退回
