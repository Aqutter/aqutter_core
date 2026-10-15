import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../webview_platform.dart';
import '../types/disposable.dart';
import '../webview_environment/platform_webview_environment.dart';
import 'platform_webview_controller.dart';
import 'platform_webview.dart';

part 'platform_headless_webview.g.dart';

///{@template aqutter_core.AqutterPlatformHeadlessWebViewCreationParams}
///Object specifying creation parameters for creating a [AqutterPlatformWebViewWidget].
///
///Platform specific implementations can add additional fields by extending
///this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformHeadlessWebViewCreationParams.supported_platforms}
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
class AqutterPlatformHeadlessWebViewCreationParams
    extends AqutterPlatformWebViewCreationParams {
  ///{@macro aqutter_core.AqutterPlatformHeadlessWebViewCreationParams}
  ///
  ///{@macro aqutter_core.AqutterPlatformHeadlessWebViewCreationParams.supported_platforms}
  const AqutterPlatformHeadlessWebViewCreationParams({
    this.initialSize = const Size(-1, -1),
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
    @Deprecated('Use onFaviconChanged instead') super.onReceivedIcon,
    super.onFaviconChanged,
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
    super.onProcessFailed,
    super.onNotificationReceived,
    super.onSaveAsUIShowing,
    super.onSaveFileSecurityCheckStarting,
    super.onScreenCaptureStarting,
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

  ///{@template aqutter_core.AqutterPlatformHeadlessWebViewCreationParams.initialSize}
  ///The WebView initial size in pixels.
  ///
  ///Set `-1` to match the corresponding width or height of the current device screen size.
  ///`Size(-1, -1)` will match both width and height of the current device screen size.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformHeadlessWebViewCreationParams.initialSize.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        note:
            '`Size` width and height values will be converted to `int` values because they cannot have `double` values.',
      ),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(requiresSameOrigin: false),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  final Size initialSize;

  ///{@template aqutter_core.AqutterPlatformHeadlessWebViewCreationParams.webViewEnvironment}
  ///Used to create the [AqutterPlatformHeadlessWebView] using the specified environment.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformHeadlessWebViewCreationParams.webViewEnvironment.supported_platforms}
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

  ///{@template aqutter_core.AqutterPlatformHeadlessWebViewCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  @override
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformHeadlessWebViewCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformHeadlessWebViewCreationParams.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///The property should be one of the [AqutterPlatformWebViewCreationParamsProperty] or [AqutterPlatformHeadlessWebViewCreationParamsProperty] values.
  ///{@endtemplate}
  @override
  bool isPropertySupported(dynamic property, {TargetPlatform? platform}) =>
      property is AqutterPlatformWebViewCreationParamsProperty
      ? super.isPropertySupported(property, platform: platform)
      : _AqutterPlatformHeadlessWebViewCreationParamsPropertySupported.isPropertySupported(
          property,
          platform: platform,
        );
}

///{@template aqutter_core.AqutterPlatformHeadlessWebView}
///Class that represents a WebView in headless mode.
///It can be used to run a WebView in background without attaching an `AqutterWebView` to the widget tree.
///
///**NOTE**: Remember to dispose it when you don't need it anymore.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformHeadlessWebView.supported_platforms}
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
abstract class AqutterPlatformHeadlessWebView extends PlatformInterface
    implements AqutterDisposable {
  /// Creates a new [AqutterPlatformHeadlessWebView]
  factory AqutterPlatformHeadlessWebView(
    AqutterPlatformHeadlessWebViewCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformHeadlessWebView webViewControllerDelegate =
        AqutterWebViewPlatform.instance!.createPlatformHeadlessWebView(
          params,
        );
    PlatformInterface.verify(webViewControllerDelegate, _token);
    return webViewControllerDelegate;
  }

  /// Creates a new [AqutterPlatformHeadlessWebView] to access static methods.
  factory AqutterPlatformHeadlessWebView.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformHeadlessWebView headlessWebViewStatic =
        AqutterWebViewPlatform.instance!
            .createPlatformHeadlessWebViewStatic();
    PlatformInterface.verify(headlessWebViewStatic, _token);
    return headlessWebViewStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformHeadlessWebView].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformHeadlessWebView.implementation(this.params)
    : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformHeadlessWebView].
  final AqutterPlatformHeadlessWebViewCreationParams params;

  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.id}
  ///View ID.
  ///{@endtemplate}
  String get id =>
      throw UnimplementedError('id is not implemented on the current platform');

  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.webViewController}
  ///WebView Controller that can be used to access the [AqutterWebViewController] API.
  ///{@endtemplate}
  AqutterPlatformWebViewController? get webViewController =>
      throw UnimplementedError(
        'webViewController is not implemented on the current platform',
      );

  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.run}
  ///Runs the headless WebView.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformHeadlessWebView.run.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(
        requiresSameOrigin: false,
        note: 'It will append a new `iframe` to the body.',
      ),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> run() {
    throw UnimplementedError('run is not implemented on the current platform');
  }

  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.isRunning}
  ///Indicates if the headless WebView is running or not.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformHeadlessWebView.isRunning.supported_platforms}
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
  bool isRunning() {
    throw UnimplementedError(
      'isRunning is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.setSize}
  ///Set the size of the WebView in pixels.
  ///
  ///Set `-1` to match the corresponding width or height of the current device screen size.
  ///`Size(-1, -1)` will match both width and height of the current device screen size.
  ///
  ///Note that if the [AqutterPlatformHeadlessWebView] is not running, this method won't have effect.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformHeadlessWebView.setSize.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        note:
            '`Size` width and height values will be converted to `int` values because they cannot have `double` values.',
      ),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(requiresSameOrigin: false),
      LinuxPlatform(),
    ],
  )
  Future<void> setSize(Size size) {
    throw UnimplementedError(
      'setSize is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.getSize}
  ///Gets the current size in pixels of the WebView.
  ///
  ///Note that if the [AqutterPlatformHeadlessWebView] is not running, this method will return `null`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformHeadlessWebView.getSize.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(requiresSameOrigin: false),
      LinuxPlatform(),
    ],
  )
  Future<Size?> getSize() {
    throw UnimplementedError(
      'getSize is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.dispose}
  ///Disposes the headless WebView.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformHeadlessWebView.dispose.supported_platforms}
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
  Future<void> dispose() {
    throw UnimplementedError(
      'dispose is not implemented on the current platform',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformHeadlessWebViewCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);

  ///{@macro aqutter_core.AqutterPlatformHeadlessWebViewCreationParams.isPropertySupported}
  bool isPropertySupported(dynamic property, {TargetPlatform? platform}) =>
      params.isPropertySupported(property, platform: platform);

  ///{@template aqutter_core.AqutterPlatformHeadlessWebView.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformHeadlessWebViewMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformHeadlessWebViewMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}
