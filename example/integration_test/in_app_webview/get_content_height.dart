part of 'main.dart';

void getContentHeight() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.getContentHeight,
  );

  var url = !kIsWeb ? TEST_CROSS_PLATFORM_URL_1 : TEST_WEB_PLATFORM_URL_1;

  skippableTestWidgets('getContentHeight', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();

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
            pageLoaded.complete();
          },
        ),
      ),
    );

    final AqutterWebViewController controller = await controllerCompleter.future;
    await tester.pump();
    await pageLoaded.future;

    final contentHeight = await controller.getContentHeight();
    expect(contentHeight, isNonZero);
    expect(contentHeight, isPositive);
  }, skip: shouldSkip);
}
