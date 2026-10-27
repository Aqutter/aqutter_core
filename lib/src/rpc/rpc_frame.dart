import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

/// 單一 WebSocket 訊息的大小上限（位元組）。
const int aqutterRpcMaxFrameBytes = 64 * 1024 * 1024;

/// 邏輯訊框（call／res／err／evt）的大小上限：超過 [aqutterRpcMaxFrameBytes] 的由傳輸層自動分段。
const int aqutterRpcMaxMessageBytes = 512 * 1024 * 1024;

/// 分段時每一片的大小（最後一片較短）。
const int aqutterRpcPartBytes = 16 * 1024 * 1024;

/// 一個分段訊息最多幾片：[aqutterRpcMaxMessageBytes] / [aqutterRpcPartBytes]。
const int aqutterRpcMaxParts = 32;

/// 同一方向同時進行（尚未收齊）的分段訊息上限。
const int aqutterRpcMaxPartialMessages = 4;

/// 訊框類型。
enum AqutterRpcFrameType {
  /// 網頁 -> Dart：呼叫 handler。
  call,

  /// Dart -> 網頁：成功回應。
  res,

  /// Dart -> 網頁：失敗回應。
  err,

  /// Dart -> 網頁：事件。
  evt,

  /// 雙向：大訊框的一片（見 [AqutterRpcReassembler]）。
  part,
}

/// 訊框格式錯誤（長度不符、佔位對不上、未知類型…）。
class AqutterRpcFormatException implements Exception {
  const AqutterRpcFormatException(this.message);

  final String message;

  @override
  String toString() => 'AqutterRpcFormatException: $message';
}

/// 多工連線上的一個訊框。格式見網頁端 `@aqutter/aqutter` 與殼的契約：
///
/// ```
/// frame  = headerLength(u32, big-endian) | header(UTF-8 JSON) | blob_0 | blob_1 | …
/// header = { t, id?, name?, ch?, p?, e?, blobs }
/// ```
///
/// 酬載 [payload] 內的 [Uint8List]（或任何 [TypedData]）送出時抽成 blob，並在酬載中換成 `{"$bin": i}`；
/// 解碼時還原成 [Uint8List]。
class AqutterRpcFrame {
  const AqutterRpcFrame({
    required this.type,
    this.id,
    this.name,
    this.channel,
    this.payload,
    this.errorCode,
    this.errorMessage,
    this.partSeq,
    this.partTotal,
    this.partData,
  });

  final AqutterRpcFrameType type;

  /// 呼叫編號（`call`／`res`／`err`）。
  final int? id;

  /// handler 名稱（`call`）。
  final String? name;

  /// 事件頻道（`evt`）。
  final String? channel;

  /// 酬載／結果／事件內容；已把二進位佔位還原。
  final Object? payload;

  final String? errorCode;
  final String? errorMessage;

  /// `part`：片序（0 起算）、總片數與這一片的位元組；[id] 是分段訊息編號。
  final int? partSeq;
  final int? partTotal;
  final Uint8List? partData;
}

/// 酬載中二進位佔位的保留鍵。
const String aqutterRpcBinaryKey = r'$bin';

/// JavaScript 的整數安全上限（2^53 - 1）。
const int _maxSafeInteger = 9007199254740991;

/// 把 [frame] 編成**單一** WebSocket 訊息。超過 [aqutterRpcMaxFrameBytes] 時拋出 [AqutterRpcFormatException]；
/// 可能超過的訊框請用 [encodeAqutterRpcMessages]。
///
/// 酬載含無法序列化的物件、或使用者資料使用了保留鍵 `$bin` 時拋出 [ArgumentError]。
Uint8List encodeAqutterRpcFrame(AqutterRpcFrame frame) {
  final bytes = _encode(frame);
  if (bytes.length > aqutterRpcMaxFrameBytes) {
    throw const AqutterRpcFormatException('Frame exceeds the size limit');
  }
  return bytes;
}

