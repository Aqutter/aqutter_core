part of 'main.dart';

void onTitleChanged() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onTitleChanged,
  );

  var url = !kIsWeb ? TEST_URL_1 : TEST_WEB_PLATFORM_URL_1;

  skippableTestWidgets('onTitleChanged', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();
    final Completer<void> onTitleChangedCompleter = Completer<void>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: url),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onLoadStop: (controller, url) {
            if (!pageLoaded.isCompleted) {
              pageLoaded.complete();
            }
          },
          onTitleChanged: (controller, title) {
            if (title == "title test") {
              onTitleChangedCompleter.complete();
            }
          },
        ),
      ),
    );

    final AqutterWebViewController controller = await controllerCompleter.future;
    await tester.pump();
    await pageLoaded.future;
    await controller.evaluateJavascript(
      source: "document.title = 'title test';",
    );
    await expectLater(onTitleChangedCompleter.future, completes);
  }, skip: shouldSkip);
}
