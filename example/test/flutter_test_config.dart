import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'test_helpers/mock_aqutter_platform.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  MockAqutterPlatform.initialize();
  await testMain();
}
