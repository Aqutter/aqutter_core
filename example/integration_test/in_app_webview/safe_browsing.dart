part of 'main.dart';

void safeBrowsing() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onSafeBrowsingHit,
  );

  skippableGroup('safe browsing', () {
    skippableTestWidgets('onSafeBrowsingHit', (WidgetTester tester) async {
      final Completer<String> pageLoaded = Completer<String>();
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(
              url: TEST_CHROME_SAFE_BROWSING_MALWARE,
            ),
            initialSettings: AqutterWebViewSettings(
              // if I set javaScriptEnabled to true, it will crash!
              javaScriptEnabled: false,
              clearCache: true,
              safeBrowsingEnabled: true,
            ),
            onWebViewCreated: (controller) {
              controller.startSafeBrowsing();
            },
            onLoadStop: (controller, url) {
              pageLoaded.complete(url!.toString());
            },
            onSafeBrowsingHit: (controller, url, threatType) async {
              return AqutterSafeBrowsingResponse(
                report: true,
                action: AqutterSafeBrowsingResponseAction.PROCEED,
              );
            },
          ),
        ),
      );

      final String url = await pageLoaded.future;
      expect(url, TEST_CHROME_SAFE_BROWSING_MALWARE.toString());
    });

    skippableTest('getSafeBrowsingPrivacyPolicyUrl', () async {
      expect(
        await AqutterWebViewController.getSafeBrowsingPrivacyPolicyUrl(),
        isNotNull,
      );
    });

    skippableTest('setSafeBrowsingWhitelist', () async {
      expect(
        await AqutterWebViewController.setSafeBrowsingAllowlist(
          hosts: ["flutter.dev", "github.com"],
        ),
        true,
      );
    });
  }, skip: shouldSkip);
}
