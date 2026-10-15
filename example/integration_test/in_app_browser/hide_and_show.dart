part of 'main.dart';

void hideAndShow() {
  final shouldSkip = !AqutterBrowser.isClassSupported();

  skippableTest('hide and show', () async {
    var browser = new AqutterMyBrowser();
    await browser.openUrlRequest(
      urlRequest: AqutterURLRequest(url: TEST_URL_1),
      settings: AqutterBrowserClassSettings(
        browserSettings: AqutterBrowserSettings(hidden: true),
      ),
    );
    await browser.browserCreated.future;
    await browser.firstPageLoaded.future;

    expect(await browser.isHidden(), true);
    await expectLater(browser.show(), completes);
    expect(await browser.isHidden(), false);
    await expectLater(browser.hide(), completes);
    expect(await browser.isHidden(), true);

    await expectLater(browser.close(), completes);
  }, skip: shouldSkip);
}
