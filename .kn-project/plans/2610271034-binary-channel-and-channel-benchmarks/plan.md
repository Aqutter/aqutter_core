<!-- REMINDER: Relative Paths Only! No file:///c:/... -->
# Plan: 2610271034 - binary-channel-and-channel-benchmarks
- Created: 2026-10-27
- Branch: feature/2610271034-binary-channel-and-channel-benchmarks
- Issue: Aqutter/aqutter_core#2
- Milestone: N/A（未指定）
- Base Branch: main
- Status: In Progress
- Completed: [Wait for Finish]

## Goals
讓 `AqutterNativeHost`（鏡像用的本機 WebSocket 伺服器）同時提供「通用二進位通道」：plugin 可以註冊具名通道，網頁以同一個埠與 token 連上，直接收發二進位訊息，避開 JSON 與 base64。

## Architecture
目前 `AqutterNativeHost` 只接受 `/native/<sessionId>`（`_onRequest`，`lib/src/nativeview/native_host_io.dart:205-216`），並綁定到鏡像的工作階段。本計畫新增第二個路由 `/channel/<name>`，由新的註冊表（名稱對應 `onConnection` 回呼）驅動；伺服器、埠、token、`restart()` 都沿用。鏡像路徑與協定不動。

## Cross-Repo Scope
- **共用計畫 ID**: `2610271034-binary-channel-and-channel-benchmarks`　**共用分支名**: `feature/2610271034-binary-channel-and-channel-benchmarks`
- **參與 repo 與職責**（一 repo 一 issue，尚未建立者寫 `待建立`）:
  - `Aqutter/aqutter_core`（底層）— `AqutterNativeHost` 新增通用通道的路由、註冊與連線介面。issue: 待建立
  - `Aqutter/aqutter`（契約正本；殼）— `AqutterPlugin.channels`、註冊、文件；通道基準工具（`tools/channel-bench/`）與量測結果（`docs/channel-performance.md`）；Windows WebSocket 下行偏慢的調查。issue: 待建立
  - `Aqutter/aqutter-js`（網頁端）— `openBinaryChannel`。issue: 待建立
- **執行順序相依**: ① `aqutter_core`（host）合併，移動 tag 並更新 manifest 的 `core.ref` → ② `aqutter`（殼，依 ① 的新 core）合併，更新 manifest 的 `shell.ref` → ③ `aqutter-js`（可與 ② 平行，需在使用前合併並更新 `client.spec`）。契約提供方先、消費方後。Windows 調查（`aqutter`）與 ①、② 互不相依，可先做。
- **範圍外**: 不改鏡像協定；不動 `callPlugin`／事件的既有路徑；不做背壓與自動重連（v1）；iOS、macOS、Linux 的量測不在本計畫內完成（見 Manual Follow-ups）。

- **本計畫所屬 repo**: `Aqutter/aqutter_core`

## Contract / 介面契約
- **契約正本 repo**: `Aqutter/aqutter`　**修訂號**: `rev 1`　**狀態**: `凍結（核准日 2026-10-27）`

### 1. 連線（`Aqutter/aqutter_core` 的 `AqutterNativeHost`）
| 項目 | 值 |
|---|---|
| 伺服器 | 沿用鏡像的同一個本機 WebSocket 伺服器（同一個埠、同一個 token）；`native_endpoint` handler 回傳的 `{ port, token }` 不變 |
| 通用通道的路徑 | `ws://127.0.0.1:<port>/channel/<name>?token=<token>`，`<name>` 為 `<pluginId>.<channel>`（見第 3 點）。鏡像的 `/native/<sessionId>` 路徑與協定完全不變 |
| 驗證 | token 不符、`<name>` 未註冊、不是 WebSocket 升級請求：HTTP 403，不升級 |
| 壓縮 | 關閉 permessage-deflate（沿用鏡像的做法） |
| 訊息格式 | 只用**二進位**訊息（binary frame）；收到文字訊息一律忽略。v1 不定義訊息內的任何結構，由 plugin 自己決定 |
| 重啟 | 殼的 `AqutterNativeHost.restart()`（App 進背景後回到前景）會以 `goingAway`（1001）關閉所有連線；通道**不**自動重連，網頁端收到關閉事件後自行重新 `openBinaryChannel` |

