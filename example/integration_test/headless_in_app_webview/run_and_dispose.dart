part of 'main.dart';

void runAndDispose() {
  final shouldSkip = !AqutterHeadlessWebView.isMethodSupported(
    AqutterPlatformHeadlessWebViewMethod.run,
  );

  skippableTest('run and dispose', () async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();

    var headlessWebView = new AqutterHeadlessWebView(
      initialUrlRequest: AqutterURLRequest(url: TEST_CROSS_PLATFORM_URL_1),
      onWebViewCreated: (controller) {
        controllerCompleter.complete(controller);
      },
      onLoadStop: (controller, url) async {
        pageLoaded.complete();
      },
    );

    await headlessWebView.run();
    expect(headlessWebView.isRunning(), true);

    final AqutterWebViewController controller = await controllerCompleter.future;
    await pageLoaded.future;

    final String? url = (await controller.getUrl())?.toString();
    expect(url, TEST_CROSS_PLATFORM_URL_1.toString());

    await headlessWebView.dispose();

    expect(headlessWebView.isRunning(), false);
  }, skip: shouldSkip);
}
