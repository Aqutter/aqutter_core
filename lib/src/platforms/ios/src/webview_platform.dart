import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import 'chrome_safari_browser/chrome_safari_browser.dart';
import 'cookie_manager.dart';
import 'find_interaction/main.dart';
import 'http_auth_credentials_database.dart';
import 'browser/browser.dart';
import 'webview/main.dart';
import 'print_job/main.dart';
import 'proxy_controller.dart';
import 'pull_to_refresh/main.dart';
import 'web_authentication_session/main.dart';
import 'web_message/main.dart';
import 'web_storage/main.dart';

/// Implementation of [AqutterWebViewPlatform] using the WebKit API.
class AqutterIOSWebViewPlatform extends AqutterWebViewPlatform {
  /// Registers this class as the default instance of [AqutterWebViewPlatform].
  static void registerWith() {
    AqutterWebViewPlatform.instance = AqutterIOSWebViewPlatform();
  }

  /// Creates a new [IOSCookieManager].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCookieManager] in `aqutter` instead.
  @override
  IOSCookieManager createPlatformCookieManager(
    AqutterPlatformCookieManagerCreationParams params,
  ) {
    return IOSCookieManager(params);
  }

  /// Creates a new empty [IOSCookieManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCookieManager] in `aqutter` instead.
  @override
  IOSCookieManager createPlatformCookieManagerStatic() {
    return IOSCookieManager.static();
  }

  /// Creates a new [AqutterIOSWebViewControllerImpl].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  @override
  AqutterIOSWebViewControllerImpl createPlatformWebViewController(
    AqutterPlatformWebViewControllerCreationParams params,
  ) {
    return AqutterIOSWebViewControllerImpl(params);
  }

  /// Creates a new empty [AqutterIOSWebViewControllerImpl] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  @override
  AqutterIOSWebViewControllerImpl createPlatformWebViewControllerStatic() {
    return AqutterIOSWebViewControllerImpl.static();
  }

  /// Creates a new [AqutterIOSWebViewWidget].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  @override
  AqutterIOSWebViewWidget createPlatformWebViewWidget(
    AqutterPlatformWebViewWidgetCreationParams params,
  ) {
    return AqutterIOSWebViewWidget(params);
  }

  /// Creates a new empty [AqutterIOSWebViewWidget] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  @override
  AqutterIOSWebViewWidget createPlatformWebViewWidgetStatic() {
    return AqutterIOSWebViewWidget.static();
  }

  /// Creates a new [IOSFindInteractionController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterFindInteractionController] in `aqutter` instead.
  @override
  IOSFindInteractionController createPlatformFindInteractionController(
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) {
    return IOSFindInteractionController(params);
  }

  /// Creates a new empty [IOSFindInteractionController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterFindInteractionController] in `aqutter` instead.
  @override
  IOSFindInteractionController createPlatformFindInteractionControllerStatic() {
    return IOSFindInteractionController.static();
  }

  /// Creates a new [IOSPrintJobController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPrintJobController] in `aqutter` instead.
  @override
  IOSPrintJobController createPlatformPrintJobController(
    AqutterPlatformPrintJobControllerCreationParams params,
  ) {
    return IOSPrintJobController(params);
  }

  /// Creates a new empty [AqutterPlatformPrintJobController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPrintJobController] in `aqutter` instead.
  @override
  IOSPrintJobController createPlatformPrintJobControllerStatic() {
    return IOSPrintJobController.static();
  }

  /// Creates a new [IOSPullToRefreshController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPullToRefreshController] in `aqutter` instead.
  @override
  IOSPullToRefreshController createPlatformPullToRefreshController(
    AqutterPlatformPullToRefreshControllerCreationParams params,
  ) {
    return IOSPullToRefreshController(params);
  }

  /// Creates a new empty [IOSPullToRefreshController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPullToRefreshController] in `aqutter` instead.
  @override
  IOSPullToRefreshController createPlatformPullToRefreshControllerStatic() {
    return IOSPullToRefreshController.static();
  }

  /// Creates a new [IOSWebMessageChannel].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageChannel] in `aqutter` instead.
  @override
  IOSWebMessageChannel createPlatformWebMessageChannel(
    AqutterPlatformWebMessageChannelCreationParams params,
  ) {
    return IOSWebMessageChannel(params);
  }

  /// Creates a new empty [IOSWebMessageChannel] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageChannel] in `aqutter` instead.
  @override
  IOSWebMessageChannel createPlatformWebMessageChannelStatic() {
    return IOSWebMessageChannel.static();
  }

  /// Creates a new [IOSWebMessageListener].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageListener] in `aqutter` instead.
  @override
  IOSWebMessageListener createPlatformWebMessageListener(
    AqutterPlatformWebMessageListenerCreationParams params,
  ) {
    return IOSWebMessageListener(params);
  }

  /// Creates a new empty [IOSWebMessageListener] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageListener] in `aqutter` instead.
  @override
  IOSWebMessageListener createPlatformWebMessageListenerStatic() {
    return IOSWebMessageListener.static();
  }

  /// Creates a new [IOSJavaScriptReplyProxy].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterJavaScriptReplyProxy] in `aqutter` instead.
  @override
  IOSJavaScriptReplyProxy createPlatformJavaScriptReplyProxy(
    AqutterPlatformJavaScriptReplyProxyCreationParams params,
  ) {
    return IOSJavaScriptReplyProxy(params);
  }

