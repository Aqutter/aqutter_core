part of 'main.dart';

void programmaticZoomScale() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onZoomScaleChanged,
  );

  skippableGroup('programmatic zoom scale', () {
    final shouldSkipTest1 = !AqutterWebViewController.isMethodSupported(
      AqutterPlatformWebViewControllerMethod.zoomIn,
    );

    skippableTestWidgets('zoomIn/zoomOut', (WidgetTester tester) async {
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

      final AqutterWebViewController controller =
          await controllerCompleter.future;
      await pageLoaded.future;
      expect(await controller.zoomIn(), true);
      await Future.delayed(Duration(seconds: 1));
      expect(await controller.zoomOut(), true);
    }, skip: shouldSkipTest1);

    skippableTestWidgets('onZoomScaleChanged', (WidgetTester tester) async {
      final Completer<AqutterWebViewController> controllerCompleter =
          Completer<AqutterWebViewController>();
      final Completer<void> pageLoaded = Completer<void>();
      final Completer<void> onZoomScaleChangedCompleter = Completer<void>();

      var listenForScaleChange = false;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(url: TEST_URL_1),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            onLoadStop: (controller, url) {
              if (!pageLoaded.isCompleted) {
                pageLoaded.complete();
              }
            },
            onZoomScaleChanged: (controller, oldScale, newScale) {
              if (listenForScaleChange) {
                onZoomScaleChangedCompleter.complete();
              }
            },
          ),
        ),
      );

      final AqutterWebViewController controller =
          await controllerCompleter.future;
      await pageLoaded.future;
      listenForScaleChange = true;

      await controller.zoomBy(zoomFactor: 2);

      await expectLater(onZoomScaleChangedCompleter.future, completes);
    });

    skippableTestWidgets('zoomBy', (WidgetTester tester) async {
      final Completer<AqutterWebViewController> controllerCompleter =
          Completer<AqutterWebViewController>();
      final Completer<void> pageLoaded = Completer<void>();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(url: AqutterWebUri('https://flutter.dev')),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            onLoadStop: (controller, url) {
              pageLoaded.complete();
            },
          ),
        ),
      );

      final AqutterWebViewController controller =
          await controllerCompleter.future;
      await pageLoaded.future;

      await expectLater(
        controller.zoomBy(zoomFactor: 3.0, animated: true),
        completes,
      );
    });

    skippableTestWidgets('getZoomScale', (WidgetTester tester) async {
      final Completer<AqutterWebViewController> controllerCompleter =
          Completer<AqutterWebViewController>();
      final Completer<void> pageLoaded = Completer<void>();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(url: AqutterWebUri('https://flutter.dev')),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            onLoadStop: (controller, url) {
              pageLoaded.complete();
            },
          ),
        ),
      );

      final AqutterWebViewController controller =
          await controllerCompleter.future;
      await pageLoaded.future;

      final scale = await controller.getZoomScale();
      expect(scale, isNonZero);
      expect(scale, isPositive);
    });
  }, skip: shouldSkip);
}
