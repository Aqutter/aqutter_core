import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import 'cookie_manager.dart';
import 'find_interaction/main.dart';
import 'http_auth_credentials_database.dart';
import 'browser/browser.dart';
import 'webview/main.dart';
import 'print_job/main.dart';
import 'proxy_controller.dart';
import 'web_authentication_session/main.dart';
import 'web_message/main.dart';
import 'web_storage/main.dart';

/// Implementation of [AqutterWebViewPlatform] using the WebKit API.
class AqutterMacOSWebViewPlatform extends AqutterWebViewPlatform {
  /// Registers this class as the default instance of [AqutterWebViewPlatform].
  static void registerWith() {
    AqutterWebViewPlatform.instance = AqutterMacOSWebViewPlatform();
  }

  /// Creates a new [MacOSCookieManager].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCookieManager] in `aqutter` instead.
  @override
  MacOSCookieManager createPlatformCookieManager(
    AqutterPlatformCookieManagerCreationParams params,
  ) {
    return MacOSCookieManager(params);
  }

  /// Creates a new empty [MacOSCookieManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCookieManager] in `aqutter` instead.
  @override
  MacOSCookieManager createPlatformCookieManagerStatic() {
    return MacOSCookieManager.static();
  }

  /// Creates a new [AqutterMacOSWebViewController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  @override
  AqutterMacOSWebViewController createPlatformWebViewController(
    AqutterPlatformWebViewControllerCreationParams params,
  ) {
    return AqutterMacOSWebViewController(params);
  }

  /// Creates a new empty [AqutterMacOSWebViewController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  @override
  AqutterMacOSWebViewController createPlatformWebViewControllerStatic() {
    return AqutterMacOSWebViewController.static();
  }

  /// Creates a new [AqutterMacOSWebViewWidget].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  @override
  AqutterMacOSWebViewWidget createPlatformWebViewWidget(
    AqutterPlatformWebViewWidgetCreationParams params,
  ) {
    return AqutterMacOSWebViewWidget(params);
  }

  /// Creates a new empty [AqutterMacOSWebViewWidget] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  @override
  AqutterMacOSWebViewWidget createPlatformWebViewWidgetStatic() {
    return AqutterMacOSWebViewWidget.static();
  }

  /// Creates a new [MacOSFindInteractionController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterFindInteractionController] in `aqutter` instead.
  @override
  MacOSFindInteractionController createPlatformFindInteractionController(
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) {
    return MacOSFindInteractionController(params);
  }

  /// Creates a new empty [MacOSFindInteractionController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterFindInteractionController] in `aqutter` instead.
  @override
  MacOSFindInteractionController
  createPlatformFindInteractionControllerStatic() {
    return MacOSFindInteractionController.static();
  }

  /// Creates a new [MacOSPrintJobController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPrintJobController] in `aqutter` instead.
  @override
  MacOSPrintJobController createPlatformPrintJobController(
    AqutterPlatformPrintJobControllerCreationParams params,
  ) {
    return MacOSPrintJobController(params);
  }

  /// Creates a new empty [AqutterPlatformPrintJobController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPrintJobController] in `aqutter` instead.
  @override
  MacOSPrintJobController createPlatformPrintJobControllerStatic() {
    return MacOSPrintJobController.static();
  }

  /// Creates a new empty [AqutterPlatformPullToRefreshController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPullToRefreshController] in `aqutter` instead.
  @override
  AqutterPlatformPullToRefreshController
  createPlatformPullToRefreshControllerStatic() {
    return _PlatformPullToRefreshController.static();
  }

  /// Creates a new [MacOSWebMessageChannel].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageChannel] in `aqutter` instead.
  @override
  MacOSWebMessageChannel createPlatformWebMessageChannel(
    AqutterPlatformWebMessageChannelCreationParams params,
  ) {
    return MacOSWebMessageChannel(params);
  }

  /// Creates a new empty [MacOSWebMessageChannel] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageChannel] in `aqutter` instead.
  @override
  MacOSWebMessageChannel createPlatformWebMessageChannelStatic() {
    return MacOSWebMessageChannel.static();
  }

