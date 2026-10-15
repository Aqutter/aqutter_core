part of 'main.dart';

void pauseResume() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.pause,
  );

  skippableTestWidgets('pause/resume', (WidgetTester tester) async {
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
    await expectLater(controller.pause(), completes);
    await Future.delayed(Duration(seconds: 1));
    await expectLater(controller.resume(), completes);
  }, skip: shouldSkip);
}
