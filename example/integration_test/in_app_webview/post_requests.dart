part of 'main.dart';

void postRequests() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.postUrl,
  );

  skippableGroup('POST requests', () {
    skippableTestWidgets('initialUrlRequest', (WidgetTester tester) async {
      final Completer<AqutterWebViewController> controllerCompleter =
          Completer<AqutterWebViewController>();
      final Completer<void> postPageLoaded = Completer<void>();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(
              url: AqutterWebUri(
                "http://${environment["NODE_SERVER_IP"]}:8082/test-post",
              ),
              method: 'POST',
              body: Uint8List.fromList(utf8.encode("name=FooBar")),
              headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            ),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            onLoadStop: (controller, url) {
              postPageLoaded.complete();
            },
          ),
        ),
      );

      final AqutterWebViewController controller =
          await controllerCompleter.future;
      await postPageLoaded.future;

      final String? currentUrl = (await controller.getUrl())?.toString();
      expect(
        currentUrl,
        'http://${environment["NODE_SERVER_IP"]}:8082/test-post',
      );

      final String? pContent = await controller.evaluateJavascript(
        source: "document.querySelector('p').innerHTML;",
      );
      expect(pContent, "HELLO FooBar!");
    });

    skippableTestWidgets('loadUrl', (WidgetTester tester) async {
      final Completer<AqutterWebViewController> controllerCompleter =
          Completer<AqutterWebViewController>();
      final Completer<void> postPageLoaded = Completer<void>();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(url: AqutterWebUri('about:blank')),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            onLoadStop: (controller, url) {
              if (url?.scheme != "about") {
                postPageLoaded.complete();
              }
            },
          ),
        ),
      );

      final AqutterWebViewController controller =
          await controllerCompleter.future;

      var postData = Uint8List.fromList(utf8.encode("name=FooBar"));
      await controller.loadUrl(
        urlRequest: AqutterURLRequest(
          url: AqutterWebUri("http://${environment["NODE_SERVER_IP"]}:8082/test-post"),
          method: 'POST',
          body: postData,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      await postPageLoaded.future;

      final String? currentUrl = (await controller.getUrl())?.toString();
      expect(
        currentUrl,
        'http://${environment["NODE_SERVER_IP"]}:8082/test-post',
      );

      final String? pContent = await controller.evaluateJavascript(
        source: "document.querySelector('p').innerHTML;",
      );
      expect(pContent, "HELLO FooBar!");
    });

    skippableTestWidgets('postUrl', (WidgetTester tester) async {
      final Completer<AqutterWebViewController> controllerCompleter =
          Completer<AqutterWebViewController>();
      final Completer<void> postPageLoaded = Completer<void>();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(url: AqutterWebUri('about:blank')),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            onLoadStop: (controller, url) {
              if (url?.scheme != "about") {
                postPageLoaded.complete();
              }
            },
          ),
        ),
      );

      final AqutterWebViewController controller =
          await controllerCompleter.future;

      var postData = Uint8List.fromList(utf8.encode("name=FooBar"));
      await controller.postUrl(
        url: AqutterWebUri("http://${environment["NODE_SERVER_IP"]}:8082/test-post"),
        postData: postData,
      );

      await postPageLoaded.future;

      final String? currentUrl = (await controller.getUrl())?.toString();
      expect(
        currentUrl,
        'http://${environment["NODE_SERVER_IP"]}:8082/test-post',
      );

      final String? pContent = await controller.evaluateJavascript(
        source: "document.querySelector('p').innerHTML;",
      );
      expect(pContent, "HELLO FooBar!");
    });
  }, skip: shouldSkip);
}
