# Plan: Windows custom_platform_view 效能優化

- Status: Awaiting Archive
- Base Branch: (本地實驗，無遠端基準；由 tag 0.0.0 切出)
- Milestone: 不指定
- Issue: 無

## Summary
優化 Windows 版 `custom_platform_view`（WebView2 → Graphics Capture → Flutter texture）的幀路徑與輸入路徑。
使用者以 `/goal` 與對話明確要求「開分支、全部優化、自行測試」，視為本計畫核准。

## Cross-Repo Scope
無

## Contract / 介面契約
無（channel 名稱與方法名不變，符合 AGENTS.md 紅線 2）

## Impact Files
- `lib/src/platforms/windows/src/webview/custom_platform_view.dart`：輸入事件逐筆送出、尺寸/位置重複回報
- `lib/src/platforms/windows/src/webview/input_coalescer.dart`（新增）
- `windows/custom_platform_view/texture_bridge.cc` / `.h`：`kNumBuffers = 1`、Closed 處理、Start 失敗清理
- `windows/custom_platform_view/util/swizzle.h`：fallback 轉換依賴 `/arch:AVX2`
- `windows/CMakeLists.txt:276`：fallback 路徑全域啟用 `/arch:AVX2`

## Key Decisions
- 不改任何 channel／方法名。
- GPU 路徑的整張 `CopyResource` 與「改用 DirectComposition 直接託管」不動：前者需 shared 資源由 capture 直接產出，後者為架構級改動，皆無法在無實機量測下安全處理，結果於回報中說明。

## Manual Follow-ups / 人工收尾事項
- 實機 profiling（本計畫僅做編譯與單元驗證，未量測 FPS/CPU）
- 推送分支與移動 tag 需人工決定（本流程不推送）

## Tasks
- [x] 輸入事件合併（Dart）
- [x] 尺寸/位置回報每幀合併（Dart）
- [x] kNumBuffers 1→2
- [x] Capture Closed／Start 失敗恢復
- [x] swizzle 去除對 `/arch:AVX2` 的全域依賴並補 SSSE3
- [x] 單元測試 + Windows 範例 App 建置

## Verification
- `flutter test test/windows_input_coalescer_test.dart`：8 項通過
- `windows/test/swizzle_standalone_test.cpp`（MSVC、不加 /arch）：SSSE3、AVX2 共 209 組與 portable 一致；本機 CPU 無 AVX-512，該路徑僅編譯未執行
- `flutter build windows --debug`：`aqutter_core_plugin.dll` 編譯連結成功；整體失敗僅因第三方 `permission_handler_windows` 找不到 include（與本計畫無關）
- 未驗證：實機執行與 FPS/CPU 量測
- 既有 `test/nativeview_test.dart` 在基準版本即失敗，與本計畫無關

## Verification（實機，Windows，WebView2）
- `example/integration_test/windows_input_test.dart`（`flutter test ... -d windows`）：通過
  - 200 次移動 → 網頁收到 1 次，座標為最後一點（改動前同場景收到 3 次：Chromium 本身已合併一部分，因此網頁側差異小，節省的是 Dart→原生的 199 次 channel 呼叫）
  - 20 次滾輪 → 網頁收到 1 個事件，總量 333.33 = 單次校準值 16.67 × 20（無遺失）
  - 同一幀「移動後立即點擊」→ 點擊落在 (49,49)，順序正確
  - 視窗縮放 400→640：網頁視窗尺寸跟隨；resize 事件數與改動前相同（每次縮放本來就各佔一幀）
- 未量測：FPS／CPU／延遲；`kNumBuffers=2` 與 Closed 恢復僅確認可編譯與正常執行，未製造 tearing 或關閉捕捉的情境來驗證

## Benchmark（`example/integration_test/windows_perf_bench_test.dart`，Windows，WebView2，CPU 為 app 行程）
| 情境 | 改動前 | 改動後 run1 | run2 | run3 |
|---|---|---|---|---|
| 網頁動畫 3s CPU | 1078 ms | 875 | 828 | 1063 |
| 縮放 150 幀 CPU | 1969 | 1984 | 1797 | 2891 |
| 輸入風暴 60 幀 CPU | 2078 | 1641 | 1484 | 3141 |
- 單機單次量測、run3 明顯受機器負載影響，雜訊大；僅「輸入風暴」在 3 次中有 2 次低於基準，不構成可靠結論。
- 幀時間（build/raster 平均 0.4–1.9 ms，縮放最差 3.5–7 ms）改動前後無顯著差異。
- 決定不做：GPU surface 預留餘量（縮放無卡頓可解）、縮小 mutex 範圍、調整 Flush（無競爭或同步成本證據）。
- 新增：略過位置未變的 setCursorPos（enter/leave 與幾何回報後重設）。

## Video / heavy-page benchmark（`example/integration_test/windows_video_bench_test.dart`）
1280×720 循環 H.264 影片 + CSS 動畫覆蓋層；改動前與改動後**交替**各 5 次，取中位數（機器雜訊大：先前把兩組分批跑時，數字隨時間漂移，曾誤判為縮放變差，交替後該現象消失）。
| 情境 | 指標 | 改動前 | 改動後 |
|---|---|---|---|
| 影片播放 5s | CPU | 1547 ms | 1250 ms |
| 影片＋連續縮放 150 幀 | CPU | 2922 ms | 2219 ms |
| | raster 平均 / 最差 | 4.01 / 18.8 ms | 3.12 / 15.0 ms |
| | 影片掉幀 | 22 | 14（但有 74、54 兩個離群值，基準最高 34） |
| 影片＋輸入風暴 60 幀 | CPU | 2844 ms | 1844 ms |
- n=5、單機、未做顯著性檢定；縮放情境改動後的離群值偏大，尾端風險未排除。

## 縮放離群值追查（影片頁，縮放 150 幀；四種設定輪替、每種 20 個樣本）
| 設定 | 影片掉幀 中位數 / p90 / 最大 | CPU 中位數 |
|---|---|---|
| 改動前 | 5 / 26 / 53 | 1938 ms |
| 2 個 buffer＋延後回報尺寸 | 19 / 36 / 37 | 2508 ms |
| 1 個 buffer＋延後回報尺寸 | 4 / 20 / 28 | 2086 ms |
| 2 個 buffer＋立即回報尺寸 | 11 / 39 / 70 | 2078 ms |
- 結論：`kNumBuffers=2` 使縮放明顯變差，已改回 1；延後回報尺寸無明顯副作用，保留。
- 先前 n=5 的「改動後較好」是雜訊；分批執行（非交替）會被機器漂移污染。

## 最終版本 vs 改動前（完整影片基準，交替各 5 次，中位數）
| 情境 | 指標 | 改動前 | 最終 |
|---|---|---|---|
| 影片播放 5s | CPU | 1484 ms | 1203 ms |
| 影片＋縮放 150 幀 | CPU / 影片掉幀 | 2328 ms / 19 | 2469 ms / 17（無差異） |
| 影片＋輸入風暴 60 幀 | CPU | 2766 ms | 1578 ms |
- 輸入風暴最一致（最終 1406–1859 ms；改動前 2328–5875 ms）。
- 縮放情境沒有改善，也沒有變差。
