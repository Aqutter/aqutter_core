import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import 'cookie_manager/cookie_manager.dart';
import 'find_interaction/find_interaction_controller.dart';
import 'http_auth_credentials_database.dart';
import 'browser/browser.dart';
import 'webview/webview.dart';
import 'webview/webview_controller.dart';
import 'webview/headless_webview.dart';
import 'proxy_controller/proxy_controller.dart';
import 'web_message/web_message_channel.dart';
import 'web_message/web_message_listener.dart';
import 'web_message/web_message_port.dart';
import 'web_storage/web_storage.dart';
import 'web_storage/web_storage_manager.dart';
import 'webview_environment/webview_environment.dart';

/// Implementation of [AqutterWebViewPlatform] using WPE WebKit.
class AqutterLinuxWebViewPlatform extends AqutterWebViewPlatform {
  /// Registers this class as the default instance of [AqutterWebViewPlatform].
  static void registerWith() {
    AqutterWebViewPlatform.instance = AqutterLinuxWebViewPlatform();
  }

  /// Creates a new [AqutterLinuxWebViewController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  @override
  AqutterLinuxWebViewController createPlatformWebViewController(
    AqutterPlatformWebViewControllerCreationParams params,
  ) {
    return AqutterLinuxWebViewController(params);
  }

  /// Creates a new empty [AqutterLinuxWebViewController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  @override
  AqutterLinuxWebViewController createPlatformWebViewControllerStatic() {
    return AqutterLinuxWebViewController.static();
  }

  /// Creates a new [AqutterLinuxWebViewWidget].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  @override
  AqutterLinuxWebViewWidget createPlatformWebViewWidget(
    AqutterPlatformWebViewWidgetCreationParams params,
  ) {
    return AqutterLinuxWebViewWidget(params);
  }

  /// Creates a new empty [AqutterLinuxWebViewWidget] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  @override
  AqutterLinuxWebViewWidget createPlatformWebViewWidgetStatic() {
    return AqutterLinuxWebViewWidget.static();
  }

  /// Creates a new empty [AqutterPlatformCookieManager] to access static methods.
  @override
  AqutterPlatformCookieManager createPlatformCookieManagerStatic() {
    return LinuxCookieManager.static();
  }

  /// Creates a new [LinuxCookieManager].
  @override
  LinuxCookieManager createPlatformCookieManager(
    AqutterPlatformCookieManagerCreationParams params,
  ) {
    return LinuxCookieManager(params);
  }

  /// Creates a new empty [AqutterPlatformWebViewEnvironment] to access static methods.
  @override
  AqutterPlatformWebViewEnvironment createPlatformWebViewEnvironmentStatic() {
    return LinuxWebViewEnvironment.static();
  }

  /// Creates a new [LinuxWebViewEnvironment].
  @override
  LinuxWebViewEnvironment createPlatformWebViewEnvironment(
    AqutterPlatformWebViewEnvironmentCreationParams params,
  ) {
    return LinuxWebViewEnvironment(params);
  }

  // ************************************************************************ //
  // Create static instances of unsupported classes to be able to call        //
  // isClassSupported, isMethodSupported, isPropertySupported, etc.           //
  // static methods without throwing a missing platform implementation        //
  // exception.                                                               //
  // ************************************************************************ //

  /// Creates a new empty [AqutterPlatformChromeSafariBrowser] to access static methods.
  @override
  AqutterPlatformChromeSafariBrowser createPlatformChromeSafariBrowserStatic() {
    return _PlatformChromeSafariBrowser.static();
  }

  /// Creates a new [LinuxHttpAuthCredentialDatabase].
  @override
  LinuxHttpAuthCredentialDatabase createPlatformHttpAuthCredentialDatabase(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) {
    return LinuxHttpAuthCredentialDatabase(params);
  }

