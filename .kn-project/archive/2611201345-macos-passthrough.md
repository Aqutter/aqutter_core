# 2611201345 - macos-passthrough

- Created: 2026-11-20 13:45 / Archived: 2026-11-20 15:09
- Issue: Aqutter/aqutter_core#41
- Milestone: N/A / Base Branch: main

## Summary
`AqutterNative` 的穿透模式在 macOS 開啟：`aqutterNativePassthroughSupported` 納入 macOS，`auto` 在 macOS 協商成穿透，不再退回鏡像。

macOS 的 WebView 只在建立時套用 `transparentBackground`，執行期切換（殼進出穿透頁時切換）沒有處理，且沒關 WKWebView 自己畫的底色，所以第一次實測整塊是白的。這次補 `applyTransparentBackground`（關 `drawsBackground` 並設 `underPageBackgroundColor`，還原時恢復原色），建立時與執行期都套用。macOS 27.0.1 debug 驗證：透明、點擊／拖曳／雙擊、離開穿透頁後還原；release、Intel Mac、其他 macOS 版本未驗證。測試 168 項通過。

## Cross-Repo Scope
無（單一 repo）。`aqutter`（殼）、`aqutter-js`、`aqutter-plugins`、`aqutter-nuxt-app` 只作驗證環境（暫時覆寫指向本機 core，不提交，已還原），沒有變更。

## Key Decisions
- **[Phase 0]** 單一 repo `aqutter_core`；Base Branch = `main`。core 另有 `2610211200-windows-platform-view-perf`（Awaiting Archive），與本計畫無關，不動。
- **[Milestone]** 不指定，base `main`（使用者選擇）；沒有 milestone 與 release，只有 tag `0.0.0`。
- **[不通過時]** 在 core 修 macOS 原生執行期透明切換再驗證（使用者選擇）；實際第一次驗證就不通過，走了這條路。
- **[驗證方式]** 真實整合（殼＋aqutter-js＋mirror-demo，macOS 本機 debug），暫時覆寫指向本機 core，不提交。
- **[範圍]** 不實作 macOS 版 `NativeTouchRouter`：拖曳與點擊正常，沒有 iOS 的抖動。
- **[驗證結果]** 協商成穿透（`aqutter-mode` 事件）；補原生前整塊白；補完後洞裡看得到底下格線與圓球、手勢正常、離開穿透頁後背景還原。以使用者肉眼確認。
- **[執行中]** README 一併改：原本只寫「Android、iOS」，Windows 也漏了，內容與新行為矛盾。
- **[完成後]** commit + 開 PR（base main）— 使用者核准。

## Deviations
- 正式路徑（不帶覆寫）的 macOS 主流程沒有另跑：原生修正只存在於本機 core，鎖定版本沒有它；最終程式碼與驗證時相同，驗證用的暫時改動（nuxt-app 覆寫、取模式的 `console.warn`、自動導頁）已全部還原。
- 驗證靠使用者肉眼：電腦控制被另一個 Claude 工作階段占用、`screencapture` 也抓不到視窗；模式以 `aqutter-mode` 事件的 log 確認。
- 沒有驗證：release 建置、Intel Mac、其他 macOS 版本、多螢幕與顯示縮放。
- **Wiki 未更新**：wiki 內沒有任何頁面提到穿透（沒有過時內容可修剪）；本 repo 的 wiki 沿用舊版格式（先前計畫記錄 lint 基準有 30 個硬閘違規），文件在 `doc/nativeview.md`，README 已同步。

## Impact Files
- `lib/src/nativeview/native_mode.dart:34,85-94` (`aqutterNativePassthroughSupported`) — 加入 macOS；更新注解。
- `macos/aqutter_core/Sources/aqutter_core/AqutterWebView/AqutterWebView.swift:139-141,770-775` — 新增 `applyTransparentBackground`；建立時與執行期 `setSettings` 都走它。
- `test/nativeview_passthrough_test.dart:145-150,264-269` — 支援平台清單加入 macOS；不支援平台的 widget 測試改用 Linux。
- `doc/nativeview.md:108`、新增「macOS 的驗證範圍與注意事項」 — 平台列與驗證範圍。
- `README.md:47` — 穿透平台列舉。
