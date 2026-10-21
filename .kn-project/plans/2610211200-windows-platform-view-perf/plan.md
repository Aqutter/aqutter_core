# Plan: Windows custom_platform_view 效能優化

- Status: In Progress
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
- [ ] 輸入事件合併（Dart）
- [ ] 尺寸/位置回報每幀合併（Dart）
- [ ] kNumBuffers 1→2
- [ ] Capture Closed／Start 失敗恢復
- [ ] swizzle 去除對 `/arch:AVX2` 的全域依賴並補 SSSE3
- [ ] 單元測試 + Windows 範例 App 建置
