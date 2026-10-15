part of 'main.dart';

void clearClientCertPreferences() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.clearClientCertPreferences,
  );

  skippableTest('clearClientCertPreferences', () async {
    await expectLater(
      AqutterWebViewController.clearClientCertPreferences(),
      completes,
    );
  }, skip: shouldSkip);
}
