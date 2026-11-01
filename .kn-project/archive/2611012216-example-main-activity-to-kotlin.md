# 2611012216 - example-main-activity-to-kotlin

- Created: 2026-11-01 22:16 / Archived: 2026-11-01 22:24
- Issue: Aqutter/aqutter_core#12
- Milestone: N/A / Base Branch: main

## Summary
範例 App 的 `MainActivity.java` 轉成 Kotlin，`aqutter_core` 受版控的 Android 原生程式從此全部是 Kotlin。
行為不變（空的 `FlutterActivity` 子類別）；轉換後 Kotlin 才開始編譯，因此範例 App 的 Gradle 補上 Kotlin `jvmTarget` 17。影響僅限 `example/android/app`。

## Cross-Repo Scope
無（單一 repo）。

## Key Decisions
- **[範圍]** 只轉這一個檔案 — 盤點顯示 `aqutter_core` 只剩它；外部 plugin 與 CLI 範本沒有 Java。
- **[Q1]** 合併後把 tag `0.0.0` 移到最新 `main` — 使用者決議，依 project.md 慣例。
- **[執行中]** 範例 App 的 `build.gradle` 補 `jvmTarget` 17 — 轉換後才暴露 Java 17／Kotlin 21 不一致；與 `android/build.gradle` 同解法。
- **[流程]** 完成後 commit + 開 PR。

## Deviations
- 計畫原預期不動 Gradle；實際為了 Kotlin 與 Java 的 JVM target 一致，在 `example/android/app/build.gradle` 補了 `kotlin { compilerOptions { jvmTarget } }`。
- 驗證僅限 `flutter build apk --debug`（轉換前後各一次，皆通過）；未在裝置或模擬器執行。
- 沒有 wiki 或 README 提到 Java 路徑，故無 wiki 變更（Pruning Report：未發現過時內容）。

## Impact Files
- `example/android/app/src/main/java/com/github/aqutter/core/example/MainActivity.java` — 刪除。
- `example/android/app/src/main/kotlin/com/github/aqutter/core/example/MainActivity.kt` (new) — Kotlin 版同名類別。
- `example/android/app/build.gradle:63-70` — 補 Kotlin `jvmTarget` 17（同 `android/build.gradle:64-69`）。
