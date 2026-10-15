import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// A mock AqutterWebViewPlatform for testing purposes.
/// This allows widget tests to run without requiring a real platform implementation.
class MockAqutterPlatform extends AqutterWebViewPlatform
    with MockPlatformInterfaceMixin {
  static final MockAqutterPlatform _instance =
      MockAqutterPlatform._();

  MockAqutterPlatform._();

  /// Initialize the mock platform for testing.
  /// Call this in setUp() or at the start of your tests.
  static void initialize() {
    AqutterWebViewPlatform.instance = _instance;
  }

  /// Reset the platform instance.
  /// Call this in tearDown() to clean up after tests.
  static void reset() {
    // Note: We can't actually set instance to null, but we can leave it as the mock
    // for subsequent tests. The mock is stateless so this is fine.
  }

  @override
  AqutterPlatformWebViewController createPlatformWebViewControllerStatic() {
    return AqutterMockPlatformWebViewControllerStatic(
      const AqutterPlatformWebViewControllerCreationParams(id: 'mock_controller'),
    );
  }

  @override
  AqutterPlatformCookieManager createPlatformCookieManagerStatic() {
    return MockPlatformCookieManagerStatic(
      AqutterPlatformCookieManagerCreationParams(),
    );
  }

  @override
  AqutterPlatformCookieManager createPlatformCookieManager(
    AqutterPlatformCookieManagerCreationParams params,
  ) {
    return MockPlatformCookieManager(params);
  }

  @override
  AqutterPlatformWebViewWidget createPlatformWebViewWidget(
    AqutterPlatformWebViewWidgetCreationParams params,
  ) {
    return AqutterMockPlatformWebViewWidget(params);
  }

  @override
  AqutterPlatformWebViewWidget createPlatformWebViewWidgetStatic() {
    return AqutterMockPlatformWebViewWidget(
      AqutterPlatformWebViewWidgetCreationParams(),
    );
  }

  @override
  AqutterPlatformWebViewController createPlatformWebViewController(
    AqutterPlatformWebViewControllerCreationParams params,
  ) {
    return AqutterMockPlatformWebViewController(params);
  }

  @override
  AqutterPlatformServiceWorkerController createPlatformServiceWorkerController(
    AqutterPlatformServiceWorkerControllerCreationParams params,
  ) {
    return MockPlatformServiceWorkerController(params);
  }

  @override
  AqutterPlatformServiceWorkerController
  createPlatformServiceWorkerControllerStatic() {
    return MockPlatformServiceWorkerController(
      const AqutterPlatformServiceWorkerControllerCreationParams(),
    );
  }

  @override
  AqutterPlatformProxyController createPlatformProxyController(
    AqutterPlatformProxyControllerCreationParams params,
  ) {
    return MockPlatformProxyController(params);
  }

  @override
  AqutterPlatformProxyController createPlatformProxyControllerStatic() {
    return MockPlatformProxyController(
      const AqutterPlatformProxyControllerCreationParams(),
    );
  }

  @override
  AqutterPlatformTracingController createPlatformTracingController(
    AqutterPlatformTracingControllerCreationParams params,
  ) {
    return MockPlatformTracingController(params);
  }

  @override
  AqutterPlatformTracingController createPlatformTracingControllerStatic() {
    return MockPlatformTracingController(
      const AqutterPlatformTracingControllerCreationParams(),
    );
  }

  @override
  AqutterPlatformWebViewEnvironment createPlatformWebViewEnvironment(
    AqutterPlatformWebViewEnvironmentCreationParams params,
  ) {
    return MockPlatformWebViewEnvironment(params);
  }

  @override
  AqutterPlatformWebViewEnvironment createPlatformWebViewEnvironmentStatic() {
    return MockPlatformWebViewEnvironment(
      const AqutterPlatformWebViewEnvironmentCreationParams(),
    );
  }

  @override
  AqutterPlatformProcessGlobalConfig createPlatformProcessGlobalConfig(
    AqutterPlatformProcessGlobalConfigCreationParams params,
  ) {
    return MockPlatformProcessGlobalConfig(params);
  }

  @override
  AqutterPlatformProcessGlobalConfig createPlatformProcessGlobalConfigStatic() {
    return MockPlatformProcessGlobalConfig(
      const AqutterPlatformProcessGlobalConfigCreationParams(),
    );
  }

  @override
  AqutterPlatformFindInteractionController createPlatformFindInteractionController(
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) {
    return MockPlatformFindInteractionController(params);
  }

  @override
  AqutterPlatformFindInteractionController
  createPlatformFindInteractionControllerStatic() {
    return MockPlatformFindInteractionController(
      const AqutterPlatformFindInteractionControllerCreationParams(),
    );
  }

  @override
  AqutterPlatformPullToRefreshController createPlatformPullToRefreshController(
    AqutterPlatformPullToRefreshControllerCreationParams params,
  ) {
    return MockPlatformPullToRefreshController(params);
  }

  @override
  AqutterPlatformPullToRefreshController
  createPlatformPullToRefreshControllerStatic() {
    return MockPlatformPullToRefreshController(
      AqutterPlatformPullToRefreshControllerCreationParams(),
    );
  }

  @override
  AqutterPlatformWebMessageChannel createPlatformWebMessageChannel(
    AqutterPlatformWebMessageChannelCreationParams params,
  ) {
    return MockPlatformWebMessageChannel(params);
  }

  @override
  AqutterPlatformWebMessageChannel createPlatformWebMessageChannelStatic() {
    final port1 = MockPlatformWebMessagePort(
      const AqutterPlatformWebMessagePortCreationParams(index: 0),
    );
    final port2 = MockPlatformWebMessagePort(
      const AqutterPlatformWebMessagePortCreationParams(index: 1),
    );
    return MockPlatformWebMessageChannel(
      AqutterPlatformWebMessageChannelCreationParams(
        id: 'mock_channel',
        port1: port1,
        port2: port2,
      ),
    );
  }

  @override
  AqutterPlatformHeadlessWebView createPlatformHeadlessWebView(
    AqutterPlatformHeadlessWebViewCreationParams params,
  ) {
    return AqutterMockPlatformHeadlessWebView(params);
  }

  @override
  AqutterPlatformHeadlessWebView createPlatformHeadlessWebViewStatic() {
    return AqutterMockPlatformHeadlessWebView(
      const AqutterPlatformHeadlessWebViewCreationParams(),
    );
  }

  @override
  AqutterPlatformBrowser createPlatformBrowser(
    AqutterPlatformBrowserCreationParams params,
  ) {
    return AqutterMockPlatformBrowser(params);
  }

  @override
  AqutterPlatformBrowser createPlatformBrowserStatic() {
    return AqutterMockPlatformBrowser(const AqutterPlatformBrowserCreationParams());
  }

  @override
  AqutterPlatformChromeSafariBrowser createPlatformChromeSafariBrowser(
    AqutterPlatformChromeSafariBrowserCreationParams params,
  ) {
    return MockPlatformChromeSafariBrowser(params);
  }

  @override
  AqutterPlatformChromeSafariBrowser createPlatformChromeSafariBrowserStatic() {
    return MockPlatformChromeSafariBrowser(
      const AqutterPlatformChromeSafariBrowserCreationParams(),
    );
  }

  @override
  AqutterPlatformPrintJobController createPlatformPrintJobController(
    AqutterPlatformPrintJobControllerCreationParams params,
  ) {
    return MockPlatformPrintJobController(params);
  }

  @override
  AqutterPlatformPrintJobController createPlatformPrintJobControllerStatic() {
    return MockPlatformPrintJobController(
      const AqutterPlatformPrintJobControllerCreationParams(id: 'mock_print_job'),
    );
  }

  @override
  AqutterPlatformWebAuthenticationSession createPlatformWebAuthenticationSession(
    AqutterPlatformWebAuthenticationSessionCreationParams params,
  ) {
    return MockPlatformWebAuthenticationSession(params);
  }

  @override
  AqutterPlatformWebAuthenticationSession
  createPlatformWebAuthenticationSessionStatic() {
    return MockPlatformWebAuthenticationSession(
      const AqutterPlatformWebAuthenticationSessionCreationParams(),
    );
  }

  @override
  AqutterPlatformHttpAuthCredentialDatabase createPlatformHttpAuthCredentialDatabase(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) {
    return MockPlatformHttpAuthCredentialDatabase(params);
  }

  @override
  AqutterPlatformHttpAuthCredentialDatabase
  createPlatformHttpAuthCredentialDatabaseStatic() {
    return MockPlatformHttpAuthCredentialDatabase(
      const AqutterPlatformHttpAuthCredentialDatabaseCreationParams(),
    );
  }

  @override
  AqutterPlatformWebStorage createPlatformWebStorage(
    AqutterPlatformWebStorageCreationParams params,
  ) {
    return MockPlatformWebStorage(params);
  }

  @override
  AqutterPlatformWebStorage createPlatformWebStorageStatic() {
    final localStorage = MockPlatformLocalStorage(
      AqutterPlatformLocalStorageCreationParams(
        const AqutterPlatformStorageCreationParams(
          controller: null,
          webStorageType: AqutterWebStorageType.LOCAL_STORAGE,
        ),
      ),
    );
    final sessionStorage = MockPlatformSessionStorage(
      AqutterPlatformSessionStorageCreationParams(
        const AqutterPlatformStorageCreationParams(
          controller: null,
          webStorageType: AqutterWebStorageType.SESSION_STORAGE,
        ),
      ),
    );
    return MockPlatformWebStorage(
      AqutterPlatformWebStorageCreationParams(
        localStorage: localStorage,
        sessionStorage: sessionStorage,
      ),
    );
  }

  @override
  AqutterPlatformLocalStorage createPlatformLocalStorage(
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    return MockPlatformLocalStorage(params);
  }

  @override
  AqutterPlatformLocalStorage createPlatformLocalStorageStatic() {
    return MockPlatformLocalStorage(
      AqutterPlatformLocalStorageCreationParams(
        const AqutterPlatformStorageCreationParams(
          controller: null,
          webStorageType: AqutterWebStorageType.LOCAL_STORAGE,
        ),
      ),
    );
  }

  @override
  AqutterPlatformSessionStorage createPlatformSessionStorage(
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    return MockPlatformSessionStorage(params);
  }

  @override
  AqutterPlatformSessionStorage createPlatformSessionStorageStatic() {
    return MockPlatformSessionStorage(
      AqutterPlatformSessionStorageCreationParams(
        const AqutterPlatformStorageCreationParams(
          controller: null,
          webStorageType: AqutterWebStorageType.SESSION_STORAGE,
        ),
      ),
    );
  }
}