  /// Creates a new [MacOSWebMessageListener].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageListener] in `aqutter` instead.
  @override
  MacOSWebMessageListener createPlatformWebMessageListener(
    AqutterPlatformWebMessageListenerCreationParams params,
  ) {
    return MacOSWebMessageListener(params);
  }

  /// Creates a new empty [MacOSWebMessageListener] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageListener] in `aqutter` instead.
  @override
  MacOSWebMessageListener createPlatformWebMessageListenerStatic() {
    return MacOSWebMessageListener.static();
  }

  /// Creates a new [MacOSJavaScriptReplyProxy].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterJavaScriptReplyProxy] in `aqutter` instead.
  @override
  MacOSJavaScriptReplyProxy createPlatformJavaScriptReplyProxy(
    AqutterPlatformJavaScriptReplyProxyCreationParams params,
  ) {
    return MacOSJavaScriptReplyProxy(params);
  }

  /// Creates a new [MacOSWebMessagePort].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessagePort] in `aqutter` instead.
  @override
  MacOSWebMessagePort createPlatformWebMessagePort(
    AqutterPlatformWebMessagePortCreationParams params,
  ) {
    return MacOSWebMessagePort(params);
  }

  /// Creates a new [MacOSWebStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  @override
  MacOSWebStorage createPlatformWebStorage(
    AqutterPlatformWebStorageCreationParams params,
  ) {
    return MacOSWebStorage(params);
  }

  /// Creates a new empty [MacOSWebStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  @override
  MacOSWebStorage createPlatformWebStorageStatic() {
    return MacOSWebStorage(
      MacOSWebStorageCreationParams(
        localStorage: createPlatformLocalStorageStatic(),
        sessionStorage: createPlatformSessionStorageStatic(),
      ),
    );
  }

  /// Creates a new [MacOSLocalStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  @override
  MacOSLocalStorage createPlatformLocalStorage(
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    return MacOSLocalStorage(params);
  }

  /// Creates a new empty [MacOSLocalStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  @override
  MacOSLocalStorage createPlatformLocalStorageStatic() {
    return MacOSLocalStorage.defaultStorage(controller: null);
  }

  /// Creates a new [MacOSSessionStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterSessionStorage] in `aqutter` instead.
  @override
  MacOSSessionStorage createPlatformSessionStorage(
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    return MacOSSessionStorage(params);
  }

  /// Creates a new empty [MacOSSessionStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterSessionStorage] in `aqutter` instead.
  @override
  MacOSSessionStorage createPlatformSessionStorageStatic() {
    return MacOSSessionStorage.defaultStorage(controller: null);
  }

  /// Creates a new [AqutterMacOSHeadlessWebView].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHeadlessWebView] in `aqutter` instead.
  @override
  AqutterMacOSHeadlessWebView createPlatformHeadlessWebView(
    AqutterPlatformHeadlessWebViewCreationParams params,
  ) {
    return AqutterMacOSHeadlessWebView(params);
  }

  /// Creates a new empty [AqutterMacOSHeadlessWebView] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHeadlessWebView] in `aqutter` instead.
  @override
  AqutterMacOSHeadlessWebView createPlatformHeadlessWebViewStatic() {
    return AqutterMacOSHeadlessWebView.static();
  }

  /// Creates a new [MacOSHttpAuthCredentialDatabase].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHttpAuthCredentialDatabase] in `aqutter` instead.
  @override
  MacOSHttpAuthCredentialDatabase createPlatformHttpAuthCredentialDatabase(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) {
    return MacOSHttpAuthCredentialDatabase(params);
  }

  /// Creates a new empty [MacOSHttpAuthCredentialDatabase] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHttpAuthCredentialDatabase] in `aqutter` instead.
  @override
  MacOSHttpAuthCredentialDatabase
  createPlatformHttpAuthCredentialDatabaseStatic() {
    return MacOSHttpAuthCredentialDatabase.static();
  }

  /// Creates a new [AqutterMacOSBrowser].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterBrowser] in `aqutter` instead.
  @override
  AqutterMacOSBrowser createPlatformBrowser(
    AqutterPlatformBrowserCreationParams params,
  ) {
    return AqutterMacOSBrowser(params);
  }

  /// Creates a new empty [AqutterMacOSBrowser] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterBrowser] in `aqutter` instead.
  @override
  AqutterMacOSBrowser createPlatformBrowserStatic() {
    return AqutterMacOSBrowser.static();
  }

