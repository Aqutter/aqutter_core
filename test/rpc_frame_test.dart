import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter_test/flutter_test.dart';

String _hex(Uint8List bytes) => bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

Uint8List _bytes(String hex) => Uint8List.fromList([
      for (var i = 0; i < hex.length; i += 2) int.parse(hex.substring(i, i + 2), radix: 16),
    ]);

void main() {
  final vectors = jsonDecode(File('test/rpc_frame_vectors.json').readAsStringSync()) as Map<String, dynamic>;

  group('shared vectors (also used by aqutter-js)', () {
    for (final vector in (vectors['valid'] as List).cast<Map<String, dynamic>>()) {
      test('decodes: ${vector['name']}', () {
        final frame = decodeAqutterRpcFrame(_bytes(vector['hex'] as String));
        expect(frame.type.name, vector['t']);
        expect(frame.id, vector['id']);
        expect(frame.name, vector['nameField']);
        expect(frame.channel, vector['ch']);
      });
      test('re-encodes to the same bytes: ${vector['name']}', () {
        final bytes = _bytes(vector['hex'] as String);
        expect(_hex(encodeAqutterRpcFrame(decodeAqutterRpcFrame(bytes))), vector['hex']);
      });
    }
    for (final vector in (vectors['invalid'] as List).cast<Map<String, dynamic>>()) {
      test('rejects: ${vector['name']}', () {
        expect(() => decodeAqutterRpcFrame(_bytes(vector['hex'] as String)), throwsA(isA<AqutterRpcFormatException>()));
      });
    }
  });

  group('binary payloads', () {
    test('round-trips Uint8List at any depth and restores them as Uint8List', () {
      final frame = AqutterRpcFrame(
        type: AqutterRpcFrameType.res,
        id: 1,
        payload: {
          'top': Uint8List.fromList([1, 2, 3]),
          'list': [Uint8List.fromList([4]), 'x', {'deep': Uint8List.fromList([5, 6])}],
          'n': 1.5,
          'null': null,
        },
      );
      final decoded = decodeAqutterRpcFrame(encodeAqutterRpcFrame(frame)).payload as Map<String, dynamic>;
      expect(decoded['top'], isA<Uint8List>());
      expect(decoded['top'], [1, 2, 3]);
      expect((decoded['list'] as List)[0], [4]);
      expect((((decoded['list'] as List)[2]) as Map)['deep'], [5, 6]);
      expect(decoded['n'], 1.5);
      expect(decoded['null'], isNull);
    });

    test('other typed data is sent as its raw bytes', () {
      final frame = AqutterRpcFrame(type: AqutterRpcFrameType.res, id: 1, payload: Uint16List.fromList([1, 258]));
      final decoded = decodeAqutterRpcFrame(encodeAqutterRpcFrame(frame)).payload as Uint8List;
      expect(decoded.length, 4);
    });

    test('a view into a larger buffer only sends its own range', () {
      final big = Uint8List.fromList([9, 1, 2, 3, 9]);
      final view = Uint8List.sublistView(big, 1, 4);
      final decoded = decodeAqutterRpcFrame(encodeAqutterRpcFrame(AqutterRpcFrame(type: AqutterRpcFrameType.res, id: 1, payload: view))).payload as Uint8List;
      expect(decoded, [1, 2, 3]);
    });

    test('the reserved key cannot appear in user data', () {
      expect(
        () => encodeAqutterRpcFrame(const AqutterRpcFrame(type: AqutterRpcFrameType.res, id: 1, payload: {r'$bin': 0})),
        throwsArgumentError,
      );
    });

    test('non-string map keys are rejected', () {
      expect(
        () => encodeAqutterRpcFrame(const AqutterRpcFrame(type: AqutterRpcFrameType.res, id: 1, payload: {1: 'a'})),
        throwsArgumentError,
      );
    });
  });

  test('a frame over the size limit is refused in both directions', () {
    expect(
      () => encodeAqutterRpcFrame(AqutterRpcFrame(type: AqutterRpcFrameType.res, id: 1, payload: Uint8List(aqutterRpcMaxFrameBytes))),
      throwsA(isA<AqutterRpcFormatException>()),
    );
    expect(() => decodeAqutterRpcFrame(Uint8List(aqutterRpcMaxFrameBytes + 1)), throwsA(isA<AqutterRpcFormatException>()));
  });

  test('ids up to 2^53 - 1 are accepted, beyond that rejected', () {
    final ok = encodeAqutterRpcFrame(const AqutterRpcFrame(type: AqutterRpcFrameType.res, id: 9007199254740991));
    expect(decodeAqutterRpcFrame(ok).id, 9007199254740991);
    final header = utf8.encode('{"t":"res","id":9007199254740992,"blobs":[]}');
    final bytes = Uint8List(4 + header.length);
    ByteData.sublistView(bytes).setUint32(0, header.length);
    bytes.setRange(4, bytes.length, header);
    expect(() => decodeAqutterRpcFrame(bytes), throwsA(isA<AqutterRpcFormatException>()));
  });
}