/// Mock static controller for testing
class AqutterMockPlatformWebViewControllerStatic
    extends AqutterPlatformWebViewController
    with MockPlatformInterfaceMixin {
  AqutterMockPlatformWebViewControllerStatic(super.params)
    : super.implementation();

  @override
  bool isMethodSupported(
    AqutterPlatformWebViewControllerMethod method, {
    TargetPlatform? platform,
  }) {
    // Return true for all methods in tests
    return true;
  }
}

class AqutterMockPlatformWebViewController extends AqutterPlatformWebViewController
    with MockPlatformInterfaceMixin {
  AqutterMockPlatformWebViewController(super.params) : super.implementation();

  @override
  bool isMethodSupported(
    AqutterPlatformWebViewControllerMethod method, {
    TargetPlatform? platform,
  }) => true;

  @override
  Future<void> loadUrl({
    required AqutterURLRequest urlRequest,
    @Deprecated('Use allowingReadAccessTo instead')
    Uri? iosAllowingReadAccessTo,
    AqutterWebUri? allowingReadAccessTo,
  }) async {}

  @override
  Future<void> reload() async {}

  @override
  Future<void> stopLoading() async {}

  @override
  Future<bool> canGoBack() async => false;

  @override
  Future<bool> canGoForward() async => false;

  @override
  Future<void> goBack() async {}

  @override
  Future<void> goForward() async {}

  @override
  Future<String?> getTitle() async => 'Mock Title';

  @override
  int? getViewId() => 1;

  @override
  Future<dynamic> evaluateJavascript({
    required String source,
    AqutterContentWorld? contentWorld,
  }) async => null;

  @override
  Future<AqutterCallAsyncJavaScriptResult?> callAsyncJavaScript({
    required String functionBody,
    Map<String, dynamic>? arguments,
    AqutterContentWorld? contentWorld,
  }) async => null;

  @override
  Future<void> addUserScript({required AqutterUserScript userScript}) async {}

  @override
  Future<bool> removeUserScript({required AqutterUserScript userScript}) async => true;

  @override
  Future<AqutterPlatformWebMessageChannel?> createWebMessageChannel() async {
    final port1 = MockPlatformWebMessagePort(
      const AqutterPlatformWebMessagePortCreationParams(index: 0),
    );
    final port2 = MockPlatformWebMessagePort(
      const AqutterPlatformWebMessagePortCreationParams(index: 1),
    );
    return MockPlatformWebMessageChannel(
      AqutterPlatformWebMessageChannelCreationParams(
        id: 'controller_channel',
        port1: port1,
        port2: port2,
      ),
    );
  }
}

