# 2611181030-hide-unpeered-native

- Created: 2026-11-17 / Archived: 2026-11-17
- Issue: Aqutter/aqutter_core#36
- Milestone: N/A / Base Branch: main

## Summary
有穿透工作階段時，沒有網頁連線的 `AqutterNative` 用 `Offstage` 隱藏 child（保持掛載、照常排版、不繪製），不再從透明的 WebView 透出來蓋住穿透的地圖；連線建立後與穿透全部結束後恢復繪製，沒有穿透時行為不變。
`AqutterNativeSession` 新增 `hasClientsListenable`，widget 合併監聽它與 `passthroughSessions`。新增 widget 測試涵蓋四種情境；`doc/nativeview.md` 寫明規則與「有網頁連線的鏡像仍會透出」的限制。

## Cross-Repo Scope
- **本計畫所屬 repo**: `aqutter_core`
- **共用計畫 ID**: `2611181030-hide-unpeered-native`　**共用分支名**: `feature/2611181030-hide-unpeered-native`
- **參與 repo 與職責**:
  - `aqutter_core` — 實作規則、測試、文件　issue: `Aqutter/aqutter_core#36`
- **執行順序相依**: 只改 core，沒有 API 或訊息契約變動（公開 API 不變；新增的連線數通知屬內部使用）。
- **合併後的跟版（人工收尾，見下）**：core tag 移動 → `aqutter` manifest 與 `aqutter-cli` 快照重同步 → nuxt-app 鎖定前進；這些各是另案，不在本計畫。

## Key Decisions
- **[Phase 0]** 單一 repo；Milestone 不指定（使用者核准）；Base Branch = `main`；core 另有一份 `2610211200-windows-platform-view-perf`（Awaiting Archive），與本計畫無關，不動。
- **[Q1]** 選項 A — 使用者核准。
- **[Q2]** Android 實機重測 — 使用者核准。
- **[完成後]** commit + 推送 + 開 PR（base main）— 使用者核准。

## Deviations
- **Android 實機（ASUS）驗證**：nuxt-app `/map-effects` 在不停用任何 plugin（`mirror-demo`、`nearby-demo`、`place-demo` 都在）時，`passthrough` 地圖正常，漸層與毛玻璃疊在上面，網頁用挖洞做的圓角有效；`mirror` 不受影響。修正前底層是 `mirror-demo` 的格線與圓球。
- **未解決的限制**：有網頁連線的鏡像工作階段，其 child 仍畫在整個 Flutter 層，穿透頁面同時有這種鏡像元素時仍會透出；已寫入文件，需要別的機制，另案評估。
- 未驗證：iOS 與桌面平台。

## Impact Files
- `lib/src/nativeview/native_widget.dart:514-535` (`build`) — 組合 `Offstage` 條件；與 `passthroughListenable`、`layoutListenable` 一起監聽連線數與穿透數。
- `lib/src/nativeview/native_session.dart:165,241` (`clientCountChanged`、`hasClients`) — 新增連線數的通知，供 widget 重建。
- `lib/src/nativeview/native_host_io.dart:80` (`passthroughSessions`) — 只讀取，預期不改；若 widget 取不到再確認。
- `lib/src/nativeview/native_host_stub.dart:29` — 同上，確認 stub 的 `passthroughSessions` 行為一致（不穿透）。
- `test/nativeview_passthrough_test.dart` — 新增：有穿透且無連線 → child 不繪製；連線後繪製；穿透結束後繪製；無穿透時不隱藏。
- `doc/nativeview.md:98-168` (穿透模式一節) — 寫明規則與「有網頁連線的鏡像仍會透出」的限制。
