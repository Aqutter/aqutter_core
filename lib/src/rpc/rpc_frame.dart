import 'dart:convert';
import 'dart:typed_data';

/// 單一訊框的大小上限（位元組）。
const int aqutterRpcMaxFrameBytes = 64 * 1024 * 1024;

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
}

/// 酬載中二進位佔位的保留鍵。
const String aqutterRpcBinaryKey = r'$bin';

/// JavaScript 的整數安全上限（2^53 - 1）。
const int _maxSafeInteger = 9007199254740991;

/// 把 [frame] 編成可直接送出的位元組。超過 [aqutterRpcMaxFrameBytes] 時拋出 [AqutterRpcFormatException]。
///
/// 酬載含無法序列化的物件、或使用者資料使用了保留鍵 `$bin` 時拋出 [ArgumentError]。
Uint8List encodeAqutterRpcFrame(AqutterRpcFrame frame) {
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
  header['blobs'] = [for (final blob in blobs) blob.length];

  final headerBytes = utf8.encode(jsonEncode(header));
  var total = 4 + headerBytes.length;
  for (final blob in blobs) {
    total += blob.length;
  }
  if (total > aqutterRpcMaxFrameBytes) {
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
AqutterRpcFrame decodeAqutterRpcFrame(Uint8List data) {
  if (data.length > aqutterRpcMaxFrameBytes) {
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