class AqutterMockPlatformWebViewWidget extends AqutterPlatformWebViewWidget
    with MockPlatformInterfaceMixin {
  AqutterMockPlatformWebViewWidget(super.params) : super.implementation();

  @override
  T controllerFromPlatform<T>(AqutterPlatformWebViewController controller) {
    return controller as T;
  }

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

/// Mock static cookie manager for testing
class MockPlatformCookieManagerStatic extends AqutterPlatformCookieManager
    with MockPlatformInterfaceMixin {
  MockPlatformCookieManagerStatic(super.params) : super.implementation();

  @override
  bool isMethodSupported(
    AqutterPlatformCookieManagerMethod method, {
    TargetPlatform? platform,
  }) {
    return true;
  }
}

class MockPlatformCookieManager extends AqutterPlatformCookieManager
    with MockPlatformInterfaceMixin {
  MockPlatformCookieManager(super.params) : super.implementation();

  @override
  bool isMethodSupported(
    AqutterPlatformCookieManagerMethod method, {
    TargetPlatform? platform,
  }) => true;
}

class MockPlatformServiceWorkerController
    extends AqutterPlatformServiceWorkerController
    with MockPlatformInterfaceMixin {
  MockPlatformServiceWorkerController(super.params) : super.implementation();

  @override
  bool isMethodSupported(
    AqutterPlatformServiceWorkerControllerMethod method, {
    TargetPlatform? platform,
  }) => true;

  @override
  Future<bool> getAllowContentAccess() async => true;

  @override
  Future<bool> getAllowFileAccess() async => true;

  @override
  Future<bool> getBlockNetworkLoads() async => false;

  @override
  Future<AqutterCacheMode?> getCacheMode() async => AqutterCacheMode.LOAD_DEFAULT;

  @override
  Future<void> setAllowContentAccess(bool value) async {}

  @override
  Future<void> setAllowFileAccess(bool value) async {}

  @override
  Future<void> setBlockNetworkLoads(bool value) async {}

  @override
  Future<void> setCacheMode(AqutterCacheMode? mode) async {}

  @override
  AqutterServiceWorkerClient? get serviceWorkerClient => null;
}

class MockPlatformProxyController extends AqutterPlatformProxyController
    with MockPlatformInterfaceMixin {
  MockPlatformProxyController(super.params) : super.implementation();

  @override
  bool isMethodSupported(
    AqutterPlatformProxyControllerMethod method, {
    TargetPlatform? platform,
  }) => true;

  @override
  Future<void> setProxyOverride({required AqutterProxySettings settings}) async {}

  @override
  Future<void> clearProxyOverride() async {}
}

class MockPlatformTracingController extends AqutterPlatformTracingController
    with MockPlatformInterfaceMixin {
  MockPlatformTracingController(super.params) : super.implementation();

  @override
  bool isMethodSupported(
    AqutterPlatformTracingControllerMethod method, {
    TargetPlatform? platform,
  }) => true;

  @override
  Future<void> start({required AqutterTracingSettings settings}) async {}

  @override
  Future<bool> stop({String? filePath}) async => true;
}

class MockPlatformWebViewEnvironment extends AqutterPlatformWebViewEnvironment
    with MockPlatformInterfaceMixin {
  MockPlatformWebViewEnvironment(super.params) : super.implementation();

  @override
  bool isMethodSupported(
    AqutterPlatformWebViewEnvironmentMethod method, {
    TargetPlatform? platform,
  }) => true;

  @override
  Future<String?> getAvailableVersion({
    String? browserExecutableFolder,
  }) async => null;

  @override
  Future<List<AqutterBrowserProcessInfo>> getBrowserProcessInfo() async => [];
}

class MockPlatformProcessGlobalConfig extends AqutterPlatformProcessGlobalConfig
    with MockPlatformInterfaceMixin {
  MockPlatformProcessGlobalConfig(super.params) : super.implementation();

  @override
  bool isMethodSupported(
    AqutterPlatformProcessGlobalConfigMethod method, {
    TargetPlatform? platform,
  }) => true;

  @override
  Future<void> setDataDirectorySuffix({required String suffix}) async {}
}

class MockPlatformFindInteractionController
    extends AqutterPlatformFindInteractionController
    with MockPlatformInterfaceMixin {
  MockPlatformFindInteractionController(super.params) : super.implementation();

  @override
  bool isMethodSupported(
    AqutterPlatformFindInteractionControllerMethod method, {
    TargetPlatform? platform,
  }) => true;

  @override
  Future<void> findAll({String? find}) async {}

  @override
  Future<void> findNext({bool forward = true}) async {}

  @override
  Future<void> clearMatches() async {}

  @override
  Future<void> setSearchText(String? searchText) async {}

  @override
  Future<String?> getSearchText() async => '';

  @override
  Future<void> presentFindNavigator() async {}

  @override
  Future<void> dismissFindNavigator() async {}

  @override
  Future<bool?> isFindNavigatorVisible() async => false;

  @override
  Future<AqutterFindSession?> getActiveFindSession() async => null;

  @override
  void dispose({bool isKeepAlive = false}) {}
}

class MockPlatformPullToRefreshController
    extends AqutterPlatformPullToRefreshController
    with MockPlatformInterfaceMixin {
  bool _enabled = true;

  MockPlatformPullToRefreshController(super.params) : super.implementation();

  @override
  bool isMethodSupported(
    AqutterPlatformPullToRefreshControllerMethod method, {
    TargetPlatform? platform,
  }) => true;

  @override
  Future<void> setEnabled(bool enabled) async {
    _enabled = enabled;
  }

  @override
  Future<bool> isEnabled() async => _enabled;

  @override
  Future<void> beginRefreshing() async {}

  @override
  Future<void> endRefreshing() async {}

  @override
  Future<bool> isRefreshing() async => false;

  @override
  Future<void> setColor(Color color) async {}

  @override
  Future<void> setBackgroundColor(Color color) async {}

  @override
  Future<int> getDefaultSlingshotDistance() async => 0;

  @override
  void dispose({bool isKeepAlive = false}) {}
}

class MockPlatformWebMessageChannel extends AqutterPlatformWebMessageChannel
    with MockPlatformInterfaceMixin {
  MockPlatformWebMessageChannel(super.params) : super.implementation();

  @override
  AqutterPlatformWebMessagePort get port1 => params.port1;

  @override
  AqutterPlatformWebMessagePort get port2 => params.port2;

  @override
  Future<void> dispose() async {}
}

class MockPlatformWebMessagePort extends AqutterPlatformWebMessagePort
    with MockPlatformInterfaceMixin {
  MockPlatformWebMessagePort(super.params) : super.implementation();

  @override
  Future<void> setWebMessageCallback(AqutterWebMessageCallback? onMessage) async {}

  @override
  Future<void> postMessage(AqutterWebMessage message) async {}

  @override
  Future<void> close() async {}

  @override
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) => {};

  @override
  Map<String, dynamic> toJson() => toMap();
}

