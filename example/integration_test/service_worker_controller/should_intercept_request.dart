part of 'main.dart';

void shouldInterceptRequest() {
  final shouldSkip = !AqutterServiceWorkerController.isMethodSupported(
    AqutterPlatformServiceWorkerControllerMethod.setServiceWorkerClient,
  );

  skippableTestWidgets('shouldInterceptRequest', (WidgetTester tester) async {
    final Completer completer = Completer();

    var swAvailable = await AqutterWebViewFeature.isFeatureSupported(
      AqutterWebViewFeature.SERVICE_WORKER_BASIC_USAGE,
    );
    var swInterceptAvailable = await AqutterWebViewFeature.isFeatureSupported(
      AqutterWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST,
    );

    if (swAvailable && swInterceptAvailable) {
      AqutterServiceWorkerController serviceWorkerController =
          AqutterServiceWorkerController.instance();

      await serviceWorkerController.setServiceWorkerClient(
        AqutterServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            if (!completer.isCompleted) {
              completer.complete();
            }
            return null;
          },
        ),
      );
    } else {
      completer.complete();
    }

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_SERVICE_WORKER_URL),
        ),
      ),
    );

    await expectLater(completer.future, completes);
  }, skip: shouldSkip);
}
