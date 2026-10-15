part of 'main.dart';

void tRexRunnerGame() {
  final shouldSkip = !AqutterWebViewController.isPropertySupported(
    AqutterPlatformWebViewControllerProperty.tRexRunnerHtml,
  );

  skippableTestWidgets('T-Rex Runner game', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_URL_ABOUT_BLANK),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onLoadStop: (controller, url) {
            pageLoaded.complete();
          },
        ),
      ),
    );

    await controllerCompleter.future;
    await pageLoaded.future;

    var html = await AqutterWebViewController.tRexRunnerHtml;
    var css = await AqutterWebViewController.tRexRunnerCss;

    expect(html, isNotNull);
    expect(css, isNotNull);
  }, skip: shouldSkip);
}
