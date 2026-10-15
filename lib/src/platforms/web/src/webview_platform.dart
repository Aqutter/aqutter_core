import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import 'cookie_manager.dart';
import 'webview/main.dart';
import 'web_storage/web_storage.dart';

/// Implementation of [AqutterWebViewPlatform] using the Web API.
class AqutterWebPlatformWebViewPlatform extends AqutterWebViewPlatform {
  /// Registers this class as the default instance of [AqutterWebViewPlatform].
  static void registerWith() {
    AqutterWebViewPlatform.instance = AqutterWebPlatformWebViewPlatform();
  }

  /// Creates a new [WebPlatformCookieManager].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCookieManager] in `aqutter` instead.
  @override
  WebPlatformCookieManager createPlatformCookieManager(
    AqutterPlatformCookieManagerCreationParams params,
  ) {
    return WebPlatformCookieManager(params);
  }

  /// Creates a new empty [WebPlatformCookieManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCookieManager] in `aqutter` instead.
  @override
  WebPlatformCookieManager createPlatformCookieManagerStatic() {
    return WebPlatformCookieManager.static();
  }

  /// Creates a new [AqutterWebPlatformWebViewController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  @override
  AqutterWebPlatformWebViewController createPlatformWebViewController(
    AqutterPlatformWebViewControllerCreationParams params,
  ) {
    return AqutterWebPlatformWebViewController(params);
  }

  /// Creates a new empty [AqutterWebPlatformWebViewController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  @override
  AqutterWebPlatformWebViewController
  createPlatformWebViewControllerStatic() {
    return AqutterWebPlatformWebViewController.static();
  }

  /// Creates a new [AqutterWebPlatformWebViewWidget].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  @override
  AqutterWebPlatformWebViewWidget createPlatformWebViewWidget(
    AqutterPlatformWebViewWidgetCreationParams params,
  ) {
    return AqutterWebPlatformWebViewWidget(params);
  }

  /// Creates a new empty [AqutterWebPlatformWebViewWidget] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  @override
  AqutterWebPlatformWebViewWidget createPlatformWebViewWidgetStatic() {
    return AqutterWebPlatformWebViewWidget.static();
  }

  /// Creates a new [AqutterWebPlatformHeadlessWebView].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHeadlessWebView] in `aqutter` instead.
  @override
  AqutterWebPlatformHeadlessWebView createPlatformHeadlessWebView(
    AqutterPlatformHeadlessWebViewCreationParams params,
  ) {
    return AqutterWebPlatformHeadlessWebView(params);
  }

  /// Creates a new empty [AqutterWebPlatformHeadlessWebView] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHeadlessWebView] in `aqutter` instead.
  @override
  AqutterWebPlatformHeadlessWebView createPlatformHeadlessWebViewStatic() {
    return AqutterWebPlatformHeadlessWebView.static();
  }

  /// Creates a new [WebPlatformWebStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  @override
  WebPlatformWebStorage createPlatformWebStorage(
    AqutterPlatformWebStorageCreationParams params,
  ) {
    return WebPlatformWebStorage(params);
  }

  /// Creates a new empty [WebPlatformWebStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  @override
  WebPlatformWebStorage createPlatformWebStorageStatic() {
    return WebPlatformWebStorage(
      WebPlatformWebStorageCreationParams(
        localStorage: createPlatformLocalStorageStatic(),
        sessionStorage: createPlatformSessionStorageStatic(),
      ),
    );
  }

  /// Creates a new [WebPlatformLocalStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  @override
  WebPlatformLocalStorage createPlatformLocalStorage(
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    return WebPlatformLocalStorage(params);
  }

  /// Creates a new empty [WebPlatformLocalStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  @override
  WebPlatformLocalStorage createPlatformLocalStorageStatic() {
    return WebPlatformLocalStorage.defaultStorage(controller: null);
  }

  /// Creates a new [WebPlatformSessionStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterSessionStorage] in `aqutter` instead.
  @override
  WebPlatformSessionStorage createPlatformSessionStorage(
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    return WebPlatformSessionStorage(params);
  }

  /// Creates a new empty [WebPlatformSessionStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterSessionStorage] in `aqutter` instead.
  @override
  WebPlatformSessionStorage createPlatformSessionStorageStatic() {
    return WebPlatformSessionStorage.defaultStorage(controller: null);
  }

