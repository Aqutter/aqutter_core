part of 'main.dart';

void pauseResumeTimers() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.pauseTimers,
  );

  skippableTestWidgets('pause/resume timers', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_URL_ABOUT_BLANK),
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

    await controller.evaluateJavascript(
      source: """
      var count = 0;
      setInterval(function() {
        count = count + 10;
      }, 20);
      """,
    );

    await controller.pauseTimers();
    await Future.delayed(Duration(seconds: 2));
    await controller.resumeTimers();
    expect(await controller.evaluateJavascript(source: "count;"), lessThan(50));
    await Future.delayed(Duration(seconds: 4));
    expect(
      await controller.evaluateJavascript(source: "count;"),
      greaterThan(50),
    );
  }, skip: shouldSkip);
}