/// 把 [frame] 編成要依序送出的 WebSocket 訊息：≤ [aqutterRpcMaxFrameBytes] 時只有一個（與
/// [encodeAqutterRpcFrame] 相同）；超過時切成每片 [aqutterRpcPartBytes] 的 `part` 訊框，[partId] 是這個
/// 分段訊息在送出方向上的編號（同一方向內不可重複）。超過 [aqutterRpcMaxMessageBytes] 拋出 [AqutterRpcFormatException]。
List<Uint8List> encodeAqutterRpcMessages(AqutterRpcFrame frame, {required int partId}) {
  final bytes = _encode(frame);
  if (bytes.length > aqutterRpcMaxMessageBytes) {
    throw const AqutterRpcFormatException('Frame exceeds the size limit');
  }
  if (bytes.length <= aqutterRpcMaxFrameBytes) {
    return [bytes];
  }
  final total = (bytes.length + aqutterRpcPartBytes - 1) ~/ aqutterRpcPartBytes;
  return [
    for (var seq = 0; seq < total; seq++)
      _encode(
        AqutterRpcFrame(
          type: AqutterRpcFrameType.part,
          id: partId,
          partSeq: seq,
          partTotal: total,
          partData: Uint8List.sublistView(bytes, seq * aqutterRpcPartBytes, min((seq + 1) * aqutterRpcPartBytes, bytes.length)),
        ),
      ),
  ];
}

Uint8List _encode(AqutterRpcFrame frame) {
  final blobs = <Uint8List>[];
  final header = <String, Object?>{'t': frame.type.name};
  if (frame.id != null) {
    header['id'] = frame.id;
  }
  if (frame.name != null) {
    header['name'] = frame.name;
  }
  if (frame.channel != null) {
    header['ch'] = frame.channel;
  }
  if (frame.payload != null) {
    header['p'] = _extractBlobs(frame.payload, blobs);
  }
  if (frame.errorCode != null) {
    header['e'] = {'code': frame.errorCode, 'message': frame.errorMessage ?? ''};
  }
  if (frame.type == AqutterRpcFrameType.part) {
    header['seq'] = frame.partSeq;
    header['total'] = frame.partTotal;
    blobs.add(frame.partData!);
  }
  header['blobs'] = [for (final blob in blobs) blob.length];

  final headerBytes = utf8.encode(jsonEncode(header));
  var total = 4 + headerBytes.length;
  for (final blob in blobs) {
    total += blob.length;
  }
  if (total > aqutterRpcMaxMessageBytes) {
    throw const AqutterRpcFormatException('Frame exceeds the size limit');
  }
  final out = Uint8List(total);
  ByteData.sublistView(out).setUint32(0, headerBytes.length, Endian.big);
  out.setRange(4, 4 + headerBytes.length, headerBytes);
  var offset = 4 + headerBytes.length;
  for (final blob in blobs) {
    out.setRange(offset, offset + blob.length, blob);
    offset += blob.length;
  }
  return out;
}

Object? _extractBlobs(Object? value, List<Uint8List> blobs) {
  if (value is TypedData) {
    blobs.add(Uint8List.view(value.buffer, value.offsetInBytes, value.lengthInBytes));
    return {aqutterRpcBinaryKey: blobs.length - 1};
  }
  if (value is List) {
    return [for (final item in value) _extractBlobs(item, blobs)];
  }
  if (value is Map) {
    final out = <String, Object?>{};
    for (final entry in value.entries) {
      final key = entry.key;
      if (key is! String) {
        throw ArgumentError.value(key, 'payload', 'Map keys must be strings');
      }
      if (key == aqutterRpcBinaryKey) {
        throw ArgumentError.value(key, 'payload', '"$aqutterRpcBinaryKey" is a reserved key');
      }
      out[key] = _extractBlobs(entry.value, blobs);
    }
    return out;
  }
  return value;
}

