part of 'main.dart';

void onWindowFocus() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onWindowFocus,
  );

  var url = !kIsWeb ? TEST_URL_1 : TEST_WEB_PLATFORM_URL_1;

  skippableTestWidgets('onWindowFocus', (WidgetTester tester) async {
    final Completer<void> onWindowFocusCompleter = Completer<void>();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: url),
          onLoadStop: (controller, url) async {
            await controller.evaluateJavascript(
              source: 'window.dispatchEvent(new Event("focus"));',
            );
          },
          onWindowFocus: (controller) {
            onWindowFocusCompleter.complete();
          },
        ),
      ),
    );
    await tester.pump();
    await expectLater(onWindowFocusCompleter.future, completes);
  }, skip: shouldSkip);
}
