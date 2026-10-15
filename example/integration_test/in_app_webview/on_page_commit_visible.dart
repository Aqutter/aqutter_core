part of 'main.dart';

void onPageCommitVisible() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onPageCommitVisible,
  );

  skippableTestWidgets('onPageCommitVisible', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<String> onPageCommitVisibleCompleter = Completer<String>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_URL_1),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onPageCommitVisible: (controller, url) {
            onPageCommitVisibleCompleter.complete(url?.toString());
          },
        ),
      ),
    );

    final String? url = await onPageCommitVisibleCompleter.future;
    expect(url, TEST_URL_1.toString());
  }, skip: shouldSkip);
}
