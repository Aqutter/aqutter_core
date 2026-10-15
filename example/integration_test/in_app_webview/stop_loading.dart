part of 'main.dart';

void stopLoading() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.stopLoading,
  );

  skippableTestWidgets('stopLoading', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
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
            controller.stopLoading();
          },
          onLoadStop: (controller, url) {
            pageLoaded.complete();
          },
        ),
      ),
    );

    final AqutterWebViewController controller = await controllerCompleter.future;

    if (defaultTargetPlatform == TargetPlatform.android) {
      await pageLoaded.future;
      expect(
        await controller.evaluateJavascript(source: "document.body"),
        isNullOrEmpty,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      expect(pageLoaded.future, doesNotComplete);
    }
  }, skip: shouldSkip);
}
