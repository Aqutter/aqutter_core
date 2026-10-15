part of 'main.dart';

void pullToRefresh() {
  final shouldSkip = !AqutterPullToRefreshController.isClassSupported();

  skippableTestWidgets('launches with pull-to-refresh feature', (
    WidgetTester tester,
  ) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final pullToRefreshController = AqutterPullToRefreshController(
      settings: AqutterPullToRefreshSettings(
        color: Colors.blue,
        size: AqutterPullToRefreshSize.DEFAULT,
        backgroundColor: Colors.grey,
        enabled: true,
        slingshotDistance: 150,
        distanceToTriggerSync: 150,
        attributedTitle: AqutterAttributedString(string: "test"),
      ),
      onRefresh: () {},
    );

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_URL_1),
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
        ),
      ),
    );
    final AqutterWebViewController controller = await controllerCompleter.future;
    final String? currentUrl = (await controller.getUrl())?.toString();
    expect(currentUrl, TEST_URL_1.toString());
  }, skip: shouldSkip);
}