  /// Creates a new [IOSWebMessagePort].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessagePort] in `aqutter` instead.
  @override
  IOSWebMessagePort createPlatformWebMessagePort(
    AqutterPlatformWebMessagePortCreationParams params,
  ) {
    return IOSWebMessagePort(params);
  }

  /// Creates a new [IOSWebStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  @override
  IOSWebStorage createPlatformWebStorage(
    AqutterPlatformWebStorageCreationParams params,
  ) {
    return IOSWebStorage(params);
  }

  /// Creates a new empty [IOSWebStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  @override
  IOSWebStorage createPlatformWebStorageStatic() {
    return IOSWebStorage(
      IOSWebStorageCreationParams(
        localStorage: createPlatformLocalStorageStatic(),
        sessionStorage: createPlatformSessionStorageStatic(),
      ),
    );
  }

  /// Creates a new [IOSLocalStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  @override
  IOSLocalStorage createPlatformLocalStorage(
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    return IOSLocalStorage(params);
  }

  /// Creates a new empty [IOSLocalStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  @override
  IOSLocalStorage createPlatformLocalStorageStatic() {
    return IOSLocalStorage.defaultStorage(controller: null);
  }

  /// Creates a new [IOSSessionStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterSessionStorage] in `aqutter` instead.
  @override
  IOSSessionStorage createPlatformSessionStorage(
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    return IOSSessionStorage(params);
  }

  /// Creates a new empty [IOSSessionStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterSessionStorage] in `aqutter` instead.
  @override
  IOSSessionStorage createPlatformSessionStorageStatic() {
    return IOSSessionStorage.defaultStorage(controller: null);
  }

  /// Creates a new [AqutterIOSHeadlessWebView].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHeadlessWebView] in `aqutter` instead.
  @override
  AqutterIOSHeadlessWebView createPlatformHeadlessWebView(
    AqutterPlatformHeadlessWebViewCreationParams params,
  ) {
    return AqutterIOSHeadlessWebView(params);
  }

  /// Creates a new empty [AqutterIOSHeadlessWebView] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHeadlessWebView] in `aqutter` instead.
  @override
  AqutterIOSHeadlessWebView createPlatformHeadlessWebViewStatic() {
    return AqutterIOSHeadlessWebView.static();
  }

  /// Creates a new [IOSHttpAuthCredentialDatabase].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHttpAuthCredentialDatabase] in `aqutter` instead.
  @override
  IOSHttpAuthCredentialDatabase createPlatformHttpAuthCredentialDatabase(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) {
    return IOSHttpAuthCredentialDatabase(params);
  }

  /// Creates a new empty [IOSHttpAuthCredentialDatabase] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHttpAuthCredentialDatabase] in `aqutter` instead.
  @override
  IOSHttpAuthCredentialDatabase
  createPlatformHttpAuthCredentialDatabaseStatic() {
    return IOSHttpAuthCredentialDatabase.static();
  }

  /// Creates a new [AqutterIOSBrowser].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterBrowser] in `aqutter` instead.
  @override
  AqutterIOSBrowser createPlatformBrowser(
    AqutterPlatformBrowserCreationParams params,
  ) {
    return AqutterIOSBrowser(params);
  }

  /// Creates a new empty [AqutterIOSBrowser] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterBrowser] in `aqutter` instead.
  @override
  AqutterIOSBrowser createPlatformBrowserStatic() {
    return AqutterIOSBrowser.static();
  }

  /// Creates a new [IOSChromeSafariBrowser].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterChromeSafariBrowser] in `aqutter` instead.
  @override
  IOSChromeSafariBrowser createPlatformChromeSafariBrowser(
    AqutterPlatformChromeSafariBrowserCreationParams params,
  ) {
    return IOSChromeSafariBrowser(params);
  }

  /// Creates a new empty [IOSChromeSafariBrowser] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterChromeSafariBrowser] in `aqutter` instead.
  @override
  IOSChromeSafariBrowser createPlatformChromeSafariBrowserStatic() {
    return IOSChromeSafariBrowser.static();
  }

  /// Creates a new empty [IOSWebStorageManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorageManager] in `aqutter` instead.
  @override
  IOSWebStorageManager createPlatformWebStorageManager(
    AqutterPlatformWebStorageManagerCreationParams params,
  ) {
    return IOSWebStorageManager(params);
  }

  /// Creates a new empty [IOSWebStorageManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorageManager] in `aqutter` instead.
  @override
  IOSWebStorageManager createPlatformWebStorageManagerStatic() {
    return IOSWebStorageManager.static();
  }

  /// Creates a new [IOSWebAuthenticationSession].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebAuthenticationSession] in `aqutter` instead.
  @override
  IOSWebAuthenticationSession createPlatformWebAuthenticationSession(
    AqutterPlatformWebAuthenticationSessionCreationParams params,
  ) {
    return IOSWebAuthenticationSession(params);
  }

  /// Creates a new empty [IOSWebAuthenticationSession] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebAuthenticationSession] in `aqutter` instead.
  @override
  IOSWebAuthenticationSession createPlatformWebAuthenticationSessionStatic() {
    return IOSWebAuthenticationSession.static();
  }

  /// Creates a new [IOSProxyController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProxyController] in `aqutter` instead.
  @override
  AqutterPlatformProxyController createPlatformProxyController(
    AqutterPlatformProxyControllerCreationParams params,
  ) {
    return IOSProxyController(params);
  }

  /// Creates a new empty [IOSProxyController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProxyController] in `aqutter` instead.
  @override
  IOSProxyController createPlatformProxyControllerStatic() {
    return IOSProxyController.static();
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
