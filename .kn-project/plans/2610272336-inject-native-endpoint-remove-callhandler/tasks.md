# Tasks for 2610272336

## Phase 1 — 端點通知（契約 #1）
- [x] [aqutter_core] `native_host_io.dart`：以 `ValueNotifier<AqutterNativeEndpoint?>` 保存端點，對外暴露 `endpoint`（`ValueListenable`）
- [x] [aqutter_core] `_start()` 在 `server.listen` 之後指派新值；`restart()` 先清為 null、重啟完成後指派新值；`stop()` 設為 null
- [x] [aqutter_core] `native_host_stub.dart`：補同名 `endpoint`（恆為 null）
- [x] [aqutter_core] `nativeview.dart` 匯出確認

## Phase 2 — 測試與文件
- [x] [aqutter_core] `test/nativeview_test.dart`：啟動後非 null；`restart()` 後通知且埠、令牌改變；`stop()` 後為 null
- [x] [aqutter_core] `doc/nativeview.md`（27、35 行）與 `doc/rpc.md`（80 行）改寫

- [x] [aqutter_core] 補列：`doc/rpc.md:5`、`lib/src/rpc/rpc_host.dart:35` 註解

## Phase 3 — 驗證
- [x] [aqutter_core] `flutter analyze` 與 `flutter test` 全過
- [x] [aqutter_core] 確認 `lib/` 內沒有新增對 `callHandler` 的使用（`git grep callHandler -- lib` 只剩平台層原有命中）
