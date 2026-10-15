part of 'main.dart';

void supported() {
  skippableGroup('supported', () {
    skippableTestWidgets('basic', (WidgetTester tester) async {
      expect(AqutterWebViewController.isClassSupported(), true);
      expect(
        AqutterWebViewController.isPropertySupported(
          AqutterPlatformWebViewControllerProperty.webStorage,
        ),
        true,
      );
      expect(
        AqutterWebViewController.isMethodSupported(
          AqutterPlatformWebViewControllerMethod.startSafeBrowsing,
        ),
        defaultTargetPlatform == TargetPlatform.android,
      );
      expect(
        AqutterWebViewController.isMethodSupported(
          AqutterPlatformWebViewControllerMethod.createPdf,
        ),
        [
          TargetPlatform.iOS,
          TargetPlatform.macOS,
        ].contains(defaultTargetPlatform),
      );
      expect(
        AqutterWebViewController.isMethodSupported(
          AqutterPlatformWebViewControllerMethod.clearSslPreferences,
        ),
        [
          TargetPlatform.android,
          TargetPlatform.windows,
        ].contains(defaultTargetPlatform),
      );
      expect(
        AqutterWebViewController.isMethodSupported(
          AqutterPlatformWebViewControllerMethod.openDevTools,
        ),
        defaultTargetPlatform == TargetPlatform.windows,
      );

      expect(AqutterWebView.isClassSupported(), true);
      expect(
        AqutterWebView.isPropertySupported(
          AqutterPlatformWebViewCreationParamsProperty.initialSettings,
        ),
        true,
      );
      expect(
        AqutterWebView.isPropertySupported(
          AqutterPlatformWebViewCreationParamsProperty.windowId,
        ),
        true,
      );
      expect(
        AqutterWebView.isPropertySupported(
          AqutterPlatformWebViewWidgetCreationParamsProperty.preventGestureDelay,
        ),
        defaultTargetPlatform == TargetPlatform.iOS,
      );
      expect(
        AqutterWebView.isPropertySupported(
          AqutterPlatformWebViewCreationParamsProperty.onWebContentProcessDidTerminate,
        ),
        [
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.windows,
        ].contains(defaultTargetPlatform),
      );
      expect(
        AqutterWebView.isPropertySupported(
          AqutterPlatformWebViewCreationParamsProperty.onAcceleratorKeyPressed,
        ),
        defaultTargetPlatform == TargetPlatform.windows,
      );

      expect(
        AqutterWebViewSettings.isPropertySupported(
          AqutterWebViewSettingsProperty.algorithmicDarkeningAllowed,
        ),
        defaultTargetPlatform == TargetPlatform.android,
      );
      expect(
        AqutterWebViewSettings.isPropertySupported(
          AqutterWebViewSettingsProperty.allowsBackForwardNavigationGestures,
        ),
        [
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.windows,
        ].contains(defaultTargetPlatform),
      );
      expect(
        AqutterWebViewSettings.isPropertySupported(
          AqutterWebViewSettingsProperty.handleAcceleratorKeyPressed,
        ),
        defaultTargetPlatform == TargetPlatform.windows,
      );
    }, skip: false);
  }, skip: false);
}
