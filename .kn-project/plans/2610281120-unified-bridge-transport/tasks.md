# Tasks for 2610281120

## Phase 1 — 契約（需等待：使用者核准並凍結契約）
- [x] 凍結契約 rev 1，三個 repo 的 `## Contract` 逐字相同

## Phase 2 — AqutterRpcHost（依賴 Contract §2、§3、§5）
- [x] `rpc_frame.dart`：編碼、解碼、格式錯誤與測試；產出測試向量　可平行
- [x] `rpc_host.dart`：登錄表、並行分派、`res`／`err`、`emit`、`AqutterRpcException`、連線關閉時的處理與測試
- [x] 匯出、stub、文件與 `.kn-project/project.md`
- [x] `flutter analyze`、`flutter test`

## Phase 3 — 驗證
- [ ] 需等待 aqutter 與 aqutter-js：Android 實機端對端
