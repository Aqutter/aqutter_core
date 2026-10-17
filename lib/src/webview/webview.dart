import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../find_interaction/find_interaction_controller.dart';
import '../pull_to_refresh/main.dart';
import '../pull_to_refresh/pull_to_refresh_controller.dart';
import '../webview_environment/webview_environment.dart';
import 'headless_webview.dart';
import 'webview_controller.dart';

///{@macro aqutter_core.AqutterPlatformWebViewWidget}
///
///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.supported_platforms}
class AqutterWebView extends StatefulWidget {
  /// Constructs a [AqutterWebView].
  ///
  /// See [AqutterWebView.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterWebView.fromPlatformCreationParams({
    Key? key,
    required AqutterPlatformWebViewWidgetCreationParams params,
  }) : this.fromPlatform(
         key: key,
         platform: AqutterPlatformWebViewWidget(params),
       );

  /// Constructs a [AqutterWebView] from a specific platform implementation.
  AqutterWebView.fromPlatform({super.key, required this.platform});

  /// Implementation of [AqutterPlatformWebView] for the current platform.
  final AqutterPlatformWebViewWidget platform;

  ///{@macro aqutter_core.AqutterPlatformWebViewWidget}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.supported_platforms}
  AqutterWebView({
    Key? key,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
    int? windowId,
    AqutterHeadlessWebView? headlessWebView,
    AqutterWebViewKeepAlive? keepAlive,
    bool? preventGestureDelay,
    TextDirection? layoutDirection,
    AqutterWebViewEnvironment? webViewEnvironment,
    @Deprecated('Use onGeolocationPermissionsHidePrompt instead')
    void Function(AqutterWebViewController controller)?
    androidOnGeolocationPermissionsHidePrompt,
    @Deprecated('Use onGeolocationPermissionsShowPrompt instead')
    FutureOr<AqutterGeolocationPermissionShowPromptResponse?> Function(
      AqutterWebViewController controller,
      String origin,
    )?
    androidOnGeolocationPermissionsShowPrompt,
    @Deprecated('Use onPermissionRequest instead')
    FutureOr<AqutterPermissionRequestResponse?> Function(
      AqutterWebViewController controller,
      String origin,
      List<String> resources,
    )?
    androidOnPermissionRequest,
    @Deprecated('Use onSafeBrowsingHit instead')
    FutureOr<AqutterSafeBrowsingResponse?> Function(
      AqutterWebViewController controller,
      Uri url,
      AqutterSafeBrowsingThreat? threatType,
    )?
    androidOnSafeBrowsingHit,
    AqutterWebViewInitialData? initialData,
    String? initialFile,
    @Deprecated('Use initialSettings instead')
    AqutterWebViewGroupOptions? initialOptions,
    AqutterWebViewSettings? initialSettings,
    AqutterURLRequest? initialUrlRequest,
    UnmodifiableListView<AqutterUserScript>? initialUserScripts,
    AqutterPullToRefreshController? pullToRefreshController,
    AqutterFindInteractionController? findInteractionController,
    AqutterContextMenu? contextMenu,
    void Function(AqutterWebViewController controller, AqutterWebUri? url)?
    onContentLoading,
    void Function(AqutterWebViewController controller, AqutterWebUri? url)?
    onDOMContentLoaded,
    void Function(AqutterWebViewController controller, AqutterWebUri? url)?
    onPageCommitVisible,
    void Function(AqutterWebViewController controller, String? title)?
    onTitleChanged,
    @Deprecated(
      'Use onDidReceiveServerRedirectForProvisionalNavigation instead',
    )
    void Function(AqutterWebViewController controller)?
    iosOnDidReceiveServerRedirectForProvisionalNavigation,
    @Deprecated('Use onWebContentProcessDidTerminate instead')
    void Function(AqutterWebViewController controller)?
    iosOnWebContentProcessDidTerminate,
    @Deprecated('Use onNavigationResponse instead')
    FutureOr<AqutterIOSNavigationResponseAction?> Function(
      AqutterWebViewController controller,
      AqutterIOSWKNavigationResponse navigationResponse,
    )?
    iosOnNavigationResponse,
    @Deprecated('Use shouldAllowDeprecatedTLS instead')
    FutureOr<AqutterIOSShouldAllowDeprecatedTLSAction?> Function(
      AqutterWebViewController controller,
      AqutterURLAuthenticationChallenge challenge,
    )?
    iosShouldAllowDeprecatedTLS,
    FutureOr<AqutterAjaxRequestAction?> Function(
      AqutterWebViewController controller,
      AqutterAjaxRequest ajaxRequest,
    )?
    onAjaxProgress,
    FutureOr<AqutterAjaxRequestAction?> Function(
      AqutterWebViewController controller,
      AqutterAjaxRequest ajaxRequest,
    )?
    onAjaxReadyStateChange,
    void Function(
      AqutterWebViewController controller,
      AqutterConsoleMessage consoleMessage,
    )?
    onConsoleMessage,
    FutureOr<bool?> Function(
      AqutterWebViewController controller,
      AqutterCreateWindowAction createWindowAction,
    )?
    onCreateWindow,
    void Function(AqutterWebViewController controller)? onCloseWindow,
    void Function(AqutterWebViewController controller)? onWindowFocus,
    void Function(AqutterWebViewController controller)? onWindowBlur,
    @Deprecated('Use onReceivedIcon instead')
    void Function(AqutterWebViewController controller, Uint8List icon)?
    androidOnReceivedIcon,
    @Deprecated('Use onReceivedTouchIconUrl instead')
    void Function(AqutterWebViewController controller, Uri url, bool precomposed)?
    androidOnReceivedTouchIconUrl,
    @Deprecated('Use onDownloadStarting instead')
    void Function(AqutterWebViewController controller, Uri url)? onDownloadStart,
    @Deprecated('Use onDownloadStarting instead')
    void Function(
      AqutterWebViewController controller,
      AqutterDownloadStartRequest downloadStartRequest,
    )?
    onDownloadStartRequest,
    FutureOr<AqutterDownloadStartResponse?> Function(
      AqutterWebViewController controller,
      AqutterDownloadStartRequest downloadStartRequest,
    )?
    onDownloadStarting,
    @Deprecated('Use AqutterFindInteractionController.onFindResultReceived instead')
    void Function(
      AqutterWebViewController controller,
      int activeMatchOrdinal,
      int numberOfMatches,
      bool isDoneCounting,
    )?
    onFindResultReceived,
    FutureOr<AqutterJsAlertResponse?> Function(
      AqutterWebViewController controller,
      AqutterJsAlertRequest jsAlertRequest,
    )?
    onJsAlert,
    FutureOr<AqutterJsConfirmResponse?> Function(
      AqutterWebViewController controller,
      AqutterJsConfirmRequest jsConfirmRequest,
    )?
    onJsConfirm,
    FutureOr<AqutterJsPromptResponse?> Function(
      AqutterWebViewController controller,
      AqutterJsPromptRequest jsPromptRequest,
    )?
    onJsPrompt,
    @Deprecated("Use onReceivedError instead")
    void Function(
      AqutterWebViewController controller,
      Uri? url,
      int code,
      String message,
    )?
    onLoadError,
    void Function(
      AqutterWebViewController controller,
      AqutterWebResourceRequest request,
      AqutterWebResourceError error,
    )?
    onReceivedError,
    @Deprecated("Use onReceivedHttpError instead")
    void Function(
      AqutterWebViewController controller,
      Uri? url,
      int statusCode,
      String description,
    )?
    onLoadHttpError,
    void Function(
      AqutterWebViewController controller,
      AqutterWebResourceRequest request,
      AqutterWebResourceResponse errorResponse,
    )?
    onReceivedHttpError,
    void Function(AqutterWebViewController controller, AqutterLoadedResource resource)?
    onLoadResource,
    @Deprecated('Use onLoadResourceWithCustomScheme instead')
    FutureOr<AqutterCustomSchemeResponse?> Function(
      AqutterWebViewController controller,
      Uri url,
    )?
    onLoadResourceCustomScheme,
    FutureOr<AqutterCustomSchemeResponse?> Function(
      AqutterWebViewController controller,
      AqutterWebResourceRequest request,
    )?
    onLoadResourceWithCustomScheme,
    void Function(AqutterWebViewController controller, AqutterWebUri? url)? onLoadStart,
    void Function(AqutterWebViewController controller, AqutterWebUri? url)? onLoadStop,
    void Function(
      AqutterWebViewController controller,
      AqutterWebViewHitTestResult hitTestResult,
    )?
    onLongPressHitTestResult,
    @Deprecated("Use onPrintRequest instead")
    void Function(AqutterWebViewController controller, Uri? url)? onPrint,
    FutureOr<bool?> Function(
      AqutterWebViewController controller,
      AqutterWebUri? url,
      AqutterPlatformPrintJobController? printJobController,
    )?
    onPrintRequest,
    void Function(AqutterWebViewController controller, int progress)?
    onProgressChanged,
    FutureOr<AqutterClientCertResponse?> Function(
      AqutterWebViewController controller,
      AqutterClientCertChallenge challenge,
    )?
    onReceivedClientCertRequest,
    FutureOr<AqutterHttpAuthResponse?> Function(
      AqutterWebViewController controller,
      AqutterHttpAuthenticationChallenge challenge,
    )?
    onReceivedHttpAuthRequest,
    FutureOr<AqutterServerTrustAuthResponse?> Function(
      AqutterWebViewController controller,
      AqutterServerTrustChallenge challenge,
    )?
    onReceivedServerTrustAuthRequest,
    void Function(AqutterWebViewController controller, int x, int y)?
    onScrollChanged,
    void Function(
      AqutterWebViewController controller,
      AqutterWebUri? url,
      bool? isReload,
    )?
    onUpdateVisitedHistory,
    void Function(AqutterWebViewController controller)? onWebViewCreated,
    FutureOr<AqutterAjaxRequest?> Function(
      AqutterWebViewController controller,
      AqutterAjaxRequest ajaxRequest,
    )?
    shouldInterceptAjaxRequest,
    FutureOr<AqutterFetchRequest?> Function(
      AqutterWebViewController controller,
      AqutterFetchRequest fetchRequest,
    )?
    shouldInterceptFetchRequest,
    FutureOr<AqutterNavigationActionPolicy?> Function(
      AqutterWebViewController controller,
      AqutterNavigationAction navigationAction,
    )?
    shouldOverrideUrlLoading,
    void Function(AqutterWebViewController controller)? onEnterFullscreen,
    void Function(AqutterWebViewController controller)? onExitFullscreen,
    void Function(
      AqutterWebViewController controller,
      int x,
      int y,
      bool clampedX,
      bool clampedY,
    )?
    onOverScrolled,
    void Function(
      AqutterWebViewController controller,
      double oldScale,
      double newScale,
    )?
    onZoomScaleChanged,
    @Deprecated('Use shouldInterceptRequest instead')
    FutureOr<AqutterWebResourceResponse?> Function(
      AqutterWebViewController controller,
      AqutterWebResourceRequest request,
    )?
    androidShouldInterceptRequest,
    @Deprecated('Use onRenderProcessUnresponsive instead')
    FutureOr<AqutterWebViewRenderProcessAction?> Function(
      AqutterWebViewController controller,
      Uri? url,
    )?
    androidOnRenderProcessUnresponsive,
    @Deprecated('Use onRenderProcessResponsive instead')
    FutureOr<AqutterWebViewRenderProcessAction?> Function(
      AqutterWebViewController controller,
      Uri? url,
    )?
    androidOnRenderProcessResponsive,
    @Deprecated('Use onRenderProcessGone instead')
    void Function(
      AqutterWebViewController controller,
      AqutterRenderProcessGoneDetail detail,
    )?
    androidOnRenderProcessGone,
    @Deprecated('Use onFormResubmission instead')
    FutureOr<AqutterFormResubmissionAction?> Function(
      AqutterWebViewController controller,
      Uri? url,
    )?
    androidOnFormResubmission,
    @Deprecated('Use onZoomScaleChanged instead')
    void Function(
      AqutterWebViewController controller,
      double oldScale,
      double newScale,
    )?
    androidOnScaleChanged,
    @Deprecated('Use onJsBeforeUnload instead')
    FutureOr<AqutterJsBeforeUnloadResponse?> Function(
      AqutterWebViewController controller,
      AqutterJsBeforeUnloadRequest jsBeforeUnloadRequest,
    )?
    androidOnJsBeforeUnload,
    @Deprecated('Use onReceivedLoginRequest instead')
    void Function(AqutterWebViewController controller, AqutterLoginRequest loginRequest)?
    androidOnReceivedLoginRequest,
    void Function(AqutterWebViewController controller)?
    onDidReceiveServerRedirectForProvisionalNavigation,
    FutureOr<AqutterFormResubmissionAction?> Function(
      AqutterWebViewController controller,
      AqutterWebUri? url,
    )?
    onFormResubmission,
    void Function(AqutterWebViewController controller)?
    onGeolocationPermissionsHidePrompt,
    FutureOr<AqutterGeolocationPermissionShowPromptResponse?> Function(
      AqutterWebViewController controller,
      String origin,
    )?
    onGeolocationPermissionsShowPrompt,
    FutureOr<AqutterJsBeforeUnloadResponse?> Function(
      AqutterWebViewController controller,
      AqutterJsBeforeUnloadRequest jsBeforeUnloadRequest,
    )?
    onJsBeforeUnload,
    FutureOr<AqutterNavigationResponseAction?> Function(
      AqutterWebViewController controller,
      AqutterNavigationResponse navigationResponse,
    )?
    onNavigationResponse,
    FutureOr<AqutterPermissionResponse?> Function(
      AqutterWebViewController controller,
      AqutterPermissionRequest permissionRequest,
    )?
    onPermissionRequest,
    @Deprecated('Use onFaviconChanged instead')
    void Function(AqutterWebViewController controller, Uint8List icon)?
    onReceivedIcon,
    void Function(
      AqutterWebViewController controller,
      AqutterFaviconChangedRequest faviconChangedRequest,
    )?
    onFaviconChanged,
    void Function(AqutterWebViewController controller, AqutterLoginRequest loginRequest)?
    onReceivedLoginRequest,
    void Function(
      AqutterWebViewController controller,
      AqutterPermissionRequest permissionRequest,
    )?
    onPermissionRequestCanceled,
    void Function(AqutterWebViewController controller)? onRequestFocus,
    void Function(
      AqutterWebViewController controller,
      AqutterWebUri url,
      bool precomposed,
    )?
    onReceivedTouchIconUrl,
    void Function(
      AqutterWebViewController controller,
      AqutterRenderProcessGoneDetail detail,
    )?
    onRenderProcessGone,
    FutureOr<AqutterWebViewRenderProcessAction?> Function(
      AqutterWebViewController controller,
      AqutterWebUri? url,
    )?
    onRenderProcessResponsive,
    FutureOr<AqutterWebViewRenderProcessAction?> Function(
      AqutterWebViewController controller,
      AqutterWebUri? url,
    )?
    onRenderProcessUnresponsive,
    FutureOr<AqutterSafeBrowsingResponse?> Function(
      AqutterWebViewController controller,
      AqutterWebUri url,
      AqutterSafeBrowsingThreat? threatType,
    )?
    onSafeBrowsingHit,
    void Function(AqutterWebViewController controller)?
    onWebContentProcessDidTerminate,
    FutureOr<AqutterShouldAllowDeprecatedTLSAction?> Function(
      AqutterWebViewController controller,
      AqutterURLAuthenticationChallenge challenge,
    )?
    shouldAllowDeprecatedTLS,
    FutureOr<AqutterWebResourceResponse?> Function(
      AqutterWebViewController controller,
      AqutterWebResourceRequest request,
    )?
    shouldInterceptRequest,
    FutureOr<void> Function(
      AqutterWebViewController controller,
      AqutterMediaCaptureState? oldState,
      AqutterMediaCaptureState? newState,
    )?
    onCameraCaptureStateChanged,
    FutureOr<void> Function(
      AqutterWebViewController controller,
      AqutterMediaCaptureState? oldState,
      AqutterMediaCaptureState? newState,
    )?
    onMicrophoneCaptureStateChanged,
    void Function(
      AqutterWebViewController controller,
      Size oldContentSize,
      Size newContentSize,
    )?
    onContentSizeChanged,
    void Function(
      AqutterWebViewController controller,
      AqutterProcessFailedDetail detail,
    )?
    onProcessFailed,
    FutureOr<AqutterNotificationReceivedResponse?> Function(
      AqutterWebViewController controller,
      AqutterNotificationReceivedRequest request,
    )?
    onNotificationReceived,
    FutureOr<AqutterSaveAsUIShowingResponse?> Function(
      AqutterWebViewController controller,
      AqutterSaveAsUIShowingRequest request,
    )?
    onSaveAsUIShowing,
    FutureOr<AqutterSaveFileSecurityCheckStartingResponse?> Function(
      AqutterWebViewController controller,
      AqutterSaveFileSecurityCheckStartingRequest request,
    )?
    onSaveFileSecurityCheckStarting,
    FutureOr<AqutterScreenCaptureStartingResponse?> Function(
      AqutterWebViewController controller,
      AqutterScreenCaptureStartingRequest request,
    )?
    onScreenCaptureStarting,
    void Function(
      AqutterWebViewController controller,
      AqutterAcceleratorKeyPressedDetail detail,
    )?
    onAcceleratorKeyPressed,
    FutureOr<AqutterShowFileChooserResponse?> Function(
      AqutterWebViewController controller,
      AqutterShowFileChooserRequest request,
    )?
    onShowFileChooser,
    FutureOr<AqutterLaunchingExternalUriSchemeResponse?> Function(
      AqutterWebViewController controller,
      AqutterLaunchingExternalUriSchemeRequest request,
    )?
    onLaunchingExternalUriScheme,
  }) : this.fromPlatformCreationParams(
         key: key,
         params: AqutterPlatformWebViewWidgetCreationParams(
           controllerFromPlatform:
               (AqutterPlatformWebViewController controller) =>
                   AqutterWebViewController.fromPlatform(platform: controller),
           windowId: windowId,
           keepAlive: keepAlive,
           initialUrlRequest: initialUrlRequest,
           initialFile: initialFile,
           initialData: initialData,
           initialOptions: initialOptions,
           initialSettings: initialSettings,
           initialUserScripts: initialUserScripts,
           pullToRefreshController: pullToRefreshController?.platform,
           findInteractionController: findInteractionController?.platform,
           contextMenu: contextMenu,
           layoutDirection: layoutDirection,
           webViewEnvironment: webViewEnvironment?.platform,
           onWebViewCreated: onWebViewCreated != null
               ? (controller) => onWebViewCreated.call(controller)
               : null,
           onLoadStart: onLoadStart != null
               ? (controller, url) => onLoadStart.call(controller, url)
               : null,
           onLoadStop: onLoadStop != null
               ? (controller, url) => onLoadStop.call(controller, url)
               : null,
           onLoadError: onLoadError != null
               ? (controller, url, code, message) =>
                     onLoadError.call(controller, url, code, message)
               : null,
           onReceivedError: onReceivedError != null
               ? (controller, request, error) =>
                     onReceivedError.call(controller, request, error)
               : null,
           onLoadHttpError: onLoadHttpError != null
               ? (controller, url, statusCode, description) => onLoadHttpError
                     .call(controller, url, statusCode, description)
               : null,
           onReceivedHttpError: onReceivedHttpError != null
               ? (controller, request, errorResponse) => onReceivedHttpError
                     .call(controller, request, errorResponse)
               : null,
           onConsoleMessage: onConsoleMessage != null
               ? (controller, consoleMessage) =>
                     onConsoleMessage.call(controller, consoleMessage)
               : null,
           onProgressChanged: onProgressChanged != null
               ? (controller, progress) =>
                     onProgressChanged.call(controller, progress)
               : null,
           shouldOverrideUrlLoading: shouldOverrideUrlLoading != null
               ? (controller, navigationAction) =>
                     shouldOverrideUrlLoading(controller, navigationAction)
               : null,
           onLoadResource: onLoadResource != null
               ? (controller, resource) =>
                     onLoadResource.call(controller, resource)
               : null,
           onScrollChanged: onScrollChanged != null
               ? (controller, x, y) => onScrollChanged.call(controller, x, y)
               : null,
           onDownloadStart: onDownloadStart != null
               ? (controller, url) => onDownloadStart.call(controller, url)
               : null,
           onDownloadStartRequest: onDownloadStartRequest != null
               ? (controller, downloadStartRequest) => onDownloadStartRequest
                     .call(controller, downloadStartRequest)
               : null,
           onDownloadStarting: onDownloadStarting != null
               ? (controller, downloadStartRequest) =>
                     onDownloadStarting.call(controller, downloadStartRequest)
               : null,
           onLoadResourceCustomScheme: onLoadResourceCustomScheme != null
               ? (controller, url) =>
                     onLoadResourceCustomScheme.call(controller, url)
               : null,
           onLoadResourceWithCustomScheme:
               onLoadResourceWithCustomScheme != null
               ? (controller, request) =>
                     onLoadResourceWithCustomScheme.call(controller, request)
               : null,
           onCreateWindow: onCreateWindow != null
               ? (controller, createWindowAction) =>
                     onCreateWindow.call(controller, createWindowAction)
               : null,
           onCloseWindow: onCloseWindow != null
               ? (controller) => onCloseWindow.call(controller)
               : null,
           onJsAlert: onJsAlert != null
               ? (controller, jsAlertRequest) =>
                     onJsAlert.call(controller, jsAlertRequest)
               : null,
           onJsConfirm: onJsConfirm != null
               ? (controller, jsConfirmRequest) =>
                     onJsConfirm.call(controller, jsConfirmRequest)
               : null,
           onJsPrompt: onJsPrompt != null
               ? (controller, jsPromptRequest) =>
                     onJsPrompt.call(controller, jsPromptRequest)
               : null,
           onReceivedHttpAuthRequest: onReceivedHttpAuthRequest != null
               ? (controller, challenge) =>
                     onReceivedHttpAuthRequest.call(controller, challenge)
               : null,
           onReceivedServerTrustAuthRequest:
               onReceivedServerTrustAuthRequest != null
               ? (controller, challenge) => onReceivedServerTrustAuthRequest
                     .call(controller, challenge)
               : null,
           onReceivedClientCertRequest: onReceivedClientCertRequest != null
               ? (controller, challenge) =>
                     onReceivedClientCertRequest.call(controller, challenge)
               : null,
           onFindResultReceived: onFindResultReceived != null
               ? (
                   controller,
                   activeMatchOrdinal,
                   numberOfMatches,
                   isDoneCounting,
                 ) => onFindResultReceived.call(
                   controller,
                   activeMatchOrdinal,
                   numberOfMatches,
                   isDoneCounting,
                 )
               : null,
           shouldInterceptAjaxRequest: shouldInterceptAjaxRequest != null
               ? (controller, ajaxRequest) =>
                     shouldInterceptAjaxRequest.call(controller, ajaxRequest)
               : null,
           onAjaxReadyStateChange: onAjaxReadyStateChange != null
               ? (controller, ajaxRequest) =>
                     onAjaxReadyStateChange.call(controller, ajaxRequest)
               : null,
           onAjaxProgress: onAjaxProgress != null
               ? (controller, ajaxRequest) =>
                     onAjaxProgress.call(controller, ajaxRequest)
               : null,
           shouldInterceptFetchRequest: shouldInterceptFetchRequest != null
               ? (controller, fetchRequest) =>
                     shouldInterceptFetchRequest.call(controller, fetchRequest)
               : null,
           onUpdateVisitedHistory: onUpdateVisitedHistory != null
               ? (controller, url, isReload) =>
                     onUpdateVisitedHistory.call(controller, url, isReload)
               : null,
           onPrint: onPrint != null
               ? (controller, url) => onPrint.call(controller, url)
               : null,
           onPrintRequest: onPrintRequest != null
               ? (controller, url, printJobController) =>
                     onPrintRequest.call(controller, url, printJobController)
               : null,
           onLongPressHitTestResult: onLongPressHitTestResult != null
               ? (controller, hitTestResult) =>
                     onLongPressHitTestResult.call(controller, hitTestResult)
               : null,
           onEnterFullscreen: onEnterFullscreen != null
               ? (controller) => onEnterFullscreen.call(controller)
               : null,
           onExitFullscreen: onExitFullscreen != null
               ? (controller) => onExitFullscreen.call(controller)
               : null,
           onContentLoading: onContentLoading != null
               ? (controller, url) => onContentLoading.call(controller, url)
               : null,
           onDOMContentLoaded: onDOMContentLoaded != null
               ? (controller, url) => onDOMContentLoaded.call(controller, url)
               : null,
           onPageCommitVisible: onPageCommitVisible != null
               ? (controller, url) => onPageCommitVisible.call(controller, url)
               : null,
           onTitleChanged: onTitleChanged != null
               ? (controller, title) => onTitleChanged.call(controller, title)
               : null,
           onWindowFocus: onWindowFocus != null
               ? (controller) => onWindowFocus.call(controller)
               : null,
           onWindowBlur: onWindowBlur != null
               ? (controller) => onWindowBlur.call(controller)
               : null,
           onOverScrolled: onOverScrolled != null
               ? (controller, x, y, clampedX, clampedY) =>
                     onOverScrolled.call(controller, x, y, clampedX, clampedY)
               : null,
           onZoomScaleChanged: onZoomScaleChanged != null
               ? (controller, oldScale, newScale) =>
                     onZoomScaleChanged.call(controller, oldScale, newScale)
               : null,
           androidOnSafeBrowsingHit: androidOnSafeBrowsingHit != null
               ? (controller, url, threatType) =>
                     androidOnSafeBrowsingHit.call(controller, url, threatType)
               : null,
           onSafeBrowsingHit: onSafeBrowsingHit != null
               ? (controller, url, threatType) =>
                     onSafeBrowsingHit.call(controller, url, threatType)
               : null,
           androidOnPermissionRequest: androidOnPermissionRequest != null
               ? (controller, origin, resources) => androidOnPermissionRequest
                     .call(controller, origin, resources)
               : null,
           onPermissionRequest: onPermissionRequest != null
               ? (controller, permissionRequest) =>
                     onPermissionRequest.call(controller, permissionRequest)
               : null,
           androidOnGeolocationPermissionsShowPrompt:
               androidOnGeolocationPermissionsShowPrompt != null
               ? (controller, origin) =>
                     androidOnGeolocationPermissionsShowPrompt.call(
                       controller,
                       origin,
                     )
               : null,
           onGeolocationPermissionsShowPrompt:
               onGeolocationPermissionsShowPrompt != null
               ? (controller, origin) =>
                     onGeolocationPermissionsShowPrompt.call(controller, origin)
               : null,
           androidOnGeolocationPermissionsHidePrompt:
               androidOnGeolocationPermissionsHidePrompt != null
               ? (controller) =>
                     androidOnGeolocationPermissionsHidePrompt.call(controller)
               : null,
           onGeolocationPermissionsHidePrompt:
               onGeolocationPermissionsHidePrompt != null
               ? (controller) =>
                     onGeolocationPermissionsHidePrompt.call(controller)
               : null,
           androidShouldInterceptRequest: androidShouldInterceptRequest != null
               ? (controller, request) =>
                     androidShouldInterceptRequest.call(controller, request)
               : null,
           shouldInterceptRequest: shouldInterceptRequest != null
               ? (controller, request) =>
                     shouldInterceptRequest.call(controller, request)
               : null,
           androidOnRenderProcessGone: androidOnRenderProcessGone != null
               ? (controller, detail) =>
                     androidOnRenderProcessGone.call(controller, detail)
               : null,
           onRenderProcessGone: onRenderProcessGone != null
               ? (controller, detail) =>
                     onRenderProcessGone.call(controller, detail)
               : null,
           androidOnRenderProcessResponsive:
               androidOnRenderProcessResponsive != null
               ? (controller, url) =>
                     androidOnRenderProcessResponsive.call(controller, url)
               : null,
           onRenderProcessResponsive: onRenderProcessResponsive != null
               ? (controller, url) =>
                     onRenderProcessResponsive.call(controller, url)
               : null,
           androidOnRenderProcessUnresponsive:
               androidOnRenderProcessUnresponsive != null
               ? (controller, url) =>
                     androidOnRenderProcessUnresponsive.call(controller, url)
               : null,
           onRenderProcessUnresponsive: onRenderProcessUnresponsive != null
               ? (controller, url) =>
                     onRenderProcessUnresponsive.call(controller, url)
               : null,
           androidOnFormResubmission: androidOnFormResubmission != null
               ? (controller, url) =>
                     androidOnFormResubmission.call(controller, url)
               : null,
           onFormResubmission: onFormResubmission != null
               ? (controller, url) => onFormResubmission.call(controller, url)
               : null,
           androidOnScaleChanged: androidOnScaleChanged != null
               ? (controller, oldScale, newScale) =>
                     androidOnScaleChanged.call(controller, oldScale, newScale)
               : null,
           androidOnReceivedIcon: androidOnReceivedIcon != null
               ? (controller, icon) =>
                     androidOnReceivedIcon.call(controller, icon)
               : null,
           onReceivedIcon: onReceivedIcon != null
               ? (controller, icon) => onReceivedIcon.call(controller, icon)
               : null,
           onFaviconChanged: onFaviconChanged != null
               ? (controller, request) =>
                     onFaviconChanged.call(controller, request)
               : null,
           androidOnReceivedTouchIconUrl: androidOnReceivedTouchIconUrl != null
               ? (controller, url, precomposed) => androidOnReceivedTouchIconUrl
                     .call(controller, url, precomposed)
               : null,
           onReceivedTouchIconUrl: onReceivedTouchIconUrl != null
               ? (controller, url, precomposed) =>
                     onReceivedTouchIconUrl.call(controller, url, precomposed)
               : null,
           androidOnJsBeforeUnload: androidOnJsBeforeUnload != null
               ? (controller, jsBeforeUnloadRequest) => androidOnJsBeforeUnload
                     .call(controller, jsBeforeUnloadRequest)
               : null,
           onJsBeforeUnload: onJsBeforeUnload != null
               ? (controller, jsBeforeUnloadRequest) =>
                     onJsBeforeUnload.call(controller, jsBeforeUnloadRequest)
               : null,
           androidOnReceivedLoginRequest: androidOnReceivedLoginRequest != null
               ? (controller, loginRequest) => androidOnReceivedLoginRequest
                     .call(controller, loginRequest)
               : null,
           onReceivedLoginRequest: onReceivedLoginRequest != null
               ? (controller, loginRequest) =>
                     onReceivedLoginRequest.call(controller, loginRequest)
               : null,
           onPermissionRequestCanceled: onPermissionRequestCanceled != null
               ? (controller, permissionRequest) => onPermissionRequestCanceled
                     .call(controller, permissionRequest)
               : null,
           onRequestFocus: onRequestFocus != null
               ? (controller) => onRequestFocus.call(controller)
               : null,
           iosOnWebContentProcessDidTerminate:
               iosOnWebContentProcessDidTerminate != null
               ? (controller) =>
                     iosOnWebContentProcessDidTerminate.call(controller)
               : null,
           onWebContentProcessDidTerminate:
               onWebContentProcessDidTerminate != null
               ? (controller) =>
                     onWebContentProcessDidTerminate.call(controller)
               : null,
           iosOnDidReceiveServerRedirectForProvisionalNavigation:
               iosOnDidReceiveServerRedirectForProvisionalNavigation != null
               ? (controller) =>
                     iosOnDidReceiveServerRedirectForProvisionalNavigation.call(
                       controller,
                     )
               : null,
           onDidReceiveServerRedirectForProvisionalNavigation:
               onDidReceiveServerRedirectForProvisionalNavigation != null
               ? (controller) =>
                     onDidReceiveServerRedirectForProvisionalNavigation.call(
                       controller,
                     )
               : null,
           iosOnNavigationResponse: iosOnNavigationResponse != null
               ? (controller, navigationResponse) => iosOnNavigationResponse
                     .call(controller, navigationResponse)
               : null,
           onNavigationResponse: onNavigationResponse != null
               ? (controller, navigationResponse) =>
                     onNavigationResponse.call(controller, navigationResponse)
               : null,
           iosShouldAllowDeprecatedTLS: iosShouldAllowDeprecatedTLS != null
               ? (controller, challenge) =>
                     iosShouldAllowDeprecatedTLS.call(controller, challenge)
               : null,
           shouldAllowDeprecatedTLS: shouldAllowDeprecatedTLS != null
               ? (controller, challenge) =>
                     shouldAllowDeprecatedTLS.call(controller, challenge)
               : null,
           onCameraCaptureStateChanged: onCameraCaptureStateChanged != null
               ? (controller, oldState, newState) => onCameraCaptureStateChanged
                     .call(controller, oldState, newState)
               : null,
           onMicrophoneCaptureStateChanged:
               onMicrophoneCaptureStateChanged != null
               ? (controller, oldState, newState) =>
                     onMicrophoneCaptureStateChanged.call(
                       controller,
                       oldState,
                       newState,
                     )
               : null,
           onContentSizeChanged: onContentSizeChanged != null
               ? (controller, oldContentSize, newContentSize) =>
                     onContentSizeChanged.call(
                       controller,
                       oldContentSize,
                       newContentSize,
                     )
               : null,
           onProcessFailed: onProcessFailed != null
               ? (controller, detail) =>
                     onProcessFailed.call(controller, detail)
               : null,
           onNotificationReceived: onNotificationReceived != null
               ? (controller, request) =>
                     onNotificationReceived.call(controller, request)
               : null,
           onSaveAsUIShowing: onSaveAsUIShowing != null
               ? (controller, request) =>
                     onSaveAsUIShowing.call(controller, request)
               : null,
           onSaveFileSecurityCheckStarting:
               onSaveFileSecurityCheckStarting != null
               ? (controller, request) =>
                     onSaveFileSecurityCheckStarting.call(controller, request)
               : null,
           onScreenCaptureStarting: onScreenCaptureStarting != null
               ? (controller, request) =>
                     onScreenCaptureStarting.call(controller, request)
               : null,
           onAcceleratorKeyPressed: onAcceleratorKeyPressed != null
               ? (controller, detail) =>
                     onAcceleratorKeyPressed.call(controller, detail)
               : null,
           onShowFileChooser: onShowFileChooser != null
               ? (controller, request) =>
                     onShowFileChooser.call(controller, request)
               : null,
           onLaunchingExternalUriScheme: onLaunchingExternalUriScheme != null
               ? (controller, request) =>
                     onLaunchingExternalUriScheme.call(controller, request)
               : null,
           gestureRecognizers: gestureRecognizers,
           headlessWebView: headlessWebView?.platform,
           preventGestureDelay: preventGestureDelay,
         ),
       );

  @override
  _AqutterWebViewState createState() => _AqutterWebViewState();

  ///{@macro aqutter_core.AqutterPlatformWebViewWidgetCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformWebViewWidget.static().isClassSupported(platform: platform);

  ///{@macro aqutter_core.AqutterPlatformWebViewWidgetCreationParams.isPropertySupported}
  static bool isPropertySupported(
    dynamic property, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebViewWidget.static().isPropertySupported(
    property,
    platform: platform,
  );
}

class _AqutterWebViewState extends State<AqutterWebView> {
  /// 這個 State 存活期間用過的所有平台實作。
  ///
  /// 父層重建時會傳入新的 [AqutterWebView]（也就是新的平台物件），但原生 view 與 controller 是掛在**第一個**
  /// 平台物件上、不會重建。只 dispose 目前的 `widget.platform` 會讓第一個物件的 controller、
  /// method channel handler 與（Android 的）鍵盤觀察者永遠不被釋放。
  final Set<AqutterPlatformWebViewWidget> _platforms = {};

  @override
  Widget build(BuildContext context) {
    _platforms.add(widget.platform);
    return widget.platform.build(context);
  }

  @override
  void dispose() {
    _platforms.add(widget.platform);
    for (final platform in _platforms) {
      platform.dispose();
    }
    _platforms.clear();
    super.dispose();
  }
}
