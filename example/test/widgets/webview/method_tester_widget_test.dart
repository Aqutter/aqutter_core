import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aqutter_core_example/widgets/webview/method_tester_widget.dart';

import '../../test_helpers/mock_aqutter_platform.dart';

void main() {
  setUpAll(() {
    MockAqutterPlatform.initialize();
  });

  group('MethodTesterWidget', () {
    testWidgets('renders search input and warning when controller is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: MethodTesterWidget(controller: null)),
        ),
      );

      expect(find.textContaining('Method Tester'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(
        find.textContaining('WebView controller not available'),
        findsOneWidget,
      );
    });
  });
}
