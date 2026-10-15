part of 'main.dart';

void reload() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.reload,
  );

  var url = !kIsWeb ? TEST_URL_1 : TEST_WEB_PLATFORM_URL_1;

  skippableGroup('reload', () {
    final shouldSkipTest1 = !AqutterWebViewController.isMethodSupported(
      AqutterPlatformWebViewControllerMethod.reloadFromOrigin,
    );

    skippableTestWidgets('from origin', (WidgetTester tester) async {
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
              if (!pageLoaded.isCompleted) {
                pageLoaded.complete();
              }
            },
          ),
        ),
      );

      final AqutterWebViewController controller =
          await controllerCompleter.future;
      await pageLoaded.future;
      await expectLater(controller.reloadFromOrigin(), completes);
    }, skip: shouldSkipTest1);

    skippableTestWidgets('basic', (WidgetTester tester) async {
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
      final AqutterWebViewController controller =
          await controllerCompleter.future;
      // do not wait for pump to not miss the load event
      tester.pump();
      String? reloadUrl = await pageLoads.stream.first;
      expect(reloadUrl, url.toString());

      await controller.reload();
      reloadUrl = await pageLoads.stream.first;
      expect(reloadUrl, url.toString());

      pageLoads.close();
    });
  }, skip: shouldSkip);
}
