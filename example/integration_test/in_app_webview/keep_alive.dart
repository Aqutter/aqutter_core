part of 'main.dart';

void keepAlive() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewWidgetCreationParamsProperty.keepAlive,
  );

  final initialUrl = !kIsWeb
      ? TEST_CROSS_PLATFORM_URL_1
      : TEST_WEB_PLATFORM_URL_1;

  skippableTestWidgets('Keep Alive', (WidgetTester tester) async {
    final keepAlive = AqutterWebViewKeepAlive();

    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<AqutterWebViewController> controllerCompleter2 =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();
    final Completer<void> pageLoaded2 = Completer<void>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          keepAlive: keepAlive,
          initialUrlRequest: AqutterURLRequest(url: initialUrl),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onLoadStop: (controller, url) {
            if (!pageLoaded.isCompleted &&
                initialUrl.toString() == url.toString()) {
              pageLoaded.complete();
            }
            if (!pageLoaded2.isCompleted &&
                TEST_CROSS_PLATFORM_URL_2.toString() == url.toString()) {
              pageLoaded2.complete();
            }
          },
        ),
      ),
    );

    final AqutterWebViewController controller = await controllerCompleter.future;
    await pageLoaded.future;

    await controller.loadUrl(
      urlRequest: AqutterURLRequest(url: TEST_CROSS_PLATFORM_URL_2),
    );
    await pageLoaded2.future;

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          keepAlive: keepAlive,
          onWebViewCreated: (controller) {
            controllerCompleter2.complete(controller);
          },
        ),
      ),
    );
    final AqutterWebViewController controller2 =
        await controllerCompleter2.future;

    final String? currentUrl = (await controller2.getUrl())?.toString();
    expect(currentUrl, TEST_CROSS_PLATFORM_URL_2.toString());

    await expectLater(
      AqutterWebViewController.disposeKeepAlive(keepAlive),
      completes,
    );
  }, skip: shouldSkip);
}
