part of 'main.dart';

void takeScreenshot() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.takeScreenshot,
  );

  skippableTestWidgets('takeScreenshot', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_CROSS_PLATFORM_URL_1),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onLoadStop: (controller, url) {
            pageLoaded.complete();
          },
        ),
      ),
    );

    final AqutterWebViewController controller = await controllerCompleter.future;
    await pageLoaded.future;

    await Future.delayed(Duration(seconds: 1));
    await tester.pump();

    var screenshotConfiguration = AqutterScreenshotConfiguration(
      compressFormat: AqutterCompressFormat.JPEG,
      quality: 20,
      rect: AqutterWebViewRect(width: 100, height: 100, x: 50, y: 50),
    );
    var screenshot = await controller.takeScreenshot(
      screenshotConfiguration: screenshotConfiguration,
    );
    expect(screenshot, isNotNull);
  }, skip: shouldSkip);
}
