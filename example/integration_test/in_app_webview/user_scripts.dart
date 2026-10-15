part of 'main.dart';

void userScripts() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.addUserScript,
  );

  skippableGroup('user scripts', () {
    skippableTestWidgets('initialUserScripts', (WidgetTester tester) async {
      final Completer<AqutterWebViewController> controllerCompleter =
          Completer<AqutterWebViewController>();
      final Completer<void> pageLoaded = Completer<void>();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(url: TEST_CROSS_PLATFORM_URL_1),
            initialUserScripts: UnmodifiableListView<AqutterUserScript>([
              AqutterUserScript(
                source: "var foo = 49;",
                injectionTime: AqutterUserScriptInjectionTime.AT_DOCUMENT_START,
              ),
              AqutterUserScript(
                source: "var foo2 = 19;",
                injectionTime: AqutterUserScriptInjectionTime.AT_DOCUMENT_START,
                contentWorld: AqutterContentWorld.PAGE,
              ),
              AqutterUserScript(
                source: "var bar = 2;",
                injectionTime: AqutterUserScriptInjectionTime.AT_DOCUMENT_END,
                forMainFrameOnly:
                    defaultTargetPlatform != TargetPlatform.android,
                contentWorld: AqutterContentWorld.DEFAULT_CLIENT,
              ),
              AqutterUserScript(
                source: "var bar2 = 12;",
                injectionTime: AqutterUserScriptInjectionTime.AT_DOCUMENT_END,
                forMainFrameOnly:
                    defaultTargetPlatform != TargetPlatform.android,
                contentWorld: AqutterContentWorld.world(name: "test"),
              ),
            ]),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            onLoadStop: (controller, url) async {
              pageLoaded.complete();
            },
          ),
        ),
      );
      final AqutterWebViewController controller =
          await controllerCompleter.future;
      await pageLoaded.future;

      expect(await controller.evaluateJavascript(source: "foo;"), 49);
      expect(await controller.evaluateJavascript(source: "foo2;"), 19);
      expect(
        await controller.evaluateJavascript(
          source: "foo2;",
          contentWorld: AqutterContentWorld.PAGE,
        ),
        19,
      );
      expect(await controller.evaluateJavascript(source: "bar;"), isNull);
      expect(await controller.evaluateJavascript(source: "bar2;"), isNull);
      expect(
        await controller.evaluateJavascript(
          source: "bar;",
          contentWorld: AqutterContentWorld.DEFAULT_CLIENT,
        ),
        2,
      );
      expect(
        await controller.evaluateJavascript(
          source: "bar2;",
          contentWorld: AqutterContentWorld.world(name: "test"),
        ),
        12,
      );
    });

    skippableTestWidgets('add/remove user scripts', (
      WidgetTester tester,
    ) async {
      final Completer<AqutterWebViewController> controllerCompleter =
          Completer<AqutterWebViewController>();
      final StreamController<String> pageLoads =
          StreamController<String>.broadcast();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(url: TEST_CROSS_PLATFORM_URL_1),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            onLoadStop: (controller, url) {
              pageLoads.add(url!.toString());
            },
          ),
        ),
      );

      final AqutterWebViewController controller =
          await controllerCompleter.future;
      await pageLoads.stream.first;

      var userScript1 = AqutterUserScript(
        source: "window.foo = 49;",
        injectionTime: AqutterUserScriptInjectionTime.AT_DOCUMENT_START,
      );
      var userScript2 = AqutterUserScript(
        source: "window.bar = 19;",
        injectionTime: AqutterUserScriptInjectionTime.AT_DOCUMENT_END,
      );
      await controller.addUserScripts(userScripts: [userScript1, userScript2]);
      await controller.reload();
      await pageLoads.stream.first;
      var value = await controller.evaluateJavascript(source: "window.foo;");
      expect(value, 49);
      value = await controller.evaluateJavascript(source: "window.bar;");
      expect(value, 19);

      await controller.removeUserScript(userScript: userScript1);
      await controller.reload();
      await pageLoads.stream.first;
      value = await controller.evaluateJavascript(source: "window.foo;");
      expect(value, isNull);
      value = await controller.evaluateJavascript(source: "window.bar;");
      expect(value, 19);

      await controller.removeAllUserScripts();
      await controller.reload();
      await pageLoads.stream.first;
      value = await controller.evaluateJavascript(source: "window.foo;");
      expect(value, isNull);
      value = await controller.evaluateJavascript(source: "window.bar;");
      expect(value, isNull);

      pageLoads.close();
    });
  }, skip: shouldSkip);
}
