part of 'main.dart';

void webViewAssetLoader() {
  final shouldSkip = !AqutterWebViewSettings.isPropertySupported(
    AqutterWebViewSettingsProperty.webViewAssetLoader,
  );

  skippableTestWidgets('AqutterWebViewAssetLoader', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<String> pageLoaded = Completer<String>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_WEBVIEW_ASSET_LOADER_URL),
          initialSettings: AqutterWebViewSettings(
            allowFileAccessFromFileURLs: false,
            allowUniversalAccessFromFileURLs: false,
            allowFileAccess: false,
            allowContentAccess: false,
            webViewAssetLoader: AqutterWebViewAssetLoader(
              domain: TEST_WEBVIEW_ASSET_LOADER_DOMAIN,
              pathHandlers: [AqutterAssetsPathHandler(path: '/assets/')],
            ),
          ),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onLoadStop: (controller, url) {
            pageLoaded.complete(url.toString());
          },
        ),
      ),
    );

    final AqutterWebViewController controller = await controllerCompleter.future;
    final url = await pageLoaded.future;

    expect(url, TEST_WEBVIEW_ASSET_LOADER_URL.toString());

    expect(
      await controller.evaluateJavascript(
        source: "document.querySelector('h1').innerHTML",
      ),
      'AqutterWebViewAssetLoader',
    );
  }, skip: shouldSkip);
}
