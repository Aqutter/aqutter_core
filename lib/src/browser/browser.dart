import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../find_interaction/find_interaction_controller.dart';
import '../pull_to_refresh/main.dart';

import '../webview/webview_controller.dart';
import '../webview_environment/webview_environment.dart';

///{@macro aqutter_core.AqutterPlatformBrowser}
///
///{@macro aqutter_core.AqutterPlatformBrowser.supported_platforms}
class AqutterBrowser implements AqutterPlatformBrowserEvents {
  ///Constructs a [AqutterBrowser].
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.supported_platforms}
  AqutterBrowser({
    AqutterContextMenu? contextMenu,
    AqutterPullToRefreshController? pullToRefreshController,
    AqutterFindInteractionController? findInteractionController,
    UnmodifiableListView<AqutterUserScript>? initialUserScripts,
    int? windowId,
    AqutterWebViewEnvironment? webViewEnvironment,
  }) : this.fromPlatformCreationParams(
         AqutterPlatformBrowserCreationParams(
           contextMenu: contextMenu,
           pullToRefreshController: pullToRefreshController?.platform,
           findInteractionController: findInteractionController?.platform,
           initialUserScripts: initialUserScripts,
           windowId: windowId,
           webViewEnvironment: webViewEnvironment?.platform,
         ),
       );

  /// Constructs a [AqutterBrowser] from creation params for a specific
  /// platform.
  AqutterBrowser.fromPlatformCreationParams(
    AqutterPlatformBrowserCreationParams params,
  ) : this.fromPlatform(AqutterPlatformBrowser(params));

  /// Constructs a [AqutterBrowser] from a specific platform
  /// implementation.
  AqutterBrowser.fromPlatform(this.platform) {
    this.platform.eventHandler = this;
  }

  /// Implementation of [AqutterPlatformBrowser] for the current platform.
  final AqutterPlatformBrowser platform;

  ///{@macro aqutter_core.AqutterPlatformBrowser.id}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.id.supported_platforms}
  String get id => platform.id;

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.contextMenu}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.contextMenu.supported_platforms}
  AqutterContextMenu? get contextMenu => platform.contextMenu;

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.pullToRefreshController}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.pullToRefreshController.supported_platforms}
  AqutterPullToRefreshController? get pullToRefreshController {
    final pullToRefreshControllerPlatform = platform.pullToRefreshController;
    if (pullToRefreshControllerPlatform == null) {
      return null;
    }
    return AqutterPullToRefreshController.fromPlatform(
      platform: pullToRefreshControllerPlatform,
    );
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.findInteractionController}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.findInteractionController.supported_platforms}
  AqutterFindInteractionController? get findInteractionController {
    final findInteractionControllerPlatform =
        platform.findInteractionController;
    if (findInteractionControllerPlatform == null) {
      return null;
    }
    return AqutterFindInteractionController.fromPlatform(
      platform: findInteractionControllerPlatform,
    );
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.initialUserScripts}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.initialUserScripts.supported_platforms}
  UnmodifiableListView<AqutterUserScript>? get initialUserScripts =>
      platform.initialUserScripts;

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.windowId}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.windowId.supported_platforms}
  int? get windowId => platform.windowId;

  ///{@macro aqutter_core.AqutterPlatformBrowser.webViewController}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.webViewController.supported_platforms}
  AqutterWebViewController? get webViewController {
    final webViewControllerPlatform = platform.webViewController;
    if (webViewControllerPlatform == null) {
      return null;
    }
    return AqutterWebViewController.fromPlatform(
      platform: webViewControllerPlatform,
    );
  }

  ///{@macro aqutter_core.AqutterPlatformBrowser.openUrlRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.openUrlRequest.supported_platforms}
  Future<void> openUrlRequest({
    required AqutterURLRequest urlRequest,
    @Deprecated('Use settings instead') AqutterBrowserClassOptions? options,
    AqutterBrowserClassSettings? settings,
  }) {
    this.platform.eventHandler = this;
    return platform.openUrlRequest(
      urlRequest: urlRequest,
      options: options,
      settings: settings,
    );
  }

  ///{@macro aqutter_core.AqutterPlatformBrowser.openFile}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.openFile.supported_platforms}
  Future<void> openFile({
    required String assetFilePath,
    @Deprecated('Use settings instead') AqutterBrowserClassOptions? options,
    AqutterBrowserClassSettings? settings,
  }) {
    this.platform.eventHandler = this;
    return platform.openFile(
      assetFilePath: assetFilePath,
      options: options,
      settings: settings,
    );
  }

  ///{@macro aqutter_core.AqutterPlatformBrowser.openData}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.openData.supported_platforms}
  Future<void> openData({
    required String data,
    String mimeType = "text/html",
    String encoding = "utf8",
    AqutterWebUri? baseUrl,
    @Deprecated("Use historyUrl instead") Uri? androidHistoryUrl,
    AqutterWebUri? historyUrl,
    @Deprecated('Use settings instead') AqutterBrowserClassOptions? options,
    AqutterBrowserClassSettings? settings,
  }) {
    this.platform.eventHandler = this;
    return platform.openData(
      data: data,
      mimeType: mimeType,
      encoding: encoding,
      baseUrl: baseUrl,
      androidHistoryUrl: androidHistoryUrl,
      historyUrl: historyUrl,
      options: options,
      settings: settings,
    );
  }

  ///{@macro aqutter_core.AqutterPlatformBrowser.openWithSystemBrowser}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.openWithSystemBrowser.supported_platforms}
  static Future<void> openWithSystemBrowser({required AqutterWebUri url}) =>
      AqutterPlatformBrowser.static().openWithSystemBrowser(url: url);

  ///{@macro aqutter_core.AqutterPlatformBrowser.addMenuItem}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.addMenuItem.supported_platforms}
  void addMenuItem(AqutterBrowserMenuItem menuItem) =>
      platform.addMenuItem(menuItem);

  ///{@macro aqutter_core.AqutterPlatformBrowser.addMenuItems}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.addMenuItems.supported_platforms}
  void addMenuItems(List<AqutterBrowserMenuItem> menuItems) =>
      platform.addMenuItems(menuItems);

  ///{@macro aqutter_core.AqutterPlatformBrowser.removeMenuItem}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.removeMenuItem.supported_platforms}
  bool removeMenuItem(AqutterBrowserMenuItem menuItem) =>
      platform.removeMenuItem(menuItem);

  ///{@macro aqutter_core.AqutterPlatformBrowser.removeMenuItems}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.removeMenuItems.supported_platforms}
  void removeMenuItems(List<AqutterBrowserMenuItem> menuItems) =>
      platform.removeMenuItems(menuItems);

  ///{@macro aqutter_core.AqutterPlatformBrowser.removeAllMenuItem}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.removeAllMenuItem.supported_platforms}
  void removeAllMenuItem() => platform.removeAllMenuItem();

  ///{@macro aqutter_core.AqutterPlatformBrowser.hasMenuItem}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.hasMenuItem.supported_platforms}
  bool hasMenuItem(AqutterBrowserMenuItem menuItem) =>
      platform.hasMenuItem(menuItem);

  ///{@macro aqutter_core.AqutterPlatformBrowser.show}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.show.supported_platforms}
  Future<void> show() => platform.show();

  ///{@macro aqutter_core.AqutterPlatformBrowser.hide}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.hide.supported_platforms}
  Future<void> hide() => platform.hide();

  ///{@macro aqutter_core.AqutterPlatformBrowser.close}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.close.supported_platforms}
  Future<void> close() => platform.close();

  ///{@macro aqutter_core.AqutterPlatformBrowser.isHidden}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.isHidden.supported_platforms}
  Future<bool> isHidden() => platform.isHidden();

  ///{@macro aqutter_core.AqutterPlatformBrowser.setOptions}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.setOptions.supported_platforms}
  @Deprecated('Use setSettings instead')
  Future<void> setOptions({required AqutterBrowserClassOptions options}) =>
      platform.setOptions(options: options);

  ///{@macro aqutter_core.AqutterPlatformBrowser.getOptions}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.getOptions.supported_platforms}
  @Deprecated('Use getSettings instead')
  Future<AqutterBrowserClassOptions?> getOptions() => platform.getOptions();

  ///{@macro aqutter_core.AqutterPlatformBrowser.setSettings}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.setSettings.supported_platforms}
  Future<void> setSettings({required AqutterBrowserClassSettings settings}) =>
      platform.setSettings(settings: settings);

  ///{@macro aqutter_core.AqutterPlatformBrowser.getSettings}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.getSettings.supported_platforms}
  Future<AqutterBrowserClassSettings?> getSettings() => platform.getSettings();

  ///{@macro aqutter_core.AqutterPlatformBrowser.isOpened}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.isOpened.supported_platforms}
  bool isOpened() => platform.isOpened();

  ///{@macro aqutter_core.AqutterPlatformBrowser.dispose}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.dispose.supported_platforms}
  @mustCallSuper
  void dispose() => platform.dispose();

  ///Use [onFormResubmission] instead.
  @Deprecated('Use onFormResubmission instead')
  @override
  FutureOr<AqutterFormResubmissionAction?>? androidOnFormResubmission(Uri? url) {
    return null;
  }

  ///Use [onGeolocationPermissionsHidePrompt] instead.
  @Deprecated("Use onGeolocationPermissionsHidePrompt instead")
  @override
  void androidOnGeolocationPermissionsHidePrompt() {}

  ///Use [onGeolocationPermissionsShowPrompt] instead.
  @Deprecated("Use onGeolocationPermissionsShowPrompt instead")
  @override
  FutureOr<AqutterGeolocationPermissionShowPromptResponse?>?
  androidOnGeolocationPermissionsShowPrompt(String origin) {
    return null;
  }

  ///Use [onJsBeforeUnload] instead.
  @Deprecated('Use onJsBeforeUnload instead')
  @override
  FutureOr<AqutterJsBeforeUnloadResponse?>? androidOnJsBeforeUnload(
    AqutterJsBeforeUnloadRequest jsBeforeUnloadRequest,
  ) {
    return null;
  }

  ///Use [onPermissionRequest] instead.
  @Deprecated("Use onPermissionRequest instead")
  @override
  FutureOr<AqutterPermissionRequestResponse?>? androidOnPermissionRequest(
    String origin,
    List<String> resources,
  ) {
    return null;
  }

  ///Use [onReceivedIcon] instead.
  @Deprecated('Use onReceivedIcon instead')
  @override
  void androidOnReceivedIcon(Uint8List icon) {}

  ///Use [onReceivedLoginRequest] instead.
  @Deprecated('Use onReceivedLoginRequest instead')
  @override
  void androidOnReceivedLoginRequest(AqutterLoginRequest loginRequest) {}

  ///Use [onReceivedTouchIconUrl] instead.
  @Deprecated('Use onReceivedTouchIconUrl instead')
  @override
  void androidOnReceivedTouchIconUrl(Uri url, bool precomposed) {}

  ///Use [onRenderProcessGone] instead.
  @Deprecated("Use onRenderProcessGone instead")
  @override
  void androidOnRenderProcessGone(AqutterRenderProcessGoneDetail detail) {}

  ///Use [onRenderProcessResponsive] instead.
  @Deprecated("Use onRenderProcessResponsive instead")
  @override
  FutureOr<AqutterWebViewRenderProcessAction?>? androidOnRenderProcessResponsive(
    Uri? url,
  ) {
    return null;
  }

  ///Use [onRenderProcessUnresponsive] instead.
  @Deprecated("Use onRenderProcessUnresponsive instead")
  @override
  FutureOr<AqutterWebViewRenderProcessAction?>? androidOnRenderProcessUnresponsive(
    Uri? url,
  ) {
    return null;
  }

  ///Use [onSafeBrowsingHit] instead.
  @Deprecated("Use onSafeBrowsingHit instead")
  @override
  FutureOr<AqutterSafeBrowsingResponse?>? androidOnSafeBrowsingHit(
    Uri url,
    AqutterSafeBrowsingThreat? threatType,
  ) {
    return null;
  }

  ///Use [onZoomScaleChanged] instead.
  @Deprecated('Use onZoomScaleChanged instead')
  @override
  void androidOnScaleChanged(double oldScale, double newScale) {}

  ///Use [shouldInterceptRequest] instead.
  @Deprecated("Use shouldInterceptRequest instead")
  @override
  FutureOr<AqutterWebResourceResponse?>? androidShouldInterceptRequest(
    AqutterWebResourceRequest request,
  ) {
    return null;
  }

  ///Use [onDidReceiveServerRedirectForProvisionalNavigation] instead.
  @Deprecated('Use onDidReceiveServerRedirectForProvisionalNavigation instead')
  @override
  void iosOnDidReceiveServerRedirectForProvisionalNavigation() {}

  ///Use [onNavigationResponse] instead.
  @Deprecated('Use onNavigationResponse instead')
  @override
  FutureOr<AqutterIOSNavigationResponseAction?>? iosOnNavigationResponse(
    AqutterIOSWKNavigationResponse navigationResponse,
  ) {
    return null;
  }

  ///Use [onWebContentProcessDidTerminate] instead.
  @Deprecated('Use onWebContentProcessDidTerminate instead')
  @override
  void iosOnWebContentProcessDidTerminate() {}

  ///Use [shouldAllowDeprecatedTLS] instead.
  @Deprecated('Use shouldAllowDeprecatedTLS instead')
  @override
  FutureOr<AqutterIOSShouldAllowDeprecatedTLSAction?>? iosShouldAllowDeprecatedTLS(
    AqutterURLAuthenticationChallenge challenge,
  ) {
    return null;
  }

  @override
  FutureOr<AqutterAjaxRequestAction?>? onAjaxProgress(AqutterAjaxRequest ajaxRequest) {
    return null;
  }

  @override
  FutureOr<AqutterAjaxRequestAction?>? onAjaxReadyStateChange(
    AqutterAjaxRequest ajaxRequest,
  ) {
    return null;
  }

  @override
  void onBrowserCreated() {}

  @override
  void onCameraCaptureStateChanged(
    AqutterMediaCaptureState? oldState,
    AqutterMediaCaptureState? newState,
  ) {}

  @override
  void onCloseWindow() {}

  @override
  void onConsoleMessage(AqutterConsoleMessage consoleMessage) {}

  @override
  void onContentSizeChanged(Size oldContentSize, Size newContentSize) {}

  @override
  FutureOr<bool?>? onCreateWindow(AqutterCreateWindowAction createWindowAction) {
    return null;
  }

  @override
  void onDidReceiveServerRedirectForProvisionalNavigation() {}

  ///Use [onDownloadStarting] instead
  @Deprecated('Use onDownloadStarting instead')
  @override
  void onDownloadStart(Uri url) {}

  ///Use [onDownloadStarting] instead
  @Deprecated('Use onDownloadStarting instead')
  @override
  void onDownloadStartRequest(AqutterDownloadStartRequest downloadStartRequest) {}

  @override
  FutureOr<AqutterDownloadStartResponse?>? onDownloadStarting(
    AqutterDownloadStartRequest downloadStartRequest,
  ) {
    return null;
  }

  @override
  void onEnterFullscreen() {}

  @override
  void onExit() {}

  @override
  void onExitFullscreen() {}

  @override
  void onContentLoading(AqutterWebUri? url) {}

  @override
  void onDOMContentLoaded(AqutterWebUri? url) {}

  ///Use [AqutterFindInteractionController.onFindResultReceived] instead.
  @Deprecated('Use AqutterFindInteractionController.onFindResultReceived instead')
  @override
  void onFindResultReceived(
    int activeMatchOrdinal,
    int numberOfMatches,
    bool isDoneCounting,
  ) {}

  @override
  FutureOr<AqutterFormResubmissionAction?>? onFormResubmission(AqutterWebUri? url) {
    return null;
  }

  @override
  void onGeolocationPermissionsHidePrompt() {}

  @override
  FutureOr<AqutterGeolocationPermissionShowPromptResponse?>?
  onGeolocationPermissionsShowPrompt(String origin) {
    return null;
  }

  @override
  FutureOr<AqutterJsAlertResponse?>? onJsAlert(AqutterJsAlertRequest jsAlertRequest) {
    return null;
  }

  @override
  FutureOr<AqutterJsBeforeUnloadResponse?>? onJsBeforeUnload(
    AqutterJsBeforeUnloadRequest jsBeforeUnloadRequest,
  ) {
    return null;
  }

  @override
  FutureOr<AqutterJsConfirmResponse?>? onJsConfirm(AqutterJsConfirmRequest jsConfirmRequest) {
    return null;
  }

  @override
  FutureOr<AqutterJsPromptResponse?>? onJsPrompt(AqutterJsPromptRequest jsPromptRequest) {
    return null;
  }

  ///Use [onReceivedError] instead.
  @Deprecated("Use onReceivedError instead")
  @override
  void onLoadError(Uri? url, int code, String message) {}

  ///Use [onReceivedHttpError] instead.
  @Deprecated("Use onReceivedHttpError instead")
  @override
  void onLoadHttpError(Uri? url, int statusCode, String description) {}

  @override
  void onLoadResource(AqutterLoadedResource resource) {}

  ///Use [onLoadResourceWithCustomScheme] instead.
  @Deprecated('Use onLoadResourceWithCustomScheme instead')
  @override
  FutureOr<AqutterCustomSchemeResponse?>? onLoadResourceCustomScheme(Uri url) {
    return null;
  }

  @override
  FutureOr<AqutterCustomSchemeResponse?>? onLoadResourceWithCustomScheme(
    AqutterWebResourceRequest request,
  ) {
    return null;
  }

  @override
  void onLoadStart(AqutterWebUri? url) {}

  @override
  void onLoadStop(AqutterWebUri? url) {}

  @override
  void onLongPressHitTestResult(AqutterWebViewHitTestResult hitTestResult) {}

  @override
  void onMicrophoneCaptureStateChanged(
    AqutterMediaCaptureState? oldState,
    AqutterMediaCaptureState? newState,
  ) {}

  @override
  FutureOr<AqutterNavigationResponseAction?>? onNavigationResponse(
    AqutterNavigationResponse navigationResponse,
  ) {
    return null;
  }

  @override
  void onOverScrolled(int x, int y, bool clampedX, bool clampedY) {}

  @override
  void onPageCommitVisible(AqutterWebUri? url) {}

  @override
  FutureOr<AqutterPermissionResponse?>? onPermissionRequest(
    AqutterPermissionRequest permissionRequest,
  ) {
    return null;
  }

  @override
  void onPermissionRequestCanceled(AqutterPermissionRequest permissionRequest) {}

  ///Use [onPrintRequest] instead
  @Deprecated("Use onPrintRequest instead")
  @override
  void onPrint(Uri? url) {}

  @override
  FutureOr<bool?>? onPrintRequest(
    AqutterWebUri? url,
    AqutterPlatformPrintJobController? printJobController,
  ) {
    return null;
  }

  @override
  void onProgressChanged(int progress) {}

  @override
  FutureOr<AqutterClientCertResponse?>? onReceivedClientCertRequest(
    AqutterClientCertChallenge challenge,
  ) {
    return null;
  }

  @override
  void onReceivedError(AqutterWebResourceRequest request, AqutterWebResourceError error) {}

  @override
  FutureOr<AqutterHttpAuthResponse?>? onReceivedHttpAuthRequest(
    AqutterHttpAuthenticationChallenge challenge,
  ) {
    return null;
  }

  @override
  void onReceivedHttpError(
    AqutterWebResourceRequest request,
    AqutterWebResourceResponse errorResponse,
  ) {}

  ///Use [onFaviconChanged] instead.
  @Deprecated('Use onFaviconChanged instead')
  @override
  void onReceivedIcon(Uint8List icon) {}

  @override
  void onFaviconChanged(AqutterFaviconChangedRequest faviconChangedRequest) {}

  @override
  void onReceivedLoginRequest(AqutterLoginRequest loginRequest) {}

  @override
  FutureOr<AqutterServerTrustAuthResponse?>? onReceivedServerTrustAuthRequest(
    AqutterServerTrustChallenge challenge,
  ) {
    return null;
  }

  @override
  void onReceivedTouchIconUrl(AqutterWebUri url, bool precomposed) {}

  @override
  FutureOr<AqutterNotificationReceivedResponse?>? onNotificationReceived(
    AqutterNotificationReceivedRequest request,
  ) {
    return null;
  }

  @override
  FutureOr<AqutterSaveAsUIShowingResponse?>? onSaveAsUIShowing(
    AqutterSaveAsUIShowingRequest request,
  ) {
    return null;
  }

  @override
  FutureOr<AqutterSaveFileSecurityCheckStartingResponse?>?
  onSaveFileSecurityCheckStarting(
    AqutterSaveFileSecurityCheckStartingRequest request,
  ) {
    return null;
  }

  @override
  FutureOr<AqutterScreenCaptureStartingResponse?>? onScreenCaptureStarting(
    AqutterScreenCaptureStartingRequest request,
  ) {
    return null;
  }

  @override
  FutureOr<AqutterLaunchingExternalUriSchemeResponse?>? onLaunchingExternalUriScheme(
    AqutterLaunchingExternalUriSchemeRequest request,
  ) {
    return null;
  }

  @override
  void onRenderProcessGone(AqutterRenderProcessGoneDetail detail) {}

  @override
  FutureOr<AqutterWebViewRenderProcessAction?>? onRenderProcessResponsive(
    AqutterWebUri? url,
  ) {
    return null;
  }

  @override
  FutureOr<AqutterWebViewRenderProcessAction?>? onRenderProcessUnresponsive(
    AqutterWebUri? url,
  ) {
    return null;
  }

  @override
  void onRequestFocus() {}

  @override
  FutureOr<AqutterSafeBrowsingResponse?>? onSafeBrowsingHit(
    AqutterWebUri url,
    AqutterSafeBrowsingThreat? threatType,
  ) {
    return null;
  }

  @override
  void onScrollChanged(int x, int y) {}

  @override
  void onTitleChanged(String? title) {}

  @override
  void onUpdateVisitedHistory(AqutterWebUri? url, bool? isReload) {}

  @override
  void onWebContentProcessDidTerminate() {}

  @override
  void onWindowBlur() {}

  @override
  void onWindowFocus() {}

  @override
  void onZoomScaleChanged(double oldScale, double newScale) {}

  @override
  FutureOr<AqutterShouldAllowDeprecatedTLSAction?>? shouldAllowDeprecatedTLS(
    AqutterURLAuthenticationChallenge challenge,
  ) {
    return null;
  }

  @override
  FutureOr<AqutterAjaxRequest?>? shouldInterceptAjaxRequest(AqutterAjaxRequest ajaxRequest) {
    return null;
  }

  @override
  FutureOr<AqutterFetchRequest?>? shouldInterceptFetchRequest(
    AqutterFetchRequest fetchRequest,
  ) {
    return null;
  }

  @override
  FutureOr<AqutterWebResourceResponse?>? shouldInterceptRequest(
    AqutterWebResourceRequest request,
  ) {
    return null;
  }

  @override
  FutureOr<AqutterNavigationActionPolicy?>? shouldOverrideUrlLoading(
    AqutterNavigationAction navigationAction,
  ) {
    return null;
  }

  @override
  void onMainWindowWillClose() {}

  @override
  void onProcessFailed(AqutterProcessFailedDetail detail) {}

  @override
  void onAcceleratorKeyPressed(AqutterAcceleratorKeyPressedDetail detail) {}

  @override
  FutureOr<AqutterShowFileChooserResponse?> onShowFileChooser(
    AqutterShowFileChooserRequest request,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformBrowser.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformBrowser.static().isClassSupported(platform: platform);

  ///{@macro aqutter_core.AqutterPlatformBrowser.isPropertySupported}
  static bool isPropertySupported(
    AqutterPlatformBrowserProperty property, {
    TargetPlatform? platform,
  }) => AqutterPlatformBrowser.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformBrowser.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformBrowserMethod property, {
    TargetPlatform? platform,
  }) => AqutterPlatformBrowser.static().isMethodSupported(
    property,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.isMethodSupported}
  static bool isEventMethodSupported(
    AqutterPlatformBrowserEventsMethod method, {
    TargetPlatform? platform,
  }) =>
      AqutterPlatformBrowserEvents.isMethodSupported(method, platform: platform);
}
