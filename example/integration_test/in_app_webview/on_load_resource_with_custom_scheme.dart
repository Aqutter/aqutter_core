part of 'main.dart';

void onLoadResourceWithCustomScheme() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onLoadResourceWithCustomScheme,
  );

  skippableTestWidgets('onLoadResourceWithCustomScheme', (
    WidgetTester tester,
  ) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> imageLoaded = Completer<void>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialFile:
              "test_assets/in_app_webview_on_load_resource_custom_scheme_test.html",
          initialSettings: AqutterWebViewSettings(
            clearCache: true,
            resourceCustomSchemes: ["my-special-custom-scheme"],
          ),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);

            controller.addJavaScriptHandler(
              handlerName: "imageLoaded",
              callback: (args) {
                imageLoaded.complete();
              },
            );
          },
          onLoadResourceWithCustomScheme: (controller, request) async {
            if (request.url.scheme == "my-special-custom-scheme") {
              var bytes = await rootBundle.load(
                "test_assets/" +
                    request.url.toString().replaceFirst(
                      "my-special-custom-scheme://",
                      "",
                      0,
                    ),
              );
              var response = AqutterCustomSchemeResponse(
                data: bytes.buffer.asUint8List(),
                contentType: "image/svg+xml",
                contentEncoding: "utf-8",
              );
              return response;
            }
            return null;
          },
        ),
      ),
    );

    await expectLater(imageLoaded.future, completes);
  }, skip: shouldSkip);
}
