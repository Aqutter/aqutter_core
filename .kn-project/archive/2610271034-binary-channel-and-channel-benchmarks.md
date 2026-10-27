# 2610271034 - binary-channel-and-channel-benchmarks

- Created: 2026-10-27 10:34 / Archived: 2026-10-28 10:00
- Issue: Aqutter/aqutter_core#2
- Milestone: N/A / Base Branch: main

## Summary
`AqutterNativeHost` 新增通用二進位通道：`registerChannel`／`unregisterChannel`／`hasChannel`，網頁以 `/channel/<pluginId>.<channel>?token=` 連上（與鏡像共用伺服器與令牌），每條新連線交給註冊的處理函式；型別 `AqutterChannelConnection`、`AqutterChannelHandler` 與名稱格式 `aqutterChannelNamePattern` 都由本 repo 提供。Android 實機 1MB 往返由 base64 的 126 ms 降到 11.5 ms。

## Cross-Repo Scope
- 共用計畫 ID `2610271034-binary-channel-and-channel-benchmarks`、共用分支名 `feature/2610271034-binary-channel-and-channel-benchmarks`。
- `Aqutter/aqutter_core`（`#2`、PR `#3`）：通道的路由、註冊與連線介面。
- `Aqutter/aqutter`（`#14`，契約正本，PR `#15`）：`AqutterPlugin.channels`、註冊、基準工具與文件。
- `Aqutter/aqutter-js`（`#3`、PR `#4`）：`openBinaryChannel`。
- 順序：core → aqutter → aqutter-js。

## Key Decisions
- **[Phase 0]** 整合主幹 `main`；三個 repo 的 milestone 皆不指定，base 為 `main`。
- **[分層]** Dart 端型別與能力（連線、處理函式型別、註冊）都在 `aqutter_core`；殼只做界接。
- **[Q2]** 伺服器放在 `aqutter_core` 的 `AqutterNativeHost`，與鏡像共用伺服器與令牌（未採納「殼內另建」）。
- **[v1 範圍]** 只做二進位，不做背壓與自動重連；斷線後由網頁端自行重新開啟。
- **[契約]** rev 1 凍結（2026-10-27），實作後路徑、名稱格式與 API 未變。
- **[收尾語意]** 網頁端關閉時 `done` 要完成（`dart:io` 的 `WebSocket.done` 要等本地也關閉，不能直接用）；`restart()` 先關通道連線再關伺服器，否則連線被強制中斷而收不到 1001。

## Deviations
- 未歸檔就合併：PR #3 合併時尚未歸檔，歸檔另開 PR 補上；wiki 沒有新增頁（現有 wiki 只有舊式 features 頁，通道文件在 `doc/nativeview.md`）。

## Impact Files
- `lib/src/nativeview/native_host_io.dart` — 通道註冊表、`registerChannel`／`unregisterChannel`／`hasChannel`、`_onChannelRequest`、`_SocketChannelConnection`；`restart()`／`stop()` 關閉通道連線。
- `lib/src/nativeview/native_channel.dart` (new) — 連線與處理函式型別、名稱格式。
- `lib/src/nativeview/native_host_stub.dart`、`lib/src/nativeview/nativeview.dart` — 非 `dart:io` 的對應與匯出。
- `test/nativeview_channel_test.dart` (new) — 13 個測試（403、名稱、雙向、大訊息、文字被忽略、緩衝、done、關閉碼、取代、1011、重啟、鏡像不受影響）。
- `doc/nativeview.md` — 「通用二進位通道」一節。
- `.kn-project/project.md` — 保留鐵則補通道。
