part of 'main.dart';

void startAndStop() {
  final shouldSkip =
      !AqutterTracingController.isMethodSupported(
        AqutterPlatformTracingControllerMethod.start,
      ) ||
      !AqutterTracingController.isMethodSupported(
        AqutterPlatformTracingControllerMethod.stop,
      );

  skippableTestWidgets('start and stop', (WidgetTester tester) async {
    final Completer<void> pageLoaded = Completer<void>();

    final tracingAvailable = await AqutterWebViewFeature.isFeatureSupported(
      AqutterWebViewFeature.TRACING_CONTROLLER_BASIC_USAGE,
    );

    if (!tracingAvailable) {
      return;
    }

    final tracingController = AqutterTracingController.instance();
    expect(await tracingController.isTracing(), false);
    await tracingController.start(
      settings: AqutterTracingSettings(
        tracingMode: AqutterTracingMode.RECORD_CONTINUOUSLY,
        categories: [AqutterTracingCategory.CATEGORIES_ANDROID_WEBVIEW, "blink*"],
      ),
    );
    expect(await tracingController.isTracing(), true);

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_CROSS_PLATFORM_URL_1),
          onLoadStop: (controller, url) {
            if (!pageLoaded.isCompleted) {
              pageLoaded.complete();
            }
          },
        ),
      ),
    );

    await pageLoaded.future;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String traceFilePath =
        '${appDocDir.path}${Platform.pathSeparator}trace.json';
    expect(await tracingController.stop(filePath: traceFilePath), true);

    expect(File(traceFilePath).existsSync(), true);

    await Future.delayed(Duration(seconds: 2));
    expect(await tracingController.isTracing(), false);
  }, skip: shouldSkip);
}
