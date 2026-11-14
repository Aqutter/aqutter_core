import 'package:aqutter_core/src/platform_interface/src/util.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HexColor.toHex', () {
    test('keeps the ARGB hex order and the leading hash sign', () {
      expect(const Color(0x80FF8040).toHex(), '#80ff8040');
      expect(const Color(0xFF000000).toHex(), '#ff000000');
      expect(const Color(0x00FFFFFF).toHex(), '#00ffffff');
    });

    test('omits the hash sign when asked to', () {
      expect(const Color(0xFF123456).toHex(leadingHashSign: false), 'ff123456');
    });

    test('covers every 8-bit channel value without drift', () {
      for (var v = 0; v <= 255; v++) {
        final hex = Color.fromARGB(v, v, v, v).toHex(leadingHashSign: false);
        final byte = v.toRadixString(16).padLeft(2, '0');
        expect(hex, '$byte$byte$byte$byte', reason: 'channel value $v');
      }
    });
  });
}
