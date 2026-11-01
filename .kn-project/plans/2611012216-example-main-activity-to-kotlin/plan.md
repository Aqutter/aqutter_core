<!-- REMINDER: Relative Paths Only! No file:///c:/... -->
# Plan: 2611012216 - example-main-activity-to-kotlin
- Created: 2026-11-01
- Branch: feature/2611012216-example-main-activity-to-kotlin
- Issue: Aqutter/aqutter_core#12
- Milestone: N/A（未指定）
- Base Branch: main
- Status: In Progress
- Completed: [Wait for Finish]

## Goals
把 `aqutter_core` 範例 App 的 `MainActivity.java` 轉成 Kotlin，使 repo 內受版控的 Android 原生程式全部是 Kotlin（規則：Android 原生一律 Kotlin，Apple 一律 Swift）。這是盤點後唯一剩下的受版控 Java 檔；行為不變（空的 `FlutterActivity` 子類別）。

## Architecture
- 現況：`example/android/app/src/main/java/com/github/aqutter/core/example/MainActivity.java` 是空類別 `public class MainActivity extends FlutterActivity {}`；`example/android/app/build.gradle:3` 已套用 `kotlin-android`，`:29-30` 為 Java 17，所以只要把檔案換成 `src/main/kotlin/` 下的 `.kt`，不需動 Gradle。
- 目標：`example/android/app/src/main/kotlin/com/github/aqutter/core/example/MainActivity.kt`（package 與類別名不變，`AndroidManifest.xml` 的引用不用改），刪除 Java 檔與其空目錄。
- `GeneratedPluginRegistrant.java` 是 Flutter 產生且已被 gitignore，不在範圍。

## Cross-Repo Scope
無（單一 repo）。

## Contract / 介面契約
無（單一 repo，單一層；沒有對外介面變更）。

## Impact Files
- `example/android/app/src/main/java/com/github/aqutter/core/example/MainActivity.java:1` (`MainActivity`) — 刪除，由 Kotlin 版取代。
- `example/android/app/src/main/kotlin/com/github/aqutter/core/example/MainActivity.kt` (new) — Kotlin 版的同名類別。
- `example/android/app/build.gradle:3` (`kotlin-android`)、`:63` — 已套用 `kotlin-android`；轉換後 Kotlin 開始編譯，因 Java 為 17 而 Kotlin 預設 21，需補 `kotlin { compilerOptions { jvmTarget = JVM_17 } }`（做法同 `android/build.gradle:64-69`）。

## App-Flow Screens
（本專案無 `.kn-project/app-flow.json`。）

## Open Questions / 待確認事項
### Q1. 是否把 git tag `0.0.0` 移到本次 commit — 影響範圍：版本鎖定點
- [ ] 不移　(原建議，理由：只動範例 App，不隨套件發佈給使用端，鎖定點的內容沒有變)
- [x] 移到最新 `main`（依 `project.md` 的「有變更時移到最新的 main」）
- **決議**：移到最新 `main`　狀態：✅ 已確認

## Manual Follow-ups / 人工收尾事項
- **[合併後]** 把 git tag `0.0.0` 移到合併後的最新 `main` 並推送 — `git tag -f 0.0.0 <sha> && git push -f origin 0.0.0` — 移動遠端 tag 是對外可見的覆寫，需當下再次確認

## Key Decisions
- **[範圍]** 只轉這一個檔案 — 盤點（`git ls-files` 的 `.java`）顯示 `aqutter_core` 只剩它；外部 plugin 與 CLI 範本沒有 Java。

- **[Q1]** 合併後把 tag `0.0.0` 移到最新 `main` — 理由：使用者決議，依 project.md 慣例。
- **[執行中]** 範例 App 的 `build.gradle` 補 `jvmTarget` 17 — 理由：Kotlin 之前沒有原始碼可編譯，轉換後才暴露 Java 17／Kotlin 21 不一致；與 `android/build.gradle` 同解法。
- **[流程]** 完成後：commit + 開 PR（rebase 並 `--force-with-lease` 推工作分支）。

## Git Completion Policy
- PR 一律以 `--base main` 顯式指定。
- Issue 綁定後，每個 commit 訊息與 PR body 含 `Closes #${N}`；歸檔後於該 issue 張貼結案留言，合併後清理時關閉。
- commit 一律自動；完成時依核准閘的「完成後」選項。
- 本 repo 另有計畫 `2610211200-windows-platform-view-perf`（Awaiting Archive），與本計畫無檔案重疊。

## References
- 使用者規則：Android 原生一律 Kotlin（記憶 `android-native-kotlin-only`）。
