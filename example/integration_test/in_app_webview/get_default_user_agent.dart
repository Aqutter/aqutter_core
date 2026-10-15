part of 'main.dart';

void getDefaultUserAgent() {
  final shouldSkip = !AqutterWebViewController.isMethodSupported(
    AqutterPlatformWebViewControllerMethod.getDefaultUserAgent,
  );

  skippableTest('getDefaultUserAgent', () async {
    expect(await AqutterWebViewController.getDefaultUserAgent(), isNotNull);
  }, skip: shouldSkip);
}