  /// Creates a new empty [MacOSWebStorageManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorageManager] in `aqutter` instead.
  @override
  MacOSWebStorageManager createPlatformWebStorageManager(
    AqutterPlatformWebStorageManagerCreationParams params,
  ) {
    return MacOSWebStorageManager(params);
  }

  /// Creates a new empty [MacOSWebStorageManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorageManager] in `aqutter` instead.
  @override
  MacOSWebStorageManager createPlatformWebStorageManagerStatic() {
    return MacOSWebStorageManager.static();
  }

  /// Creates a new [MacOSWebAuthenticationSession].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebAuthenticationSession] in `aqutter` instead.
  @override
  MacOSWebAuthenticationSession createPlatformWebAuthenticationSession(
    AqutterPlatformWebAuthenticationSessionCreationParams params,
  ) {
    return MacOSWebAuthenticationSession(params);
  }

  /// Creates a new empty [MacOSWebAuthenticationSession] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebAuthenticationSession] in `aqutter` instead.
  @override
  MacOSWebAuthenticationSession createPlatformWebAuthenticationSessionStatic() {
    return MacOSWebAuthenticationSession.static();
  }

  /// Creates a new [MacOSProxyController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProxyController] in `aqutter` instead.
  @override
  AqutterPlatformProxyController createPlatformProxyController(
    AqutterPlatformProxyControllerCreationParams params,
  ) {
    return MacOSProxyController(params);
  }

  /// Creates a new empty [MacOSProxyController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProxyController] in `aqutter` instead.
  @override
  MacOSProxyController createPlatformProxyControllerStatic() {
    return MacOSProxyController.static();
  }

  // ************************************************************************ //
  // Create static instances of unsupported classes to be able to call        //
  // isClassSupported, isMethodSupported, isPropertySupported, etc.           //
  // static methods without throwing a missing platform implementation        //
  // exception.                                                               //
  // ************************************************************************ //

  /// Creates a new empty [AqutterPlatformWebViewEnvironment] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewEnvironment] in `aqutter` instead.
  @override
  AqutterPlatformWebViewEnvironment createPlatformWebViewEnvironmentStatic() {
    return _PlatformWebViewEnvironment.static();
  }

  /// Creates a new empty [AqutterPlatformChromeSafariBrowser] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterChromeSafariBrowser] in `aqutter` instead.
  AqutterPlatformChromeSafariBrowser createPlatformChromeSafariBrowserStatic() {
    return _PlatformChromeSafariBrowser.static();
  }

  /// Creates a new empty [AqutterPlatformProcessGlobalConfig] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProcessGlobalConfig] in `aqutter` instead.
  @override
  AqutterPlatformProcessGlobalConfig createPlatformProcessGlobalConfigStatic() {
    return _PlatformProcessGlobalConfig.static();
  }

  /// Creates a new empty [AqutterPlatformServiceWorkerController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterServiceWorkerController] in `aqutter` instead.
  @override
  AqutterPlatformServiceWorkerController
  createPlatformServiceWorkerControllerStatic() {
    return _PlatformServiceWorkerController.static();
  }

  /// Creates a new empty [AqutterPlatformTracingController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterTracingController] in `aqutter` instead.
  @override
  AqutterPlatformTracingController createPlatformTracingControllerStatic() {
    return _PlatformTracingController.static();
  }

  /// Creates a new empty [AqutterPlatformWebNotificationController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebNotificationController] in `aqutter` instead.
  @override
  AqutterPlatformWebNotificationController
  createPlatformWebNotificationControllerStatic() {
    return _PlatformWebNotificationController.static();
  }

  /// Creates a new empty [AqutterPlatformAssetsPathHandler] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterAssetsPathHandler] in `aqutter` instead.
  @override
  AqutterPlatformAssetsPathHandler createPlatformAssetsPathHandlerStatic() {
    return _PlatformAssetsPathHandler.static();
  }

  /// Creates a new empty [AqutterPlatformResourcesPathHandler] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterResourcesPathHandler] in `aqutter` instead.
  @override
  AqutterPlatformResourcesPathHandler createPlatformResourcesPathHandlerStatic() {
    return _PlatformResourcesPathHandler.static();
  }

