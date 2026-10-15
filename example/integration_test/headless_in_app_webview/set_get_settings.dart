part of 'main.dart';

void setGetSettings() {
  final shouldSkip = false;

  skippableTest('set/get settings', () async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();

    var headlessWebView = new AqutterHeadlessWebView(
      initialUrlRequest: AqutterURLRequest(url: TEST_CROSS_PLATFORM_URL_1),
      initialSettings: AqutterWebViewSettings(javaScriptEnabled: false),
      onWebViewCreated: (controller) {
        controllerCompleter.complete(controller);
      },
      onLoadStop: (controller, url) async {
        pageLoaded.complete();
      },
    );

    await headlessWebView.run();
    final AqutterWebViewController controller = await controllerCompleter.future;
    await pageLoaded.future;

    var settings = await controller.getSettings();
    expect(settings, isNotNull);
    expect(settings!.javaScriptEnabled, false);

    await controller.setSettings(
      settings: AqutterWebViewSettings(javaScriptEnabled: true),
    );

    settings = await controller.getSettings();
    expect(settings, isNotNull);
    expect(settings!.javaScriptEnabled, true);
  }, skip: shouldSkip);
}
