# 2611142200-fix-deprecation-warnings

- Created: 2026-11-14 22:00 / Archived: 2026-11-14 23:00
- Issue: Aqutter/aqutter_core#25
- Milestone: N/A / Base Branch: main

## Summary
解決 aqutter_core 在 Flutter 3.50 下的棄用警告：example 149 筆歸零、library 12 筆減為 4 筆，並以 aqutter-nuxt-app 在 Android 實機驗證。

剩下的 4 筆是 Windows／Linux 的 `window` 與 Web 的 `HttpRequest`，因本機是 Mac 無法實測而暫不改動，另開 issue 追蹤。

## Cross-Repo Scope
無（單一 repo）。`aqutter-nuxt-app` 只作為驗證用 App，暫時覆寫依賴、無提交。

## Key Decisions
- **[Q1]** example 一併修正，nuxt-app 做實機驗證（使用者確認「用 nuxt_app 當範例 APP」指實機驗證）— 理由：一次清乾淨，機械式替換風險低
- **[Q2]** Windows／Linux／Web 專屬 4 筆本次不動，記入 issue — 理由：本機為 Mac，無法實測，改了風險高於警告本身
- **[核准]** 使用者核准；完成後採預設 commit + 開 PR；Issue 已建立（#25）。
- **[Phase 0]** 單一 repo `aqutter_core`；證據：暫時打開 `deprecated_member_use` 的實測輸出（已還原設定）；已 sync 至 `origin/main` 且工作區乾淨。
- **[Phase 0]** Milestone：不指定（使用者回答）；Base Branch = `main`。
- **[Phase 0]** 整合主幹：遠端無 dev／develop 類分支，採 `origin/HEAD`＝`main`，不詢問、不記錄。
- **[範圍]** 掃描只在 `aqutter_core` 找到棄用警告；其餘 repo 與 plugin 為 0，不在範圍。
- **[驗證]** 使用者指定以 `aqutter-nuxt-app` 作為範例 App 驗證（暫時覆寫依賴，不提交）。
- **[執行模式]** 序列（單一 repo）。
- **[發現]** generators 的 `getDisplayString(withNullability: false)` 不能直接去掉參數：舊參數會去掉型別的 `?`，直接移除會讓 `Uri?` 與 "Uri" 的比對失敗，重新生成後 31 個 `.g.dart` 變了（例如 `mainDocumentURL` 的轉換消失）。改用保持舊語意的 helper（`getDisplayString().replaceAll('?', '')`），重新生成後 `.g.dart` 零差異。
- **[發現]** `ReorderableListView.onReorder` → `onReorderItem` 的 newIndex 已扣掉被移除項，`reorderCustomSteps` 原本自己 `newIndex--`，改為不再調整（無測試依賴此函式）。`Radio` 的 `groupValue`／`onChanged` 改為 `RadioGroup` 包住兩個 `RadioListTile`。
- **[決策]** example 對 `aqutter_core` 自己已棄用 API 的 29 處刻意呼叫（`clearCache`、`onReceivedIcon`、`onLoadError`、`onLoadHttpError`、`onDownloadStartRequest`、`useHybridComposition`）不改，逐處加 `// ignore: deprecated_member_use` 與原因 — 理由：example 是 API 測試台，要保留舊 API 的覆蓋。
- **[實測]** 暫時打開 `deprecated_member_use`：example 149 → 0；library 12 → 4（皆為 Q2 決定不動的 Windows/Linux `window` 3、Web `HttpRequest` 1）；`flutter analyze` 無 error；library `flutter test` 128 項通過（含新增的 3 項 `toHex` 測試，涵蓋 256 個通道值）；`test/widgets` 為 75 通過、3 失敗，與 origin/main 完全相同。
- **[既有失敗]** `responsive_phase7_screens_test.dart` 的 `test_all_screens_mobile_no_overflow` 失敗並卡住（`FlutterError.onError` 斷言），在乾淨的 origin/main 上完全相同，非本計畫造成；這也是先前 example 完整測試套件跑不完的原因。我改過的另外 3 個 screens 測試檔（2、14、2 項）全過。
- **[實機驗證]** 依使用者指定以 `aqutter-nuxt-app` 為範例 App：暫時以 `dependency_overrides` 指向本機 `aqutter_core`，`aqutter dev` 在 Android 16 實機建置並啟動，Nuxt 頁面載入、HCPP 渲染、點 `Greet` 的橋接回傳 `Hello from Flutter (android)`；驗完已還原，nuxt-app 無任何變更。
- **[未驗證]** Windows／Linux／Web 實機；iOS／macOS 建置（本次未涉及原生）；example 完整測試套件（既有卡住問題）；`responsive_phase7_screens_test` 其餘測試。

## Deviations
無。Q1／Q2 與實際執行一致；計畫預估 example 約 128 筆，實際為 149 筆（含 library 以外的 `integration_test` 21）。

## Impact Files
- `dev_packages/generators/lib/src/exchangeable_object_generator.dart:45-49,400-402,754,885` — `_plainDisplayString` helper 取代 `withNullability`
- `lib/src/platform_interface/src/util.dart:520-530` — `HexColor.toHex` 改用 `.a/.r/.g/.b`
- `test/hex_color_test.dart`（新增）— `toHex` 測試（256 個通道值）
- `example/lib/**`（19 個檔案）、`example/test/**`（5 個）、`example/integration_test/**`（15 個）— 機械式替換與 ignore 註解
- `example/lib/models/test_configuration.dart:1324` — `reorderCustomSteps` 不再自行調整 index
- `example/lib/screens/test_automation/test_configuration_screen.dart` — `onReorderItem`、`RadioGroup`
- `.kn-project/project.md:75` — 補上棄用警告清理結果
