part of 'main.dart';

void httpAuthCredentialDatabase() {
  final shouldSkip = !AqutterHttpAuthCredentialDatabase.isClassSupported();

  skippableGroup('Http Auth Credential Database', () {
    skippableTestWidgets('use saved credentials', (WidgetTester tester) async {
      AqutterHttpAuthCredentialDatabase httpAuthCredentialDatabase =
          AqutterHttpAuthCredentialDatabase.instance();
      final Completer<AqutterWebViewController> controllerCompleter =
          Completer<AqutterWebViewController>();
      final Completer<void> pageLoaded = Completer<void>();

      httpAuthCredentialDatabase.setHttpAuthCredential(
        protectionSpace: AqutterURLProtectionSpace(
          host: environment["NODE_SERVER_IP"]!,
          protocol: "http",
          realm: "Node",
          port: 8081,
        ),
        credential: AqutterURLCredential(username: "USERNAME", password: "PASSWORD"),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(
              url: AqutterWebUri("http://${environment["NODE_SERVER_IP"]}:8081/"),
            ),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            initialSettings: AqutterWebViewSettings(clearCache: true),
            onLoadStop: (controller, url) {
              pageLoaded.complete();
            },
            onReceivedHttpAuthRequest: (controller, challenge) async {
              return new AqutterHttpAuthResponse(
                action: AqutterHttpAuthResponseAction.USE_SAVED_HTTP_AUTH_CREDENTIALS,
              );
            },
          ),
        ),
      );
      final AqutterWebViewController controller =
          await controllerCompleter.future;
      await pageLoaded.future;

      final String h1Content = await controller.evaluateJavascript(
        source: "document.body.querySelector('h1').textContent",
      );
      expect(h1Content, "Authorized");

      var credentials = await httpAuthCredentialDatabase.getHttpAuthCredentials(
        protectionSpace: AqutterURLProtectionSpace(
          host: environment["NODE_SERVER_IP"]!,
          protocol: "http",
          realm: "Node",
          port: 8081,
        ),
      );
      expect(credentials.length, 1);

      await httpAuthCredentialDatabase.clearAllAuthCredentials();
      credentials = await httpAuthCredentialDatabase.getHttpAuthCredentials(
        protectionSpace: AqutterURLProtectionSpace(
          host: environment["NODE_SERVER_IP"]!,
          protocol: "http",
          realm: "Node",
          port: 8081,
        ),
      );
      expect(credentials, isEmpty);
    });

    skippableTestWidgets('save credentials', (WidgetTester tester) async {
      final Completer<AqutterWebViewController> controllerCompleter =
          Completer<AqutterWebViewController>();
      final Completer<void> pageLoaded = Completer<void>();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(
              url: AqutterWebUri("http://${environment["NODE_SERVER_IP"]}:8081/"),
            ),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            initialSettings: AqutterWebViewSettings(clearCache: true),
            onLoadStop: (controller, url) {
              pageLoaded.complete();
            },
            onReceivedHttpAuthRequest: (controller, challenge) async {
              return new AqutterHttpAuthResponse(
                username: "USERNAME",
                password: "PASSWORD",
                action: AqutterHttpAuthResponseAction.PROCEED,
                permanentPersistence: true,
              );
            },
          ),
        ),
      );
      final AqutterWebViewController controller =
          await controllerCompleter.future;
      await pageLoaded.future;

      final String h1Content = await controller.evaluateJavascript(
        source: "document.body.querySelector('h1').textContent",
      );
      expect(h1Content, "Authorized");
    });
  }, skip: shouldSkip);
}