  /// Creates a new empty [AqutterPlatformInternalStoragePathHandler] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterInternalStoragePathHandler] in `aqutter` instead.
  @override
  AqutterPlatformInternalStoragePathHandler
  createPlatformInternalStoragePathHandlerStatic() {
    return _PlatformInternalStoragePathHandler.static();
  }

  /// Creates a new empty [AqutterPlatformCustomPathHandler] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCustomPathHandler] in `aqutter` instead.
  @override
  AqutterPlatformCustomPathHandler createPlatformCustomPathHandlerStatic() {
    return _PlatformCustomPathHandler.static();
  }

  /// Creates a new [AqutterDefaultLocalhostServer].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalhostServer] in `aqutter` instead.
  @override
  AqutterDefaultLocalhostServer createPlatformLocalhostServer(
    AqutterPlatformLocalhostServerCreationParams params,
  ) {
    return AqutterDefaultLocalhostServer(params);
  }

  /// Creates a new empty [AqutterDefaultLocalhostServer] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalhostServer] in `aqutter` instead.
  @override
  AqutterDefaultLocalhostServer createPlatformLocalhostServerStatic() {
    return AqutterDefaultLocalhostServer.static();
  }

  /// Creates a new empty [AqutterPlatformWebViewFeature] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewFeature] in `aqutter` instead
  @override
  AqutterPlatformWebViewFeature createPlatformWebViewFeatureStatic() {
    return _PlatformWebViewFeature.static();
  }
}

class _PlatformChromeSafariBrowser extends AqutterPlatformChromeSafariBrowser {
  _PlatformChromeSafariBrowser(AqutterPlatformChromeSafariBrowserCreationParams params)
    : super.implementation(params);
  static final _PlatformChromeSafariBrowser _staticValue =
      _PlatformChromeSafariBrowser(
        const AqutterPlatformChromeSafariBrowserCreationParams(),
      );

  factory _PlatformChromeSafariBrowser.static() => _staticValue;
}

class _PlatformProcessGlobalConfig extends AqutterPlatformProcessGlobalConfig {
  _PlatformProcessGlobalConfig(AqutterPlatformProcessGlobalConfigCreationParams params)
    : super.implementation(params);
  static final _PlatformProcessGlobalConfig _staticValue =
      _PlatformProcessGlobalConfig(
        const AqutterPlatformProcessGlobalConfigCreationParams(),
      );

  factory _PlatformProcessGlobalConfig.static() => _staticValue;
}

class _PlatformServiceWorkerController extends AqutterPlatformServiceWorkerController {
  _PlatformServiceWorkerController(
    AqutterPlatformServiceWorkerControllerCreationParams params,
  ) : super.implementation(params);
  static final _PlatformServiceWorkerController _staticValue =
      _PlatformServiceWorkerController(
        const AqutterPlatformServiceWorkerControllerCreationParams(),
      );

  factory _PlatformServiceWorkerController.static() => _staticValue;

  @override
  AqutterServiceWorkerClient? get serviceWorkerClient => throw UnimplementedError();
}

class _PlatformTracingController extends AqutterPlatformTracingController {
  _PlatformTracingController(AqutterPlatformTracingControllerCreationParams params)
    : super.implementation(params);
  static final _PlatformTracingController _staticValue =
      _PlatformTracingController(
        const AqutterPlatformTracingControllerCreationParams(),
      );

  factory _PlatformTracingController.static() => _staticValue;
}

class _PlatformPullToRefreshController extends AqutterPlatformPullToRefreshController {
  _PlatformPullToRefreshController(
    AqutterPlatformPullToRefreshControllerCreationParams params,
  ) : super.implementation(params);

  static final _PlatformPullToRefreshController _staticValue =
      _PlatformPullToRefreshController(
        AqutterPlatformPullToRefreshControllerCreationParams(),
      );

  factory _PlatformPullToRefreshController.static() => _staticValue;
}

class _PlatformWebViewEnvironment extends AqutterPlatformWebViewEnvironment {
  _PlatformWebViewEnvironment(AqutterPlatformWebViewEnvironmentCreationParams params)
    : super.implementation(params);
  static final _PlatformWebViewEnvironment _staticValue =
      _PlatformWebViewEnvironment(
        const AqutterPlatformWebViewEnvironmentCreationParams(),
      );