  /// Creates a new empty [LinuxHttpAuthCredentialDatabase] to access static methods.
  @override
  LinuxHttpAuthCredentialDatabase
  createPlatformHttpAuthCredentialDatabaseStatic() {
    return LinuxHttpAuthCredentialDatabase.static();
  }

  /// Creates a new empty [AqutterLinuxBrowser] to access static methods.
  @override
  AqutterLinuxBrowser createPlatformBrowserStatic() {
    return AqutterLinuxBrowser.static();
  }

  /// Creates a new [AqutterLinuxBrowser].
  @override
  AqutterLinuxBrowser createPlatformBrowser(
    AqutterPlatformBrowserCreationParams params,
  ) {
    return AqutterLinuxBrowser(params);
  }

  /// Creates a new empty [AqutterPlatformHeadlessWebView] to access static methods.
  @override
  AqutterPlatformHeadlessWebView createPlatformHeadlessWebViewStatic() {
    return AqutterLinuxHeadlessWebView.static();
  }

  /// Creates a new [AqutterLinuxHeadlessWebView].
  @override
  AqutterLinuxHeadlessWebView createPlatformHeadlessWebView(
    AqutterPlatformHeadlessWebViewCreationParams params,
  ) {
    return AqutterLinuxHeadlessWebView(params);
  }

  /// Creates a new empty [AqutterPlatformProcessGlobalConfig] to access static methods.
  @override
  AqutterPlatformProcessGlobalConfig createPlatformProcessGlobalConfigStatic() {
    return _PlatformProcessGlobalConfig.static();
  }

  /// Creates a new empty [AqutterPlatformProxyController] to access static methods.
  @override
  AqutterPlatformProxyController createPlatformProxyControllerStatic() {
    return LinuxProxyController.static();
  }

  /// Creates a new [LinuxProxyController].
  @override
  LinuxProxyController createPlatformProxyController(
    AqutterPlatformProxyControllerCreationParams params,
  ) {
    return LinuxProxyController(params);
  }

  /// Creates a new empty [AqutterPlatformServiceWorkerController] to access static methods.
  @override
  AqutterPlatformServiceWorkerController
  createPlatformServiceWorkerControllerStatic() {
    return _PlatformServiceWorkerController.static();
  }

  /// Creates a new empty [AqutterPlatformTracingController] to access static methods.
  @override
  AqutterPlatformTracingController createPlatformTracingControllerStatic() {
    return _PlatformTracingController.static();
  }

  /// Creates a new empty [AqutterPlatformFindInteractionController] to access static methods.
  @override
  AqutterPlatformFindInteractionController
  createPlatformFindInteractionControllerStatic() {
    return LinuxFindInteractionController.static();
  }

  /// Creates a new [LinuxFindInteractionController].
  @override
  LinuxFindInteractionController createPlatformFindInteractionController(
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) {
    return LinuxFindInteractionController(params);
  }

  /// Creates a new empty [AqutterPlatformPrintJobController] to access static methods.
  @override
  AqutterPlatformPrintJobController createPlatformPrintJobControllerStatic() {
    return _PlatformPrintJobController.static();
  }

  /// Creates a new empty [AqutterPlatformPullToRefreshController] to access static methods.
  @override
  AqutterPlatformPullToRefreshController
  createPlatformPullToRefreshControllerStatic() {
    return _PlatformPullToRefreshController.static();
  }

  /// Creates a new empty [AqutterPlatformWebAuthenticationSession] to access static methods.
  @override
  AqutterPlatformWebAuthenticationSession
  createPlatformWebAuthenticationSessionStatic() {
    return _PlatformWebAuthenticationSession.static();
  }

  /// Creates a new empty [AqutterPlatformWebNotificationController] to access static methods.
  @override
  AqutterPlatformWebNotificationController
  createPlatformWebNotificationControllerStatic() {
    return _PlatformWebNotificationController.static();
  }

  /// Creates a new empty [LinuxWebMessageChannel] to access static methods.
  @override
  LinuxWebMessageChannel createPlatformWebMessageChannelStatic() {
    return LinuxWebMessageChannel.static();
  }

