part of 'main.dart';

void openUrlAndClose() {
  final shouldSkip = !AqutterBrowser.isClassSupported();

  skippableTest('open url and close', () async {
    var browser = new AqutterMyBrowser();
    expect(browser.isOpened(), false);
    expect(() async {
      await browser.show();
    }, throwsAssertionError);

    await browser.openUrlRequest(urlRequest: AqutterURLRequest(url: TEST_URL_1));
    await browser.browserCreated.future;
    expect(browser.isOpened(), true);
    expect(() async {
      await browser.openUrlRequest(
        urlRequest: AqutterURLRequest(url: TEST_CROSS_PLATFORM_URL_1),
      );
    }, throwsAssertionError);

    await browser.firstPageLoaded.future;
    var controller = browser.webViewController;

    expect(controller, isNotNull);
    final String? url = (await controller!.getUrl())?.toString();
    expect(url, TEST_URL_1.toString());

    await browser.close();
    await browser.browserClosed.future;
    expect(browser.isOpened(), false);
    expect(browser.webViewController, isNull);
  }, skip: shouldSkip);
}