/// 解碼一個訊框。格式錯誤一律拋出 [AqutterRpcFormatException]。
///
/// [maxBytes] 是這個訊框允許的長度；`part` 重組後的整段位元組用 [aqutterRpcMaxMessageBytes]。
AqutterRpcFrame decodeAqutterRpcFrame(Uint8List data, {int maxBytes = aqutterRpcMaxFrameBytes}) {
  if (data.length > maxBytes) {
    throw const AqutterRpcFormatException('Frame exceeds the size limit');
  }
  if (data.length < 4) {
    throw const AqutterRpcFormatException('Frame is shorter than its length prefix');
  }
  final headerLength = ByteData.sublistView(data).getUint32(0, Endian.big);
  if (headerLength > data.length - 4) {
    throw const AqutterRpcFormatException('Header length exceeds the frame');
  }

  final Object? decoded;
  try {
    decoded = jsonDecode(utf8.decode(data.sublist(4, 4 + headerLength)));
  }
  on FormatException catch (error) {
    throw AqutterRpcFormatException('Header is not valid JSON: ${error.message}');
  }
  if (decoded is! Map<String, dynamic>) {
    throw const AqutterRpcFormatException('Header must be an object');
  }

  final blobLengths = decoded['blobs'];
  if (blobLengths is! List) {
    throw const AqutterRpcFormatException('"blobs" must be an array');
  }
  final blobs = <Uint8List>[];
  var offset = 4 + headerLength;
  for (final length in blobLengths) {
    if (length is! int || length < 0 || length > data.length - offset) {
      throw const AqutterRpcFormatException('Blob lengths do not fit the frame');
    }
    blobs.add(Uint8List.sublistView(data, offset, offset + length));
    offset += length;
  }
  if (offset != data.length) {
    throw const AqutterRpcFormatException('Blob lengths do not add up to the frame length');
  }

  final typeName = decoded['t'];
  final type = AqutterRpcFrameType.values.where((value) => value.name == typeName).firstOrNull;
  if (type == null) {
    throw AqutterRpcFormatException('Unknown frame type: $typeName');
  }
  final id = decoded['id'];
  if (id != null && (id is! int || id < 0 || id > _maxSafeInteger)) {
    throw const AqutterRpcFormatException('"id" must be an integer in 0..2^53-1');
  }
  if (type == AqutterRpcFrameType.part) {
    final seq = decoded['seq'];
    final total = decoded['total'];
    if (id == null || seq is! int || total is! int || total < 2 || total > aqutterRpcMaxParts || seq < 0 || seq >= total) {
      throw const AqutterRpcFormatException('"part" needs "id", "seq" and "total" (2..$aqutterRpcMaxParts)');
    }
    if (blobs.length != 1 || blobs[0].length > aqutterRpcPartBytes || decoded.containsKey('p')) {
      throw const AqutterRpcFormatException('"part" carries exactly one blob of at most one part size');
    }
    return AqutterRpcFrame(type: type, id: id as int, partSeq: seq, partTotal: total, partData: blobs[0]);
  }
  final name = decoded['name'];
  final channel = decoded['ch'];
  if (name != null && name is! String || channel != null && channel is! String) {
    throw const AqutterRpcFormatException('"name" and "ch" must be strings');
  }

  switch (type) {
    case AqutterRpcFrameType.call:
      if (id == null || name == null) {
        throw const AqutterRpcFormatException('"call" needs "id" and "name"');
      }
    case AqutterRpcFrameType.res:
      if (id == null) {
        throw const AqutterRpcFormatException('"res" needs "id"');
      }
    case AqutterRpcFrameType.err:
      if (id == null || decoded['e'] is! Map) {
        throw const AqutterRpcFormatException('"err" needs "id" and "e"');
      }
    case AqutterRpcFrameType.evt:
      if (channel == null) {
        throw const AqutterRpcFormatException('"evt" needs "ch"');
      }
    case AqutterRpcFrameType.part:
      break; // 上方已處理並回傳
  }

  final used = <int>{};
  final payload = _restoreBlobs(decoded['p'], blobs, used);
  if (used.length != blobs.length) {
    throw const AqutterRpcFormatException('Every blob must be referenced exactly once');
  }

  final error = decoded['e'];
  return AqutterRpcFrame(
    type: type,
    id: id as int?,
    name: name as String?,
    channel: channel as String?,
    payload: payload,
    errorCode: error is Map ? '${error['code']}' : null,
    errorMessage: error is Map ? '${error['message']}' : null,
  );
}

