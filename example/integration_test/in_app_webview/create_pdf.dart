part of 'main.dart';

void createPdf() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.createPdf,
  );

  skippableTestWidgets('createPdf', (WidgetTester tester) async {
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

    var pdfConfiguration = AqutterPDFConfiguration(
      rect: AqutterWebViewRect(width: 100, height: 100, x: 50, y: 50),
    );
    var pdf = await controller.createPdf(pdfConfiguration: pdfConfiguration);
    expect(pdf, isNotNull);
  }, skip: shouldSkip);
}
