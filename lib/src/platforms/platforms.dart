// 原生平台的實作會用到 dart:io，Web 實作則依賴 dart:js_interop；
// 以條件匯出讓每個建置目標只編入自己能編譯的那一側。
export 'platforms_native.dart'
    if (dart.library.js_interop) 'platforms_web.dart';