class AqutterMockPlatformHeadlessWebView extends AqutterPlatformHeadlessWebView
    with MockPlatformInterfaceMixin {
  AqutterMockPlatformHeadlessWebView(super.params) : super.implementation();

  @override
  String get id => 'mock_headless';

  @override
  AqutterPlatformWebViewController? get webViewController =>
      AqutterMockPlatformWebViewController(
        const AqutterPlatformWebViewControllerCreationParams(
          id: 'mock_headless_controller',
        ),
      );

  @override
  Future<void> run() async {}

  @override
  bool isRunning() => false;

  @override
  Future<void> setSize(Size size) async {}

  @override
  Future<Size?> getSize() async => null;

  @override
  Future<void> dispose() async {}
}

class AqutterMockPlatformBrowser extends AqutterPlatformBrowser
    with MockPlatformInterfaceMixin {
  AqutterMockPlatformBrowser(super.params) : super.implementation();

  @override
  String get id => 'mock_inapp_browser';

  @override
  AqutterPlatformWebViewController? get webViewController =>
      AqutterMockPlatformWebViewController(
        const AqutterPlatformWebViewControllerCreationParams(
          id: 'mock_inapp_browser_controller',
        ),
      );

  @override
  Future<void> openUrlRequest({
    required AqutterURLRequest urlRequest,
    @Deprecated('Use settings instead') AqutterBrowserClassOptions? options,
    AqutterBrowserClassSettings? settings,
  }) async {}

  @override
  Future<void> openFile({
    required String assetFilePath,
    @Deprecated('Use settings instead') AqutterBrowserClassOptions? options,
    AqutterBrowserClassSettings? settings,
  }) async {}

  @override
  Future<void> openData({
    required String data,
    String mimeType = 'text/html',
    String encoding = 'utf8',
    AqutterWebUri? baseUrl,
    @Deprecated('Use historyUrl instead') Uri? androidHistoryUrl,
    AqutterWebUri? historyUrl,
    @Deprecated('Use settings instead') AqutterBrowserClassOptions? options,
    AqutterBrowserClassSettings? settings,
  }) async {}

  @override
  Future<void> show() async {}

  @override
  Future<void> hide() async {}

  @override
  Future<void> close() async {}

  @override
  Future<bool> isHidden() async => false;

  @override
  Future<void> setSettings({
    required AqutterBrowserClassSettings settings,
  }) async {}

  @override
  Future<AqutterBrowserClassSettings?> getSettings() async =>
      AqutterBrowserClassSettings();

  @override
  bool isOpened() => true;

  @override
  void dispose() {
    super.dispose();
  }
}

