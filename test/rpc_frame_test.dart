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

  group('auto-split (messages over 64 MiB)', () {
    Uint8List big(int bytes) => Uint8List(bytes)..fillRange(0, bytes, 7);

    test('a frame within the limit is a single message identical to encodeAqutterRpcFrame', () {
      const frame = AqutterRpcFrame(type: AqutterRpcFrameType.res, id: 1, payload: {'a': 1});
      final messages = encodeAqutterRpcMessages(frame, partId: 0);
      expect(messages, hasLength(1));
      expect(_hex(messages.single), _hex(encodeAqutterRpcFrame(frame)));
    });

    test('a 70 MiB payload is split into 16 MiB parts and reassembled intact', () {
      final data = big(70 * 1024 * 1024);
      data[5] = 1;
      data[data.length - 1] = 9;
      final messages = encodeAqutterRpcMessages(AqutterRpcFrame(type: AqutterRpcFrameType.res, id: 3, payload: {'data': data}), partId: 11);
      expect(messages.length, 5);
      for (final message in messages) {
        expect(message.length, lessThanOrEqualTo(aqutterRpcMaxFrameBytes));
        expect(decodeAqutterRpcFrame(message).type, AqutterRpcFrameType.part);
      }
      final reassembler = AqutterRpcReassembler();
      AqutterRpcFrame? result;
      for (final message in messages) {
        expect(result, isNull);
        result = reassembler.add(message);
      }
      expect(reassembler.pending, 0);
      expect(result!.id, 3);
      final out = (result.payload as Map<String, dynamic>)['data'] as Uint8List;
      expect(out.length, data.length);
      expect(out[5], 1);
      expect(out.last, 9);
    });

    test('a frame over 512 MiB is refused', () {
      expect(
        () => encodeAqutterRpcMessages(AqutterRpcFrame(type: AqutterRpcFrameType.res, id: 1, payload: Uint8List(aqutterRpcMaxMessageBytes)), partId: 0),
        throwsA(isA<AqutterRpcFormatException>()),
      );
    });

    test('ordinary frames pass through the reassembler untouched', () {
      final reassembler = AqutterRpcReassembler();
      final frame = reassembler.add(encodeAqutterRpcFrame(const AqutterRpcFrame(type: AqutterRpcFrameType.call, id: 4, name: 'a.b')));
      expect(frame!.name, 'a.b');
    });

    List<Uint8List> parts(int id, int total, {int sizeOfLast = 3}) => [
          for (var seq = 0; seq < total; seq++)
            encodeAqutterRpcFrame(
              AqutterRpcFrame(
                type: AqutterRpcFrameType.part,
                id: id,
                partSeq: seq,
                partTotal: total,
                partData: seq < total - 1 ? big(aqutterRpcPartBytes) : Uint8List(sizeOfLast),
              ),
            ),
        ];

    test('rejects a sequence that does not start at 0 or arrives out of order', () {
      final three = parts(1, 3);
      expect(() => AqutterRpcReassembler().add(three[1]), throwsA(isA<AqutterRpcFormatException>()));
      final reassembler = AqutterRpcReassembler()..add(three[0]);
      expect(() => reassembler.add(three[2]), throwsA(isA<AqutterRpcFormatException>()));
    });

    test('rejects a short part that is not the last one', () {
      final short = encodeAqutterRpcFrame(
        AqutterRpcFrame(type: AqutterRpcFrameType.part, id: 1, partSeq: 0, partTotal: 2, partData: Uint8List(10)),
      );
      expect(() => AqutterRpcReassembler().add(short), throwsA(isA<AqutterRpcFormatException>()));
    });

    test('rejects more than four partial messages in flight', () {
      final reassembler = AqutterRpcReassembler();
      for (var id = 0; id < aqutterRpcMaxPartialMessages; id++) {
        reassembler.add(parts(id, 2).first);
      }
      expect(reassembler.pending, aqutterRpcMaxPartialMessages);
      expect(() => reassembler.add(parts(99, 2).first), throwsA(isA<AqutterRpcFormatException>()));
    });

    test('rejects a reassembled message that is itself a part', () {
      final inner = encodeAqutterRpcFrame(
        AqutterRpcFrame(type: AqutterRpcFrameType.part, id: 1, partSeq: 0, partTotal: 2, partData: Uint8List(aqutterRpcPartBytes)),
      );
      expect(inner.length, greaterThan(aqutterRpcPartBytes));
      Uint8List piece(int seq, Uint8List data) => encodeAqutterRpcFrame(
            AqutterRpcFrame(type: AqutterRpcFrameType.part, id: 8, partSeq: seq, partTotal: 2, partData: data),
          );
      final reassembler = AqutterRpcReassembler();
      expect(reassembler.add(piece(0, Uint8List.sublistView(inner, 0, aqutterRpcPartBytes))), isNull);
      expect(() => reassembler.add(piece(1, Uint8List.sublistView(inner, aqutterRpcPartBytes))), throwsA(isA<AqutterRpcFormatException>()));
    });
  });
}
