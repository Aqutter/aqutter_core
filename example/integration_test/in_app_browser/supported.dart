part of 'main.dart';

void supported() {
  skippableGroup('supported', () {
    skippableTestWidgets('basic', (WidgetTester tester) async {
      expect(AqutterBrowser.isClassSupported(), true);
      expect(
        AqutterBrowser.isPropertySupported(AqutterPlatformBrowserProperty.windowId),
        true,
      );
      expect(
        AqutterBrowser.isMethodSupported(
          AqutterPlatformBrowserMethod.openUrlRequest,
        ),
        true,
      );
      expect(
        AqutterBrowser.isMethodSupported(AqutterPlatformBrowserMethod.close),
        true,
      );
      expect(
        AqutterBrowser.isMethodSupported(AqutterPlatformBrowserMethod.hide),
        true,
      );
      expect(
        AqutterBrowser.isMethodSupported(AqutterPlatformBrowserMethod.show),
        true,
      );
      expect(
        AqutterBrowser.isEventMethodSupported(
          AqutterPlatformBrowserEventsMethod.onWebContentProcessDidTerminate,
        ),
        [
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.windows,
        ].contains(defaultTargetPlatform),
      );
      expect(
        AqutterBrowser.isEventMethodSupported(
          AqutterPlatformBrowserEventsMethod.onAcceleratorKeyPressed,
        ),
        defaultTargetPlatform == TargetPlatform.windows,
      );

      expect(
        AqutterBrowserSettings.isPropertySupported(
          AqutterBrowserSettingsProperty.toolbarBottomTintColor,
        ),
        defaultTargetPlatform == TargetPlatform.iOS,
      );
      expect(
        AqutterBrowserSettings.isPropertySupported(
          AqutterBrowserSettingsProperty.hidden,
        ),
        true,
      );
      expect(
        AqutterBrowserSettings.isPropertySupported(
          AqutterBrowserSettingsProperty.closeOnCannotGoBack,
        ),
        defaultTargetPlatform == TargetPlatform.android,
      );
    }, skip: false);
  }, skip: false);
}