class MockPlatformChromeSafariBrowser extends AqutterPlatformChromeSafariBrowser
    with MockPlatformInterfaceMixin {
  MockPlatformChromeSafariBrowser(super.params) : super.implementation();

  @override
  String get id => 'mock_chrome_safari_browser';

  @override
  Future<void> open({
    AqutterWebUri? url,
    Map<String, String>? headers,
    List<AqutterWebUri>? otherLikelyURLs,
    AqutterWebUri? referrer,
    @Deprecated('Use settings instead')
    AqutterChromeSafariBrowserClassOptions? options,
    AqutterChromeSafariBrowserSettings? settings,
  }) async {}

  @override
  Future<void> launchUrl({
    required AqutterWebUri url,
    Map<String, String>? headers,
    List<AqutterWebUri>? otherLikelyURLs,
    AqutterWebUri? referrer,
  }) async {}

  @override
  Future<bool> mayLaunchUrl({
    AqutterWebUri? url,
    List<AqutterWebUri>? otherLikelyURLs,
  }) async => true;

  @override
  Future<bool> validateRelationship({
    required AqutterCustomTabsRelationType relation,
    required AqutterWebUri origin,
  }) async => true;

  @override
  Future<void> close() async {}

  @override
  void dispose() {
    eventHandler = null;
  }
}

