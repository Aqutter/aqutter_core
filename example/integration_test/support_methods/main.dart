import 'package:flutter/foundation.dart';
import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../util.dart';

void main() {
  skippableGroup('Support methods', () {
    skippableTest('AqutterWebMessageChannel support methods are callable', () {
      expect(
        () =>
            AqutterWebMessageChannel.isClassSupported(platform: defaultTargetPlatform),
        returnsNormally,
      );
      expect(
        () => AqutterWebMessageChannel.isMethodSupported(
          AqutterPlatformWebMessageChannelMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterWebMessageChannel.isPropertySupported(
          AqutterPlatformWebMessageChannelCreationParamsProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterWebMessageListener support methods are callable', () {
      expect(
        () => AqutterWebMessageListener.isClassSupported(
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterWebMessageListener.isMethodSupported(
          AqutterPlatformWebMessageListenerMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterWebMessageListener.isPropertySupported(
          AqutterPlatformWebMessageListenerCreationParamsProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterWebViewEnvironment support methods are callable', () {
      expect(
        () => AqutterWebViewEnvironment.isClassSupported(
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterWebViewEnvironment.isMethodSupported(
          AqutterPlatformWebViewEnvironmentMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterWebViewEnvironment.isPropertySupported(
          AqutterPlatformWebViewEnvironmentCreationParamsProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterHeadlessWebView support methods are callable', () {
      expect(
        () => AqutterHeadlessWebView.isClassSupported(
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterHeadlessWebView.isMethodSupported(
          AqutterPlatformHeadlessWebViewMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterHeadlessWebView.isPropertySupported(
          AqutterPlatformHeadlessWebViewCreationParamsProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterWebStorage support methods are callable', () {
      expect(
        () => AqutterWebStorage.isClassSupported(platform: defaultTargetPlatform),
        returnsNormally,
      );
      expect(
        () => AqutterWebStorage.isMethodSupported(
          AqutterPlatformWebStorageMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterWebStorage.isPropertySupported(
          AqutterPlatformWebStorageCreationParamsProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterWebStorage.isPropertySupported(
          AqutterPlatformWebStorageProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterLocalStorage support methods are callable', () {
      expect(
        () => AqutterLocalStorage.isClassSupported(platform: defaultTargetPlatform),
        returnsNormally,
      );
      expect(
        () => AqutterLocalStorage.isMethodSupported(
          AqutterPlatformLocalStorageMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterLocalStorage.isPropertySupported(
          AqutterPlatformStorageCreationParamsProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterSessionStorage support methods are callable', () {
      expect(
        () => AqutterSessionStorage.isClassSupported(platform: defaultTargetPlatform),
        returnsNormally,
      );
      expect(
        () => AqutterSessionStorage.isMethodSupported(
          AqutterPlatformSessionStorageMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterSessionStorage.isPropertySupported(
          AqutterPlatformStorageCreationParamsProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterWebStorageManager support methods are callable', () {
      expect(
        () =>
            AqutterWebStorageManager.isClassSupported(platform: defaultTargetPlatform),
        returnsNormally,
      );
      expect(
        () => AqutterWebStorageManager.isMethodSupported(
          AqutterPlatformWebStorageManagerMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterPullToRefreshController support methods are callable', () {
      expect(
        () => AqutterPullToRefreshController.isClassSupported(
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterPullToRefreshController.isMethodSupported(
          AqutterPlatformPullToRefreshControllerMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterPullToRefreshController.isPropertySupported(
          AqutterPlatformPullToRefreshControllerCreationParamsProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterWebView support methods are callable', () {
      expect(
        () => AqutterWebView.isClassSupported(platform: defaultTargetPlatform),
        returnsNormally,
      );
      expect(
        () => AqutterWebView.isPropertySupported(
          AqutterPlatformWebViewWidgetCreationParamsProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterWebViewSettings support methods are callable', () {
      expect(
        () => AqutterWebViewSettings.isPropertySupported(
          AqutterWebViewSettingsProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterWebViewController support methods are callable', () {
      expect(
        () => AqutterWebViewController.isClassSupported(
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterWebViewController.isMethodSupported(
          AqutterPlatformWebViewControllerMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterWebViewController.isPropertySupported(
          AqutterPlatformWebViewControllerProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterBrowser support methods are callable', () {
      expect(
        () => AqutterBrowser.isClassSupported(platform: defaultTargetPlatform),
        returnsNormally,
      );
      expect(
        () => AqutterBrowser.isMethodSupported(
          AqutterPlatformBrowserMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterBrowser.isPropertySupported(
          AqutterPlatformBrowserProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterChromeSafariBrowser support methods are callable', () {
      expect(
        () => AqutterChromeSafariBrowser.isClassSupported(
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterChromeSafariBrowser.isMethodSupported(
          AqutterPlatformChromeSafariBrowserMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterWebAuthenticationSession support methods are callable', () {
      expect(
        () => AqutterWebAuthenticationSession.isClassSupported(
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterWebAuthenticationSession.isMethodSupported(
          AqutterPlatformWebAuthenticationSessionMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterWebAuthenticationSession.isPropertySupported(
          AqutterPlatformWebAuthenticationSessionProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterCookieManager support methods are callable', () {
      expect(
        () => AqutterCookieManager.isClassSupported(platform: defaultTargetPlatform),
        returnsNormally,
      );
      expect(
        () => AqutterCookieManager.isMethodSupported(
          AqutterPlatformCookieManagerMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterCookieManager.isPropertySupported(
          AqutterPlatformCookieManagerCreationParamsProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterProcessGlobalConfig support methods are callable', () {
      expect(
        () => AqutterProcessGlobalConfig.isClassSupported(
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterProcessGlobalConfig.isMethodSupported(
          AqutterPlatformProcessGlobalConfigMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterServiceWorkerController support methods are callable', () {
      expect(
        () => AqutterServiceWorkerController.isClassSupported(
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterServiceWorkerController.isMethodSupported(
          AqutterPlatformServiceWorkerControllerMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterProxyController support methods are callable', () {
      expect(
        () => AqutterProxyController.isClassSupported(platform: defaultTargetPlatform),
        returnsNormally,
      );
      expect(
        () => AqutterProxyController.isMethodSupported(
          AqutterPlatformProxyControllerMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterPrintJobController support methods are callable', () {
      expect(
        () => AqutterPrintJobController.isClassSupported(
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterPrintJobController.isMethodSupported(
          AqutterPlatformPrintJobControllerMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterPrintJobController.isPropertySupported(
          AqutterPlatformPrintJobControllerCreationParamsProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterPrintJobController.isPropertySupported(
          AqutterPlatformPrintJobControllerProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterTracingController support methods are callable', () {
      expect(
        () =>
            AqutterTracingController.isClassSupported(platform: defaultTargetPlatform),
        returnsNormally,
      );
      expect(
        () => AqutterTracingController.isMethodSupported(
          AqutterPlatformTracingControllerMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest('AqutterFindInteractionController support methods are callable', () {
      expect(
        () => AqutterFindInteractionController.isClassSupported(
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterFindInteractionController.isMethodSupported(
          AqutterPlatformFindInteractionControllerMethod.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
      expect(
        () => AqutterFindInteractionController.isPropertySupported(
          AqutterPlatformFindInteractionControllerCreationParamsProperty.values.first,
          platform: defaultTargetPlatform,
        ),
        returnsNormally,
      );
    });

    skippableTest(
      'AqutterHttpAuthCredentialDatabase support methods are callable',
      () {
        expect(
          () => AqutterHttpAuthCredentialDatabase.isClassSupported(
            platform: defaultTargetPlatform,
          ),
          returnsNormally,
        );
        expect(
          () => AqutterHttpAuthCredentialDatabase.isMethodSupported(
            AqutterPlatformHttpAuthCredentialDatabaseMethod.values.first,
            platform: defaultTargetPlatform,
          ),
          returnsNormally,
        );
      },
    );
  });
}
