# 2610271120 - unified-bridge-transport

- Created: 2026-10-27 11:20 / Archived: 2026-10-27 16:00
- Issue: Aqutter/aqutter_core#6
- Milestone: N/A / Base Branch: main

## Summary
`AqutterRpcHost` 讓網頁與 Dart 之間的呼叫、回應、事件與二進位共用一條本機連線（通道 `aqutter.rpc`）：訊框含 JSON 標頭與二進位區塊、酬載內以 `{"$bin": i}` 引用、handler 並行分派、事件只送給目前連線；超過 64 MiB 的訊框自動切成 16 MiB 的 `part` 重組，邏輯上限 512 MiB。Android 實機 1MB 往返二進位 15.5 ms 對 base64 100 ms（約 6.5 倍）。

## Cross-Repo Scope
- 共用計畫 ID `2610271120-unified-bridge-transport`、共用分支名 `feature/2610281120-unified-bridge-transport`。
- `Aqutter/aqutter_core`（`#6`）：`AqutterRpcHost`——訊框編解碼、`aqutter.rpc` 通道、handler 登錄與分派、`emit`、自動分段。
- `Aqutter/aqutter`（`#20`，界接）：內建與 plugin handler 登錄到 `AqutterRpcHost`、`supportedPlatforms`、`aqutterError` 轉換、移除 `channels`；文件與基準。
- `Aqutter/aqutter-js`（`#6`）：傳輸模組（連線、排隊、重連）、訊框編解碼、`callFlutter`／`callPlugin`／事件改走新傳輸、`onTransportState`、移除 `openBinaryChannel`。
- 順序：`aqutter_core` → `aqutter` → `aqutter-js`（契約 rev 2 起，core 與 js 可平行）。

## Key Decisions
- **[Phase 0]** 整合主幹 `main`；三個 repo 皆不指定 milestone，base 為 `main`。
- **[方向]** 使用者要求擴充 plugin 與使用 Flutter⇄網頁通道時不要有太多選擇，因此合併成單一傳輸，不並存兩套 API；開發介面（`handlers`、`emit`、`callPlugin`、`onPluginEvent`）不變，二進位直接放進酬載。
- **[分層]** Dart 端程式碼與介面由 `aqutter_core` 提供，`aqutter` 只做界接。
- **[Q1]** 內建 handler 全部改走新傳輸，只留 `native_endpoint` 在 `callHandler`。
- **[Q2]** Linux 由 agent 以 WSL2 驗證；iOS、macOS 由使用者用 Mac 驗證（追蹤於 Aqutter/aqutter#21）；失敗的處理屆時再決定，不預設也不排除全面統一。
- **[Q3]** 重連期間的事件不補發，提供 `onTransportState`。
- **[Q4]** 呼叫不設預設逾時；連線關閉時已送出的呼叫以 `TRANSPORT_CLOSED` 失敗。
- **[Q5]** 單一 WebSocket 訊息上限 64 MiB（rev 1）。
- **[契約變更]** rev 1 → 2：新增 `part` 訊框與自動分段，邏輯訊框上限 512 MiB（使用者要求框架自動處理大資料，2026-10-27 核准）。
- **[執行模式]** 序列。
- **[執行中]** 新連線到來時舊連線以 1000 關閉（最後一條有效）；訊框超過上限以 1009、格式錯誤以 1002 關閉——補上契約未指定的細節。
- **[完成後]** commit + 開 PR（併回 `main`）。

## Deviations
- 計畫 ID 與日期更正：原 `2610281120`（誤用 2026-10-28，機器日期是 2026-10-27）更正為 `2610271120`；GitHub 上實際存在過的分支名（`feature/2610281120-unified-bridge-transport`）、PR 與 issue 留言維持原樣。
- 契約 rev 1 → rev 2（Rule 29）：新增 `part` 與自動分段、上限 64 → 512 MiB；`aqutter_core` 與 `aqutter-js` 重做編解碼，`aqutter` 只改文件。
- 順手修正既有 `test/nativeview_test.dart` 的競態（`take(2)` 取消訂閱讓連線被關），其餘逾時由 2 秒放寬到 10 秒；不修就無法可靠驗證全套測試。
- iOS、macOS 未驗證（Aqutter/aqutter#21）。

## Impact Files
- `lib/src/rpc/rpc_frame.dart` (new) — 訊框編解碼、`$bin` 佔位、`encodeAqutterRpcMessages`、`AqutterRpcReassembler`、大小與分段常數。
- `lib/src/rpc/rpc_host.dart` (new) — `AqutterRpcHost`：登錄表、並行分派、`res`／`err`、`emit`、`AqutterRpcException`、錯誤碼常數、連線取代規則。
- `lib/src/rpc/rpc.dart` (new)、`lib/aqutter_core.dart` — 匯出。
- `test/rpc_frame_test.dart` (new)、`test/rpc_host_test.dart` (new)、`test/rpc_frame_vectors.json` (new，與 `aqutter-js` 共用) — 共 58 個測試。
- `test/nativeview_test.dart` — 去除競態與放寬逾時。
- `doc/rpc.md` (new)、`.kn-project/project.md` — 協定說明與保留鐵則。

## Details
- 驗證：全套 122 個測試連跑 4 次皆過；Android 實機（ASUS_I006D）、Windows、Linux（WSL2 Debian 13）端對端通過，含 70 MiB 呼叫來回、66 MiB 事件、超過 512 MiB 回 `PAYLOAD_TOO_LARGE`、殼重啟後重連。
