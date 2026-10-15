part of 'main.dart';

void openDataAndClose() {
  final shouldSkip = !AqutterBrowser.isClassSupported();

  skippableTest('open data and close', () async {
    var browser = new AqutterMyBrowser();
    expect(browser.isOpened(), false);
    expect(() async {
      await browser.show();
    }, throwsAssertionError);

    await browser.openData(
      data: """
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="https://getbootstrap.com/docs/4.3/dist/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    </head>
    <body>
      <img src="https://via.placeholder.com/100x50" alt="placeholder 100x50">
    </body>
</html>
""",
      encoding: 'utf-8',
      mimeType: 'text/html',
      historyUrl: TEST_CROSS_PLATFORM_URL_1,
      baseUrl: TEST_CROSS_PLATFORM_URL_1,
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
    expect(url, TEST_CROSS_PLATFORM_URL_1.toString());

    await browser.close();
    await browser.browserClosed.future;
    expect(browser.isOpened(), false);
    expect(browser.webViewController, isNull);
  }, skip: shouldSkip);
}
