part of 'main.dart';

void webArchive() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.saveWebArchive,
  );

  skippableGroup('web archive', () {
    final shouldSkipTest1 = !AqutterWebViewController.isMethodSupported(
      AqutterPlatformWebViewControllerMethod.createWebArchiveData,
    );

    skippableTestWidgets('create data', (WidgetTester tester) async {
      final Completer<AqutterWebViewController> controllerCompleter =
          Completer<AqutterWebViewController>();
      final Completer<void> pageLoaded = Completer<void>();

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
              pageLoaded.complete();
            },
          ),
        ),
      );

      final AqutterWebViewController controller =
          await controllerCompleter.future;
      await pageLoaded.future;

      expect(await controller.createWebArchiveData(), isNotNull);
    }, skip: shouldSkipTest1);

    skippableTestWidgets('save', (WidgetTester tester) async {
      final Completer<AqutterWebViewController> controllerCompleter =
          Completer<AqutterWebViewController>();
      final Completer<void> pageLoaded = Completer<void>();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AqutterWebView(
            key: GlobalKey(),
            initialUrlRequest: AqutterURLRequest(url: TEST_URL_1),
            onWebViewCreated: (controller) {
              controllerCompleter.complete(controller);
            },
            onLoadStop: (controller, url) {
              if (!pageLoaded.isCompleted) {
                pageLoaded.complete();
              }
            },
          ),
        ),
      );

      final AqutterWebViewController controller =
          await controllerCompleter.future;
      await pageLoaded.future;

      // wait a little bit after page load otherwise Android will not save the web archive
      await Future.delayed(Duration(seconds: 1));

      var supportDir = await getApplicationSupportDirectory();

      var fileName = "flutter-website.";
      if (AqutterWebArchiveFormat.MHT.isSupported()) {
        fileName = fileName + AqutterWebArchiveFormat.MHT.toValue();
      } else {
        fileName = fileName + AqutterWebArchiveFormat.WEBARCHIVE.toValue();
      }

      var fullPath = supportDir.path + Platform.pathSeparator + fileName;
      var path = await controller.saveWebArchive(filePath: fullPath);
      expect(path, isNotNull);
      expect(path, endsWith(fileName));

      path = await controller.saveWebArchive(
        filePath: supportDir.path,
        autoname: true,
      );
      expect(path, isNotNull);
    });
  }, skip: shouldSkip);
}