  factory _PlatformWebViewEnvironment.static() => _staticValue;
}

class _PlatformWebNotificationController
    extends AqutterPlatformWebNotificationController {
  _PlatformWebNotificationController(
    AqutterPlatformWebNotificationControllerCreationParams params,
  ) : super.implementation(params);

  static final _PlatformWebNotificationController _staticValue =
      _PlatformWebNotificationController(
        AqutterPlatformWebNotificationControllerCreationParams(
          id: '',
          notification: AqutterWebNotification(),
        ),
      );

  factory _PlatformWebNotificationController.static() => _staticValue;
}

class _PlatformWebViewFeature extends AqutterPlatformWebViewFeature {
  _PlatformWebViewFeature(AqutterPlatformWebViewFeatureCreationParams params)
    : super.implementation(params);

  static final _PlatformWebViewFeature _staticValue = _PlatformWebViewFeature(
    AqutterPlatformWebViewFeatureCreationParams(),
  );
  factory _PlatformWebViewFeature.static() => _staticValue;
}

class _PlatformAssetsPathHandler extends AqutterPlatformAssetsPathHandler {
  _PlatformAssetsPathHandler(AqutterPlatformAssetsPathHandlerCreationParams params)
    : super.implementation(params);

  static final _PlatformAssetsPathHandler _staticValue =
      _PlatformAssetsPathHandler(
        AqutterPlatformAssetsPathHandlerCreationParams(
          AqutterPlatformPathHandlerCreationParams(path: ''),
        ),
      );

  factory _PlatformAssetsPathHandler.static() => _staticValue;

  @override
  AqutterPlatformPathHandlerEvents? eventHandler;

  @override
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) => {
    "path": path,
    "type": type,
  };

  @override
  Map<String, dynamic> toJson() => toMap();
}

class _PlatformResourcesPathHandler extends AqutterPlatformResourcesPathHandler {
  _PlatformResourcesPathHandler(
    AqutterPlatformResourcesPathHandlerCreationParams params,
  ) : super.implementation(params);

  static final _PlatformResourcesPathHandler _staticValue =
      _PlatformResourcesPathHandler(
        AqutterPlatformResourcesPathHandlerCreationParams(
          AqutterPlatformPathHandlerCreationParams(path: ''),
        ),
      );

  factory _PlatformResourcesPathHandler.static() => _staticValue;

  @override
  AqutterPlatformPathHandlerEvents? eventHandler;

  @override
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) => {
    "path": path,
    "type": type,
  };

  @override
  Map<String, dynamic> toJson() => toMap();
}

class _PlatformInternalStoragePathHandler
    extends AqutterPlatformInternalStoragePathHandler {
  _PlatformInternalStoragePathHandler(
    AqutterPlatformInternalStoragePathHandlerCreationParams params,
  ) : super.implementation(params);

  static final _PlatformInternalStoragePathHandler _staticValue =
      _PlatformInternalStoragePathHandler(
        AqutterPlatformInternalStoragePathHandlerCreationParams(
          AqutterPlatformPathHandlerCreationParams(path: ''),
          directory: '',
        ),
      );

  factory _PlatformInternalStoragePathHandler.static() => _staticValue;

  @override
  AqutterPlatformPathHandlerEvents? eventHandler;

  @override
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) => {
    "path": path,
    "type": type,
  };

  @override
  Map<String, dynamic> toJson() => toMap();
}

class _PlatformCustomPathHandler extends AqutterPlatformCustomPathHandler {
  _PlatformCustomPathHandler(AqutterPlatformCustomPathHandlerCreationParams params)
    : super.implementation(params);

  static final _PlatformCustomPathHandler _staticValue =
      _PlatformCustomPathHandler(
        AqutterPlatformCustomPathHandlerCreationParams(
          AqutterPlatformPathHandlerCreationParams(path: ''),
        ),
      );

  factory _PlatformCustomPathHandler.static() => _staticValue;

  @override
  AqutterPlatformPathHandlerEvents? eventHandler;

  @override
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) => {
    "path": path,
    "type": type,
  };

  @override
  Map<String, dynamic> toJson() => toMap();
}
