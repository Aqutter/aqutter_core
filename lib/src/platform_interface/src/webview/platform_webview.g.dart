// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_webview.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformWebViewCreationParamsClassSupported
    on AqutterPlatformWebViewCreationParams {
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return kIsWeb && platform == null
        ? true
        : ((kIsWeb && platform != null) || !kIsWeb) &&
              [
                TargetPlatform.android,
                TargetPlatform.iOS,
                TargetPlatform.macOS,
                TargetPlatform.windows,
                TargetPlatform.linux,
              ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformWebViewCreationParams]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformWebViewCreationParamsProperty {
  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidOnFormResubmission] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidOnFormResubmission.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onFormResubmission instead')
  androidOnFormResubmission,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidOnGeolocationPermissionsHidePrompt] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidOnGeolocationPermissionsHidePrompt.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onGeolocationPermissionsHidePrompt instead')
  androidOnGeolocationPermissionsHidePrompt,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidOnGeolocationPermissionsShowPrompt] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidOnGeolocationPermissionsShowPrompt.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [origin]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onGeolocationPermissionsShowPrompt instead')
  androidOnGeolocationPermissionsShowPrompt,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidOnJsBeforeUnload] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidOnJsBeforeUnload.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [jsBeforeUnloadRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onJsBeforeUnload instead')
  androidOnJsBeforeUnload,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidOnPermissionRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidOnPermissionRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [origin]: all platforms
  ///- [resources]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onPermissionRequest instead')
  androidOnPermissionRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidOnReceivedIcon] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidOnReceivedIcon.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [icon]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onReceivedIcon instead')
  androidOnReceivedIcon,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidOnReceivedLoginRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidOnReceivedLoginRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [loginRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onReceivedLoginRequest instead')
  androidOnReceivedLoginRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidOnReceivedTouchIconUrl] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidOnReceivedTouchIconUrl.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [precomposed]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onReceivedTouchIconUrl instead')
  androidOnReceivedTouchIconUrl,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidOnRenderProcessGone] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidOnRenderProcessGone.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [detail]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onRenderProcessGone instead')
  androidOnRenderProcessGone,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidOnRenderProcessResponsive] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidOnRenderProcessResponsive.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onRenderProcessResponsive instead')
  androidOnRenderProcessResponsive,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidOnRenderProcessUnresponsive] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidOnRenderProcessUnresponsive.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onRenderProcessUnresponsive instead')
  androidOnRenderProcessUnresponsive,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidOnSafeBrowsingHit] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidOnSafeBrowsingHit.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [threatType]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onSafeBrowsingHit instead')
  androidOnSafeBrowsingHit,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidOnScaleChanged] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidOnScaleChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [oldScale]: all platforms
  ///- [newScale]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onZoomScaleChanged instead')
  androidOnScaleChanged,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.androidShouldInterceptRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.androidShouldInterceptRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use shouldInterceptRequest instead')
  androidShouldInterceptRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.contextMenu] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.contextMenu.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  contextMenu,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.findInteractionController] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.findInteractionController.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit ([Official API - WebKitFindController](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.FindController.html))
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  findInteractionController,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.initialData] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.initialData.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  initialData,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.initialFile] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.initialFile.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  initialFile,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.initialOptions] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.initialOptions.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use initialSettings instead')
  initialOptions,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.initialSettings] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.initialSettings.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  initialSettings,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.initialUrlRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.initialUrlRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - When loading an URL Request using "POST" method, headers are ignored.
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\>
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  initialUrlRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.initialUserScripts] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.initialUserScripts.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView:
  ///    - This property will be ignored if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to iOS window WebViews. This is a limitation of the native WebKit APIs.
  ///- macOS WKWebView:
  ///    - This property will be ignored if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to iOS window WebViews. This is a limitation of the native WebKit APIs.
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit ([Official API - WebKitUserContentManager](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.UserContentManager.html))
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  initialUserScripts,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.iosOnDidReceiveServerRedirectForProvisionalNavigation] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.iosOnDidReceiveServerRedirectForProvisionalNavigation.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onDidReceiveServerRedirectForProvisionalNavigation instead')
  iosOnDidReceiveServerRedirectForProvisionalNavigation,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.iosOnNavigationResponse] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.iosOnNavigationResponse.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [navigationResponse]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onNavigationResponse instead')
  iosOnNavigationResponse,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.iosOnWebContentProcessDidTerminate] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.iosOnWebContentProcessDidTerminate.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onWebContentProcessDidTerminate instead')
  iosOnWebContentProcessDidTerminate,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.iosShouldAllowDeprecatedTLS] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.iosShouldAllowDeprecatedTLS.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [challenge]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use shouldAllowDeprecatedTLS instead')
  iosShouldAllowDeprecatedTLS,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onAcceleratorKeyPressed] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onAcceleratorKeyPressed.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2Controller.add_AcceleratorKeyPressed](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller?view=webview2-1.0.2849.39#add_acceleratorkeypressed))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [detail]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onAcceleratorKeyPressed,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onAjaxProgress] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onAjaxProgress.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - In order to be able to listen this event, check the [AqutterWebViewSettings.useShouldInterceptAjaxRequest] and [AqutterWebViewSettings.useOnAjaxProgress] settings documentation. Also, on Android that doesn't support the [AqutterWebViewFeature.DOCUMENT_START_SCRIPT], unlike iOS that has [WKUserScript](https://developer.apple.com/documentation/webkit/wkuserscript) that can inject javascript code right after the document element is created but before any other content is loaded, in Android the javascript code used to intercept ajax requests is loaded as soon as possible so it won't be instantaneous as iOS. In that case, after the `window.addEventListener("aqutterPlatformReady")` event is dispatched, the ajax requests can be intercept for sure.
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit:
  ///    - This event is implemented using JavaScript. In order to be able to listen to this event, check the [AqutterWebViewSettings.useShouldInterceptAjaxRequest] and [AqutterWebViewSettings.useOnAjaxProgress] settings documentation.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [ajaxRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onAjaxProgress,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onAjaxReadyStateChange] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onAjaxReadyStateChange.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - In order to be able to listen this event, check the [AqutterWebViewSettings.useShouldInterceptAjaxRequest] and [AqutterWebViewSettings.useOnAjaxReadyStateChange] settings documentation. Also, on Android that doesn't support the [AqutterWebViewFeature.DOCUMENT_START_SCRIPT], unlike iOS that has [WKUserScript](https://developer.apple.com/documentation/webkit/wkuserscript) that can inject javascript code right after the document element is created but before any other content is loaded, in Android the javascript code used to intercept ajax requests is loaded as soon as possible so it won't be instantaneous as iOS. In that case, after the `window.addEventListener("aqutterPlatformReady")` event is dispatched, the ajax requests can be intercept for sure.
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit:
  ///    - This event is implemented using JavaScript. In order to be able to listen to this event, check the [AqutterWebViewSettings.useShouldInterceptAjaxRequest] and [AqutterWebViewSettings.useOnAjaxReadyStateChange] settings documentation.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [ajaxRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onAjaxReadyStateChange,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onCameraCaptureStateChanged] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onCameraCaptureStateChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 15.0+
  ///- macOS WKWebView 12.0+
  ///- Linux WPE WebKit ([Official API - WebKitWebView::notify::camera-capture-state](https://webkitgtk.org/reference/webkit2gtk/stable/property.WebView.camera-capture-state.html)):
  ///    - Requires WPE WebKit 2.34 or later.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [oldState]: all platforms
  ///- [newState]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onCameraCaptureStateChanged,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onCloseWindow] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onCloseWindow.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onCloseWindow](https://developer.android.com/reference/android/webkit/WebChromeClient#onCloseWindow(android.webkit.WebView)))
  ///- iOS WKWebView ([Official API - WKUIDelegate.webViewDidClose](https://developer.apple.com/documentation/webkit/wkuidelegate/1537390-webviewdidclose))
  ///- macOS WKWebView ([Official API - WKUIDelegate.webViewDidClose](https://developer.apple.com/documentation/webkit/wkuidelegate/1537390-webviewdidclose))
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_WindowCloseRequested](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_windowcloserequested))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::close](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.close.html))
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onCloseWindow,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onConsoleMessage] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onConsoleMessage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onConsoleMessage](https://developer.android.com/reference/android/webkit/WebChromeClient#onConsoleMessage(android.webkit.AqutterConsoleMessage)))
  ///- iOS WKWebView:
  ///    - This event is implemented using JavaScript.
  ///- macOS WKWebView:
  ///    - This event is implemented using JavaScript.
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit:
  ///    - This event is implemented using JavaScript.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [consoleMessage]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onConsoleMessage,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onContentLoading] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onContentLoading.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ContentLoading](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_contentloading))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onContentLoading,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onContentSizeChanged] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onContentSizeChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- Linux WPE WebKit:
  ///    - This event is implemented using JavaScript.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [oldContentSize]: all platforms
  ///- [newContentSize]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onContentSizeChanged,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onCreateWindow] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onCreateWindow.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onCreateWindow](https://developer.android.com/reference/android/webkit/WebChromeClient#onCreateWindow(android.webkit.WebView,%20boolean,%20boolean,%20android.os.Message))):
  ///    - You need to set [AqutterWebViewSettings.supportMultipleWindows] setting to `true`. Also, if the request has been created using JavaScript (`window.open()`), then there are some limitation: check the [AqutterNavigationAction] class.
  ///- iOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1536907-webview)):
  ///    - Setting these initial settings [AqutterWebViewSettings.supportZoom], [AqutterWebViewSettings.useOnLoadResource], [AqutterWebViewSettings.useShouldInterceptAjaxRequest], [AqutterWebViewSettings.useShouldInterceptFetchRequest], [AqutterWebViewSettings.applicationNameForUserAgent], [AqutterWebViewSettings.javaScriptCanOpenWindowsAutomatically], [AqutterWebViewSettings.javaScriptEnabled], [AqutterWebViewSettings.minimumFontSize], [AqutterWebViewSettings.preferredContentMode], [AqutterWebViewSettings.incognito], [AqutterWebViewSettings.cacheEnabled], [AqutterWebViewSettings.mediaPlaybackRequiresUserGesture], [AqutterWebViewSettings.resourceCustomSchemes], [AqutterWebViewSettings.sharedCookiesEnabled], [AqutterWebViewSettings.enableViewportScale], [AqutterWebViewSettings.allowsAirPlayForMediaPlayback], [AqutterWebViewSettings.allowsPictureInPictureMediaPlayback], [AqutterWebViewSettings.isFraudulentWebsiteWarningEnabled], [AqutterWebViewSettings.allowsInlineMediaPlayback], [AqutterWebViewSettings.suppressesIncrementalRendering], [AqutterWebViewSettings.selectionGranularity], [AqutterWebViewSettings.ignoresViewportScaleLimits], [AqutterWebViewSettings.limitsNavigationsToAppBoundDomains], [AqutterWebViewSettings.upgradeKnownHostsToHTTPS], will have no effect due to a `WKWebView` limitation when creating the new window WebView: it's impossible to return the new `WKWebView` with a different `WKWebViewConfiguration` instance (see https://developer.apple.com/documentation/webkit/wkuidelegate/1536907-webview). So, these options will be inherited from the caller WebView. Also, note that calling [AqutterWebViewController.setSettings] method using the controller of the new created WebView, it will update also the WebView options of the caller WebView.
  ///- macOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1536907-webview)):
  ///    - Setting these initial settings [AqutterWebViewSettings.supportZoom], [AqutterWebViewSettings.useOnLoadResource], [AqutterWebViewSettings.useShouldInterceptAjaxRequest], [AqutterWebViewSettings.useShouldInterceptFetchRequest], [AqutterWebViewSettings.applicationNameForUserAgent], [AqutterWebViewSettings.javaScriptCanOpenWindowsAutomatically], [AqutterWebViewSettings.javaScriptEnabled], [AqutterWebViewSettings.minimumFontSize], [AqutterWebViewSettings.preferredContentMode], [AqutterWebViewSettings.incognito], [AqutterWebViewSettings.cacheEnabled], [AqutterWebViewSettings.mediaPlaybackRequiresUserGesture], [AqutterWebViewSettings.resourceCustomSchemes], [AqutterWebViewSettings.sharedCookiesEnabled], [AqutterWebViewSettings.enableViewportScale], [AqutterWebViewSettings.allowsAirPlayForMediaPlayback], [AqutterWebViewSettings.allowsPictureInPictureMediaPlayback], [AqutterWebViewSettings.isFraudulentWebsiteWarningEnabled], [AqutterWebViewSettings.allowsInlineMediaPlayback], [AqutterWebViewSettings.suppressesIncrementalRendering], [AqutterWebViewSettings.selectionGranularity], [AqutterWebViewSettings.ignoresViewportScaleLimits], [AqutterWebViewSettings.limitsNavigationsToAppBoundDomains], [AqutterWebViewSettings.upgradeKnownHostsToHTTPS], will have no effect due to a `WKWebView` limitation when creating the new window WebView: it's impossible to return the new `WKWebView` with a different `WKWebViewConfiguration` instance (see https://developer.apple.com/documentation/webkit/wkuidelegate/1536907-webview). So, these options will be inherited from the caller WebView. Also, note that calling [AqutterWebViewController.setSettings] method using the controller of the new created WebView, it will update also the WebView options of the caller WebView.
  ///- Web \<iframe\> but requires same origin:
  ///    - It works only for `window.open()` javascript calls. Also, there is no way to block the opening the window in a synchronous way, so returning `true` will just close it quickly.
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_NewWindowRequested](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_newwindowrequested))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::create](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.create.html)):
  ///    - Creates a new AqutterWebView with related-view for multi-window support.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [createWindowAction]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onCreateWindow,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onDOMContentLoaded] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onDOMContentLoaded.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2_2.add_DOMContentLoaded](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_2?view=webview2-1.0.2210.55#add_domcontentloaded))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onDOMContentLoaded,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onDidReceiveServerRedirectForProvisionalNavigation] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onDidReceiveServerRedirectForProvisionalNavigation.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455627-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455627-webview))
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onDidReceiveServerRedirectForProvisionalNavigation,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onDownloadStart] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onDownloadStart.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onDownloadStarting instead')
  onDownloadStart,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onDownloadStartRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onDownloadStartRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [downloadStartRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onDownloadStarting instead')
  onDownloadStartRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onDownloadStarting] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onDownloadStarting.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebView.setDownloadListener]((https://developer.android.com/reference/android/webkit/WebView#setDownloadListener(android.webkit.DownloadListener)))
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2 ([Official API - ICoreWebView2_4.add_DownloadStarting](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_4?view=webview2-1.0.2849.39#add_downloadstarting))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::decide-policy](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.decide-policy.html)):
  ///    - Downloads are detected via WEBKIT_POLICY_DECISION_TYPE_RESPONSE.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [downloadStartRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onDownloadStarting,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onEnterFullscreen] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onEnterFullscreen.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onShowCustomView](https://developer.android.com/reference/android/webkit/WebChromeClient#onShowCustomView(android.view.View,%20android.webkit.WebChromeClient.CustomViewCallback)))
  ///- iOS WKWebView ([Official API - UIWindow.didBecomeVisibleNotification](https://developer.apple.com/documentation/uikit/uiwindow/1621621-didbecomevisiblenotification))
  ///- macOS WKWebView ([Official API - NSWindow.didEnterFullScreenNotification](https://developer.apple.com/documentation/appkit/nswindow/1419651-didenterfullscreennotification))
  ///- Web \<iframe\> but requires same origin ([Official API - Document.onfullscreenchange](https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreenchange_event))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ContainsFullScreenElementChanged](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_containsfullscreenelementchanged))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::enter-fullscreen](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.enter-fullscreen.html))
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onEnterFullscreen,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onExitFullscreen] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onExitFullscreen.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onHideCustomView](https://developer.android.com/reference/android/webkit/WebChromeClient#onHideCustomView()))
  ///- iOS WKWebView ([Official API - UIWindow.didBecomeHiddenNotification](https://developer.apple.com/documentation/uikit/uiwindow/1621617-didbecomehiddennotification))
  ///- macOS WKWebView ([Official API - NSWindow.didExitFullScreenNotification](https://developer.apple.com/documentation/appkit/nswindow/1419177-didexitfullscreennotification))
  ///- Web \<iframe\> but requires same origin ([Official API - Document.onfullscreenchange](https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreenchange_event))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ContainsFullScreenElementChanged](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_containsfullscreenelementchanged))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::leave-fullscreen](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.leave-fullscreen.html))
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onExitFullscreen,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onFaviconChanged] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onFaviconChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onReceivedIcon](https://developer.android.com/reference/android/webkit/WebChromeClient#onReceivedIcon(android.webkit.WebView,%20android.graphics.Bitmap)))
  ///- Windows WebView2 ([Official API - ICoreWebView2_15.add_FaviconChanged](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_15?view=webview2-1.0.2849.39#add_faviconchanged))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [faviconChangedRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onFaviconChanged,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onFindResultReceived] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onFindResultReceived.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [activeMatchOrdinal]: all platforms
  ///- [numberOfMatches]: all platforms
  ///- [isDoneCounting]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated(
    'Use AqutterFindInteractionController.onFindResultReceived instead',
  )
  onFindResultReceived,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onFormResubmission] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onFormResubmission.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onFormResubmission](https://developer.android.com/reference/android/webkit/WebViewClient#onFormResubmission(android.webkit.WebView,%20android.os.Message,%20android.os.Message)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onFormResubmission,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onGeolocationPermissionsHidePrompt] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onGeolocationPermissionsHidePrompt.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onGeolocationPermissionsHidePrompt](https://developer.android.com/reference/android/webkit/WebChromeClient#onGeolocationPermissionsHidePrompt()))
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onGeolocationPermissionsHidePrompt,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onGeolocationPermissionsShowPrompt] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onGeolocationPermissionsShowPrompt.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onGeolocationPermissionsShowPrompt](https://developer.android.com/reference/android/webkit/WebChromeClient#onGeolocationPermissionsShowPrompt(java.lang.String,%20android.webkit.GeolocationPermissions.Callback)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [origin]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onGeolocationPermissionsShowPrompt,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onJsAlert] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onJsAlert.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onJsAlert](https://developer.android.com/reference/android/webkit/WebChromeClient#onJsAlert(android.webkit.WebView,%20java.lang.String,%20java.lang.String,%20android.webkit.JsResult)))
  ///- iOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1537406-webview))
  ///- macOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1537406-webview))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::script-dialog](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.script-dialog.html)):
  ///    - Handles WEBKIT_SCRIPT_DIALOG_ALERT dialog type.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [jsAlertRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onJsAlert,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onJsBeforeUnload] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onJsBeforeUnload.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onJsBeforeUnload](https://developer.android.com/reference/android/webkit/WebChromeClient#onJsBeforeUnload(android.webkit.WebView,%20java.lang.String,%20java.lang.String,%20android.webkit.JsResult)))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::script-dialog](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.script-dialog.html)):
  ///    - Handles WEBKIT_SCRIPT_DIALOG_BEFORE_UNLOAD_CONFIRM dialog type.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [jsBeforeUnloadRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onJsBeforeUnload,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onJsConfirm] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onJsConfirm.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onJsConfirm](https://developer.android.com/reference/android/webkit/WebChromeClient#onJsConfirm(android.webkit.WebView,%20java.lang.String,%20java.lang.String,%20android.webkit.JsResult)))
  ///- iOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1536489-webview))
  ///- macOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1536489-webview))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::script-dialog](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.script-dialog.html)):
  ///    - Handles WEBKIT_SCRIPT_DIALOG_CONFIRM dialog type.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [jsConfirmRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onJsConfirm,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onJsPrompt] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onJsPrompt.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onJsPrompt](https://developer.android.com/reference/android/webkit/WebChromeClient#onJsPrompt(android.webkit.WebView,%20java.lang.String,%20java.lang.String,%20java.lang.String,%20android.webkit.JsPromptResult)))
  ///- iOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1538086-webview))
  ///- macOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1538086-webview))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::script-dialog](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.script-dialog.html)):
  ///    - Handles WEBKIT_SCRIPT_DIALOG_PROMPT dialog type.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [jsPromptRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onJsPrompt,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onLaunchingExternalUriScheme] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onLaunchingExternalUriScheme.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2_18.add_LaunchingExternalUriScheme](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_18?view=webview2-1.0.2849.39#add_launchingexternalurischeme))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onLaunchingExternalUriScheme,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onLoadError] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onLoadError.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [code]: all platforms
  ///- [message]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onReceivedError instead')
  onLoadError,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onLoadHttpError] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onLoadHttpError.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [statusCode]: all platforms
  ///- [description]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onReceivedHttpError instead')
  onLoadHttpError,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onLoadResource] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onLoadResource.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - This event is implemented using JavaScript.
  ///- iOS WKWebView:
  ///    - This event is implemented using JavaScript.
  ///- macOS WKWebView:
  ///    - This event is implemented using JavaScript.
  ///- Linux WPE WebKit:
  ///    - This event is implemented using JavaScript.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [resource]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onLoadResource,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onLoadResourceCustomScheme] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onLoadResourceCustomScheme.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onLoadResourceWithCustomScheme instead')
  onLoadResourceCustomScheme,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onLoadResourceWithCustomScheme] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onLoadResourceWithCustomScheme.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView ([Official API - WKURLSchemeHandler](https://developer.apple.com/documentation/webkit/wkurlschemehandler))
  ///- macOS WKWebView ([Official API - WKURLSchemeHandler](https://developer.apple.com/documentation/webkit/wkurlschemehandler))
  ///- Windows WebView2
  ///- Linux WPE WebKit ([Official API - WebKitURISchemeRequest](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.URISchemeRequest.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onLoadResourceWithCustomScheme,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onLoadStart] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onLoadStart.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onPageStarted](https://developer.android.com/reference/android/webkit/WebViewClient#onPageStarted(android.webkit.WebView,%20java.lang.String,%20android.graphics.Bitmap)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455621-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455621-webview))
  ///- Web \<iframe\> but requires same origin:
  ///    - It will be dispatched at the same time of [onLoadStop] event because there isn't any way to capture the real load start event from an iframe. If `window.location.href` isn't accessible inside the iframe, the [url] parameter will have the current value of the `iframe.src` attribute.
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_NavigationStarting](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/iwebview2webview?view=webview2-0.8.355#add_navigationstarting))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::load-changed](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.load-changed.html)):
  ///    - Fired when WebKitLoadEvent is WEBKIT_LOAD_STARTED.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onLoadStart,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onLoadStop] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onLoadStop.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onPageFinished](https://developer.android.com/reference/android/webkit/WebViewClient#onPageFinished(android.webkit.WebView,%20java.lang.String)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455629-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455629-webview))
  ///- Web \<iframe\> but requires same origin ([Official API - Window.onload](https://developer.mozilla.org/en-US/docs/Web/API/Window/load_event)):
  ///    - If `window.location.href` isn't accessible inside the iframe, the [url] parameter will have the current value of the `iframe.src` attribute.
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_NavigationCompleted](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/iwebview2webview?view=webview2-0.8.355#add_navigationcompleted))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::load-changed](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.load-changed.html)):
  ///    - Fired when WebKitLoadEvent is WEBKIT_LOAD_FINISHED.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onLoadStop,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onLongPressHitTestResult] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onLongPressHitTestResult.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - View.setOnLongClickListener](https://developer.android.com/reference/android/view/View#setOnLongClickListener(android.view.View.OnLongClickListener)))
  ///- iOS WKWebView ([Official API - UILongPressGestureRecognizer](https://developer.apple.com/documentation/uikit/uilongpressgesturerecognizer))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [hitTestResult]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onLongPressHitTestResult,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onMicrophoneCaptureStateChanged] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onMicrophoneCaptureStateChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 15.0+
  ///- macOS WKWebView 12.0+
  ///- Linux WPE WebKit ([Official API - WebKitWebView::notify::microphone-capture-state](https://webkitgtk.org/reference/webkit2gtk/stable/property.WebView.microphone-capture-state.html)):
  ///    - Requires WPE WebKit 2.34 or later.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [oldState]: all platforms
  ///- [newState]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onMicrophoneCaptureStateChanged,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onNavigationResponse] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onNavigationResponse.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455643-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455643-webview))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::decide-policy](https://webkitgtk.org/reference/webkit2gtk/stable/signal.WebView.decide-policy.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [navigationResponse]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onNavigationResponse,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onNotificationReceived] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onNotificationReceived.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2_24.add_NotificationReceived](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_24?view=webview2-1.0.2849.39#add_notificationreceived))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onNotificationReceived,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onOverScrolled] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onOverScrolled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebView.onOverScrolled](https://developer.android.com/reference/android/webkit/WebView#onOverScrolled(int,%20int,%20boolean,%20boolean)))
  ///- iOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [x]: all platforms
  ///- [y]: all platforms
  ///- [clampedX]: all platforms
  ///- [clampedY]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onOverScrolled,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onPageCommitVisible] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onPageCommitVisible.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onPageCommitVisible](https://developer.android.com/reference/android/webkit/WebViewClient#onPageCommitVisible(android.webkit.WebView,%20java.lang.String)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455635-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455635-webview))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::load-changed](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.load-changed.html)):
  ///    - Fired when WebKitLoadEvent is WEBKIT_LOAD_COMMITTED.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onPageCommitVisible,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onPermissionRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onPermissionRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 21+ ([Official API - WebChromeClient.onPermissionRequest](https://developer.android.com/reference/android/webkit/WebChromeClient#onPermissionRequest(android.webkit.AqutterPermissionRequest)))
  ///- iOS WKWebView 15.0+:
  ///    - The default [AqutterPermissionResponse.action] is [AqutterPermissionResponseAction.PROMPT].
  ///- macOS WKWebView 12.0+:
  ///    - The default [AqutterPermissionResponse.action] is [AqutterPermissionResponseAction.PROMPT].
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_PermissionRequested](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_permissionrequested))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::permission-request](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.permission-request.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [permissionRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onPermissionRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onPermissionRequestCanceled] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onPermissionRequestCanceled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 21+ ([Official API - WebChromeClient.onPermissionRequestCanceled](https://developer.android.com/reference/android/webkit/WebChromeClient#onPermissionRequestCanceled(android.webkit.AqutterPermissionRequest)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [permissionRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onPermissionRequestCanceled,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onPrint] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onPrint.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onPrintRequest instead')
  onPrint,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onPrintRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onPrintRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Linux WPE WebKit:
  ///    - Intercepted via JavaScript window.print() override.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [printJobController]:
  ///    - Android WebView
  ///    - iOS WKWebView
  ///    - macOS WKWebView
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onPrintRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onProcessFailed] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onProcessFailed.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ProcessFailed](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2849.39#add_processfailed))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [detail]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onProcessFailed,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onProgressChanged] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onProgressChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onProgressChanged](https://developer.android.com/reference/android/webkit/WebChromeClient#onProgressChanged(android.webkit.WebView,%20int)))
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit ([Official API - WebKitWebView::notify::estimated-load-progress](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/property.WebView.estimated-load-progress.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [progress]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onProgressChanged,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onReceivedClientCertRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedClientCertRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onReceivedClientCertRequest](https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedClientCertRequest(android.webkit.WebView,%20android.webkit.ClientCertRequest)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview))
  ///- Windows WebView2 ([Official API - ICoreWebView2_5.add_ClientCertificateRequested](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_5?view=webview2-1.0.2849.39#add_clientcertificaterequested))
  ///- Linux WPE WebKit ([Official API - WebKitAuthenticationRequest with WEBKIT_AUTHENTICATION_SCHEME_CLIENT_CERTIFICATE_REQUESTED](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.authenticate.html)):
  ///    - WPE WebKit supports client certificate requests via the authenticate signal. Providing a certificate programmatically requires WebKit 2.34+ and the certificate must be loaded from a PEM file. PKCS12 format may not be fully supported. If the certificate cannot be loaded, PROCEED will behave like CANCEL.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [challenge]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onReceivedClientCertRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onReceivedError] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedError.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onReceivedError](https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedError(android.webkit.WebView,%20android.webkit.AqutterWebResourceRequest,%20android.webkit.AqutterWebResourceError)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455623-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455623-webview))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_NavigationCompleted](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/iwebview2webview?view=webview2-0.8.355#add_navigationcompleted))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::load-failed](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.load-failed.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///- [error]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onReceivedError,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onReceivedHttpAuthRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedHttpAuthRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onReceivedHttpAuthRequest](https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedHttpAuthRequest(android.webkit.WebView,%20android.webkit.HttpAuthHandler,%20java.lang.String,%20java.lang.String)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview))
  ///- Windows WebView2 ([Official API - ICoreWebView2_10.add_BasicAuthenticationRequested](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_10?view=webview2-1.0.2849.39#add_basicauthenticationrequested))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::authenticate](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.authenticate.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [challenge]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onReceivedHttpAuthRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onReceivedHttpError] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedHttpError.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 23+ ([Official API - WebViewClient.onReceivedHttpError](https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedHttpError(android.webkit.WebView,%20android.webkit.AqutterWebResourceRequest,%20android.webkit.AqutterWebResourceResponse)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455643-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455643-webview))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_NavigationCompleted](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/iwebview2webview?view=webview2-0.8.355#add_navigationcompleted))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::load-failed](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.load-failed.html)):
  ///    - HTTP errors are detected during the load-failed signal handling.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///- [errorResponse]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onReceivedHttpError,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onReceivedIcon] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedIcon.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onReceivedIcon](https://developer.android.com/reference/android/webkit/WebChromeClient#onReceivedIcon(android.webkit.WebView,%20android.graphics.Bitmap)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [icon]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onFaviconChanged instead')
  onReceivedIcon,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onReceivedLoginRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedLoginRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onReceivedLoginRequest](https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedLoginRequest(android.webkit.WebView,%20java.lang.String,%20java.lang.String,%20java.lang.String)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [loginRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onReceivedLoginRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onReceivedServerTrustAuthRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedServerTrustAuthRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onReceivedSslError](https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedSslError(android.webkit.WebView,%20android.webkit.SslErrorHandler,%20android.net.http.AqutterSslError)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview)):
  ///    - To override the certificate verification logic, you have to provide ATS (App Transport Security) exceptions in your iOS/macOS `Info.plist`. See `NSAppTransportSecurity` in the [Information Property List Key Reference](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW1) for details.
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview)):
  ///    - To override the certificate verification logic, you have to provide ATS (App Transport Security) exceptions in your iOS/macOS `Info.plist`. See `NSAppTransportSecurity` in the [Information Property List Key Reference](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW1) for details.
  ///- Windows WebView2 ([Official API - ICoreWebView2_14.add_ServerCertificateErrorDetected](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_14?view=webview2-1.0.2792.45#add_servercertificateerrordetected))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::load-failed-with-tls-errors](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.load-failed-with-tls-errors.html)):
  ///    - Uses webkit_web_context_allow_tls_certificate_for_host() to allow proceeding with an invalid certificate.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [challenge]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onReceivedServerTrustAuthRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onReceivedTouchIconUrl] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedTouchIconUrl.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onReceivedTouchIconUrl](https://developer.android.com/reference/android/webkit/WebChromeClient#onReceivedTouchIconUrl(android.webkit.WebView,%20java.lang.String,%20boolean)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [precomposed]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onReceivedTouchIconUrl,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onRenderProcessGone] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onRenderProcessGone.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 26+ ([Official API - WebViewClient.onRenderProcessGone](https://developer.android.com/reference/android/webkit/WebViewClient#onRenderProcessGone(android.webkit.WebView,%20android.webkit.AqutterRenderProcessGoneDetail)))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ProcessFailed](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2849.39#add_processfailed))
  ///- Linux WPE WebKit ([Official API - WebView.web-process-terminated](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/WebKitWebView.html#WebKitWebView-web-process-terminated))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [detail]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onRenderProcessGone,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onRenderProcessResponsive] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onRenderProcessResponsive.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 29+ ([Official API - WebViewRenderProcessClient.onRenderProcessResponsive](https://developer.android.com/reference/android/webkit/WebViewRenderProcessClient#onRenderProcessResponsive(android.webkit.WebView,%20android.webkit.WebViewRenderProcess)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onRenderProcessResponsive,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onRenderProcessUnresponsive] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onRenderProcessUnresponsive.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 29+ ([Official API - WebViewRenderProcessClient.onRenderProcessUnresponsive](https://developer.android.com/reference/android/webkit/WebViewRenderProcessClient#onRenderProcessUnresponsive(android.webkit.WebView,%20android.webkit.WebViewRenderProcess)))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ProcessFailed](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2849.39#add_processfailed))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onRenderProcessUnresponsive,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onRequestFocus] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onRequestFocus.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onRequestFocus](https://developer.android.com/reference/android/webkit/WebChromeClient#onRequestFocus(android.webkit.WebView)))
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onRequestFocus,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onSafeBrowsingHit] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onSafeBrowsingHit.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 27+ ([Official API - WebViewClient.onSafeBrowsingHit](https://developer.android.com/reference/android/webkit/WebViewClient#onSafeBrowsingHit(android.webkit.WebView,%20android.webkit.AqutterWebResourceRequest,%20int,%20android.webkit.AqutterSafeBrowsingResponse)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [threatType]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onSafeBrowsingHit,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onSaveAsUIShowing] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onSaveAsUIShowing.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2_25.add_SaveAsUIShowing](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_25?view=webview2-1.0.2849.39#add_saveasuishowing))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onSaveAsUIShowing,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onSaveFileSecurityCheckStarting] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onSaveFileSecurityCheckStarting.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2_26.add_SaveFileSecurityCheckStarting](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_26?view=webview2-1.0.2849.39#add_savefilesecuritycheckstarting))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onSaveFileSecurityCheckStarting,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onScreenCaptureStarting] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onScreenCaptureStarting.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2_27.add_ScreenCaptureStarting](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_27?view=webview2-1.0.2849.39#add_screencapturestarting))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onScreenCaptureStarting,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onScrollChanged] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onScrollChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebView.onScrollChanged](https://developer.android.com/reference/android/webkit/WebView#onScrollChanged(int,%20int,%20int,%20int)))
  ///- iOS WKWebView ([Official API - UIScrollViewDelegate.scrollViewDidScroll](https://developer.apple.com/documentation/uikit/uiscrollviewdelegate/1619392-scrollviewdidscroll))
  ///- macOS WKWebView:
  ///    - This event is implemented using JavaScript.
  ///- Web \<iframe\> but requires same origin ([Official API - Window.onscroll](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onscroll))
  ///- Linux WPE WebKit:
  ///    - This event is implemented using JavaScript.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [x]: all platforms
  ///- [y]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onScrollChanged,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onShowFileChooser] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onShowFileChooser.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onShowFileChooser](https://developer.android.com/reference/android/webkit/WebChromeClient#onShowFileChooser(android.webkit.WebView,%20android.webkit.ValueCallback%3Candroid.net.Uri[]%3E,%20android.webkit.WebChromeClient.FileChooserParams)))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::run-file-chooser](https://webkitgtk.org/reference/webkit2gtk/stable/signal.WebView.run-file-chooser.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onShowFileChooser,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onTitleChanged] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onTitleChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onReceivedTitle](https://developer.android.com/reference/android/webkit/WebChromeClient#onReceivedTitle(android.webkit.WebView,%20java.lang.String)))
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_DocumentTitleChanged](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_documenttitlechanged))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::notify::title](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/property.WebView.title.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [title]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onTitleChanged,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onUpdateVisitedHistory] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onUpdateVisitedHistory.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.doUpdateVisitedHistory](https://developer.android.com/reference/android/webkit/WebViewClient#doUpdateVisitedHistory(android.webkit.WebView,%20java.lang.String,%20boolean)))
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_HistoryChanged](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_historychanged))
  ///- Linux WPE WebKit:
  ///    - Tracked via load-changed signal and History API JavaScript events.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [isReload]:
  ///    - Android WebView
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onUpdateVisitedHistory,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onWebContentProcessDidTerminate] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onWebContentProcessDidTerminate.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webViewWebContentProcessDidTerminate](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455639-webviewwebcontentprocessdidtermi))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webViewWebContentProcessDidTerminate](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455639-webviewwebcontentprocessdidtermi))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ProcessFailed](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2849.39#add_processfailed))
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onWebContentProcessDidTerminate,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onWebViewCreated] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onWebViewCreated.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onWebViewCreated,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onWindowBlur] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onWindowBlur.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin ([Official API - Window.onblur](https://developer.mozilla.org/en-US/docs/Web/API/Window/blur_event))
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onWindowBlur,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onWindowFocus] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onWindowFocus.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin ([Official API - Window.onfocus](https://developer.mozilla.org/en-US/docs/Web/API/Window/focus_event))
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onWindowFocus,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.onZoomScaleChanged] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.onZoomScaleChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onScaleChanged](https://developer.android.com/reference/android/webkit/WebViewClient#onScaleChanged(android.webkit.WebView,%20float,%20float)))
  ///- iOS WKWebView ([Official API - UIScrollViewDelegate.scrollViewDidZoom](https://developer.apple.com/documentation/uikit/uiscrollviewdelegate/1619409-scrollviewdidzoom))
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2 ([Official API - ICoreWebView2Controller.add_ZoomFactorChanged](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller?view=webview2-1.0.2849.39#add_zoomfactorchanged))
  ///- Linux WPE WebKit ([Official API - WebKitWebView::notify::zoom-level](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/property.WebView.zoom-level.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [oldScale]: all platforms
  ///- [newScale]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onZoomScaleChanged,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.pullToRefreshController] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.pullToRefreshController.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - To be able to use the "pull-to-refresh" feature, [AqutterWebViewSettings.useHybridComposition] must be `true`.
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  pullToRefreshController,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.shouldAllowDeprecatedTLS] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.shouldAllowDeprecatedTLS.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 14.0+ ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/3601237-webview))
  ///- macOS WKWebView 11.0+ ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/3601237-webview))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [challenge]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  shouldAllowDeprecatedTLS,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.shouldInterceptAjaxRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.shouldInterceptAjaxRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - In order to be able to listen this event, check the [AqutterWebViewSettings.useShouldInterceptAjaxRequest] setting documentation. Also, on Android that doesn't support the [AqutterWebViewFeature.DOCUMENT_START_SCRIPT], unlike iOS that has [WKUserScript](https://developer.apple.com/documentation/webkit/wkuserscript) that can inject javascript code right after the document element is created but before any other content is loaded, in Android the javascript code used to intercept ajax requests is loaded as soon as possible so it won't be instantaneous as iOS. In that case, after the `window.addEventListener("aqutterPlatformReady")` event is dispatched, the ajax requests can be intercept for sure.
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit:
  ///    - This event is implemented using JavaScript. In order to be able to listen to this event, check the [AqutterWebViewSettings.useShouldInterceptAjaxRequest] setting documentation.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [ajaxRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  shouldInterceptAjaxRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.shouldInterceptFetchRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.shouldInterceptFetchRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - In order to be able to listen this event, check the [AqutterWebViewSettings.useShouldInterceptFetchRequest] setting documentation. Also, on Android that doesn't support the [AqutterWebViewFeature.DOCUMENT_START_SCRIPT], unlike iOS that has [WKUserScript](https://developer.apple.com/documentation/webkit/wkuserscript) that can inject javascript code right after the document element is created but before any other content is loaded, in Android the javascript code used to intercept ajax requests is loaded as soon as possible so it won't be instantaneous as iOS. In that case, after the `window.addEventListener("aqutterPlatformReady")` event is dispatched, the ajax requests can be intercept for sure.
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit:
  ///    - This event is implemented using JavaScript. In order to be able to listen to this event, check the [AqutterWebViewSettings.useShouldInterceptFetchRequest] setting documentation.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [fetchRequest]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  shouldInterceptFetchRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.shouldInterceptRequest] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.shouldInterceptRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.shouldInterceptRequest](https://developer.android.com/reference/android/webkit/WebViewClient#shouldInterceptRequest(android.webkit.WebView,%20android.webkit.AqutterWebResourceRequest)))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_WebResourceRequested](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2478.35#add_webresourcerequested))
  ///- Linux WPE WebKit ([Official API - webkit_web_context_register_uri_scheme](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.register_uri_scheme.html)):
  ///    - Request interception is implemented via custom URI scheme handlers.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  shouldInterceptRequest,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.shouldOverrideUrlLoading] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.shouldOverrideUrlLoading.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.shouldOverrideUrlLoading](https://developer.android.com/reference/android/webkit/WebViewClient#shouldOverrideUrlLoading(android.webkit.WebView,%20java.lang.String))):
  ///    - There isn't any way to load an URL for a frame that is not the main frame, so if the request is not for the main frame, the navigation is allowed by default. However, if you want to cancel requests for subframes, you can use the [AqutterWebViewSettings.regexToCancelSubFramesLoading] setting to write a Regular Expression that, if the url request of a subframe matches, then the request of that subframe is canceled. Instead, the [AqutterWebViewSettings.regexToAllowSyncUrlLoading] setting could be used to allow navigation requests synchronously, as this event is synchronous on native side and the current plugin implementation will always cancel the current request and load a new request if this event returns [AqutterNavigationActionPolicy.ALLOW] because Flutter method channels work only asynchronously. Also, this event is not called for POST requests and is not called on the first page load.
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455641-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455641-webview))
  ///- Windows WebView2
  ///- Linux WPE WebKit ([Official API - WebKitWebView::decide-policy](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/signal.WebView.decide-policy.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [navigationAction]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  shouldOverrideUrlLoading,

  ///Can be used to check if the [AqutterPlatformWebViewCreationParams.windowId] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewCreationParams.windowId.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebViewCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  windowId,
}

