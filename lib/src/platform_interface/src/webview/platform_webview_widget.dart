import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../webview_platform.dart';
import '../types/disposable.dart';
import '../webview_environment/platform_webview_environment.dart';
import 'webview_keep_alive.dart';
import 'platform_headless_webview.dart';
import 'platform_webview_controller.dart';
import 'platform_webview.dart';

part 'platform_webview_widget.g.dart';

///{@template aqutter_core.AqutterPlatformWebViewWidgetCreationParams}
///Object specifying creation parameters for creating a [AqutterPlatformWebViewWidget].
///
///Platform specific implementations can add additional fields by extending
///this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebViewWidgetCreationParams.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WebPlatform(requiresSameOrigin: false),
    WindowsPlatform(),
    LinuxPlatform(),
  ],
)
class AqutterPlatformWebViewWidgetCreationParams
    extends AqutterPlatformWebViewCreationParams {
  ///{@macro aqutter_core.AqutterPlatformWebViewWidgetCreationParams}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.supported_platforms}
  AqutterPlatformWebViewWidgetCreationParams({
    this.key,
    this.layoutDirection,
    this.gestureRecognizers,
    this.headlessWebView,
    this.keepAlive,
    this.preventGestureDelay,
    this.webViewEnvironment,
    super.controllerFromPlatform,
    super.windowId,
    super.onWebViewCreated,
    super.onLoadStart,
    super.onLoadStop,
    super.onContentLoading,
    super.onDOMContentLoaded,
    @Deprecated('Use onReceivedError instead') super.onLoadError,
    super.onReceivedError,
    @Deprecated("Use onReceivedHttpError instead") super.onLoadHttpError,
    super.onReceivedHttpError,
    super.onProgressChanged,
    super.onConsoleMessage,
    super.shouldOverrideUrlLoading,
    super.onLaunchingExternalUriScheme,
    super.onLoadResource,
    super.onFaviconChanged,
    super.onScrollChanged,
    @Deprecated('Use onDownloadStarting instead') super.onDownloadStart,
    @Deprecated('Use onDownloadStarting instead') super.onDownloadStartRequest,
    super.onDownloadStarting,
    @Deprecated('Use onLoadResourceWithCustomScheme instead')
    super.onLoadResourceCustomScheme,
    super.onLoadResourceWithCustomScheme,
    super.onCreateWindow,
    super.onCloseWindow,
    super.onJsAlert,
    super.onJsConfirm,
    super.onJsPrompt,
    super.onReceivedHttpAuthRequest,
    super.onReceivedServerTrustAuthRequest,
    super.onReceivedClientCertRequest,
    @Deprecated('Use AqutterFindInteractionController.onFindResultReceived instead')
    super.onFindResultReceived,
    super.shouldInterceptAjaxRequest,
    super.onAjaxReadyStateChange,
    super.onAjaxProgress,
    super.shouldInterceptFetchRequest,
    super.onUpdateVisitedHistory,
    @Deprecated("Use onPrintRequest instead") super.onPrint,
    super.onPrintRequest,
    super.onLongPressHitTestResult,
    super.onEnterFullscreen,
    super.onExitFullscreen,
    super.onPageCommitVisible,
    super.onTitleChanged,
    super.onWindowFocus,
    super.onWindowBlur,
    super.onOverScrolled,
    super.onZoomScaleChanged,
    @Deprecated('Use onSafeBrowsingHit instead') super.androidOnSafeBrowsingHit,
    super.onSafeBrowsingHit,
    @Deprecated('Use onPermissionRequest instead')
    super.androidOnPermissionRequest,
    super.onPermissionRequest,
    @Deprecated('Use onGeolocationPermissionsShowPrompt instead')
    super.androidOnGeolocationPermissionsShowPrompt,
    super.onGeolocationPermissionsShowPrompt,
    @Deprecated('Use onGeolocationPermissionsHidePrompt instead')
    super.androidOnGeolocationPermissionsHidePrompt,
    super.onGeolocationPermissionsHidePrompt,
    @Deprecated('Use shouldInterceptRequest instead')
    super.androidShouldInterceptRequest,
    super.shouldInterceptRequest,
    @Deprecated('Use onRenderProcessGone instead')
    super.androidOnRenderProcessGone,
    super.onRenderProcessGone,
    @Deprecated('Use onRenderProcessResponsive instead')
    super.androidOnRenderProcessResponsive,
    super.onRenderProcessResponsive,
    @Deprecated('Use onRenderProcessUnresponsive instead')
    super.androidOnRenderProcessUnresponsive,
    super.onRenderProcessUnresponsive,
    @Deprecated('Use onFormResubmission instead')
    super.androidOnFormResubmission,
    super.onFormResubmission,
    @Deprecated('Use onZoomScaleChanged instead') super.androidOnScaleChanged,
    @Deprecated('Use onReceivedIcon instead') super.androidOnReceivedIcon,
    super.onReceivedIcon,
    @Deprecated('Use onReceivedTouchIconUrl instead')
    super.androidOnReceivedTouchIconUrl,
    super.onReceivedTouchIconUrl,
    @Deprecated('Use onJsBeforeUnload instead') super.androidOnJsBeforeUnload,
    super.onJsBeforeUnload,
    @Deprecated('Use onReceivedLoginRequest instead')
    super.androidOnReceivedLoginRequest,
    super.onReceivedLoginRequest,
    super.onPermissionRequestCanceled,
    super.onRequestFocus,
    @Deprecated('Use onWebContentProcessDidTerminate instead')
    super.iosOnWebContentProcessDidTerminate,
    super.onWebContentProcessDidTerminate,
    @Deprecated(
      'Use onDidReceiveServerRedirectForProvisionalNavigation instead',
    )
    super.iosOnDidReceiveServerRedirectForProvisionalNavigation,
    super.onDidReceiveServerRedirectForProvisionalNavigation,
    @Deprecated('Use onNavigationResponse instead')
    super.iosOnNavigationResponse,
    super.onNavigationResponse,
    @Deprecated('Use shouldAllowDeprecatedTLS instead')
    super.iosShouldAllowDeprecatedTLS,
    super.shouldAllowDeprecatedTLS,
    super.onCameraCaptureStateChanged,
    super.onMicrophoneCaptureStateChanged,
    super.onContentSizeChanged,
    super.onNotificationReceived,
    super.onSaveAsUIShowing,
    super.onSaveFileSecurityCheckStarting,
    super.onScreenCaptureStarting,
    super.onProcessFailed,
    super.onAcceleratorKeyPressed,
    super.onShowFileChooser,
    super.initialUrlRequest,
    super.initialFile,
    super.initialData,
    @Deprecated('Use initialSettings instead') super.initialOptions,
    super.initialSettings,
    super.contextMenu,
    super.initialUserScripts,
    super.pullToRefreshController,
    super.findInteractionController,
  });

  /// Controls how one widget replaces another widget in the tree.
  ///
  /// See also:
  ///
  ///  * The discussions at [Key] and [GlobalKey].
  final Key? key;

  /// The layout direction to use for the embedded WebView.
  final TextDirection? layoutDirection;

  /// The `gestureRecognizers` specifies which gestures should be consumed by the
  /// web view.
  ///
  /// It is possible for other gesture recognizers to be competing with the web
  /// view on pointer events, e.g. if the web view is inside a [ListView] the
  /// [ListView] will want to handle vertical drags. The web view will claim
  /// gestures that are recognized by any of the recognizers on this list.
  ///
  /// When `gestureRecognizers` is empty (default), the web view will only handle
  /// pointer events for gestures that were not claimed by any other gesture
  /// recognizer.
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  ///{@template aqutter_core.AqutterPlatformWebViewWidgetCreationParams.headlessWebView}
  ///The [AqutterPlatformHeadlessWebView] to use to initialize this widget.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewWidgetCreationParams.keepAlive.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(requiresSameOrigin: false),
      WindowsPlatform(),
    ],
  )
  final AqutterPlatformHeadlessWebView? headlessWebView;

  ///{@template aqutter_core.AqutterPlatformWebViewWidgetCreationParams.keepAlive}
  ///Used to keep alive this WebView.
  ///Remember to dispose the [AqutterWebViewKeepAlive] instance
  ///using [AqutterWebViewController.disposeKeepAlive].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewWidgetCreationParams.keepAlive.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
    ],
  )
  final AqutterWebViewKeepAlive? keepAlive;

  ///{@template aqutter_core.AqutterPlatformWebViewWidgetCreationParams.webViewEnvironment}
  ///Used to prevent gesture delay on iOS caused by Flutter's gestures handling
  ///between native/platform views.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewWidgetCreationParams.webViewEnvironment.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform()])
  final bool? preventGestureDelay;

  ///{@template aqutter_core.AqutterPlatformWebViewWidgetCreationParams.webViewEnvironment}
  ///Used to create the [AqutterPlatformWebViewWidget] using the specified environment.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewWidgetCreationParams.webViewEnvironment.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(),
      LinuxPlatform(
        apiName: 'WebKitWebContext',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.WebContext.html',
      ),
    ],
  )
  final AqutterPlatformWebViewEnvironment? webViewEnvironment;

  ///{@template aqutter_core.AqutterPlatformWebViewWidgetCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  @override
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebViewWidgetCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformWebViewWidgetCreationParams.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///The property should be one of the [AqutterPlatformWebViewCreationParamsProperty] or [AqutterPlatformWebViewWidgetCreationParamsProperty] values.
  ///{@endtemplate}
  @override
  bool isPropertySupported(dynamic property, {TargetPlatform? platform}) =>
      property is AqutterPlatformWebViewCreationParamsProperty
      ? super.isPropertySupported(property, platform: platform)
      : _AqutterPlatformWebViewWidgetCreationParamsPropertySupported.isPropertySupported(
          property,
          platform: platform,
        );
}

