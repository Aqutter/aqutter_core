part of 'main.dart';

void isLoading() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.isLoading,
  );

  skippableTestWidgets('isLoading', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageStarted = Completer<void>();
    final Completer<void> pageLoaded = Completer<void>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_CROSS_PLATFORM_URL_1),
          initialSettings: AqutterWebViewSettings(clearCache: true),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onLoadStart: (controller, url) {
            pageStarted.complete();
          },
          onLoadStop: (controller, url) {
            pageLoaded.complete();
          },
        ),
      ),
    );

    final AqutterWebViewController controller = await controllerCompleter.future;
    await pageStarted.future;
    expect(await controller.isLoading(), true);

    await pageLoaded.future;
    expect(await controller.isLoading(), false);
  }, skip: shouldSkip);
}
