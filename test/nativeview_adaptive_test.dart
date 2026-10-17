import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AqutterNativeScaler', () {
    test('starts at full resolution', () {
      expect(AqutterNativeScaler().scale, 1.0);
    });

    test('degrades only after several consecutive slow frames', () {
      final scaler = AqutterNativeScaler();
      scaler
        ..record(40, 15)
        ..record(40, 15);
      expect(scaler.scale, 1.0);
      scaler.record(40, 15);
      expect(scaler.scale, closeTo(0.85, 1e-9));
    });

    test('a single fast frame resets the slow streak', () {
      final scaler = AqutterNativeScaler();
      scaler
        ..record(40, 15)
        ..record(40, 15)
        ..record(5, 15) // 夠快 → 連續慢的計數歸零
        ..record(40, 15)
        ..record(40, 15);
      expect(scaler.scale, 1.0);
    });

    test('never goes below minScale', () {
      final scaler = AqutterNativeScaler(minScale: 0.6);
      for (var i = 0; i < 100; i++) {
        scaler.record(100, 15);
      }
      expect(scaler.scale, 0.6);
    });

    test('recovers only after many consecutive fast frames', () {
      final scaler = AqutterNativeScaler();
      for (var i = 0; i < 9; i++) {
        scaler.record(100, 15);
      }
      final degraded = scaler.scale;
      expect(degraded, lessThan(1.0));
      for (var i = 0; i < 29; i++) {
        scaler.record(2, 15);
      }
      expect(scaler.scale, degraded);
      scaler.record(2, 15);
      expect(scaler.scale, greaterThan(degraded));
    });

    test('frames near the budget neither degrade nor recover', () {
      final scaler = AqutterNativeScaler();
      for (var i = 0; i < 50; i++) {
        scaler.record(12, 15); // 在預算內但不夠快（> 6 成預算）
      }
      expect(scaler.scale, 1.0);
    });
  });
}
