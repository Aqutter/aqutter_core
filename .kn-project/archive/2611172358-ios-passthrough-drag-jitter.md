# 2611172358-ios-passthrough-drag-jitter

- Created: 2026-11-17 23:58 / Archived: 2026-11-19 00:16
- Issue: Aqutter/aqutter_core#35
- Milestone: N/A / Base Branch: main

## Summary
iOS 穿透模式下，手指落在元素內、網頁沒有要接管的點時，觸控改為直接交給原生地圖（`webRegions`），拖曳不再抖；按鈕等網頁內容照舊可點。
原因：穿透時原生內容的拖曳要經「WebView → 網頁手勢 → WebSocket → Dart → `moveCamera`」，iPad 實機會抖，直接進原生則平順。本 repo 是契約提供方：解析 `layout.webRegions`、計算原生觸控區域、Dart 層 hit test 閘、iOS 層觸控路由 view、`AqutterNativeTouch`。實機（iPad）與模擬器以真實 aqutter-js、google-maps plugin 端到端驗證；Android 沒有實機驗證（只有單元測試確認不受影響）。

## Cross-Repo Scope
- 契約正本 repo：`aqutter_core`；最終修訂號 `rev 3`（介面：`layout.webRegions`、`AqutterNativeTouch.of(context)`；全文不進 archive，見 `aqutter_core` 的歸檔與程式碼）。
- 參與 repo 與 issue：`aqutter_core`（`Aqutter/aqutter_core#35`，契約與核心路由）、`aqutter-js`（`Aqutter/aqutter-js#20`，取樣回報 `webRegions`）、`aqutter-plugins`（`Aqutter/aqutter-plugins#12`，google-maps 宣告手勢）、`aqutter`（`Aqutter/aqutter#78`，殼轉出 `AqutterNativeTouch`）。共用計畫 ID `2611172358-ios-passthrough-drag-jitter`，共用分支名 `feature/2611172358-ios-passthrough-drag-jitter`。
- 執行順序相依：core 的契約凍結後 js、plugins、殼可平行；plugin 與殼的編譯依賴新 core 的 manifest ref（合併後同步）。建議合併次序：core → 殼 → js → plugins，之後 `aqutter` manifest、`aqutter-cli` snapshot、`aqutter-nuxt-app` 鎖定檔前進。

## Key Decisions
- **[調查]** iPad 實機與最新版確認：現行「網頁轉送手勢 → Dart → `moveCamera`」路徑拖地圖會抖；手指直接拖原生地圖不抖（模擬器合成 swipe 不能當判準）。
- **[根因的一半]** Flutter 手勢競技場把觸控判給最上層 WebView、封鎖地圖；但 UIKit 層的 hit test 也要讓路（整個 WebView 範圍的觸控先進它外層的容器），所以需要 Dart 與 UIKit 兩層配合。關掉 WKWebView 捲動追蹤的假設實驗沒有差別，已排除。
- **[設計]** 以觸控起點決定走原生或網頁：網頁端以 `document.elementFromPoint` 取樣回報 `webRegions`；core 把元素矩形扣掉網頁區域後的區域，一邊讓 Dart 的 `NativeTouchGate` 對 hit test 透明、一邊由 iOS `NativeTouchRouter`（window 最上層的透明 view，略過 WebView 外層 `ChildClippingView`）回傳底下的原生 view；plugin 在 `AqutterNativeTouch` 為真時讓原生 view 以 `EagerGestureRecognizer` 宣告手勢。只有 iOS，Android、macOS、Windows 與 mirror 不變；舊 client 不帶 `webRegions` 時行為不變。
- **[Q2]** spike 在 iPad 不過關就停下、只歸檔文件（實際 spike 與完整實作都在 iPad 實機過關，未觸發）。**[Q3]** 沒有 `pointer-events: none` 的網頁覆蓋層照 DOM 語意算網頁區域。
- **[契約變更]** rev 1 → rev 2：plugin 拿到的 context 來自殼套件，改由 core 以 `AqutterNativeTouch.of(context)` 提供，區域邊界歸屬改為不保證（±1px）。rev 2 → rev 3：plugin 只依賴殼，殼要轉出 `AqutterNativeTouch`（殼納入本計畫為第四個 repo，經使用者同意）。
- **[完成後]** commit + 開 PR（base main）；四個 repo 一起開。

## Deviations
- 計畫起初是「調查 iOS 穿透拖曳抖動」，Phase 1 實驗（模擬器與 iPad）證實直接進原生不抖後，經使用者核准擴大為跨 repo 實作（契約 rev 1，先做 core 單獨 spike，iPad 過關後才建 js、plugins 的 issue）。
- 契約 rev 1 → rev 2 → rev 3（見 Key Decisions「契約變更」）：`nativeTouch` 的暴露方式由「context 欄位」改為 `AqutterNativeTouch` 繼承通知器，且要由殼轉出，因此殼成為第四個 repo（使用者同意）。
- 調查中途更正：先前「IgnorePointer／Eager 都沒用」的結論無效（`pubspec_overrides.yaml` 當時未生效，沒有重跑 `flutter pub get`），已於重做後確認。
- spike 缺陷：離開穿透與 session 釋放時沒清區域，導致 mirror 觸控失效；正式版在 `setPassthrough(false)` 與 `dispose` 清除。
- 未驗證：Android 實機、macOS、Windows；mirror 切換與頁面捲動時區域跟隨在最終版 iPad 上未逐項回報（spike 階段的 mirror 切換已確認）。

## Impact Files
- `lib/src/nativeview/native_mode.dart:140`（`AqutterNativeLayout.webRegions`、`tryParse`、`==`）— 解析與驗證
- `lib/src/nativeview/native_session.dart`（`updateLayout`、`setPassthrough`、`dispose`、`nativeTouchListenable`）— 計算原生觸控區域與旗標
- `lib/src/nativeview/native_touch_gate.dart` (new) — `NativeTouchRegions`、`subtractRects`、`AqutterNativeTouch`、`NativeTouchGate`
- `lib/src/nativeview/native_widget.dart:523`（passthrough 分支）、`lib/src/nativeview/nativeview.dart`（匯出）— 提供 `AqutterNativeTouch`
- `lib/src/webview/webview.dart:921`（`build`）— `NativeTouchGate` 包住 WebView
- `ios/aqutter_core/Sources/aqutter_core/NativeView/NativeTouchRouter.swift` (new)、`AqutterCorePlugin.swift`、`AqutterWebView/AqutterWebView.swift` — iOS 觸控路由
- `test/native_touch_test.dart` (new) — 解析、區域扣除、旗標條件、`AqutterNativeTouch`
- `doc/nativeview.md` — 「iOS 穿透的觸控」章節
