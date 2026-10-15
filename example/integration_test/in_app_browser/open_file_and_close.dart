part of 'main.dart';

void openFileAndClose() {
  final shouldSkip = !AqutterBrowser.isClassSupported();

  skippableTest('open file and close', () async {
    var browser = new AqutterMyBrowser();
    expect(browser.isOpened(), false);
    expect(() async {
      await browser.show();
    }, throwsAssertionError);

    await browser.openFile(
      assetFilePath: "test_assets/in_app_webview_initial_file_test.html",
    );
    await browser.browserCreated.future;
    expect(browser.isOpened(), true);
    expect(() async {
      await browser.openUrlRequest(
        urlRequest: AqutterURLRequest(url: TEST_URL_1),
      );
    }, throwsAssertionError);

    await browser.firstPageLoaded.future;
    var controller = browser.webViewController;

    expect(controller, isNotNull);
    final String? url = (await controller!.getUrl())?.toString();
    expect(url, endsWith("in_app_webview_initial_file_test.html"));

    await browser.close();
    await browser.browserClosed.future;
    expect(browser.isOpened(), false);
    expect(browser.webViewController, isNull);
  }, skip: shouldSkip);
}
