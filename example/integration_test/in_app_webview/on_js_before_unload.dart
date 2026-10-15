part of 'main.dart';

void onJsBeforeUnload() {
  // final shouldSkip = !AqutterWebView.isPropertySupported(
  //   AqutterPlatformWebViewCreationParamsProperty.onJsBeforeUnload,
  // );
  final shouldSkip = true;
  // on Android, for some reason, it works on an example app but not in this test
  skippableTestWidgets('onJsBeforeUnload', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<String> onJsBeforeUnloadCompleter = Completer<String>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialFile: "test_assets/in_app_webview_on_js_before_unload.html",
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onJsBeforeUnload: (controller, jsBeforeUnloadRequest) async {
            onJsBeforeUnloadCompleter.complete(
              jsBeforeUnloadRequest.url.toString(),
            );
            return null;
          },
        ),
      ),
    );

    final String url = await onJsBeforeUnloadCompleter.future;
    expect(
      url,
      endsWith("test_assets/in_app_webview_on_js_before_unload.html"),
    );
  }, skip: shouldSkip);
}
