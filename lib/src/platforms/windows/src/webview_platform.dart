import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import 'cookie_manager.dart';
import 'find_interaction/find_interaction_controller.dart';
import 'browser/browser.dart';
import 'webview/headless_webview.dart';
import 'webview/webview.dart';
import 'webview/webview_controller.dart';
import 'web_message/web_message_channel.dart';
import 'web_message/web_message_listener.dart';
import 'web_message/web_message_port.dart';
import 'web_notification/web_notification_controller.dart';
import 'web_storage/web_storage.dart';
import 'webview_environment/webview_environment.dart';

/// Implementation of [AqutterWebViewPlatform] using the WebView2 API.
class AqutterWindowsWebViewPlatform extends AqutterWebViewPlatform {
  /// Registers this class as the default instance of [AqutterWebViewPlatform].
  static void registerWith() {
    AqutterWebViewPlatform.instance = AqutterWindowsWebViewPlatform();
  }

  /// Creates a new [WindowsCookieManager].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCookieManager] in `aqutter` instead.
  @override
  WindowsCookieManager createPlatformCookieManager(
    AqutterPlatformCookieManagerCreationParams params,
  ) {
    return WindowsCookieManager(params);
  }

  /// Creates a new empty [WindowsCookieManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCookieManager] in `aqutter` instead.
  @override
  WindowsCookieManager createPlatformCookieManagerStatic() {
    return WindowsCookieManager.static();
  }

  /// Creates a new [AqutterWindowsWebViewController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  @override
  AqutterWindowsWebViewController createPlatformWebViewController(
    AqutterPlatformWebViewControllerCreationParams params,
  ) {
    return AqutterWindowsWebViewController(params);
  }

  /// Creates a new empty [AqutterWindowsWebViewController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  @override
  AqutterWindowsWebViewController createPlatformWebViewControllerStatic() {
    return AqutterWindowsWebViewController.static();
  }

  /// Creates a new [AqutterWindowsWebViewWidget].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  @override
  AqutterWindowsWebViewWidget createPlatformWebViewWidget(
    AqutterPlatformWebViewWidgetCreationParams params,
  ) {
    return AqutterWindowsWebViewWidget(params);
  }

  /// Creates a new empty [AqutterWindowsWebViewWidget] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  @override
  AqutterWindowsWebViewWidget createPlatformWebViewWidgetStatic() {
    return AqutterWindowsWebViewWidget.static();
  }

  /// Creates a new [AqutterWindowsBrowser].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterBrowser] in `aqutter` instead.
  @override
  AqutterWindowsBrowser createPlatformBrowser(
    AqutterPlatformBrowserCreationParams params,
  ) {
    return AqutterWindowsBrowser(params);
  }

  /// Creates a new empty [AqutterWindowsBrowser] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterBrowser] in `aqutter` instead.
  @override
  AqutterWindowsBrowser createPlatformBrowserStatic() {
    return AqutterWindowsBrowser.static();
  }

  /// Creates a new [AqutterWindowsHeadlessWebView].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHeadlessWebView] in `aqutter` instead.
  @override
  AqutterWindowsHeadlessWebView createPlatformHeadlessWebView(
    AqutterPlatformHeadlessWebViewCreationParams params,
  ) {
    return AqutterWindowsHeadlessWebView(params);
  }

  /// Creates a new empty [AqutterWindowsHeadlessWebView] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHeadlessWebView] in `aqutter` instead.
  @override
  AqutterWindowsHeadlessWebView createPlatformHeadlessWebViewStatic() {
    return AqutterWindowsHeadlessWebView.static();
  }

  /// Creates a new [WindowsWebViewEnvironment].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewEnvironment] in `aqutter` instead.
  @override
  WindowsWebViewEnvironment createPlatformWebViewEnvironment(
    AqutterPlatformWebViewEnvironmentCreationParams params,
  ) {
    return WindowsWebViewEnvironment(params);
  }

  /// Creates a new empty [WindowsWebViewEnvironment] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewEnvironment] in `aqutter` instead.
  @override
  WindowsWebViewEnvironment createPlatformWebViewEnvironmentStatic() {
    return WindowsWebViewEnvironment.static();
  }

  /// Creates a new [WindowsWebStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  @override
  WindowsWebStorage createPlatformWebStorage(
    AqutterPlatformWebStorageCreationParams params,
  ) {
    return WindowsWebStorage(params);
  }

  /// Creates a new empty [WindowsWebStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  @override
  WindowsWebStorage createPlatformWebStorageStatic() {
    return WindowsWebStorage(
      WindowsWebStorageCreationParams(
        localStorage: createPlatformLocalStorageStatic(),
        sessionStorage: createPlatformSessionStorageStatic(),
      ),
    );
  }

