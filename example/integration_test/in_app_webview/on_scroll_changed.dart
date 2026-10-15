part of 'main.dart';

void onScrollChanged() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onScrollChanged,
  );

  var url = !kIsWeb ? TEST_URL_1 : TEST_WEB_PLATFORM_URL_1;

  skippableTestWidgets('onScrollChanged', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();
    final Completer<void> onScrollChangedCompleter = Completer<void>();
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
          onScrollChanged: (controller, x, y) {
            if (x == 0 && y == 500) {
              onScrollChangedCompleter.complete();
            }
          },
        ),
      ),
    );

    final AqutterWebViewController controller = await controllerCompleter.future;
    await tester.pump();
    await pageLoaded.future;

    controller.scrollTo(x: 0, y: 500);

    await expectLater(onScrollChangedCompleter.future, completes);
  }, skip: shouldSkip);
}
