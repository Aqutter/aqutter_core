import 'dart:typed_data';

/// 幀的像素格式。
enum AqutterNativeFormat {
  /// PNG 壓縮（頻寬小、編碼耗時）。
  png(0),

  /// 未壓縮的 straight（非預乘）RGBA，每像素 4 bytes。
  rgba(1),

  /// JPEG 壓縮（有損、不含 alpha）：移動中的畫面用它，每幀小一個數量級，網頁端也不必複製／上傳整張未壓縮像素。
  jpeg(2);

  const AqutterNativeFormat(this.wire);

  /// 線上傳輸時的格式代碼。
  final int wire;
}

/// 一幀鏡像畫面。
class AqutterNativeFrame {
  const AqutterNativeFrame({
    required this.width,
    required this.height,
    required this.format,
    required this.payload,
  });

  final int width;
  final int height;
  final AqutterNativeFormat format;
  final Uint8List payload;
}

/// 幀標頭長度（bytes）。
const int aqutterNativeHeaderLength = 24;

/// 產生一幀的標頭（[aqutterNativeHeaderLength] bytes）。
///
/// 一幀以**兩則**連續的 WebSocket 二進位訊息送出：先標頭、再像素（不把像素複製到同一個緩衝區，
/// 手機上複製數 MB 要花數毫秒）。WebSocket 保證順序，網頁端嚴格依「標頭、像素、標頭、像素…」交替解讀。
///
/// 標頭版面（little-endian）：`[w u32 | h u32 | fmt u32 | seq u32 | sentAt f64 (epoch ms)]`。
/// [seq] 為每個工作階段遞增的序號，網頁端據此丟棄亂序的舊幀並回覆確認（`ack`）。
/// 網頁端（`@aqutter/aqutter` 的 `AqutterNative`）依同一版面解碼；兩端必須成對修改。
Uint8List encodeAqutterNativeFrameHeader(AqutterNativeFrame frame, {required int seq, required int sentAtMs}) {
  final out = Uint8List(aqutterNativeHeaderLength);
  final header = ByteData.view(out.buffer);
  header.setUint32(0, frame.width, Endian.little);
  header.setUint32(4, frame.height, Endian.little);
  header.setUint32(8, frame.format.wire, Endian.little);
  header.setUint32(12, seq & 0xFFFFFFFF, Endian.little);
  header.setFloat64(16, sentAtMs.toDouble(), Endian.little);
  return out;
}

/// 網頁端回報的顯示尺寸（CSS 像素）與裝置像素比；原生端據此決定擷取解析度。
class AqutterNativeViewport {
  const AqutterNativeViewport({required this.width, required this.height, required this.devicePixelRatio});

  final double width;
  final double height;
  final double devicePixelRatio;

  @override
  bool operator ==(Object other) =>
      other is AqutterNativeViewport && other.width == width && other.height == height && other.devicePixelRatio == devicePixelRatio;

  @override
  int get hashCode => Object.hash(width, height, devicePixelRatio);
}

/// 網頁端經 WebSocket 回傳的訊息（手勢或自訂指令）。
///
/// [type] 為訊息種類：`tap` / `doubleTap` / `longPress` / `pan` / `pinch` / `command`；
/// `pan`、`pinch` 帶 `phase`（`start` / `update` / `end`）。座標一律為 0..1 的正規化值，
/// `command` 的名稱在 [data] 的 `name`。完整欄位見 `doc/nativeview.md`。
class AqutterNativeMessage {
  const AqutterNativeMessage(this.type, this.data);

  final String type;
  final Map<String, dynamic> data;

  /// 取數值欄位；缺漏或型別不符回 null。
  double? number(String key) {
    final value = data[key];
    return value is num ? value.toDouble() : null;
  }
}