  /// Creates a new empty [AqutterPlatformWebStorageManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorageManager] in `aqutter` instead.
  @override
  AqutterPlatformWebStorageManager createPlatformWebStorageManagerStatic() {
    return _PlatformWebStorageManager.static();
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

  /// Creates a new empty [AqutterPlatformBrowser] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterBrowser] in `aqutter` instead.
  @override
  AqutterPlatformBrowser createPlatformBrowserStatic() {
    return _AqutterPlatformBrowser.static();
  }

  /// Creates a new empty [AqutterPlatformChromeSafariBrowser] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterChromeSafariBrowser] in `aqutter` instead.
  AqutterPlatformChromeSafariBrowser createPlatformChromeSafariBrowserStatic() {
    return _PlatformChromeSafariBrowser.static();
  }

  /// Creates a new empty [AqutterPlatformHttpAuthCredentialDatabase] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHttpAuthCredentialDatabase] in `aqutter` instead.
  @override
  AqutterPlatformHttpAuthCredentialDatabase
  createPlatformHttpAuthCredentialDatabaseStatic() {
    return _PlatformHttpAuthCredentialDatabase.static();
  }

  /// Creates a new empty [AqutterPlatformProcessGlobalConfig] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProcessGlobalConfig] in `aqutter` instead.
  @override
  AqutterPlatformProcessGlobalConfig createPlatformProcessGlobalConfigStatic() {
    return _PlatformProcessGlobalConfig.static();
  }

  /// Creates a new empty [AqutterPlatformProxyController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProxyController] in `aqutter` instead.
  @override
  AqutterPlatformProxyController createPlatformProxyControllerStatic() {
    return _PlatformProxyController.static();
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

  /// Creates a new empty [AqutterPlatformFindInteractionController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterFindInteractionController] in `aqutter` instead.
  @override
  AqutterPlatformFindInteractionController
  createPlatformFindInteractionControllerStatic() {
    return _PlatformFindInteractionController.static();
  }

  /// Creates a new empty [AqutterPlatformPrintJobController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPrintJobController] in `aqutter` instead.
  @override
  AqutterPlatformPrintJobController createPlatformPrintJobControllerStatic() {
    return _PlatformPrintJobController.static();
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

  /// Creates a new empty [AqutterPlatformWebAuthenticationSession] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebAuthenticationSession] in `aqutter` instead.
  @override
  AqutterPlatformWebAuthenticationSession
  createPlatformWebAuthenticationSessionStatic() {
    return _PlatformWebAuthenticationSession.static();
  }

  /// Creates a new empty [AqutterPlatformWebMessageChannel] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageChannel] in `aqutter` instead.
  @override
  AqutterPlatformWebMessageChannel createPlatformWebMessageChannelStatic() {
    return _PlatformWebMessageChannel.static();
  }

  /// Creates a new empty [AqutterPlatformWebMessageListener] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageListener] in `aqutter` instead.
  @override
  AqutterPlatformWebMessageListener createPlatformWebMessageListenerStatic() {
    return _PlatformWebMessageListener.static();
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

  /// Creates a new empty [AqutterPlatformLocalhostServer] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalhostServer] in `aqutter` instead.
  @override
  AqutterPlatformLocalhostServer createPlatformLocalhostServerStatic() {
    return _AqutterPlatformLocalhostServer.static();
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

class _AqutterPlatformBrowser extends AqutterPlatformBrowser {
  _AqutterPlatformBrowser(AqutterPlatformBrowserCreationParams params)
    : super.implementation(params);
  static final _AqutterPlatformBrowser _staticValue = _AqutterPlatformBrowser(
    const AqutterPlatformBrowserCreationParams(),
  );

  factory _AqutterPlatformBrowser.static() => _staticValue;
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

class _PlatformHttpAuthCredentialDatabase
    extends AqutterPlatformHttpAuthCredentialDatabase {
  _PlatformHttpAuthCredentialDatabase(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) : super.implementation(params);
  static final _PlatformHttpAuthCredentialDatabase _staticValue =
      _PlatformHttpAuthCredentialDatabase(
        const AqutterPlatformHttpAuthCredentialDatabaseCreationParams(),
      );

  factory _PlatformHttpAuthCredentialDatabase.static() => _staticValue;
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

class _PlatformProxyController extends AqutterPlatformProxyController {
  _PlatformProxyController(AqutterPlatformProxyControllerCreationParams params)
    : super.implementation(params);
  static final _PlatformProxyController _staticValue = _PlatformProxyController(
    const AqutterPlatformProxyControllerCreationParams(),
  );

  factory _PlatformProxyController.static() => _staticValue;
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

class _PlatformFindInteractionController
    extends AqutterPlatformFindInteractionController {
  _PlatformFindInteractionController(
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) : super.implementation(params);
  static final _PlatformFindInteractionController _staticValue =
      _PlatformFindInteractionController(
        const AqutterPlatformFindInteractionControllerCreationParams(),
      );

  factory _PlatformFindInteractionController.static() => _staticValue;
}

class _PlatformPrintJobController extends AqutterPlatformPrintJobController {
  _PlatformPrintJobController(AqutterPlatformPrintJobControllerCreationParams params)
    : super.implementation(params);

  static final _PlatformPrintJobController _staticValue =
      _PlatformPrintJobController(
        const AqutterPlatformPrintJobControllerCreationParams(id: ''),
      );

  factory _PlatformPrintJobController.static() => _staticValue;
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

class _PlatformWebAuthenticationSession
    extends AqutterPlatformWebAuthenticationSession {
  _PlatformWebAuthenticationSession(
    AqutterPlatformWebAuthenticationSessionCreationParams params,
  ) : super.implementation(params);

  static final _PlatformWebAuthenticationSession _staticValue =
      _PlatformWebAuthenticationSession(
        const AqutterPlatformWebAuthenticationSessionCreationParams(),
      );

  factory _PlatformWebAuthenticationSession.static() => _staticValue;
}

class _PlatformWebMessageChannel extends AqutterPlatformWebMessageChannel {
  _PlatformWebMessageChannel(AqutterPlatformWebMessageChannelCreationParams params)
    : super.implementation(params);

  static final _PlatformWebMessageChannel _staticValue =
      _PlatformWebMessageChannel(
        AqutterPlatformWebMessageChannelCreationParams(
          id: '',
          port1: _PlatformWebMessagePort(
            const AqutterPlatformWebMessagePortCreationParams(index: 0),
          ),
          port2: _PlatformWebMessagePort(
            const AqutterPlatformWebMessagePortCreationParams(index: 1),
          ),
        ),
      );

  factory _PlatformWebMessageChannel.static() => _staticValue;
}

class _PlatformWebMessageListener extends AqutterPlatformWebMessageListener {
  _PlatformWebMessageListener(AqutterPlatformWebMessageListenerCreationParams params)
    : super.implementation(params);

  static final _PlatformWebMessageListener _staticValue =
      _PlatformWebMessageListener(
        const AqutterPlatformWebMessageListenerCreationParams(jsObjectName: ''),
      );

  factory _PlatformWebMessageListener.static() => _staticValue;
}

class _PlatformWebMessagePort extends AqutterPlatformWebMessagePort {
  _PlatformWebMessagePort(AqutterPlatformWebMessagePortCreationParams params)
    : super.implementation(params);

  static final _PlatformWebMessagePort _staticValue = _PlatformWebMessagePort(
    const AqutterPlatformWebMessagePortCreationParams(index: 0),
  );

  factory _PlatformWebMessagePort.static() => _staticValue;

  @override
  Future<void> close() {
    throw UnimplementedError();
  }

  @override
  Future<void> postMessage(AqutterWebMessage message) {
    throw UnimplementedError();
  }

  @override
  Future<void> setWebMessageCallback(AqutterWebMessageCallback? onMessage) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    throw UnimplementedError();
  }
}

class _PlatformWebStorageManager extends AqutterPlatformWebStorageManager {
  _PlatformWebStorageManager(AqutterPlatformWebStorageManagerCreationParams params)
    : super.implementation(params);

  static final _PlatformWebStorageManager _staticValue =
      _PlatformWebStorageManager(
        const AqutterPlatformWebStorageManagerCreationParams(),
      );

  factory _PlatformWebStorageManager.static() => _staticValue;
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

class _AqutterPlatformLocalhostServer extends AqutterPlatformLocalhostServer {
  _AqutterPlatformLocalhostServer(
    AqutterPlatformLocalhostServerCreationParams params,
  ) : super.implementation(params);

  static final _AqutterPlatformLocalhostServer _staticValue =
      _AqutterPlatformLocalhostServer(
        const AqutterPlatformLocalhostServerCreationParams(),
      );

  factory _AqutterPlatformLocalhostServer.static() => _staticValue;
}
