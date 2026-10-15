part of 'main.dart';

void setWebContentsDebuggingEnabled() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.setWebContentsDebuggingEnabled,
  );

  skippableTest('setWebContentsDebuggingEnabled', () async {
    expect(
      AqutterWebViewController.setWebContentsDebuggingEnabled(true),
      completes,
    );
  }, skip: shouldSkip);
}
