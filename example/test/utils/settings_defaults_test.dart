import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aqutter_core/aqutter_core.dart';
import 'package:aqutter_core_example/utils/settings_defaults.dart';

void main() {
  setUp(() {
    debugDefaultTargetPlatformOverride = null;
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });

  test('default settings map matches constructor defaults', () {
    final defaults = defaultWebViewSettings().toMap(
      enumMethod: AqutterEnumMethod.nativeValue,
    );
    final expected = AqutterWebViewSettings().toMap(
      enumMethod: AqutterEnumMethod.nativeValue,
    );

    expect(defaults, expected);
  });

  test('default environment settings map matches constructor defaults', () {
    final defaults = defaultWebViewEnvironmentSettings().toMap(
      enumMethod: AqutterEnumMethod.nativeValue,
    );
    final expected = AqutterWebViewEnvironmentSettings().toMap(
      enumMethod: AqutterEnumMethod.nativeValue,
    );

    expect(defaults, expected);
  });
}
