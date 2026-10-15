import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import 'chrome_safari_browser/chrome_safari_browser.dart';
import 'cookie_manager.dart';
import 'find_interaction/main.dart';
import 'http_auth_credentials_database.dart';
import 'browser/browser.dart';
import 'webview/main.dart';
import 'print_job/main.dart';
import 'process_global_config.dart';
import 'proxy_controller.dart';
import 'pull_to_refresh/main.dart';
import 'service_worker_controller.dart';
import 'tracing_controller.dart';
import 'web_message/main.dart';
import 'web_storage/main.dart';
import 'webview_asset_loader.dart';
import 'webview_feature.dart' as wv;

/// Implementation of [AqutterWebViewPlatform] using the WebView API.
class AqutterAndroidWebViewPlatform extends AqutterWebViewPlatform {
  /// Registers this class as the default instance of [AqutterWebViewPlatform].
  static void registerWith() {
    AqutterWebViewPlatform.instance = AqutterAndroidWebViewPlatform();
    // The platform view factory picks a composition mode synchronously, so whether Hybrid
    // Composition++ is available has to be known by then. Start resolving it here, at the
    // earliest point the plugin runs any Dart code.
    precacheHybridCompositionPlusPlusSupport();
  }

  /// Creates a new [AndroidCookieManager].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCookieManager] in `aqutter` instead.
  @override
  AndroidCookieManager createPlatformCookieManager(
    AqutterPlatformCookieManagerCreationParams params,
  ) {
    return AndroidCookieManager(params);
  }

  /// Creates a new empty [AndroidCookieManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCookieManager] in `aqutter` instead.
  @override
  AndroidCookieManager createPlatformCookieManagerStatic() {
    return AndroidCookieManager.static();
  }

  /// Creates a new [AqutterAndroidWebViewControllerImpl].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  @override
  AqutterAndroidWebViewControllerImpl createPlatformWebViewController(
    AqutterPlatformWebViewControllerCreationParams params,
  ) {
    return AqutterAndroidWebViewControllerImpl(params);
  }

  /// Creates a new empty [AqutterAndroidWebViewControllerImpl] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  @override
  AqutterAndroidWebViewControllerImpl createPlatformWebViewControllerStatic() {
    return AqutterAndroidWebViewControllerImpl.static();
  }

  /// Creates a new [AqutterAndroidWebViewWidget].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  @override
  AqutterAndroidWebViewWidget createPlatformWebViewWidget(
    AqutterPlatformWebViewWidgetCreationParams params,
  ) {
    return AqutterAndroidWebViewWidget(params);
  }

  /// Creates a new empty [AqutterAndroidWebViewWidget] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  @override
  AqutterAndroidWebViewWidget createPlatformWebViewWidgetStatic() {
    return AqutterAndroidWebViewWidget.static();
  }

  /// Creates a new [AndroidFindInteractionController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterFindInteractionController] in `aqutter` instead.
  @override
  AndroidFindInteractionController createPlatformFindInteractionController(
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) {
    return AndroidFindInteractionController(params);
  }

  /// Creates a new empty [AndroidFindInteractionController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterFindInteractionController] in `aqutter` instead.
  @override
  AndroidFindInteractionController
  createPlatformFindInteractionControllerStatic() {
    return AndroidFindInteractionController.static();
  }

  /// Creates a new [AndroidPrintJobController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPrintJobController] in `aqutter` instead.
  @override
  AndroidPrintJobController createPlatformPrintJobController(
    AqutterPlatformPrintJobControllerCreationParams params,
  ) {
    return AndroidPrintJobController(params);
  }

  /// Creates a new empty [AqutterPlatformPrintJobController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPrintJobController] in `aqutter` instead.
  @override
  AndroidPrintJobController createPlatformPrintJobControllerStatic() {
    return AndroidPrintJobController.static();
  }

  /// Creates a new [AndroidPullToRefreshController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPullToRefreshController] in `aqutter` instead.
  @override
  AndroidPullToRefreshController createPlatformPullToRefreshController(
    AqutterPlatformPullToRefreshControllerCreationParams params,
  ) {
    return AndroidPullToRefreshController(params);
  }

