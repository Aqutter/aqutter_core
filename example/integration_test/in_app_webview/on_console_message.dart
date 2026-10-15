part of 'main.dart';

void onConsoleMessage() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onConsoleMessage,
  );

  skippableTestWidgets('onConsoleMessage', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<AqutterConsoleMessage> onConsoleMessageCompleter =
        Completer<AqutterConsoleMessage>();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialFile: !kIsWeb
              ? "test_assets/in_app_webview_on_console_message_test.html"
              : null,
          initialUrlRequest: kIsWeb
              ? AqutterURLRequest(url: TEST_WEB_PLATFORM_URL_1)
              : null,
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onConsoleMessage: (controller, consoleMessage) {
            onConsoleMessageCompleter.complete(consoleMessage);
          },
        ),
      ),
    );
    await tester.pump();
    final AqutterConsoleMessage consoleMessage =
        await onConsoleMessageCompleter.future;
    expect(consoleMessage.message, 'message');
    expect(consoleMessage.messageLevel, AqutterConsoleMessageLevel.LOG);
  }, skip: shouldSkip);
}