///Interface for a platform implementation of a web view widget.
///
///{@template aqutter_core.AqutterPlatformWebViewWidget}
///Flutter Widget for adding an **inline native WebView** integrated in the flutter widget tree.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebViewWidgetCreationParams.supported_platforms}
abstract class AqutterPlatformWebViewWidget extends PlatformInterface
    implements AqutterDisposable {
  /// Creates a new [AqutterPlatformWebViewWidget]
  factory AqutterPlatformWebViewWidget(
    AqutterPlatformWebViewWidgetCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebViewWidget webViewWidgetDelegate =
        AqutterWebViewPlatform.instance!.createPlatformWebViewWidget(params);
    PlatformInterface.verify(webViewWidgetDelegate, _token);
    return webViewWidgetDelegate;
  }

  /// Creates a new [AqutterPlatformWebViewWidget] to access static methods.
  factory AqutterPlatformWebViewWidget.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebViewWidget webViewWidgetStatic =
        AqutterWebViewPlatform.instance!.createPlatformWebViewWidgetStatic();
    PlatformInterface.verify(webViewWidgetStatic, _token);
    return webViewWidgetStatic;
  }

  /// Used by the platform implementation to create a new
  /// [AqutterPlatformWebViewWidget].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformWebViewWidget.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformWebViewWidget].
  final AqutterPlatformWebViewWidgetCreationParams params;

  /// Builds a new WebView.
  ///
  /// Returns a Widget tree that embeds the created web view.
  Widget build(BuildContext context);

  /// Gets the `AqutterWebViewController` instance controller
  T controllerFromPlatform<T>(AqutterPlatformWebViewController controller);

  ///{@macro aqutter_core.AqutterPlatformWebViewWidgetCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);

  ///{@macro aqutter_core.AqutterPlatformWebViewWidgetCreationParams.isPropertySupported}
  bool isPropertySupported(dynamic property, {TargetPlatform? platform}) =>
      params.isPropertySupported(property, platform: platform);

  @override
  void dispose();
}