  /// Creates a new empty [AndroidPullToRefreshController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPullToRefreshController] in `aqutter` instead.
  @override
  AndroidPullToRefreshController createPlatformPullToRefreshControllerStatic() {
    return AndroidPullToRefreshController.static();
  }

  /// Creates a new [AndroidWebMessageChannel].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageChannel] in `aqutter` instead.
  @override
  AndroidWebMessageChannel createPlatformWebMessageChannel(
    AqutterPlatformWebMessageChannelCreationParams params,
  ) {
    return AndroidWebMessageChannel(params);
  }

  /// Creates a new empty [AndroidWebMessageChannel] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageChannel] in `aqutter` instead.
  @override
  AndroidWebMessageChannel createPlatformWebMessageChannelStatic() {
    return AndroidWebMessageChannel.static();
  }

  /// Creates a new [AndroidWebMessageListener].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageListener] in `aqutter` instead.
  @override
  AndroidWebMessageListener createPlatformWebMessageListener(
    AqutterPlatformWebMessageListenerCreationParams params,
  ) {
    return AndroidWebMessageListener(params);
  }

  /// Creates a new empty [AndroidWebMessageListener] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageListener] in `aqutter` instead.
  @override
  AndroidWebMessageListener createPlatformWebMessageListenerStatic() {
    return AndroidWebMessageListener.static();
  }

  /// Creates a new [AndroidJavaScriptReplyProxy].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterJavaScriptReplyProxy] in `aqutter` instead.
  @override
  AndroidJavaScriptReplyProxy createPlatformJavaScriptReplyProxy(
    AqutterPlatformJavaScriptReplyProxyCreationParams params,
  ) {
    return AndroidJavaScriptReplyProxy(params);
  }

  /// Creates a new [AndroidWebMessagePort].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessagePort] in `aqutter` instead.
  @override
  AndroidWebMessagePort createPlatformWebMessagePort(
    AqutterPlatformWebMessagePortCreationParams params,
  ) {
    return AndroidWebMessagePort(params);
  }

  /// Creates a new [AndroidWebStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  @override
  AndroidWebStorage createPlatformWebStorage(
    AqutterPlatformWebStorageCreationParams params,
  ) {
    return AndroidWebStorage(params);
  }

  /// Creates a new empty [AndroidWebStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  @override
  AndroidWebStorage createPlatformWebStorageStatic() {
    return AndroidWebStorage(
      AndroidWebStorageCreationParams(
        localStorage: createPlatformLocalStorageStatic(),
        sessionStorage: createPlatformSessionStorageStatic(),
      ),
    );
  }

  /// Creates a new [AndroidLocalStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  @override
  AndroidLocalStorage createPlatformLocalStorage(
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    return AndroidLocalStorage(params);
  }

  /// Creates a new empty [AndroidLocalStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  @override
  AndroidLocalStorage createPlatformLocalStorageStatic() {
    return AndroidLocalStorage.defaultStorage(controller: null);
  }

  /// Creates a new [AndroidSessionStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterSessionStorage] in `aqutter` instead.
  @override
  AndroidSessionStorage createPlatformSessionStorage(
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    return AndroidSessionStorage(params);
  }

  /// Creates a new empty [AndroidSessionStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterSessionStorage] in `aqutter` instead.
  @override
  AndroidSessionStorage createPlatformSessionStorageStatic() {
    return AndroidSessionStorage.defaultStorage(controller: null);
  }

  /// Creates a new [AqutterAndroidHeadlessWebView].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHeadlessWebView] in `aqutter` instead.
  @override
  AqutterAndroidHeadlessWebView createPlatformHeadlessWebView(
    AqutterPlatformHeadlessWebViewCreationParams params,
  ) {
    return AqutterAndroidHeadlessWebView(params);
  }