class MockPlatformPrintJobController extends AqutterPlatformPrintJobController
    with MockPlatformInterfaceMixin {
  MockPlatformPrintJobController(super.params) : super.implementation();

  @override
  Future<void> cancel() async {}

  @override
  Future<void> restart() async {}

  @override
  Future<void> dismiss({bool animated = true}) async {}

  @override
  Future<AqutterPrintJobInfo?> getInfo() async => null;

  @override
  void dispose() {}
}

class MockPlatformWebAuthenticationSession
    extends AqutterPlatformWebAuthenticationSession
    with MockPlatformInterfaceMixin {
  MockPlatformWebAuthenticationSession(super.params) : super.implementation();

  @override
  bool isMethodSupported(
    AqutterPlatformWebAuthenticationSessionMethod method, {
    TargetPlatform? platform,
  }) => true;
}

class MockPlatformHttpAuthCredentialDatabase
    extends AqutterPlatformHttpAuthCredentialDatabase
    with MockPlatformInterfaceMixin {
  MockPlatformHttpAuthCredentialDatabase(super.params) : super.implementation();

  @override
  bool isMethodSupported(
    AqutterPlatformHttpAuthCredentialDatabaseMethod method, {
    TargetPlatform? platform,
  }) => true;
}

class MockPlatformWebStorage extends AqutterPlatformWebStorage
    with MockPlatformInterfaceMixin {
  MockPlatformWebStorage(super.params) : super.implementation();

  @override
  AqutterPlatformLocalStorage get localStorage => params.localStorage;

  @override
  AqutterPlatformSessionStorage get sessionStorage => params.sessionStorage;
}

class MockPlatformLocalStorage extends AqutterPlatformLocalStorage
    with MockPlatformInterfaceMixin {
  MockPlatformLocalStorage(super.params) : super.implementation();

  @override
  AqutterPlatformWebViewController? get controller => params.controller;

  @override
  bool isMethodSupported(
    AqutterPlatformLocalStorageMethod method, {
    TargetPlatform? platform,
  }) => true;
}

class MockPlatformSessionStorage extends AqutterPlatformSessionStorage
    with MockPlatformInterfaceMixin {
  MockPlatformSessionStorage(super.params) : super.implementation();

  @override
  AqutterPlatformWebViewController? get controller => params.controller;

  @override
  bool isMethodSupported(
    AqutterPlatformSessionStorageMethod method, {
    TargetPlatform? platform,
  }) => true;
}
