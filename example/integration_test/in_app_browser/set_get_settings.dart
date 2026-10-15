part of 'main.dart';

void setGetSettings() {
  final shouldSkip = !AqutterBrowser.isClassSupported();

  skippableTest('set/get settings', () async {
    var browser = new AqutterMyBrowser();
    await browser.openUrlRequest(
      urlRequest: AqutterURLRequest(url: TEST_URL_1),
      settings: AqutterBrowserClassSettings(
        browserSettings: AqutterBrowserSettings(hideToolbarTop: true),
      ),
    );
    await browser.browserCreated.future;
    await browser.firstPageLoaded.future;

    AqutterBrowserClassSettings? settings = await browser.getSettings();
    expect(settings, isNotNull);
    expect(settings!.browserSettings.hideToolbarTop, true);

    await browser.setSettings(
      settings: AqutterBrowserClassSettings(
        browserSettings: AqutterBrowserSettings(hideToolbarTop: false),
      ),
    );

    settings = await browser.getSettings();
    expect(settings, isNotNull);
    expect(settings!.browserSettings.hideToolbarTop, false);

    await expectLater(browser.close(), completes);
  }, skip: shouldSkip);
}
