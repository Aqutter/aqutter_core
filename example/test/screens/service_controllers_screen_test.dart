import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aqutter_core_example/providers/event_log_provider.dart';
import 'package:aqutter_core_example/screens/advanced/service_controllers_screen.dart';

import '../test_helpers/mock_aqutter_platform.dart';
import '../test_helpers/test_provider_wrapper.dart';

void main() {
  setUpAll(() {
    MockAqutterPlatform.initialize();
  });

  group('ServiceControllersScreen', () {
    Widget createWidget() {
      return MaterialApp(
        home: TestProviderWrapper(
          eventLogProvider: EventLogProvider(),
          child: const ServiceControllersScreen(),
        ),
      );
    }

    testWidgets('does not overflow on small height', (tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pump();

      expect(tester.takeException(), isNull);
    });
  });
}