  /// Creates a new [WindowsLocalStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  @override
  WindowsLocalStorage createPlatformLocalStorage(
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    return WindowsLocalStorage(params);
  }

  /// Creates a new empty [WindowsLocalStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  @override
  WindowsLocalStorage createPlatformLocalStorageStatic() {
    return WindowsLocalStorage.defaultStorage(controller: null);
  }

  /// Creates a new [WindowsSessionStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterSessionStorage] in `aqutter` instead.
  @override
  WindowsSessionStorage createPlatformSessionStorage(
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    return WindowsSessionStorage(params);
  }

  /// Creates a new empty [WindowsSessionStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterSessionStorage] in `aqutter` instead.
  @override
  WindowsSessionStorage createPlatformSessionStorageStatic() {
    return WindowsSessionStorage.defaultStorage(controller: null);
  }

  /// Creates a new [WindowsWebMessageChannel].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageChannel] in `aqutter` instead.
  @override
  WindowsWebMessageChannel createPlatformWebMessageChannel(
    AqutterPlatformWebMessageChannelCreationParams params,
  ) {
    return WindowsWebMessageChannel(params);
  }

  /// Creates a new empty [WindowsWebMessageChannel] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageChannel] in `aqutter` instead.
  @override
  WindowsWebMessageChannel createPlatformWebMessageChannelStatic() {
    return WindowsWebMessageChannel.static();
  }

  /// Creates a new [WindowsWebMessagePort].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessagePort] in `aqutter` instead.
  @override
  WindowsWebMessagePort createPlatformWebMessagePort(
    AqutterPlatformWebMessagePortCreationParams params,
  ) {
    return WindowsWebMessagePort(params);
  }

  /// Creates a new [WindowsWebMessageListener].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageListener] in `aqutter` instead.
  @override
  WindowsWebMessageListener createPlatformWebMessageListener(
    AqutterPlatformWebMessageListenerCreationParams params,
  ) {
    return WindowsWebMessageListener(params);
  }

  /// Creates a new [WindowsJavaScriptReplyProxy].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterJavaScriptReplyProxy] in `aqutter` instead.
  @override
  WindowsJavaScriptReplyProxy createPlatformJavaScriptReplyProxy(
    AqutterPlatformJavaScriptReplyProxyCreationParams params,
  ) {
    return WindowsJavaScriptReplyProxy(params);
  }

  /// Creates a new empty [WindowsWebMessageListener] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageListener] in `aqutter` instead.
  @override
  WindowsWebMessageListener createPlatformWebMessageListenerStatic() {
    return WindowsWebMessageListener.static();
  }

  /// Creates a new [WindowsFindInteractionController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterFindInteractionController] in `aqutter` instead.
  @override
  WindowsFindInteractionController createPlatformFindInteractionController(
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) {
    return WindowsFindInteractionController(params);
  }

  /// Creates a new empty [WindowsFindInteractionController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterFindInteractionController] in `aqutter` instead.
  @override
  WindowsFindInteractionController
  createPlatformFindInteractionControllerStatic() {
    return WindowsFindInteractionController.static();
  }

  /// Creates a new [WindowsWebNotificationController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebNotificationController] in `aqutter` instead.
  @override
  WindowsWebNotificationController createPlatformWebNotificationController(
    AqutterPlatformWebNotificationControllerCreationParams params,
  ) {
    return WindowsWebNotificationController(params);
  }

  /// Creates a new empty [WindowsWebNotificationController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebNotificationController] in `aqutter` instead.
  @override
  WindowsWebNotificationController
  createPlatformWebNotificationControllerStatic() {
    return WindowsWebNotificationController.static();
  }

  // ************************************************************************ //
  // Create static instances of unsupported classes to be able to call        //
  // isClassSupported, isMethodSupported, isPropertySupported, etc.           //
  // static methods without throwing a missing platform implementation        //
  // exception.                                                               //
  // ************************************************************************ //

  /// Creates a new empty [AqutterPlatformWebStorageManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorageManager] in `aqutter` instead.
  @override
  AqutterPlatformWebStorageManager createPlatformWebStorageManagerStatic() {
    return _PlatformWebStorageManager.static();
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

class _PlatformWebStorageManager extends AqutterPlatformWebStorageManager {
  _PlatformWebStorageManager(AqutterPlatformWebStorageManagerCreationParams params)
    : super.implementation(params);

  static final _PlatformWebStorageManager _staticValue =
      _PlatformWebStorageManager(
        const AqutterPlatformWebStorageManagerCreationParams(),
      );

  factory _PlatformWebStorageManager.static() => _staticValue;
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
