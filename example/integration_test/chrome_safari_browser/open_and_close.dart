part of 'main.dart';

void openAndClose() {
  final shouldSkip = !AqutterChromeSafariBrowser.isMethodSupported(
    AqutterPlatformChromeSafariBrowserMethod.open,
  );

  skippableTest('open and close', () async {
    var chromeSafariBrowser = MyChromeSafariBrowser();
    expect(chromeSafariBrowser.isOpened(), false);

    await chromeSafariBrowser.open(
      url: TEST_URL_1,
      settings: AqutterChromeSafariBrowserSettings(
        shareState: AqutterCustomTabsShareState.SHARE_STATE_OFF,
        startAnimations: [
          AqutterAndroidResource.anim(name: "slide_in_left", defPackage: "android"),
          AqutterAndroidResource.anim(name: "slide_out_right", defPackage: "android"),
        ],
        exitAnimations: [
          AqutterAndroidResource.anim(
            name: "abc_slide_in_top",
            defPackage: "com.pichillilorenzo.flutter_inappwebviewexample",
          ),
          AqutterAndroidResource.anim(
            name: "abc_slide_out_top",
            defPackage: "com.pichillilorenzo.flutter_inappwebviewexample",
          ),
        ],
        keepAliveEnabled: true,
        dismissButtonStyle: AqutterDismissButtonStyle.CLOSE,
        presentationStyle: AqutterModalPresentationStyle.OVER_FULL_SCREEN,
        eventAttribution: AqutterUIEventAttribution(
          sourceIdentifier: 4,
          destinationURL: AqutterWebUri("https://shop.example/test.html"),
          sourceDescription: "Banner ad for Test.",
          purchaser: "Shop Example, Inc.",
        ),
        activityButton: AqutterActivityButton(
          templateImage: AqutterUIImage(systemName: "sun.max"),
          extensionIdentifier:
              "com.pichillilorenzo.flutterinappwebview-ios-example5.test",
        ),
      ),
    );
    await chromeSafariBrowser.opened.future;
    expect(chromeSafariBrowser.isOpened(), true);
    expect(() async {
      await chromeSafariBrowser.open(url: TEST_CROSS_PLATFORM_URL_1);
    }, throwsAssertionError);

    await expectLater(chromeSafariBrowser.firstPageLoaded.future, completes);
    await chromeSafariBrowser.close();
    await chromeSafariBrowser.closed.future;
    expect(chromeSafariBrowser.isOpened(), false);
  }, skip: shouldSkip);
}
