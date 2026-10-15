part of 'main.dart';

void onProgressChanged() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onProgressChanged,
  );

  skippableTestWidgets('onProgressChanged', (WidgetTester tester) async {
    final Completer<void> onProgressChangedCompleter = Completer<void>();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_URL_1),
          initialSettings: AqutterWebViewSettings(clearCache: true),
          onProgressChanged: (controller, progress) {
            if (progress == 100 && !onProgressChangedCompleter.isCompleted) {
              onProgressChangedCompleter.complete();
            }
          },
        ),
      ),
    );
    await expectLater(onProgressChangedCompleter.future, completes);
  }, skip: shouldSkip);
}
