part of 'main.dart';

void isSecureContext() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.isSecureContext,
  );

  var url = !kIsWeb ? TEST_CROSS_PLATFORM_URL_1 : TEST_WEB_PLATFORM_URL_1;

  skippableTestWidgets('isSecureContext', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final StreamController<String> pageLoads =
        StreamController<String>.broadcast();

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
            pageLoads.add(url!.toString());
          },
        ),
      ),
    );

    final AqutterWebViewController controller = await controllerCompleter.future;
    await tester.pump();
    await pageLoads.stream.first;
    expect(await controller.isSecureContext(), true);

    if (!kIsWeb) {
      await controller.loadUrl(
        urlRequest: AqutterURLRequest(url: AqutterWebUri('http://example.com/')),
      );
      await pageLoads.stream.first;
      expect(await controller.isSecureContext(), false);
    }

    pageLoads.close();
  }, skip: shouldSkip);
}
