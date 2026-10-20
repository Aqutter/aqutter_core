import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'chrome_safari_browser/platform_chrome_safari_browser.dart';
import 'find_interaction/platform_find_interaction_controller.dart';
import 'browser/platform_browser.dart';
import 'localhost_server.dart';
import 'webview/platform_headless_webview.dart';
import 'webview/platform_webview_controller.dart';
import 'webview/platform_webview_widget.dart';
import 'platform_cookie_manager.dart';
import 'platform_http_auth_credentials_database.dart';
import 'platform_localhost_server.dart';
import 'platform_process_global_config.dart';
import 'platform_proxy_controller.dart';
import 'platform_service_worker_controller.dart';
import 'platform_tracing_controller.dart';
import 'platform_webview_asset_loader.dart';
import 'platform_webview_feature.dart';
import 'print_job/platform_print_job_controller.dart';
import 'pull_to_refresh/platform_pull_to_refresh_controller.dart';
import 'web_authentication_session/platform_web_authenticate_session.dart';
import 'web_message/platform_web_message_channel.dart';
import 'web_message/platform_web_message_listener.dart';
import 'web_message/platform_web_message_port.dart';
import 'web_notification/platform_web_notification_controller.dart';
import 'web_storage/platform_web_storage.dart';
import 'web_storage/platform_web_storage_manager.dart';
import 'webview_environment/platform_webview_environment.dart';

/// Interface for a platform implementation of a WebView.
abstract class AqutterWebViewPlatform extends PlatformInterface {
  /// Creates a new [AqutterWebViewPlatform].
  AqutterWebViewPlatform() : super(token: _token);

  static final Object _token = Object();

  static AqutterWebViewPlatform? _instance;

