part of 'main.dart';

void setGetSettings() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.getSettings,
  );

  final url = !kIsWeb ? TEST_CROSS_PLATFORM_URL_1 : TEST_WEB_PLATFORM_URL_1;

  skippableTestWidgets('set/get settings', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: url),
          initialSettings: AqutterWebViewSettings(javaScriptEnabled: false),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onLoadStop: (controller, url) {
            pageLoaded.complete();
          },
        ),
      ),
    );
    // Platform view creation happens asynchronously.
    await tester.pumpAndSettle();
    final AqutterWebViewController controller = await controllerCompleter.future;
    await pageLoaded.future;

    AqutterWebViewSettings? settings = await controller.getSettings();
    expect(settings, isNotNull);
    expect(settings!.javaScriptEnabled, false);

    if (kIsWeb) {
      expect(settings.iframeSandbox, isNotNull);
      expect(settings.iframeSandbox!.contains(AqutterSandbox.ALLOW_SCRIPTS), false);
    }

    await controller.setSettings(
      settings: AqutterWebViewSettings(javaScriptEnabled: true),
    );

    settings = await controller.getSettings();
    expect(settings, isNotNull);
    expect(settings!.javaScriptEnabled, true);

    if (kIsWeb) {
      expect(settings.iframeSandbox, isNotNull);
      expect(settings.iframeSandbox!.contains(AqutterSandbox.ALLOW_SCRIPTS), true);
    }
  }, skip: shouldSkip);
}
