part of 'main.dart';

void customMenuItems() {
  final shouldSkip = !AqutterBrowser.isClassSupported();

  skippableTest('custom menu items', () async {
    var browser = new AqutterMyBrowser();

    final data = (await rootBundle.load(
      'test_assets/images/flutter-logo.png',
    )).buffer.asUint8List();

    browser.addMenuItem(
      AqutterBrowserMenuItem(
        id: 0,
        title: 'Menu Item 0',
        iconColor: Colors.black,
        order: 0,
        onClick: () {
          browser.webViewController?.reload();
        },
      ),
    );
    browser.addMenuItem(
      AqutterBrowserMenuItem(
        id: 1,
        title: 'Menu Item 1',
        icon: data,
        showAsAction: true,
        order: 2,
        onClick: () {
          browser.webViewController?.reload();
        },
      ),
    );

    var icon = null;
    if ([
      TargetPlatform.iOS,
      TargetPlatform.macOS,
    ].contains(defaultTargetPlatform)) {
      icon = AqutterUIImage(systemName: 'ellipsis.circle');
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      icon = AqutterAndroidResource.drawable(
        name: 'ic_menu_edit',
        defPackage: 'android',
      );
    }
    browser.addMenuItem(
      AqutterBrowserMenuItem(
        id: 2,
        title: 'Menu Item 2',
        icon: icon,
        iconColor: Colors.red,
        showAsAction: true,
        order: 1,
        onClick: () {
          browser.webViewController?.reload();
        },
      ),
    );

    await browser.openUrlRequest(
      urlRequest: AqutterURLRequest(url: TEST_URL_1),
      settings: AqutterBrowserClassSettings(
        browserSettings: AqutterBrowserSettings(hideDefaultMenuItems: true),
      ),
    );
    await browser.browserCreated.future;
    await browser.firstPageLoaded.future;

    await expectLater(browser.close(), completes);
  }, skip: shouldSkip);
}
