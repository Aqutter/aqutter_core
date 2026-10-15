part of 'main.dart';

void loadAssetFile(AqutterLocalhostServer localhostServer) {
  final shouldSkip = kIsWeb || !AqutterWebView.isClassSupported();

  skippableTestWidgets('load asset file', (WidgetTester tester) async {
    expect(localhostServer.isRunning(), true);

    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(
            url: AqutterWebUri('http://localhost:8080/test_assets/index.html'),
          ),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
        ),
      ),
    );
    final AqutterWebViewController controller = await controllerCompleter.future;
    final String? currentUrl = (await controller.getUrl())?.toString();
    expect(currentUrl, 'http://localhost:8080/test_assets/index.html');
  }, skip: shouldSkip);
}
