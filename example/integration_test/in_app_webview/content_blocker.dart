part of 'main.dart';

void contentBlocker() {
  final shouldSkip = !AqutterWebViewSettings.isPropertySupported(
    AqutterWebViewSettingsProperty.contentBlockers,
  );

  skippableTestWidgets('Content Blocker', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_CROSS_PLATFORM_URL_1),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          initialSettings: AqutterWebViewSettings(
            clearCache: true,
            contentBlockers: [
              AqutterContentBlocker(
                trigger: AqutterContentBlockerTrigger(
                  urlFilter: ".*",
                  resourceType: [
                    AqutterContentBlockerTriggerResourceType.IMAGE,
                    AqutterContentBlockerTriggerResourceType.STYLE_SHEET,
                  ],
                  ifTopUrl: [TEST_CROSS_PLATFORM_URL_1.toString()],
                ),
                action: AqutterContentBlockerAction(
                  type: AqutterContentBlockerActionType.BLOCK,
                ),
              ),
            ],
          ),
          onLoadStop: (controller, url) {
            pageLoaded.complete();
          },
        ),
      ),
    );
    await expectLater(pageLoaded.future, completes);
  }, skip: shouldSkip);
}
