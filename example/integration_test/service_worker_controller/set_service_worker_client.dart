part of 'main.dart';

void setServiceWorkerClient() {
  final shouldSkip = !AqutterServiceWorkerController.isMethodSupported(
    AqutterPlatformServiceWorkerControllerMethod.setServiceWorkerClient,
  );

  skippableTestWidgets('setServiceWorkerClient to null', (
    WidgetTester tester,
  ) async {
    final Completer<String> pageLoaded = Completer<String>();

    var swAvailable = await AqutterWebViewFeature.isFeatureSupported(
      AqutterWebViewFeature.SERVICE_WORKER_BASIC_USAGE,
    );
    var swInterceptAvailable = await AqutterWebViewFeature.isFeatureSupported(
      AqutterWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST,
    );

    if (swAvailable && swInterceptAvailable) {
      AqutterServiceWorkerController serviceWorkerController =
          AqutterServiceWorkerController.instance();

      await serviceWorkerController.setServiceWorkerClient(null);
    }

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_SERVICE_WORKER_URL),
          onLoadStop: (controller, url) {
            pageLoaded.complete(url!.toString());
          },
        ),
      ),
    );

    final String url = await pageLoaded.future;
    expect(url, TEST_SERVICE_WORKER_URL.toString());
  }, skip: shouldSkip);
}
