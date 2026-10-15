part of 'main.dart';

void onDownloadStarting() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onDownloadStarting,
  );

  skippableTestWidgets('onDownloadStarting', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<String> onDownloadStartCompleter = Completer<String>();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialData: AqutterWebViewInitialData(
            data:
                """
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>AqutterWebViewOnDownloadStartTest</title>
    </head>
    <body>
        <h1>AqutterWebViewOnDownloadStartTest</h1>
        <a id="download-file" href="http://${environment["NODE_SERVER_IP"]}:8082/test-download-file">download file</a>
        <script>
            window.addEventListener("aqutterPlatformReady", function(event) {
                document.querySelector("#download-file").click();
            });
        </script>
    </body>
</html>
          """,
          ),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onDownloadStarting: (controller, request) {
            onDownloadStartCompleter.complete(request.url.toString());
            return null;
          },
        ),
      ),
    );

    final String url = await onDownloadStartCompleter.future;
    expect(
      url,
      "http://${environment["NODE_SERVER_IP"]}:8082/test-download-file",
    );
  }, skip: shouldSkip);
}
