part of 'main.dart';

void handlesURLScheme() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.handlesURLScheme,
  );

  skippableTest('handlesURLScheme', () async {
    expect(await AqutterWebViewController.handlesURLScheme("http"), true);
    expect(await AqutterWebViewController.handlesURLScheme("https"), true);
  }, skip: shouldSkip);
}
