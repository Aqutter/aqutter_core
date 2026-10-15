part of 'main.dart';

void onReceivedError() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onReceivedError,
  );

  skippableGroup('onReceivedError', () {
    skippableTestWidgets('invalid url', (WidgetTester tester) async {
      final Completer<String> errorUrlCompleter = Completer<String>();
      final Completer<AqutterWebResourceErrorType> errorCodeCompleter =
          Completer<AqutterWebResourceErrorType>();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(url: TEST_NOT_A_WEBSITE_URL),
            onReceivedError: (controller, request, error) {
              errorUrlCompleter.complete(request.url.toString());
              errorCodeCompleter.complete(error.type);
            },
          ),
        ),
      );

      final String url = await errorUrlCompleter.future;
      final AqutterWebResourceErrorType errorType = await errorCodeCompleter.future;

      expect(errorType, AqutterWebResourceErrorType.HOST_LOOKUP);
      expect(url, TEST_NOT_A_WEBSITE_URL.toString());
    });

    skippableTestWidgets('event is not called with valid url', (
      WidgetTester tester,
    ) async {
      final Completer<void> onReceivedErrorCompleter = Completer<void>();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(
              url: AqutterWebUri(
                'data:text/html;charset=utf-8;base64,PCFET0NUWVBFIGh0bWw+',
              ),
            ),
            onReceivedError: (controller, request, error) {
              onReceivedErrorCompleter.complete();
            },
          ),
        ),
      );

      expect(onReceivedErrorCompleter.future, doesNotComplete);
    });
  }, skip: shouldSkip);
}