  /// Creates a new [LinuxWebMessageChannel].
  @override
  LinuxWebMessageChannel createPlatformWebMessageChannel(
    AqutterPlatformWebMessageChannelCreationParams params,
  ) {
    return LinuxWebMessageChannel(params);
  }

  /// Creates a new [LinuxWebMessagePort].
  @override
  LinuxWebMessagePort createPlatformWebMessagePort(
    AqutterPlatformWebMessagePortCreationParams params,
  ) {
    return LinuxWebMessagePort(params);
  }

  /// Creates a new empty [AqutterPlatformWebMessageListener] to access static methods.
  @override
  AqutterPlatformWebMessageListener createPlatformWebMessageListenerStatic() {
    return LinuxWebMessageListener.static();
  }

  /// Creates a new [LinuxWebMessageListener].
  @override
  LinuxWebMessageListener createPlatformWebMessageListener(
    AqutterPlatformWebMessageListenerCreationParams params,
  ) {
    return LinuxWebMessageListener(params);
  }

  /// Creates a new [LinuxWebStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  @override
  LinuxWebStorage createPlatformWebStorage(
    AqutterPlatformWebStorageCreationParams params,
  ) {
    return LinuxWebStorage(params);
  }

  /// Creates a new empty [LinuxWebStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  @override
  LinuxWebStorage createPlatformWebStorageStatic() {
    return LinuxWebStorage(
      LinuxWebStorageCreationParams(
        localStorage: createPlatformLocalStorageStatic(),
        sessionStorage: createPlatformSessionStorageStatic(),
      ),
    );
  }

  /// Creates a new [LinuxLocalStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  @override
  LinuxLocalStorage createPlatformLocalStorage(
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    return LinuxLocalStorage(params);
  }

  /// Creates a new empty [LinuxLocalStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  @override
  LinuxLocalStorage createPlatformLocalStorageStatic() {
    return LinuxLocalStorage.defaultStorage(controller: null);
  }

  /// Creates a new [LinuxSessionStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterSessionStorage] in `aqutter` instead.
  @override
  LinuxSessionStorage createPlatformSessionStorage(
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    return LinuxSessionStorage(params);
  }

  /// Creates a new empty [LinuxSessionStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterSessionStorage] in `aqutter` instead.
  @override
  LinuxSessionStorage createPlatformSessionStorageStatic() {
    return LinuxSessionStorage.defaultStorage(controller: null);
  }

  /// Creates a new empty [AqutterPlatformWebStorageManager] to access static methods.
  @override
  AqutterPlatformWebStorageManager createPlatformWebStorageManagerStatic() {
    return LinuxWebStorageManager.static();
  }

  /// Creates a new [LinuxWebStorageManager].
  @override
  LinuxWebStorageManager createPlatformWebStorageManager(
    AqutterPlatformWebStorageManagerCreationParams params,
  ) {
    return LinuxWebStorageManager(params);
  }

  /// Creates a new empty [AqutterPlatformAssetsPathHandler] to access static methods.
  @override
  AqutterPlatformAssetsPathHandler createPlatformAssetsPathHandlerStatic() {
    return _PlatformAssetsPathHandler.static();
  }

  /// Creates a new empty [AqutterPlatformResourcesPathHandler] to access static methods.
  @override
  AqutterPlatformResourcesPathHandler createPlatformResourcesPathHandlerStatic() {
    return _PlatformResourcesPathHandler.static();
  }

  /// Creates a new empty [AqutterPlatformInternalStoragePathHandler] to access static methods.
  @override
  AqutterPlatformInternalStoragePathHandler
  createPlatformInternalStoragePathHandlerStatic() {
    return _PlatformInternalStoragePathHandler.static();
  }

  /// Creates a new empty [AqutterPlatformCustomPathHandler] to access static methods.
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

// Stub implementations for unsupported classes

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
