part of 'main.dart';

void supported() {
  skippableGroup('supported', () {
    skippableTestWidgets('basic', (WidgetTester tester) async {
      expect(AqutterHeadlessWebView.isClassSupported(), true);
      expect(
        AqutterHeadlessWebView.isPropertySupported(
          AqutterPlatformHeadlessWebViewCreationParamsProperty.initialSize,
        ),
        true,
      );
      expect(
        AqutterHeadlessWebView.isPropertySupported(
          AqutterPlatformHeadlessWebViewCreationParamsProperty.webViewEnvironment,
        ),
        defaultTargetPlatform == TargetPlatform.windows,
      );
      expect(
        AqutterHeadlessWebView.isMethodSupported(
          AqutterPlatformHeadlessWebViewMethod.run,
        ),
        true,
      );
      expect(
        AqutterHeadlessWebView.isMethodSupported(
          AqutterPlatformHeadlessWebViewMethod.dispose,
        ),
        true,
      );
    }, skip: false);
  }, skip: false);
}