  /// The instance of [AqutterWebViewPlatform] to use.
  static AqutterWebViewPlatform? get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [AqutterWebViewPlatform] when they register themselves.
  static set instance(AqutterWebViewPlatform? instance) {
    if (instance == null) {
      throw AssertionError(
        'Platform interfaces can only be set to a non-null instance',
      );
    }

    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Creates a new [AqutterPlatformCookieManager].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCookieManager] in `aqutter` instead.
  AqutterPlatformCookieManager createPlatformCookieManager(
    AqutterPlatformCookieManagerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformCookieManager is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformCookieManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCookieManager] in `aqutter` instead.
  AqutterPlatformCookieManager createPlatformCookieManagerStatic() {
    throw UnimplementedError(
      'createPlatformCookieManagerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformWebViewController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  AqutterPlatformWebViewController createPlatformWebViewController(
    AqutterPlatformWebViewControllerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformWebViewController is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformWebViewController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewController] in `aqutter` instead.
  AqutterPlatformWebViewController createPlatformWebViewControllerStatic() {
    throw UnimplementedError(
      'createPlatformWebViewControllerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformWebViewWidget].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  AqutterPlatformWebViewWidget createPlatformWebViewWidget(
    AqutterPlatformWebViewWidgetCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformWebViewWidget is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformWebViewWidget] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebView] in `aqutter` instead.
  AqutterPlatformWebViewWidget createPlatformWebViewWidgetStatic() {
    throw UnimplementedError(
      'createPlatformWebViewWidgetStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformFindInteractionController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterFindInteractionController] in `aqutter` instead.
  AqutterPlatformFindInteractionController createPlatformFindInteractionController(
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformFindInteractionController is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformFindInteractionController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterFindInteractionController] in `aqutter` instead.
  AqutterPlatformFindInteractionController
  createPlatformFindInteractionControllerStatic() {
    throw UnimplementedError(
      'createPlatformFindInteractionControllerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformPrintJobController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPrintJobController] in `aqutter` instead.
  AqutterPlatformPrintJobController createPlatformPrintJobController(
    AqutterPlatformPrintJobControllerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformPrintJobController is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformPrintJobController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPrintJobController] in `aqutter` instead.
  AqutterPlatformPrintJobController createPlatformPrintJobControllerStatic() {
    throw UnimplementedError(
      'createPlatformPrintJobControllerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformPullToRefreshController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPullToRefreshController] in `aqutter` instead.
  AqutterPlatformPullToRefreshController createPlatformPullToRefreshController(
    AqutterPlatformPullToRefreshControllerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformPullToRefreshController is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformPullToRefreshController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPullToRefreshController] in `aqutter` instead.
  AqutterPlatformPullToRefreshController
  createPlatformPullToRefreshControllerStatic() {
    throw UnimplementedError(
      'createPlatformPullToRefreshControllerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformWebAuthenticationSession].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebAuthenticationSession] in `aqutter` instead.
  AqutterPlatformWebAuthenticationSession createPlatformWebAuthenticationSession(
    AqutterPlatformWebAuthenticationSessionCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformWebAuthenticationSession is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformWebAuthenticationSession] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebAuthenticationSession] in `aqutter` instead.
  AqutterPlatformWebAuthenticationSession
  createPlatformWebAuthenticationSessionStatic() {
    throw UnimplementedError(
      'createPlatformWebAuthenticationSessionStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformWebMessageChannel].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageChannel] in `aqutter` instead.
  AqutterPlatformWebMessageChannel createPlatformWebMessageChannel(
    AqutterPlatformWebMessageChannelCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformWebMessageChannel is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformWebMessageChannel] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageChannel] in `aqutter` instead.
  AqutterPlatformWebMessageChannel createPlatformWebMessageChannelStatic() {
    throw UnimplementedError(
      'createPlatformWebMessageChannelStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformWebMessageListener].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageListener] in `aqutter` instead.
  AqutterPlatformWebMessageListener createPlatformWebMessageListener(
    AqutterPlatformWebMessageListenerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformWebMessageListener is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformWebMessageListener] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessageListener] in `aqutter` instead.
  AqutterPlatformWebMessageListener createPlatformWebMessageListenerStatic() {
    throw UnimplementedError(
      'createPlatformWebMessageListenerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformJavaScriptReplyProxy].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterJavaScriptReplyProxy] in `aqutter` instead.
  AqutterPlatformJavaScriptReplyProxy createPlatformJavaScriptReplyProxy(
    AqutterPlatformJavaScriptReplyProxyCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformJavaScriptReplyProxy is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformWebMessagePort].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebMessagePort] in `aqutter` instead.
  AqutterPlatformWebMessagePort createPlatformWebMessagePort(
    AqutterPlatformWebMessagePortCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformWebMessagePort is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformWebStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  AqutterPlatformWebStorage createPlatformWebStorage(
    AqutterPlatformWebStorageCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformWebStorage is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformWebStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorage] in `aqutter` instead.
  AqutterPlatformWebStorage createPlatformWebStorageStatic() {
    throw UnimplementedError(
      'createPlatformWebStorageStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformLocalStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  AqutterPlatformLocalStorage createPlatformLocalStorage(
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformLocalStorage is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformLocalStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterLocalStorage] in `aqutter` instead.
  AqutterPlatformLocalStorage createPlatformLocalStorageStatic() {
    throw UnimplementedError(
      'createPlatformLocalStorageStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformSessionStorage].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPlatformSessionStorage] in `aqutter` instead.
  AqutterPlatformSessionStorage createPlatformSessionStorage(
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformSessionStorage is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformSessionStorage] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterPlatformSessionStorage] in `aqutter` instead.
  AqutterPlatformSessionStorage createPlatformSessionStorageStatic() {
    throw UnimplementedError(
      'createPlatformSessionStorageStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformHeadlessWebView].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHeadlessWebView] in `aqutter` instead.
  AqutterPlatformHeadlessWebView createPlatformHeadlessWebView(
    AqutterPlatformHeadlessWebViewCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformHeadlessWebView is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformHeadlessWebView] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHeadlessWebView] in `aqutter` instead.
  AqutterPlatformHeadlessWebView createPlatformHeadlessWebViewStatic() {
    throw UnimplementedError(
      'createPlatformHeadlessWebViewStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformWebStorageManager].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorageManager] in `aqutter` instead.
  AqutterPlatformWebStorageManager createPlatformWebStorageManager(
    AqutterPlatformWebStorageManagerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformWebStorageManager is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformWebStorageManager] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebStorageManager] in `aqutter` instead.
  AqutterPlatformWebStorageManager createPlatformWebStorageManagerStatic() {
    throw UnimplementedError(
      'createPlatformWebStorageManagerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformHttpAuthCredentialDatabase].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHttpAuthCredentialDatabase] in `aqutter` instead.
  AqutterPlatformHttpAuthCredentialDatabase createPlatformHttpAuthCredentialDatabase(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformHttpAuthCredentialDatabase is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformHttpAuthCredentialDatabase] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterHttpAuthCredentialDatabase] in `aqutter` instead.
  AqutterPlatformHttpAuthCredentialDatabase
  createPlatformHttpAuthCredentialDatabaseStatic() {
    throw UnimplementedError(
      'createPlatformHttpAuthCredentialDatabaseStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformBrowser].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterBrowser] in `aqutter` instead.
  AqutterPlatformBrowser createPlatformBrowser(
    AqutterPlatformBrowserCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformBrowser is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformBrowser] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterBrowser] in `aqutter` instead.
  AqutterPlatformBrowser createPlatformBrowserStatic() {
    throw UnimplementedError(
      'createPlatformBrowserStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformProcessGlobalConfig].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProcessGlobalConfig] in `aqutter` instead.
  AqutterPlatformProcessGlobalConfig createPlatformProcessGlobalConfig(
    AqutterPlatformProcessGlobalConfigCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformProcessGlobalConfig is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformProcessGlobalConfig] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProcessGlobalConfig] in `aqutter` instead.
  AqutterPlatformProcessGlobalConfig createPlatformProcessGlobalConfigStatic() {
    throw UnimplementedError(
      'createPlatformProcessGlobalConfigStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformProxyController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProxyController] in `aqutter` instead.
  AqutterPlatformProxyController createPlatformProxyController(
    AqutterPlatformProxyControllerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformProxyController is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformProxyController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterProxyController] in `aqutter` instead.
  AqutterPlatformProxyController createPlatformProxyControllerStatic() {
    throw UnimplementedError(
      'createPlatformProxyControllerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformServiceWorkerController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterServiceWorkerController] in `aqutter` instead.
  AqutterPlatformServiceWorkerController createPlatformServiceWorkerController(
    AqutterPlatformServiceWorkerControllerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformServiceWorkerController is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformServiceWorkerController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterServiceWorkerController] in `aqutter` instead.
  AqutterPlatformServiceWorkerController
  createPlatformServiceWorkerControllerStatic() {
    throw UnimplementedError(
      'createPlatformServiceWorkerControllerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformTracingController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterTracingController] in `aqutter` instead.
  AqutterPlatformTracingController createPlatformTracingController(
    AqutterPlatformTracingControllerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformTracingController is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformTracingController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterTracingController] in `aqutter` instead.
  AqutterPlatformTracingController createPlatformTracingControllerStatic() {
    throw UnimplementedError(
      'createPlatformTracingControllerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformAssetsPathHandler].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterAssetsPathHandler] in `aqutter` instead.
  AqutterPlatformAssetsPathHandler createPlatformAssetsPathHandler(
    AqutterPlatformAssetsPathHandlerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformAssetsPathHandler is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformAssetsPathHandler] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterAssetsPathHandler] in `aqutter` instead.
  AqutterPlatformAssetsPathHandler createPlatformAssetsPathHandlerStatic() {
    throw UnimplementedError(
      'createPlatformAssetsPathHandlerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformResourcesPathHandler].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterResourcesPathHandler] in `aqutter` instead.
  AqutterPlatformResourcesPathHandler createPlatformResourcesPathHandler(
    AqutterPlatformResourcesPathHandlerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformResourcesPathHandler is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformResourcesPathHandler] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterResourcesPathHandler] in `aqutter` instead.
  AqutterPlatformResourcesPathHandler createPlatformResourcesPathHandlerStatic() {
    throw UnimplementedError(
      'createPlatformResourcesPathHandlerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformInternalStoragePathHandler].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterInternalStoragePathHandler] in `aqutter` instead.
  AqutterPlatformInternalStoragePathHandler createPlatformInternalStoragePathHandler(
    AqutterPlatformInternalStoragePathHandlerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformInternalStoragePathHandler is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformInternalStoragePathHandler] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterInternalStoragePathHandler] in `aqutter` instead.
  AqutterPlatformInternalStoragePathHandler
  createPlatformInternalStoragePathHandlerStatic() {
    throw UnimplementedError(
      'createPlatformInternalStoragePathHandlerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformCustomPathHandler].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCustomPathHandler] in `aqutter` instead.
  AqutterPlatformCustomPathHandler createPlatformCustomPathHandler(
    AqutterPlatformCustomPathHandlerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformCustomPathHandler is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformCustomPathHandler] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterCustomPathHandler] in `aqutter` instead.
  AqutterPlatformCustomPathHandler createPlatformCustomPathHandlerStatic() {
    throw UnimplementedError(
      'createPlatformCustomPathHandlerStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformWebViewFeature].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewFeature] in `aqutter` instead.
  AqutterPlatformWebViewFeature createPlatformWebViewFeature(
    AqutterPlatformWebViewFeatureCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformWebViewFeature is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformWebViewFeature] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewFeature] in `aqutter` instead.
  AqutterPlatformWebViewFeature createPlatformWebViewFeatureStatic() {
    throw UnimplementedError(
      'createPlatformWebViewFeatureStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformLocalhostServer] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterDefaultLocalhostServer] in `aqutter` instead.
  AqutterPlatformLocalhostServer createPlatformLocalhostServer(
    AqutterPlatformLocalhostServerCreationParams params,
  ) {
    return AqutterDefaultLocalhostServer(params);
  }

  /// Creates a new empty [AqutterPlatformLocalhostServer] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterDefaultLocalhostServer] in `aqutter` instead.
  AqutterPlatformLocalhostServer createPlatformLocalhostServerStatic() {
    return AqutterDefaultLocalhostServer(
      const AqutterPlatformLocalhostServerCreationParams(),
    );
  }

  /// Creates a new [AqutterPlatformChromeSafariBrowser].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterChromeSafariBrowser] in `aqutter` instead.
  AqutterPlatformChromeSafariBrowser createPlatformChromeSafariBrowser(
    AqutterPlatformChromeSafariBrowserCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformChromeSafariBrowser is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformChromeSafariBrowser] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterChromeSafariBrowser] in `aqutter` instead.
  AqutterPlatformChromeSafariBrowser createPlatformChromeSafariBrowserStatic() {
    throw UnimplementedError(
      'createPlatformChromeSafariBrowserStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformWebViewEnvironment].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewEnvironment] in `aqutter` instead.
  AqutterPlatformWebViewEnvironment createPlatformWebViewEnvironment(
    AqutterPlatformWebViewEnvironmentCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformWebViewEnvironment is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformWebViewEnvironment] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebViewEnvironment] in `aqutter` instead.
  AqutterPlatformWebViewEnvironment createPlatformWebViewEnvironmentStatic() {
    throw UnimplementedError(
      'createPlatformWebViewEnvironmentStatic is not implemented on the current platform.',
    );
  }

  /// Creates a new [AqutterPlatformWebNotificationController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebNotificationController] in `aqutter` instead.
  AqutterPlatformWebNotificationController createPlatformWebNotificationController(
    AqutterPlatformWebNotificationControllerCreationParams params,
  ) {
    throw UnimplementedError(
      'createPlatformWebNotificationController is not implemented on the current platform.',
    );
  }

  /// Creates a new empty [AqutterPlatformWebNotificationController] to access static methods.
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [AqutterWebNotificationController] in `aqutter` instead.
  AqutterPlatformWebNotificationController
  createPlatformWebNotificationControllerStatic() {
    throw UnimplementedError(
      'createPlatformWebNotificationControllerStatic is not implemented on the current platform.',
    );
  }
}
