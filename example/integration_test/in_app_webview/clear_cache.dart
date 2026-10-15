part of 'main.dart';

void clearCache() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.clearAllCache,
  );

  skippableTestWidgets('clearAllCache', (WidgetTester tester) async {
    await expectLater(
      AqutterWebViewController.clearAllCache(includeDiskFiles: true),
      completes,
    );
  }, skip: shouldSkip);
}