Object? _restoreBlobs(Object? value, List<Uint8List> blobs, Set<int> used) {
  if (value is List) {
    return [for (final item in value) _restoreBlobs(item, blobs, used)];
  }
  if (value is Map<String, dynamic>) {
    if (value.containsKey(aqutterRpcBinaryKey)) {
      final index = value[aqutterRpcBinaryKey];
      if (value.length != 1 || index is! int || index < 0 || index >= blobs.length || !used.add(index)) {
        throw const AqutterRpcFormatException('Invalid binary placeholder');
      }
      return blobs[index];
    }
    return {for (final entry in value.entries) entry.key: _restoreBlobs(entry.value, blobs, used)};
  }
  return value;
}

/// 重組分段訊息：把收到的每個 WebSocket 訊息交給 [add]，完整的邏輯訊框會在收齊最後一片時回傳。
///
/// 一個連線（一個方向）一個實例。分段違規（片序不連續、片數或片長不符、同時進行太多、組回後超過上限、
/// 分段內容本身又是 `part`）一律拋出 [AqutterRpcFormatException]，呼叫端應關閉連線。
class AqutterRpcReassembler {
  final Map<int, _Partial> _partials = {};

  /// 目前尚未收齊的分段訊息數。
  int get pending => _partials.length;

  /// 處理一個 WebSocket 訊息；非 `part` 的訊框直接解碼回傳，`part` 收齊時回傳組回的邏輯訊框，否則回傳 null。
  AqutterRpcFrame? add(Uint8List message) {
    final frame = decodeAqutterRpcFrame(message);
    if (frame.type != AqutterRpcFrameType.part) {
      return frame;
    }
    final id = frame.id!;
    final seq = frame.partSeq!;
    final total = frame.partTotal!;
    var partial = _partials[id];
    if (partial == null) {
      if (seq != 0) {
        throw const AqutterRpcFormatException('A part sequence must start at 0');
      }
      if (_partials.length >= aqutterRpcMaxPartialMessages) {
        throw const AqutterRpcFormatException('Too many partial messages in flight');
      }
      partial = _Partial(total);
      _partials[id] = partial;
    }
    if (partial.total != total || partial.parts.length != seq) {
      throw const AqutterRpcFormatException('Parts must arrive in order with a constant total');
    }
    final data = frame.partData!;
    if (seq < total - 1 && data.length != aqutterRpcPartBytes) {
      throw const AqutterRpcFormatException('Every part but the last must be one full part');
    }
    partial.parts.add(data);
    partial.bytes += data.length;
    if (partial.parts.length < total) {
      return null;
    }
    _partials.remove(id);
    if (partial.bytes > aqutterRpcMaxMessageBytes) {
      throw const AqutterRpcFormatException('Reassembled message exceeds the size limit');
    }
    final whole = Uint8List(partial.bytes);
    var offset = 0;
    for (final part in partial.parts) {
      whole.setRange(offset, offset + part.length, part);
      offset += part.length;
    }
    final inner = decodeAqutterRpcFrame(whole, maxBytes: aqutterRpcMaxMessageBytes);
    if (inner.type == AqutterRpcFrameType.part) {
      throw const AqutterRpcFormatException('A part cannot carry another part');
    }
    return inner;
  }
}

class _Partial {
  _Partial(this.total);

  final int total;
  final List<Uint8List> parts = [];
  int bytes = 0;
}