extension _AqutterPlatformWebViewCreationParamsPropertySupported
    on AqutterPlatformWebViewCreationParams {
  static bool isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformWebViewCreationParamsProperty
          .androidOnFormResubmission:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .androidOnGeolocationPermissionsHidePrompt:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .androidOnGeolocationPermissionsShowPrompt:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.androidOnJsBeforeUnload:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .androidOnPermissionRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.androidOnReceivedIcon:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .androidOnReceivedLoginRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .androidOnReceivedTouchIconUrl:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .androidOnRenderProcessGone:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .androidOnRenderProcessResponsive:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .androidOnRenderProcessUnresponsive:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .androidOnSafeBrowsingHit:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.androidOnScaleChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .androidShouldInterceptRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.contextMenu:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .findInteractionController:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.initialData:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.initialFile:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.initialOptions:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.initialSettings:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.initialUrlRequest:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.initialUserScripts:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .iosOnDidReceiveServerRedirectForProvisionalNavigation:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.iosOnNavigationResponse:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .iosOnWebContentProcessDidTerminate:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .iosShouldAllowDeprecatedTLS:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onAcceleratorKeyPressed:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onAjaxProgress:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onAjaxReadyStateChange:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onCameraCaptureStateChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onCloseWindow:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onConsoleMessage:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onContentLoading:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onContentSizeChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onCreateWindow:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onDOMContentLoaded:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onDidReceiveServerRedirectForProvisionalNavigation:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onDownloadStart:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onDownloadStartRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onDownloadStarting:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onEnterFullscreen:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onExitFullscreen:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onFaviconChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onFindResultReceived:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onFormResubmission:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onGeolocationPermissionsHidePrompt:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onGeolocationPermissionsShowPrompt:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onJsAlert:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onJsBeforeUnload:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onJsConfirm:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onJsPrompt:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onLaunchingExternalUriScheme:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onLoadError:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onLoadHttpError:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onLoadResource:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onLoadResourceCustomScheme:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onLoadResourceWithCustomScheme:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onLoadStart:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onLoadStop:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onLongPressHitTestResult:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onMicrophoneCaptureStateChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onNavigationResponse:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onNotificationReceived:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onOverScrolled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onPageCommitVisible:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onPermissionRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onPermissionRequestCanceled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onPrint:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onPrintRequest:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onProcessFailed:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onProgressChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onReceivedClientCertRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onReceivedError:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onReceivedHttpAuthRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onReceivedHttpError:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onReceivedIcon:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onReceivedLoginRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onReceivedServerTrustAuthRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onReceivedTouchIconUrl:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onRenderProcessGone:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onRenderProcessResponsive:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onRenderProcessUnresponsive:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onRequestFocus:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onSafeBrowsingHit:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onSaveAsUIShowing:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onSaveFileSecurityCheckStarting:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onScreenCaptureStarting:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onScrollChanged:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onShowFileChooser:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onTitleChanged:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onUpdateVisitedHistory:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .onWebContentProcessDidTerminate:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onWebViewCreated:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onWindowBlur:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onWindowFocus:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.onZoomScaleChanged:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.pullToRefreshController:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .shouldAllowDeprecatedTLS:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .shouldInterceptAjaxRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .shouldInterceptFetchRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.shouldInterceptRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty
          .shouldOverrideUrlLoading:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewCreationParamsProperty.windowId:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                  ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