### 2. Dart（`Aqutter/aqutter_core`，`lib/src/nativeview/`）
| 成員 | 簽章 | 說明 |
|---|---|---|
| `AqutterChannelConnection` | `Stream<Uint8List> messages`、`void send(Uint8List data)`、`Future<void> get done`、`void close([int? code, String? reason])` | 一條已升級的連線 |
| `AqutterChannelHandler` | `typedef AqutterChannelHandler = void Function(AqutterChannelConnection connection)` | 每個網頁連線呼叫一次；**型別定義在 core**，殼與 plugin 只引用它 |
| `AqutterNativeHost.registerChannel` | `void registerChannel(String name, AqutterChannelHandler onConnection)` | 註冊通道名稱；同名再註冊取代舊的；每個新連線呼叫一次 `onConnection` |
| `AqutterNativeHost.unregisterChannel` | `void unregisterChannel(String name)` | 取消註冊並關閉該名稱的所有連線 |

### 3. Dart（`Aqutter/aqutter`，`shell/lib/src/plugin/aqutter_plugin.dart`）：只界接，不定義新型別
| 成員 | 簽章 | 說明 |
|---|---|---|
| `AqutterPlugin.channels` | `Map<String, AqutterChannelHandler> get channels => const {}` | 欄位型別用 core 的 `AqutterChannelHandler`；鍵為通道名（不含 plugin id 前綴），須符合 `^[a-z][a-z0-9-]*$` |
| 匯出 | `shell/lib/aqutter.dart` 匯出 core 的 `AqutterChannelConnection`、`AqutterChannelHandler` | plugin 作者只需 `import 'package:aqutter/aqutter.dart'`，與現在匯出 `AqutterNative` 的做法一致 |
| 命名 | `aqutterPluginHandlerName(pluginId, channel)`（`<id>.<channel>`） | 與 handler 名稱同一條規則 |
| 註冊時機 | 殼在 `_registerPlugins` 為每個通道呼叫 `AqutterNativeHost.registerChannel` | plugin 宣告 `supportedPlatforms` 而目前平台不支援時**不註冊** |

### 4. 網頁（`Aqutter/aqutter-js`，`src/channel.ts`）
| 成員 | 簽章 | 說明 |
|---|---|---|
| `openBinaryChannel` | `(name: string) => Promise<BinaryChannel>` | 先以 `native_endpoint` 取埠與 token，再連 `/channel/<name>`；連線打開後才 resolve |
| `BinaryChannel.send` | `(data: ArrayBuffer \| ArrayBufferView) => void` | 送二進位訊息；網頁端的背壓用 `bufferedAmount` |
| `BinaryChannel.bufferedAmount` | `readonly number` | 尚未送出的位元組數 |
| `BinaryChannel.onMessage` | `(listener: (data: ArrayBuffer) => void) => Unsubscribe` | 收到二進位訊息（`binaryType = 'arraybuffer'`） |
| `BinaryChannel.onClose` | `(listener: (info: { code: number, reason: string }) => void) => Unsubscribe` | 連線關閉 |
| `BinaryChannel.close` | `() => void` | 主動關閉 |
| 失敗 | 連線被拒（名稱未註冊、token 錯、CSP 擋掉）或逾時（預設 10 秒） | Promise reject，訊息指出可能原因（含 CSP 需放行 `ws://127.0.0.1:*`）；**不得**無回應 |

### 5. 錯誤與邊界
| 情境 | 結果 |
|---|---|
| 通道名稱格式錯誤 | `openBinaryChannel` 同步 reject（`<pluginId>.<channel>`，各段符合 `^[a-z][a-z0-9-]*$`） |
| plugin 在目前平台不支援 | 通道未註冊，等同名稱未註冊：連線被拒 |
| 在 Flutter 之外（純瀏覽器） | reject，與 `callPlugin` 一致 |

### 6. 相容性
- 鏡像的連線路徑、協定、token 與 `native_endpoint` 不變；新增的 `/channel/` 路徑不影響既有的鏡像連線。
- 既有的 `callPlugin`、事件與 base64 做法不變，通用通道是**新增**的選項。

### 7. 變更紀錄
- _(尚無)_