  /// Creates a new empty [AqutterAndroidHeadlessWebView] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHeadlessWebView] in `aqutter` instead.
  @override
  AqutterAndroidHeadlessWebView createPlatformHeadlessWebViewStatic() {
    return AqutterAndroidHeadlessWebView.static();
  }

  /// Creates a new [AndroidHttpAuthCredentialDatabase].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHttpAuthCredentialDatabase] in `aqutter` instead.
  @override
  AndroidHttpAuthCredentialDatabase createPlatformHttpAuthCredentialDatabase(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) {
    return AndroidHttpAuthCredentialDatabase(params);
  }

  /// Creates a new empty [AndroidHttpAuthCredentialDatabase] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHttpAuthCredentialDatabase] in `aqutter` instead.
  @override
  AndroidHttpAuthCredentialDatabase
  createPlatformHttpAuthCredentialDatabaseStatic() {
    return AndroidHttpAuthCredentialDatabase.static();
  }

  /// Creates a new [AqutterAndroidBrowser].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterBrowser] in `aqutter` instead.
  @override
  AqutterAndroidBrowser createPlatformBrowser(
    AqutterPlatformBrowserCreationParams params,
  ) {
    return AqutterAndroidBrowser(params);
  }

  /// Creates a new empty [AqutterAndroidBrowser] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterBrowser] in `aqutter` instead.
  @override
  AqutterAndroidBrowser createPlatformBrowserStatic() {
    return AqutterAndroidBrowser.static();
  }

  /// Creates a new [AndroidProcessGlobalConfig].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProcessGlobalConfig] in `aqutter` instead.
  @override
  AndroidProcessGlobalConfig createPlatformProcessGlobalConfig(
    AqutterPlatformProcessGlobalConfigCreationParams params,
  ) {
    return AndroidProcessGlobalConfig(params);
  }

  /// Creates a new empty [AndroidProcessGlobalConfig] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProcessGlobalConfig] in `aqutter` instead.
  @override
  AndroidProcessGlobalConfig createPlatformProcessGlobalConfigStatic() {
    return AndroidProcessGlobalConfig.static();
  }

  /// Creates a new [AndroidProxyController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProxyController] in `aqutter` instead.
  @override
  AndroidProxyController createPlatformProxyController(
    AqutterPlatformProxyControllerCreationParams params,
  ) {
    return AndroidProxyController(params);
  }

  /// Creates a new empty [AndroidProxyController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProxyController] in `aqutter` instead.
  @override
  AndroidProxyController createPlatformProxyControllerStatic() {
    return AndroidProxyController.static();
  }

  /// Creates a new [AndroidServiceWorkerController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterServiceWorkerController] in `aqutter` instead.
  @override
  AndroidServiceWorkerController createPlatformServiceWorkerController(
    AqutterPlatformServiceWorkerControllerCreationParams params,
  ) {
    return AndroidServiceWorkerController(params);
  }

  /// Creates a new empty [AndroidServiceWorkerController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterServiceWorkerController] in `aqutter` instead.
  @override
  AndroidServiceWorkerController createPlatformServiceWorkerControllerStatic() {
    return AndroidServiceWorkerController.static();
  }

  /// Creates a new [AndroidTracingController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterTracingController] in `aqutter` instead.
  @override
  AndroidTracingController createPlatformTracingController(
    AqutterPlatformTracingControllerCreationParams params,
  ) {
    return AndroidTracingController(params);
  }

  /// Creates a new empty [AndroidTracingController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterTracingController] in `aqutter` instead.
  @override
  AndroidTracingController createPlatformTracingControllerStatic() {
    return AndroidTracingController.static();
  }

  /// Creates a new [AndroidAssetsPathHandler].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterAssetsPathHandler] in `aqutter` instead.
  @override
  AndroidAssetsPathHandler createPlatformAssetsPathHandler(
    AqutterPlatformAssetsPathHandlerCreationParams params,
  ) {
    return AndroidAssetsPathHandler(params);
  }

