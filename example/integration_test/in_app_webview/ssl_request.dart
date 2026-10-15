part of 'main.dart';

void sslRequest() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onReceivedServerTrustAuthRequest,
  );

  skippableTestWidgets('SSL request', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(
            url: AqutterWebUri("https://${environment["NODE_SERVER_IP"]}:4433/"),
          ),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onLoadStop: (controller, url) {
            pageLoaded.complete();
          },
          onReceivedServerTrustAuthRequest: (controller, challenge) async {
            return new AqutterServerTrustAuthResponse(
              action: AqutterServerTrustAuthResponseAction.PROCEED,
            );
          },
          onReceivedClientCertRequest: (controller, challenge) async {
            return new AqutterClientCertResponse(
              certificatePath: "test_assets/certificate.pfx",
              certificatePassword: "password",
              keyStoreType: "PKCS12",
              action: AqutterClientCertResponseAction.PROCEED,
            );
          },
        ),
      ),
    );
    final AqutterWebViewController controller = await controllerCompleter.future;
    await pageLoaded.future;

    final String h1Content = await controller.evaluateJavascript(
      source: "document.body.querySelector('h1').textContent",
    );
    expect(h1Content, "Authorized");
  }, skip: shouldSkip);
}
