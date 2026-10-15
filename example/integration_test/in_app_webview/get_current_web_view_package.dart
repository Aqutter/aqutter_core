part of 'main.dart';

void getCurrentWebViewPackage() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.getCurrentWebViewPackage,
  );

  skippableTest('getCurrentWebViewPackage', () async {
    expect(await AqutterWebViewController.getCurrentWebViewPackage(), isNotNull);
  }, skip: shouldSkip);
}
