# 2610160230 - native-view-mirror

- Created: 2026-10-16 / Archived: 2026-10-16
- Issue: N/A
- Milestone: N/A / Base Branch: main

## Summary
`aqutter_core` 0.2.0：新增 native view 鏡像——把 Flutter 內容（Widget 或 PlatformView）擷取後經 localhost WebSocket 送給網頁 canvas，並接收網頁手勢回控。包含 Dart 端（`AqutterNative`、`AqutterNativeHost`、`AqutterNativeSession`）與 iOS 的 `drawHierarchy` 原生擷取；網頁端在 `aqutter` monorepo 的 client 套件（`<aqutter-native>`）。
直接推送 `main`，未使用 issue、PR、milestone 或版本分支。

## Cross-Repo Scope
`Aqutter/aqutter`：shell 新增 bridge handler `native_endpoint` 與 plugin 的 underlay slot，client 新增 `<aqutter-native>` 與 `AqutterNative`。

## Key Decisions
- **傳輸**：localhost WebSocket，二進位幀（20 bytes 標頭 + 未壓縮 RGBA / PNG）；H.264 / WebCodecs 管線暫不做。
- **安全**：每次啟動產生隨機令牌，經 bridge 交給網頁；令牌錯誤或工作階段不存在回 403。
- **擷取**：預設 `RepaintBoundary.toImage`；iOS 的 PlatformView 走 `drawHierarchy`（可直接擷取指定類名的 view，不含疊在其上的網頁）。
- **Web 平台不支援**（沒有 `dart:io`），以條件匯出提供會拋 `UnsupportedError` 的替身。
- Google Maps 僅作為文件中的使用範例，本套件不相依它。

## Deviations
- 驗證：Dart 單元測試（幀編碼、WebSocket 往返、令牌與重複 id 檢查）；iOS Swift 程式碼與 Android 的 PlatformView 擷取尚未在裝置驗證。

## Impact Files
- `lib/src/nativeview/**`、`lib/aqutter_core.dart`、`ios/aqutter_core/Sources/aqutter_core/NativeView/AqutterNativeCapture.swift`、`ios/aqutter_core/Sources/aqutter_core/AqutterCorePlugin.swift`、`test/nativeview_test.dart`、`doc/nativeview.md`、`README.md`、`pubspec.yaml`、`.kn-project/project.md`
