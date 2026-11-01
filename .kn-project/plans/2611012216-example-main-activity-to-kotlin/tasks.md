# Tasks for 2611012216
- [x] 以 `flutter build apk --debug` 在 `example/` 建一次基準（轉換前能建置）
- [x] 新增 `MainActivity.kt`，刪除 `MainActivity.java`
- [x] 補 `example/android/app/build.gradle` 的 Kotlin `jvmTarget` 17（轉換後才暴露的不一致）
- [x] 再次 `flutter build apk --debug` 確認建置通過、`git ls-files | grep '\.java$'` 無結果
- [x] 確認文件沒有引用舊的 Java 路徑（grep `MainActivity.java`）
