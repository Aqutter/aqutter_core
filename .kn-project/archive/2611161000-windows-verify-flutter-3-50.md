# 2611161000 - windows-verify-flutter-3-50

- Created: 2026-11-16 10:00 / Archived: 2026-11-16 11:30
- Issue: Aqutter/aqutter_core#22
- Milestone: N/A / Base Branch: main

## Summary
在 Windows 11 實機上以 Flutter 3.50.0 驗證 WebView2 → DXGI 共享 texture 路徑：可建置、畫面正常、既有整合測試與基準無退步，並把 Windows 的 2 筆 `window` 棄用警告改為 `View.of(context)`。

驗證直接在使用者的開發機執行（Windows 11 企業版 26H2 / 10.0.26300、Intel Arc Graphics 驅動 32.0.101.8860、WebView2 Runtime 157.0.4341.57、Flutter 3.50.0 / Dart 3.14.0、VS Build Tools 2022 17.14）。原生程式碼無須修改；唯一的程式碼變更是 Dart 端的 `window` 替換。

## Cross-Repo Scope
無（單一 repo）

## Key Decisions
- **[Q1]** 項目 5（退回 ES 2）記為未驗證，不另開 issue — 理由：使用者沒有舊顯卡／VM 設備，遇到再處理
- **[Q2]** `window` 兩處一併改並用視窗縮放實測 — 理由：issue 補充建議同步驗證，#25 因無法在 Mac 實測而未改
- **[Q3]** milestone 不指定，Base Branch = `main` — 理由：repo 無 milestone，沿用合法常態
- **[環境]** 在本機直接實測，不等外部協助 — 理由：本機即為 Windows 11 + WebView2
- **[完成後]** commit + 開 PR（使用者核准時選定）
- **[實作]** `View.of(context).devicePixelRatio` 在 `await _controller.ready` 之前取值 — 理由：避免跨非同步間隔使用 context（元件可能在等待期間卸載）
- **[驗證方法]** 全螢幕與多 WebView 以暫時的整合測試（未提交）搭配螢幕取色驗證 — 理由：沒有現成測試涵蓋；測試與截圖僅為暫存
- **[未驗證]** 見下方結果表的「未驗證」列

## Deviations
無。計畫預期不改原生程式碼，結果相同。項目 4 的「全螢幕影片」未能自動觸發，詳見下表。

## 驗證結果（Issue #22 回報格式）
環境：Windows 11 企業版 26H2（10.0.26300）；Intel Arc Graphics 32.0.101.8860；WebView2 Runtime 157.0.4341.57；Flutter 3.50.0 / Dart 3.14.0。

| # | 項目 | 結果 | 證據 |
|---|---|---|---|
| 1 | `flutter build windows --debug` | 通過 | 680 秒；`permission_handler_windows` 這次沒有失敗；僅有 `webview.cpp` 的 C4458 隱藏成員警告（既有） |
| 2 | GPU 路徑被選到、畫面正常 | 通過（ES 級別未確認） | vcxproj 含 `HAVE_FLUTTER_D3D_TEXTURE` 與 `texture_bridge_gpu`，執行時畫面非黑屏；引擎沒有輸出 ES 3 或 ES 2，所以實際級別未能從 log 確認（Intel Arc 預期支援 ES 3） |
| 3 | `windows_input_test` | 通過 | 輸入合併 200→1、滾輪合併、點擊、縮放 400→640 皆符合預期；修改前後相同 |
| 3 | `windows_perf_bench_test`（CPU ms：動畫／縮放／輸入） | 通過，無退步 | 3.47 歷史 1078／1969／2078 → 3.50 修改前 1000／1969／1641 → 修改後 1078／2156／1828（單機單次，雜訊大） |
| 3 | `windows_video_bench_test`（以 ffmpeg 生成的 1280×720 H.264 測試影片） | 通過，無明顯退步 | 3.50 修改前 CPU 1609／2594／1609、掉幀 0／5／1 → 修改後 2031／2469／1703、掉幀 0／16／0（縮放掉幀在歷史雜訊範圍；無 3.47 同影片數據可比） |
| 4 | 多個 WebView 並存 + 縮放 | 通過 | 三個紅綠藍 WebView 並排、尺寸 200→260 連續變動；螢幕取色三色面積同步增加（919→1604 取樣點）、無黑塊，截圖目視無撕裂 |
| 4 | 視窗縮放 | 通過 | 整合測試縮放與上列縮放皆正常；`window` 改動後再跑一次同樣通過 |
| 4 | 全螢幕影片 | **未驗證** | 以合成點擊呼叫 `requestFullscreen` 未被接受（`__fs` 為 undefined），沒有進入全螢幕；外掛只把 `ContainsFullScreenElementChanged` 轉成 `onEnterFullscreen`（`windows/webview/webview.cpp:718-738`），不經 texture 路徑 |
| 5 | 退回 ES 2 | **未驗證** | 本機只有新顯卡，使用者無舊顯卡／VM；遇到再處理 |
| — | `window` 棄用（`custom_platform_view.dart:635,649`） | 已修 | `flutter analyze` 該檔 4 筆 info 皆為既有 lint，無 `window` 警告 |

## Impact Files
- `lib/src/platforms/windows/src/webview/custom_platform_view.dart:635,649` (`_reportSurfaceSize`、`_reportWidgetPosition`) — `window.devicePixelRatio` → `View.of(context).devicePixelRatio`
- `.kn-project/project.md:75` — 更新剩餘棄用警告數與 Windows 實機驗證結果
- 只讀、未改：`windows/custom_platform_view/custom_platform_view.cc:121-137`、`windows/custom_platform_view/texture_bridge_gpu.cc:14-63`