  /// Creates a new [AndroidResourcesPathHandler].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterResourcesPathHandler] in `aqutter` instead.
  @override
  AndroidResourcesPathHandler createPlatformResourcesPathHandler(
    AqutterPlatformResourcesPathHandlerCreationParams params,
  ) {
    return AndroidResourcesPathHandler(params);
  }

  /// Creates a new [AndroidInternalStoragePathHandler].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterInternalStoragePathHandler] in `aqutter` instead.
  @override
  AndroidInternalStoragePathHandler createPlatformInternalStoragePathHandler(
    AqutterPlatformInternalStoragePathHandlerCreationParams params,
  ) {
    return AndroidInternalStoragePathHandler(params);
  }

  /// Creates a new [AndroidCustomPathHandler].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCustomPathHandler] in `aqutter` instead.
  @override
  AndroidCustomPathHandler createPlatformCustomPathHandler(
    AqutterPlatformCustomPathHandlerCreationParams params,
  ) {
    return AndroidCustomPathHandler(params);
  }

  /// Creates a new empty [AndroidAssetsPathHandler] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterAssetsPathHandler] in `aqutter` instead.
  @override
  AndroidAssetsPathHandler createPlatformAssetsPathHandlerStatic() {
    return AndroidAssetsPathHandler.static();
  }

  /// Creates a new empty [AndroidResourcesPathHandler] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterResourcesPathHandler] in `aqutter` instead.
  @override
  AndroidResourcesPathHandler createPlatformResourcesPathHandlerStatic() {
    return AndroidResourcesPathHandler.static();
  }

  /// Creates a new empty [AndroidInternalStoragePathHandler] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterInternalStoragePathHandler] in `aqutter` instead.
  @override
  AndroidInternalStoragePathHandler
  createPlatformInternalStoragePathHandlerStatic() {
    return AndroidInternalStoragePathHandler.static();
  }

  /// Creates a new empty [AndroidCustomPathHandler] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCustomPathHandler] in `aqutter` instead.
  @override
  AndroidCustomPathHandler createPlatformCustomPathHandlerStatic() {
    return AndroidCustomPathHandler.static();
  }

  /// Creates a new [wv.AndroidWebViewFeature].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewFeature] in `aqutter` instead.
  @override
  wv.AndroidWebViewFeature createPlatformWebViewFeature(
    AqutterPlatformWebViewFeatureCreationParams params,
  ) {
    return wv.AndroidWebViewFeature(params);
  }

  /// Creates a new empty [wv.AndroidWebViewFeature] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewFeature] in `aqutter` instead.
  @override
  wv.AndroidWebViewFeature createPlatformWebViewFeatureStatic() {
    return wv.AndroidWebViewFeature.static();
  }

  /// Creates a new [AndroidChromeSafariBrowser].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterChromeSafariBrowser] in `aqutter` instead.
  @override
  AndroidChromeSafariBrowser createPlatformChromeSafariBrowser(
    AqutterPlatformChromeSafariBrowserCreationParams params,
  ) {
    return AndroidChromeSafariBrowser(params);
  }

  /// Creates a new empty [AndroidChromeSafariBrowser] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterChromeSafariBrowser] in `aqutter` instead.
  @override
  AndroidChromeSafariBrowser createPlatformChromeSafariBrowserStatic() {
    return AndroidChromeSafariBrowser.static();
  }

  /// Creates a new empty [AndroidWebStorageManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorageManager] in `aqutter` instead.
  @override
  AndroidWebStorageManager createPlatformWebStorageManager(
    AqutterPlatformWebStorageManagerCreationParams params,
  ) {
    return AndroidWebStorageManager(params);
  }

  /// Creates a new empty [AndroidWebStorageManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorageManager] in `aqutter` instead.
  @override
  AndroidWebStorageManager createPlatformWebStorageManagerStatic() {
    return AndroidWebStorageManager.static();
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

  /// Creates a new empty [AqutterPlatformWebAuthenticationSession] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebAuthenticationSession] in `aqutter` instead.
  @override
  AqutterPlatformWebAuthenticationSession
  createPlatformWebAuthenticationSessionStatic() {
    return _PlatformWebAuthenticationSession.static();
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
