part of 'main.dart';

void pageDownUp() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.pageDown,
  );

  skippableTestWidgets('pageDown/pageUp', (WidgetTester tester) async {
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
    await tester.pump();
    await Future.delayed(Duration(seconds: 1));
    expect(await controller.pageDown(bottom: false), true);
    await Future.delayed(Duration(seconds: 1));
    expect(await controller.pageUp(top: false), true);
  }, skip: shouldSkip);
}
