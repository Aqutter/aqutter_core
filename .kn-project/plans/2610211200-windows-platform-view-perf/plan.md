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