## Impact Files
- `lib/src/nativeview/native_host_io.dart:40-125`（`AqutterNativeHost`、`_start`）— 新增通道註冊表與 `registerChannel`／`unregisterChannel`；`restart()`（`:105-125`）一併關閉通道連線。
- `lib/src/nativeview/native_host_io.dart:205-241`（`_onRequest`）— 路由分流：`segments[0] == 'channel'` 走通道（驗 token 與名稱，升級後交給 `onConnection`），`'native'` 維持原樣。
- `lib/src/nativeview/native_channel.dart` (new) — `AqutterChannelConnection`（`messages`、`send`、`done`、`close`）與 `AqutterChannelHandler`（處理函式的型別）。
- `lib/src/nativeview/native_host_stub.dart` — 非 `dart:io` 平台的對應空實作（維持條件匯出可編譯）。
- `lib/src/nativeview/nativeview.dart` — 匯出新型別。
- `test/nativeview_channel_test.dart` (new) — 路由與驗證（token 錯、名稱未註冊回 403）、雙向二進位、關閉、同名再註冊取代、`restart()` 關閉連線、文字訊息被忽略、鏡像路徑不受影響。
- `doc/nativeview.md` — 補「通用二進位通道」一節；`.kn-project/project.md` 保留鐵則補一行。

## Open Questions / 待確認事項
- ⏳ **背壓（flow control）**：Dart `WebSocket.add` 沒有背壓，下行大量資料可能在記憶體堆積。v1 是否只靠文件提醒，或提供 `send` 回傳 `Future`／`bufferedAmount`？於實作時用壓力測試決定，有結論才寫進契約（走 Rule 29 若需改契約）。

## Manual Follow-ups / 人工收尾事項
- **[合併後]** 移動 `aqutter_core` 的 tag `0.0.0` 到新 commit，並在 `Aqutter/aqutter` 更新 manifest 的 `core.ref`、同步 `aqutter-cli` 快照 — 沿用先前流程 — 對外動作，需使用者核准

## Key Decisions
- **[Phase 0]** 整合主幹 `main`；milestone 不指定，base 為 `main`（逐 repo 詢問，皆選不指定）。
- **[分層]** Dart 端所有型別與能力（連線、處理函式型別、註冊）都在 `aqutter_core`；`aqutter`（殼）只做界接：`AqutterPlugin.channels` 欄位、`_registerPlugins` 註冊、匯出（使用者指示）。
- **[Q1]** Dart 介面＝plugin 宣告具名通道（`AqutterPlugin.channels`）（使用者選擇，建議項）— 理由：與 handlers／事件的命名與契約一致，可配合 `supportedPlatforms`。
- **[Q2]** 伺服器放在 `aqutter_core` 的 `AqutterNativeHost`（使用者選擇，未採納建議的「殼內另建」）— 理由：與鏡像共用同一個伺服器與 token。代價：要動第三個 repo；鏡像協定與通用通道共用伺服器，路由要清楚分開（`/native/` 與 `/channel/`）。
- **[依據]** 量測（release，各一台機器一次，數字當量級）：Android（ASUS_I006D）WebSocket 1MB 下行 263 MB/s，JSON 路徑往返約 38 MB/s（約 7 倍）；Windows WebSocket 下行 44 MB/s、JSON 路徑約 20 MB/s（約 2 到 3 倍）。小呼叫往返兩平台都約 0.5 ms，不需優化。
- **[假設]** Windows 鏡像約 26 fps 的上限可能是這條 WebSocket 下行（每幀約 1.7 MB × 26 fps ≈ 44 MB/s，與量到的下行上限吻合），而不是先前判斷的畫面讀回。要在 Windows 調查任務中驗證，不得在驗證前當成結論。
- **[v1 範圍]** 只做二進位、不做背壓與自動重連；背壓策略在實作中以測試決定，有結論才寫進文件。
- **[基準工具]** 保存在 `Aqutter/aqutter` 的 `tools/channel-bench/`，量測結果寫進 `docs/channel-performance.md` — 理由：工具要能在各平台重跑，結果要有出處。
- **[契約]** rev 1 凍結（核准日 2026-10-27）。
- **[完成後]** commit + 開 PR（併回 `main`；使用者核准時未更動預設）。
- **[Windows 調查停損]** 同意：原因若在 WebView2 或 `dart:io` 本身而我們改不動，只記錄並提供 workaround。
- **[執行模式]** 序列。

## Git Completion Policy
- PR 一律以 `--base main` 顯式指定；commit 與 PR body 含 `Closes #N`。
- commit 自動；完成時依核准閘的「完成後」選項。

## References
- 通道基準的原始量測：`docs/channel-performance.md`（本計畫產出）；暫存結果 `chbench-windows.json`、`chbench-android.json`（在工作階段的暫存區，不進 repo，數字會寫進文件）
