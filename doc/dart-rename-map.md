# 上游 flutter_inappwebview → Aqutter：Dart API 名稱對照

本表供從上游 `flutter_inappwebview` 遷移到 `aqutter_core` 時對照，記錄公開型別、小寫識別字與檔案路徑的名稱。**不提供舊名別名**。

## 規則

- 型別：前綴 `Aqutter`，並移除任何位置的詞 `InApp`；`Platform`、`Android`、`IOS` 等平台前綴保留（`PlatformInAppWebViewController` → `AqutterPlatformWebViewController`）。
- 例外：舊式子類 `InAppWebViewOptions`、`InAppBrowserOptions` 保留 `InApp`（僅加前綴）。
- 小寫開頭的識別字（含公開方法名）：移除 `InApp`，不加前綴。
- 檔案與目錄：去掉 `in_app_`、`inappwebview` 改為 `webview`，不加前綴。
- 不改：`ChannelController`、`Color`、`IdGenerator`、`Util` 等本就不對外匯出的名稱；與公開型別同名的實作類別（`lib/src/platforms/**`）；
  JS／channel 對外名稱 `flutterInAppWebViewPlatformReady`、`flutterInAppWebView`、`createFlutterInAppWebView`、`createInAppWebView`（見 `doc/native-rename-map.md`）。

## 型別（526）

| 舊名 | 新名 | 備註 |
|---|---|---|
| `ASN1DERDecoder` | `AqutterASN1DERDecoder` | 僅加前綴 |
| `ASN1DEREncoder` | `AqutterASN1DEREncoder` | 僅加前綴 |
| `ASN1DistinguishedNames` | `AqutterASN1DistinguishedNames` | 僅加前綴 |
| `ASN1Identifier` | `AqutterASN1Identifier` | 僅加前綴 |
| `ASN1IdentifierClass` | `AqutterASN1IdentifierClass` | 僅加前綴 |
| `ASN1IdentifierTagNumber` | `AqutterASN1IdentifierTagNumber` | 僅加前綴 |
| `ASN1Object` | `AqutterASN1Object` | 僅加前綴 |
| `ASN1OutOfBufferError` | `AqutterASN1OutOfBufferError` | 僅加前綴 |
| `ASN1ParseError` | `AqutterASN1ParseError` | 僅加前綴 |
| `AcceleratorKeyPressedDetail` | `AqutterAcceleratorKeyPressedDetail` | 僅加前綴 |
| `ActionModeMenuItem` | `AqutterActionModeMenuItem` | 僅加前綴 |
| `ActivityButton` | `AqutterActivityButton` | 僅加前綴 |
| `AjaxRequest` | `AqutterAjaxRequest` | 僅加前綴 |
| `AjaxRequestAction` | `AqutterAjaxRequestAction` | 僅加前綴 |
| `AjaxRequestEvent` | `AqutterAjaxRequestEvent` | 僅加前綴 |
| `AjaxRequestEventType` | `AqutterAjaxRequestEventType` | 僅加前綴 |
| `AjaxRequestHeaders` | `AqutterAjaxRequestHeaders` | 僅加前綴 |
| `AjaxRequestReadyState` | `AqutterAjaxRequestReadyState` | 僅加前綴 |
| `AndroidActionModeMenuItem` | `AqutterAndroidActionModeMenuItem` | 僅加前綴 |
| `AndroidCacheMode` | `AqutterAndroidCacheMode` | 僅加前綴 |
| `AndroidChromeCustomTabsOptions` | `AqutterAndroidChromeCustomTabsOptions` | 僅加前綴 |
| `AndroidCompositionMode` | `AqutterAndroidCompositionMode` | 僅加前綴 |
| `AndroidForceDark` | `AqutterAndroidForceDark` | 僅加前綴 |
| `AndroidInAppBrowserOptions` | `AqutterAndroidBrowserOptions` | 移除 InApp |
| `AndroidInAppWebViewController` | `AqutterAndroidWebViewController` | 實作層有同名類別，實作層維持原名；移除 InApp |
| `AndroidInAppWebViewOptions` | `AqutterAndroidWebViewOptions` | 移除 InApp |
| `AndroidLayoutAlgorithm` | `AqutterAndroidLayoutAlgorithm` | 僅加前綴 |
| `AndroidLayoutInDisplayCutoutMode` | `AqutterAndroidLayoutInDisplayCutoutMode` | 僅加前綴 |
| `AndroidMixedContentMode` | `AqutterAndroidMixedContentMode` | 僅加前綴 |
| `AndroidOptions` | `AqutterAndroidOptions` | 僅加前綴 |
| `AndroidOverScrollMode` | `AqutterAndroidOverScrollMode` | 僅加前綴 |
| `AndroidPullToRefreshSize` | `AqutterAndroidPullToRefreshSize` | 僅加前綴 |
| `AndroidResource` | `AqutterAndroidResource` | 僅加前綴 |
| `AndroidScrollBarStyle` | `AqutterAndroidScrollBarStyle` | 僅加前綴 |
| `AndroidServiceWorkerClient` | `AqutterAndroidServiceWorkerClient` | 僅加前綴 |
| `AndroidServiceWorkerController` | `AqutterAndroidServiceWorkerController` | 實作層有同名類別，實作層維持原名 |
| `AndroidSslError` | `AqutterAndroidSslError` | 僅加前綴 |
| `AndroidVerticalScrollbarPosition` | `AqutterAndroidVerticalScrollbarPosition` | 僅加前綴 |
| `AndroidWebStorageManager` | `AqutterAndroidWebStorageManager` | 實作層有同名類別，實作層維持原名 |
| `AndroidWebStorageOrigin` | `AqutterAndroidWebStorageOrigin` | 僅加前綴 |
| `AndroidWebViewFeature` | `AqutterAndroidWebViewFeature` | 實作層有同名類別，實作層維持原名 |
| `AndroidWebViewPackageInfo` | `AqutterAndroidWebViewPackageInfo` | 僅加前綴 |
| `AssetsPathHandler` | `AqutterAssetsPathHandler` | 僅加前綴 |
| `AttributedString` | `AqutterAttributedString` | 僅加前綴 |
| `AttributedStringTextEffectStyle` | `AqutterAttributedStringTextEffectStyle` | 僅加前綴 |
| `AuthorityInfoAccess` | `AqutterAuthorityInfoAccess` | 僅加前綴 |
| `AuthorityInfoAccessExtension` | `AqutterAuthorityInfoAccessExtension` | 僅加前綴 |
| `AuthorityKeyIdentifierExtension` | `AqutterAuthorityKeyIdentifierExtension` | 僅加前綴 |
| `BasicConstraintExtension` | `AqutterBasicConstraintExtension` | 僅加前綴 |
| `BrowserOptions` | `AqutterBrowserOptions` | 僅加前綴 |
| `BrowserProcessExitKind` | `AqutterBrowserProcessExitKind` | 僅加前綴 |
| `BrowserProcessExitedDetail` | `AqutterBrowserProcessExitedDetail` | 僅加前綴 |
| `BrowserProcessInfo` | `AqutterBrowserProcessInfo` | 僅加前綴 |
| `BrowserProcessInfosChangedDetail` | `AqutterBrowserProcessInfosChangedDetail` | 僅加前綴 |
| `BrowserProcessKind` | `AqutterBrowserProcessKind` | 僅加前綴 |
| `CRLDistributionPointsExtension` | `AqutterCRLDistributionPointsExtension` | 僅加前綴 |
| `CSSLinkHtmlTagAttributes` | `AqutterCSSLinkHtmlTagAttributes` | 僅加前綴 |
| `CacheMode` | `AqutterCacheMode` | 僅加前綴 |
| `CacheModel` | `AqutterCacheModel` | 僅加前綴 |
| `CallAsyncJavaScriptResult` | `AqutterCallAsyncJavaScriptResult` | 僅加前綴 |
| `CertificatePoliciesExtension` | `AqutterCertificatePoliciesExtension` | 僅加前綴 |
| `CertificatePolicy` | `AqutterCertificatePolicy` | 僅加前綴 |
| `CertificatePolicyQualifier` | `AqutterCertificatePolicyQualifier` | 僅加前綴 |
| `ChromeSafariBrowser` | `AqutterChromeSafariBrowser` | 僅加前綴 |
| `ChromeSafariBrowserActionButton` | `AqutterChromeSafariBrowserActionButton` | 僅加前綴 |
| `ChromeSafariBrowserClassOptions` | `AqutterChromeSafariBrowserClassOptions` | 僅加前綴 |
| `ChromeSafariBrowserMenuItem` | `AqutterChromeSafariBrowserMenuItem` | 僅加前綴 |
| `ChromeSafariBrowserOptions` | `AqutterChromeSafariBrowserOptions` | 僅加前綴 |
| `ChromeSafariBrowserSecondaryToolbar` | `AqutterChromeSafariBrowserSecondaryToolbar` | 僅加前綴 |
| `ChromeSafariBrowserSecondaryToolbarClickableID` | `AqutterChromeSafariBrowserSecondaryToolbarClickableID` | 僅加前綴 |
| `ChromeSafariBrowserSettings` | `AqutterChromeSafariBrowserSettings` | 僅加前綴 |
| `ChromeSafariBrowserSettingsProperty` | `AqutterChromeSafariBrowserSettingsProperty` | 僅加前綴 |
| `ClientCertChallenge` | `AqutterClientCertChallenge` | 僅加前綴 |
| `ClientCertResponse` | `AqutterClientCertResponse` | 僅加前綴 |
| `ClientCertResponseAction` | `AqutterClientCertResponseAction` | 僅加前綴 |
| `CompressFormat` | `AqutterCompressFormat` | 僅加前綴 |
| `ConsoleMessage` | `AqutterConsoleMessage` | 僅加前綴 |
| `ConsoleMessageLevel` | `AqutterConsoleMessageLevel` | 僅加前綴 |
| `ContentBlocker` | `AqutterContentBlocker` | 僅加前綴 |
| `ContentBlockerAction` | `AqutterContentBlockerAction` | 僅加前綴 |
| `ContentBlockerActionType` | `AqutterContentBlockerActionType` | 僅加前綴 |
| `ContentBlockerTrigger` | `AqutterContentBlockerTrigger` | 僅加前綴 |
| `ContentBlockerTriggerLoadContext` | `AqutterContentBlockerTriggerLoadContext` | 僅加前綴 |
| `ContentBlockerTriggerLoadType` | `AqutterContentBlockerTriggerLoadType` | 僅加前綴 |
| `ContentBlockerTriggerResourceType` | `AqutterContentBlockerTriggerResourceType` | 僅加前綴 |
| `ContentWorld` | `AqutterContentWorld` | 僅加前綴 |
| `ContextMenu` | `AqutterContextMenu` | 僅加前綴 |
| `ContextMenuItem` | `AqutterContextMenuItem` | 僅加前綴 |
| `ContextMenuOptions` | `AqutterContextMenuOptions` | 僅加前綴 |
| `ContextMenuSettings` | `AqutterContextMenuSettings` | 僅加前綴 |
| `Cookie` | `AqutterCookie` | 僅加前綴 |
| `CookieManager` | `AqutterCookieManager` | 僅加前綴 |
| `CreateWindowAction` | `AqutterCreateWindowAction` | 僅加前綴 |
| `CrossOrigin` | `AqutterCrossOrigin` | 僅加前綴 |
| `CustomPathHandler` | `AqutterCustomPathHandler` | 僅加前綴 |
| `CustomSchemeRegistration` | `AqutterCustomSchemeRegistration` | 僅加前綴 |
| `CustomSchemeResponse` | `AqutterCustomSchemeResponse` | 僅加前綴 |
| `CustomTabsNavigationEventType` | `AqutterCustomTabsNavigationEventType` | 僅加前綴 |
| `CustomTabsPostMessageResultType` | `AqutterCustomTabsPostMessageResultType` | 僅加前綴 |
| `CustomTabsRelationType` | `AqutterCustomTabsRelationType` | 僅加前綴 |
| `CustomTabsShareState` | `AqutterCustomTabsShareState` | 僅加前綴 |
| `DataDetectorTypes` | `AqutterDataDetectorTypes` | 僅加前綴 |
| `DebugLoggingSettings` | `AqutterDebugLoggingSettings` | 僅加前綴 |
| `DefaultInAppLocalhostServer` | `AqutterDefaultLocalhostServer` | 移除 InApp |
| `DefaultInAppLocalhostServerCreationParams` | `AqutterDefaultLocalhostServerCreationParams` | 移除 InApp |
| `DismissButtonStyle` | `AqutterDismissButtonStyle` | 僅加前綴 |
| `Disposable` | `AqutterDisposable` | 僅加前綴 |
| `DownloadStartRequest` | `AqutterDownloadStartRequest` | 僅加前綴 |
| `DownloadStartResponse` | `AqutterDownloadStartResponse` | 僅加前綴 |
| `DownloadStartResponseAction` | `AqutterDownloadStartResponseAction` | 僅加前綴 |
| `EnumMethod` | `AqutterEnumMethod` | 僅加前綴 |
| `EnvironmentChannelSearchKind` | `AqutterEnvironmentChannelSearchKind` | 僅加前綴 |
| `EnvironmentReleaseChannels` | `AqutterEnvironmentReleaseChannels` | 僅加前綴 |
| `EnvironmentScrollbarStyle` | `AqutterEnvironmentScrollbarStyle` | 僅加前綴 |
| `Favicon` | `AqutterFavicon` | 僅加前綴 |
| `FaviconChangedRequest` | `AqutterFaviconChangedRequest` | 僅加前綴 |
| `FaviconImageFormat` | `AqutterFaviconImageFormat` | 僅加前綴 |
| `FetchRequest` | `AqutterFetchRequest` | 僅加前綴 |
| `FetchRequestAction` | `AqutterFetchRequestAction` | 僅加前綴 |
| `FetchRequestCredential` | `AqutterFetchRequestCredential` | 僅加前綴 |
| `FetchRequestCredentialDefault` | `AqutterFetchRequestCredentialDefault` | 僅加前綴 |
| `FetchRequestFederatedCredential` | `AqutterFetchRequestFederatedCredential` | 僅加前綴 |
| `FetchRequestPasswordCredential` | `AqutterFetchRequestPasswordCredential` | 僅加前綴 |
| `FindInteractionController` | `AqutterFindInteractionController` | 僅加前綴 |
| `FindOptions` | `AqutterFindOptions` | 僅加前綴 |
| `FindSession` | `AqutterFindSession` | 僅加前綴 |
| `FocusDirection` | `AqutterFocusDirection` | 僅加前綴 |
| `FontHintingStyle` | `AqutterFontHintingStyle` | 僅加前綴 |
| `FontSubpixelLayout` | `AqutterFontSubpixelLayout` | 僅加前綴 |
| `ForceDark` | `AqutterForceDark` | 僅加前綴 |
| `ForceDarkStrategy` | `AqutterForceDarkStrategy` | 僅加前綴 |
| `FormResubmissionAction` | `AqutterFormResubmissionAction` | 僅加前綴 |
| `FrameInfo` | `AqutterFrameInfo` | 僅加前綴 |
| `FrameKind` | `AqutterFrameKind` | 僅加前綴 |
| `GeolocationPermissionShowPromptResponse` | `AqutterGeolocationPermissionShowPromptResponse` | 僅加前綴 |
| `HTTPCookieSameSitePolicy` | `AqutterHTTPCookieSameSitePolicy` | 僅加前綴 |
| `HeadlessInAppWebView` | `AqutterHeadlessWebView` | 移除 InApp |
| `HttpAuthCredentialDatabase` | `AqutterHttpAuthCredentialDatabase` | 僅加前綴 |
| `HttpAuthResponse` | `AqutterHttpAuthResponse` | 僅加前綴 |
| `HttpAuthResponseAction` | `AqutterHttpAuthResponseAction` | 僅加前綴 |
| `HttpAuthenticationChallenge` | `AqutterHttpAuthenticationChallenge` | 僅加前綴 |
| `IOSCookieManager` | `AqutterIOSCookieManager` | 實作層有同名類別，實作層維持原名 |
| `IOSInAppBrowserOptions` | `AqutterIOSBrowserOptions` | 移除 InApp |
| `IOSInAppWebViewController` | `AqutterIOSWebViewController` | 實作層有同名類別，實作層維持原名；移除 InApp |
| `IOSInAppWebViewOptions` | `AqutterIOSWebViewOptions` | 移除 InApp |
| `IOSNSAttributedString` | `AqutterIOSNSAttributedString` | 僅加前綴 |
| `IOSNSAttributedStringTextEffectStyle` | `AqutterIOSNSAttributedStringTextEffectStyle` | 僅加前綴 |
| `IOSNSURLProtectionSpaceAuthenticationMethod` | `AqutterIOSNSURLProtectionSpaceAuthenticationMethod` | 僅加前綴 |
| `IOSNSURLProtectionSpaceProxyType` | `AqutterIOSNSURLProtectionSpaceProxyType` | 僅加前綴 |
| `IOSNSUnderlineStyle` | `AqutterIOSNSUnderlineStyle` | 僅加前綴 |
| `IOSNavigationResponseAction` | `AqutterIOSNavigationResponseAction` | 僅加前綴 |
| `IOSSafariDismissButtonStyle` | `AqutterIOSSafariDismissButtonStyle` | 僅加前綴 |
| `IOSSafariOptions` | `AqutterIOSSafariOptions` | 僅加前綴 |
| `IOSShouldAllowDeprecatedTLSAction` | `AqutterIOSShouldAllowDeprecatedTLSAction` | 僅加前綴 |
| `IOSSslError` | `AqutterIOSSslError` | 僅加前綴 |
| `IOSUIModalPresentationStyle` | `AqutterIOSUIModalPresentationStyle` | 僅加前綴 |
| `IOSUIModalTransitionStyle` | `AqutterIOSUIModalTransitionStyle` | 僅加前綴 |
| `IOSUIScrollViewContentInsetAdjustmentBehavior` | `AqutterIOSUIScrollViewContentInsetAdjustmentBehavior` | 僅加前綴 |
| `IOSUIScrollViewDecelerationRate` | `AqutterIOSUIScrollViewDecelerationRate` | 僅加前綴 |
| `IOSURLCredentialPersistence` | `AqutterIOSURLCredentialPersistence` | 僅加前綴 |
| `IOSURLRequestCachePolicy` | `AqutterIOSURLRequestCachePolicy` | 僅加前綴 |
| `IOSURLRequestNetworkServiceType` | `AqutterIOSURLRequestNetworkServiceType` | 僅加前綴 |
| `IOSURLResponse` | `AqutterIOSURLResponse` | 僅加前綴 |
| `IOSWKDataDetectorTypes` | `AqutterIOSWKDataDetectorTypes` | 僅加前綴 |
| `IOSWKFrameInfo` | `AqutterIOSWKFrameInfo` | 僅加前綴 |
| `IOSWKNavigationResponse` | `AqutterIOSWKNavigationResponse` | 僅加前綴 |
| `IOSWKNavigationType` | `AqutterIOSWKNavigationType` | 僅加前綴 |
| `IOSWKPDFConfiguration` | `AqutterIOSWKPDFConfiguration` | 僅加前綴 |
| `IOSWKSecurityOrigin` | `AqutterIOSWKSecurityOrigin` | 僅加前綴 |
| `IOSWKSelectionGranularity` | `AqutterIOSWKSelectionGranularity` | 僅加前綴 |
| `IOSWKWebsiteDataRecord` | `AqutterIOSWKWebsiteDataRecord` | 僅加前綴 |
| `IOSWKWebsiteDataType` | `AqutterIOSWKWebsiteDataType` | 僅加前綴 |
| `IOSWKWindowFeatures` | `AqutterIOSWKWindowFeatures` | 僅加前綴 |
| `IOSWebStorageManager` | `AqutterIOSWebStorageManager` | 實作層有同名類別，實作層維持原名 |
| `IWebMessagePort` | `AqutterIWebMessagePort` | 僅加前綴 |
| `InAppBrowser` | `AqutterBrowser` | 移除 InApp |
| `InAppBrowserClassOptions` | `AqutterBrowserClassOptions` | 移除 InApp |
| `InAppBrowserClassSettings` | `AqutterBrowserClassSettings` | 移除 InApp |
| `InAppBrowserMenuItem` | `AqutterBrowserMenuItem` | 移除 InApp |
| `InAppBrowserOptions` | `AqutterInAppBrowserOptions` | 舊式子類例外：保留 InApp |
| `InAppBrowserSettings` | `AqutterBrowserSettings` | 移除 InApp |
| `InAppBrowserSettingsProperty` | `AqutterBrowserSettingsProperty` | 移除 InApp |
| `InAppLocalhostServer` | `AqutterLocalhostServer` | 移除 InApp |
| `InAppWebView` | `AqutterWebView` | 移除 InApp |
| `InAppWebViewController` | `AqutterWebViewController` | 移除 InApp |
| `InAppWebViewControllerKeepAliveProps` | `AqutterWebViewControllerKeepAliveProps` | 移除 InApp |
| `InAppWebViewGroupOptions` | `AqutterWebViewGroupOptions` | 移除 InApp |
| `InAppWebViewHitTestResult` | `AqutterWebViewHitTestResult` | 移除 InApp |
| `InAppWebViewHitTestResultType` | `AqutterWebViewHitTestResultType` | 移除 InApp |
| `InAppWebViewInitialData` | `AqutterWebViewInitialData` | 移除 InApp |
| `InAppWebViewKeepAlive` | `AqutterWebViewKeepAlive` | 移除 InApp |
| `InAppWebViewOptions` | `AqutterInAppWebViewOptions` | 舊式子類例外：保留 InApp |
| `InAppWebViewPlatform` | `AqutterWebViewPlatform` | 移除 InApp |
| `InAppWebViewRect` | `AqutterWebViewRect` | 移除 InApp |
| `InAppWebViewSettings` | `AqutterWebViewSettings` | 移除 InApp |
| `InAppWebViewSettingsProperty` | `AqutterWebViewSettingsProperty` | 移除 InApp |
| `InternalStoragePathHandler` | `AqutterInternalStoragePathHandler` | 僅加前綴 |
| `IosOptions` | `AqutterIosOptions` | 僅加前綴 |
| `JavaScriptHandlerCallback` | `AqutterJavaScriptHandlerCallback` | 僅加前綴 |
| `JavaScriptHandlerFunction` | `AqutterJavaScriptHandlerFunction` | 僅加前綴 |
| `JavaScriptHandlerFunctionData` | `AqutterJavaScriptHandlerFunctionData` | 僅加前綴 |
| `JavaScriptReplyProxy` | `AqutterJavaScriptReplyProxy` | 僅加前綴 |
| `JsAlertRequest` | `AqutterJsAlertRequest` | 僅加前綴 |
| `JsAlertResponse` | `AqutterJsAlertResponse` | 僅加前綴 |
| `JsAlertResponseAction` | `AqutterJsAlertResponseAction` | 僅加前綴 |
| `JsBeforeUnloadRequest` | `AqutterJsBeforeUnloadRequest` | 僅加前綴 |
| `JsBeforeUnloadResponse` | `AqutterJsBeforeUnloadResponse` | 僅加前綴 |
| `JsBeforeUnloadResponseAction` | `AqutterJsBeforeUnloadResponseAction` | 僅加前綴 |
| `JsConfirmRequest` | `AqutterJsConfirmRequest` | 僅加前綴 |
| `JsConfirmResponse` | `AqutterJsConfirmResponse` | 僅加前綴 |
| `JsConfirmResponseAction` | `AqutterJsConfirmResponseAction` | 僅加前綴 |
| `JsPromptRequest` | `AqutterJsPromptRequest` | 僅加前綴 |
| `JsPromptResponse` | `AqutterJsPromptResponse` | 僅加前綴 |
| `JsPromptResponseAction` | `AqutterJsPromptResponseAction` | 僅加前綴 |
| `KeyUsage` | `AqutterKeyUsage` | 僅加前綴 |
| `LaunchingExternalUriSchemeRequest` | `AqutterLaunchingExternalUriSchemeRequest` | 僅加前綴 |
| `LaunchingExternalUriSchemeResponse` | `AqutterLaunchingExternalUriSchemeResponse` | 僅加前綴 |
| `LayoutAlgorithm` | `AqutterLayoutAlgorithm` | 僅加前綴 |
| `LayoutInDisplayCutoutMode` | `AqutterLayoutInDisplayCutoutMode` | 僅加前綴 |
| `LoadedResource` | `AqutterLoadedResource` | 僅加前綴 |
| `LocalStorage` | `AqutterLocalStorage` | 僅加前綴 |
| `LoginRequest` | `AqutterLoginRequest` | 僅加前綴 |
| `MediaCaptureState` | `AqutterMediaCaptureState` | 僅加前綴 |
| `MediaPlaybackState` | `AqutterMediaPlaybackState` | 僅加前綴 |
| `MemoryUsageTargetLevel` | `AqutterMemoryUsageTargetLevel` | 僅加前綴 |
| `MetaTag` | `AqutterMetaTag` | 僅加前綴 |
| `MetaTagAttribute` | `AqutterMetaTagAttribute` | 僅加前綴 |
| `MimeTypeResolver` | `AqutterMimeTypeResolver` | 僅加前綴 |
| `MixedContentMode` | `AqutterMixedContentMode` | 僅加前綴 |
| `ModalPresentationStyle` | `AqutterModalPresentationStyle` | 僅加前綴 |
| `ModalTransitionStyle` | `AqutterModalTransitionStyle` | 僅加前綴 |
| `NavigationAction` | `AqutterNavigationAction` | 僅加前綴 |
| `NavigationActionPolicy` | `AqutterNavigationActionPolicy` | 僅加前綴 |
| `NavigationResponse` | `AqutterNavigationResponse` | 僅加前綴 |
| `NavigationResponseAction` | `AqutterNavigationResponseAction` | 僅加前綴 |
| `NavigationType` | `AqutterNavigationType` | 僅加前綴 |
| `NotificationReceivedRequest` | `AqutterNotificationReceivedRequest` | 僅加前綴 |
| `NotificationReceivedResponse` | `AqutterNotificationReceivedResponse` | 僅加前綴 |
| `OID` | `AqutterOID` | 僅加前綴 |
| `OnPostMessageCallback` | `AqutterOnPostMessageCallback` | 僅加前綴 |
| `OverScrollMode` | `AqutterOverScrollMode` | 僅加前綴 |
| `PDFConfiguration` | `AqutterPDFConfiguration` | 僅加前綴 |
| `PathHandler` | `AqutterPathHandler` | 僅加前綴 |
| `PdfToolbarItems` | `AqutterPdfToolbarItems` | 僅加前綴 |
| `PermissionRequest` | `AqutterPermissionRequest` | 僅加前綴 |
| `PermissionRequestResponse` | `AqutterPermissionRequestResponse` | 僅加前綴 |
| `PermissionRequestResponseAction` | `AqutterPermissionRequestResponseAction` | 僅加前綴 |
| `PermissionResourceType` | `AqutterPermissionResourceType` | 僅加前綴 |
| `PermissionResponse` | `AqutterPermissionResponse` | 僅加前綴 |
| `PermissionResponseAction` | `AqutterPermissionResponseAction` | 僅加前綴 |
| `PhysicalKeyStatus` | `AqutterPhysicalKeyStatus` | 僅加前綴 |
| `PlatformAssetsPathHandler` | `AqutterPlatformAssetsPathHandler` | 僅加前綴 |
| `PlatformAssetsPathHandlerCreationParams` | `AqutterPlatformAssetsPathHandlerCreationParams` | 僅加前綴 |
| `PlatformChromeSafariBrowser` | `AqutterPlatformChromeSafariBrowser` | 僅加前綴 |
| `PlatformChromeSafariBrowserCreationParams` | `AqutterPlatformChromeSafariBrowserCreationParams` | 僅加前綴 |
| `PlatformChromeSafariBrowserEvents` | `AqutterPlatformChromeSafariBrowserEvents` | 僅加前綴 |
| `PlatformChromeSafariBrowserEventsMethod` | `AqutterPlatformChromeSafariBrowserEventsMethod` | 僅加前綴 |
| `PlatformChromeSafariBrowserMethod` | `AqutterPlatformChromeSafariBrowserMethod` | 僅加前綴 |
| `PlatformCookieManager` | `AqutterPlatformCookieManager` | 僅加前綴 |
| `PlatformCookieManagerCreationParams` | `AqutterPlatformCookieManagerCreationParams` | 僅加前綴 |
| `PlatformCookieManagerCreationParamsProperty` | `AqutterPlatformCookieManagerCreationParamsProperty` | 僅加前綴 |
| `PlatformCookieManagerMethod` | `AqutterPlatformCookieManagerMethod` | 僅加前綴 |
| `PlatformCustomPathHandler` | `AqutterPlatformCustomPathHandler` | 僅加前綴 |
| `PlatformCustomPathHandlerCreationParams` | `AqutterPlatformCustomPathHandlerCreationParams` | 僅加前綴 |
| `PlatformFindInteractionController` | `AqutterPlatformFindInteractionController` | 僅加前綴 |
| `PlatformFindInteractionControllerCreationParams` | `AqutterPlatformFindInteractionControllerCreationParams` | 僅加前綴 |
| `PlatformFindInteractionControllerCreationParamsProperty` | `AqutterPlatformFindInteractionControllerCreationParamsProperty` | 僅加前綴 |
| `PlatformFindInteractionControllerMethod` | `AqutterPlatformFindInteractionControllerMethod` | 僅加前綴 |
| `PlatformHeadlessInAppWebView` | `AqutterPlatformHeadlessWebView` | 移除 InApp |
| `PlatformHeadlessInAppWebViewCreationParams` | `AqutterPlatformHeadlessWebViewCreationParams` | 移除 InApp |
| `PlatformHeadlessInAppWebViewCreationParamsProperty` | `AqutterPlatformHeadlessWebViewCreationParamsProperty` | 移除 InApp |
| `PlatformHeadlessInAppWebViewMethod` | `AqutterPlatformHeadlessWebViewMethod` | 移除 InApp |
| `PlatformHttpAuthCredentialDatabase` | `AqutterPlatformHttpAuthCredentialDatabase` | 僅加前綴 |
| `PlatformHttpAuthCredentialDatabaseCreationParams` | `AqutterPlatformHttpAuthCredentialDatabaseCreationParams` | 僅加前綴 |
| `PlatformHttpAuthCredentialDatabaseMethod` | `AqutterPlatformHttpAuthCredentialDatabaseMethod` | 僅加前綴 |
| `PlatformInAppBrowser` | `AqutterPlatformBrowser` | 移除 InApp |
| `PlatformInAppBrowserCreationParams` | `AqutterPlatformBrowserCreationParams` | 移除 InApp |
| `PlatformInAppBrowserEvents` | `AqutterPlatformBrowserEvents` | 移除 InApp |
| `PlatformInAppBrowserEventsMethod` | `AqutterPlatformBrowserEventsMethod` | 移除 InApp |
| `PlatformInAppBrowserMethod` | `AqutterPlatformBrowserMethod` | 移除 InApp |
| `PlatformInAppBrowserProperty` | `AqutterPlatformBrowserProperty` | 移除 InApp |
| `PlatformInAppLocalhostServer` | `AqutterPlatformLocalhostServer` | 移除 InApp |
| `PlatformInAppLocalhostServerCreationParams` | `AqutterPlatformLocalhostServerCreationParams` | 移除 InApp |
| `PlatformInAppLocalhostServerMethod` | `AqutterPlatformLocalhostServerMethod` | 移除 InApp |
| `PlatformInAppWebViewController` | `AqutterPlatformWebViewController` | 移除 InApp |
| `PlatformInAppWebViewControllerCreationParams` | `AqutterPlatformWebViewControllerCreationParams` | 移除 InApp |
| `PlatformInAppWebViewControllerMethod` | `AqutterPlatformWebViewControllerMethod` | 移除 InApp |
| `PlatformInAppWebViewControllerProperty` | `AqutterPlatformWebViewControllerProperty` | 移除 InApp |
| `PlatformInAppWebViewWidget` | `AqutterPlatformWebViewWidget` | 移除 InApp |
| `PlatformInAppWebViewWidgetCreationParams` | `AqutterPlatformWebViewWidgetCreationParams` | 移除 InApp |
| `PlatformInAppWebViewWidgetCreationParamsProperty` | `AqutterPlatformWebViewWidgetCreationParamsProperty` | 移除 InApp |
| `PlatformInternalStoragePathHandler` | `AqutterPlatformInternalStoragePathHandler` | 僅加前綴 |
| `PlatformInternalStoragePathHandlerCreationParams` | `AqutterPlatformInternalStoragePathHandlerCreationParams` | 僅加前綴 |
| `PlatformJavaScriptReplyProxy` | `AqutterPlatformJavaScriptReplyProxy` | 僅加前綴 |
| `PlatformJavaScriptReplyProxyCreationParams` | `AqutterPlatformJavaScriptReplyProxyCreationParams` | 僅加前綴 |
| `PlatformLocalStorage` | `AqutterPlatformLocalStorage` | 僅加前綴 |
| `PlatformLocalStorageCreationParams` | `AqutterPlatformLocalStorageCreationParams` | 僅加前綴 |
| `PlatformLocalStorageMethod` | `AqutterPlatformLocalStorageMethod` | 僅加前綴 |
| `PlatformPathHandler` | `AqutterPlatformPathHandler` | 僅加前綴 |
| `PlatformPathHandlerCreationParams` | `AqutterPlatformPathHandlerCreationParams` | 僅加前綴 |
| `PlatformPathHandlerEvents` | `AqutterPlatformPathHandlerEvents` | 僅加前綴 |
| `PlatformPrintJobController` | `AqutterPlatformPrintJobController` | 僅加前綴 |
| `PlatformPrintJobControllerCreationParams` | `AqutterPlatformPrintJobControllerCreationParams` | 僅加前綴 |
| `PlatformPrintJobControllerCreationParamsProperty` | `AqutterPlatformPrintJobControllerCreationParamsProperty` | 僅加前綴 |
| `PlatformPrintJobControllerMethod` | `AqutterPlatformPrintJobControllerMethod` | 僅加前綴 |
| `PlatformPrintJobControllerProperty` | `AqutterPlatformPrintJobControllerProperty` | 僅加前綴 |
| `PlatformProcessGlobalConfig` | `AqutterPlatformProcessGlobalConfig` | 僅加前綴 |
| `PlatformProcessGlobalConfigCreationParams` | `AqutterPlatformProcessGlobalConfigCreationParams` | 僅加前綴 |
| `PlatformProcessGlobalConfigMethod` | `AqutterPlatformProcessGlobalConfigMethod` | 僅加前綴 |
| `PlatformProxyController` | `AqutterPlatformProxyController` | 僅加前綴 |
| `PlatformProxyControllerCreationParams` | `AqutterPlatformProxyControllerCreationParams` | 僅加前綴 |
| `PlatformProxyControllerMethod` | `AqutterPlatformProxyControllerMethod` | 僅加前綴 |
| `PlatformPullToRefreshController` | `AqutterPlatformPullToRefreshController` | 僅加前綴 |
| `PlatformPullToRefreshControllerCreationParams` | `AqutterPlatformPullToRefreshControllerCreationParams` | 僅加前綴 |
| `PlatformPullToRefreshControllerCreationParamsProperty` | `AqutterPlatformPullToRefreshControllerCreationParamsProperty` | 僅加前綴 |
| `PlatformPullToRefreshControllerMethod` | `AqutterPlatformPullToRefreshControllerMethod` | 僅加前綴 |
| `PlatformResourcesPathHandler` | `AqutterPlatformResourcesPathHandler` | 僅加前綴 |
| `PlatformResourcesPathHandlerCreationParams` | `AqutterPlatformResourcesPathHandlerCreationParams` | 僅加前綴 |
| `PlatformServiceWorkerController` | `AqutterPlatformServiceWorkerController` | 僅加前綴 |
| `PlatformServiceWorkerControllerCreationParams` | `AqutterPlatformServiceWorkerControllerCreationParams` | 僅加前綴 |
| `PlatformServiceWorkerControllerMethod` | `AqutterPlatformServiceWorkerControllerMethod` | 僅加前綴 |
| `PlatformSessionStorage` | `AqutterPlatformSessionStorage` | 僅加前綴 |
| `PlatformSessionStorageCreationParams` | `AqutterPlatformSessionStorageCreationParams` | 僅加前綴 |
| `PlatformSessionStorageMethod` | `AqutterPlatformSessionStorageMethod` | 僅加前綴 |
| `PlatformStorage` | `AqutterPlatformStorage` | 僅加前綴 |
| `PlatformStorageCreationParams` | `AqutterPlatformStorageCreationParams` | 僅加前綴 |
| `PlatformStorageCreationParamsProperty` | `AqutterPlatformStorageCreationParamsProperty` | 僅加前綴 |
| `PlatformTracingController` | `AqutterPlatformTracingController` | 僅加前綴 |
| `PlatformTracingControllerCreationParams` | `AqutterPlatformTracingControllerCreationParams` | 僅加前綴 |
| `PlatformTracingControllerMethod` | `AqutterPlatformTracingControllerMethod` | 僅加前綴 |
| `PlatformWebAuthenticationSession` | `AqutterPlatformWebAuthenticationSession` | 僅加前綴 |
| `PlatformWebAuthenticationSessionCreationParams` | `AqutterPlatformWebAuthenticationSessionCreationParams` | 僅加前綴 |
| `PlatformWebAuthenticationSessionMethod` | `AqutterPlatformWebAuthenticationSessionMethod` | 僅加前綴 |
| `PlatformWebAuthenticationSessionProperty` | `AqutterPlatformWebAuthenticationSessionProperty` | 僅加前綴 |
| `PlatformWebMessageChannel` | `AqutterPlatformWebMessageChannel` | 僅加前綴 |
| `PlatformWebMessageChannelCreationParams` | `AqutterPlatformWebMessageChannelCreationParams` | 僅加前綴 |
| `PlatformWebMessageChannelCreationParamsProperty` | `AqutterPlatformWebMessageChannelCreationParamsProperty` | 僅加前綴 |
| `PlatformWebMessageChannelMethod` | `AqutterPlatformWebMessageChannelMethod` | 僅加前綴 |
| `PlatformWebMessageListener` | `AqutterPlatformWebMessageListener` | 僅加前綴 |
| `PlatformWebMessageListenerCreationParams` | `AqutterPlatformWebMessageListenerCreationParams` | 僅加前綴 |
| `PlatformWebMessageListenerCreationParamsProperty` | `AqutterPlatformWebMessageListenerCreationParamsProperty` | 僅加前綴 |
| `PlatformWebMessageListenerMethod` | `AqutterPlatformWebMessageListenerMethod` | 僅加前綴 |
| `PlatformWebMessagePort` | `AqutterPlatformWebMessagePort` | 僅加前綴 |
| `PlatformWebMessagePortCreationParams` | `AqutterPlatformWebMessagePortCreationParams` | 僅加前綴 |
| `PlatformWebNotificationController` | `AqutterPlatformWebNotificationController` | 僅加前綴 |
| `PlatformWebNotificationControllerCreationParams` | `AqutterPlatformWebNotificationControllerCreationParams` | 僅加前綴 |
| `PlatformWebNotificationControllerCreationParamsProperty` | `AqutterPlatformWebNotificationControllerCreationParamsProperty` | 僅加前綴 |
| `PlatformWebNotificationControllerMethod` | `AqutterPlatformWebNotificationControllerMethod` | 僅加前綴 |
| `PlatformWebNotificationControllerProperty` | `AqutterPlatformWebNotificationControllerProperty` | 僅加前綴 |
| `PlatformWebStorage` | `AqutterPlatformWebStorage` | 僅加前綴 |
| `PlatformWebStorageCreationParams` | `AqutterPlatformWebStorageCreationParams` | 僅加前綴 |
| `PlatformWebStorageCreationParamsProperty` | `AqutterPlatformWebStorageCreationParamsProperty` | 僅加前綴 |
| `PlatformWebStorageManager` | `AqutterPlatformWebStorageManager` | 僅加前綴 |
| `PlatformWebStorageManagerCreationParams` | `AqutterPlatformWebStorageManagerCreationParams` | 僅加前綴 |
| `PlatformWebStorageManagerMethod` | `AqutterPlatformWebStorageManagerMethod` | 僅加前綴 |
| `PlatformWebStorageMethod` | `AqutterPlatformWebStorageMethod` | 僅加前綴 |
| `PlatformWebStorageProperty` | `AqutterPlatformWebStorageProperty` | 僅加前綴 |
| `PlatformWebViewCreationParams` | `AqutterPlatformWebViewCreationParams` | 僅加前綴 |
| `PlatformWebViewCreationParamsProperty` | `AqutterPlatformWebViewCreationParamsProperty` | 僅加前綴 |
| `PlatformWebViewEnvironment` | `AqutterPlatformWebViewEnvironment` | 僅加前綴 |
| `PlatformWebViewEnvironmentCreationParams` | `AqutterPlatformWebViewEnvironmentCreationParams` | 僅加前綴 |
| `PlatformWebViewEnvironmentCreationParamsProperty` | `AqutterPlatformWebViewEnvironmentCreationParamsProperty` | 僅加前綴 |
| `PlatformWebViewEnvironmentMethod` | `AqutterPlatformWebViewEnvironmentMethod` | 僅加前綴 |
| `PlatformWebViewEnvironmentProperty` | `AqutterPlatformWebViewEnvironmentProperty` | 僅加前綴 |
| `PlatformWebViewFeature` | `AqutterPlatformWebViewFeature` | 僅加前綴 |
| `PlatformWebViewFeatureCreationParams` | `AqutterPlatformWebViewFeatureCreationParams` | 僅加前綴 |
| `PlatformWebViewFeatureMethod` | `AqutterPlatformWebViewFeatureMethod` | 僅加前綴 |
| `PrewarmingToken` | `AqutterPrewarmingToken` | 僅加前綴 |
| `PrintJobAttributes` | `AqutterPrintJobAttributes` | 僅加前綴 |
| `PrintJobColorMode` | `AqutterPrintJobColorMode` | 僅加前綴 |
| `PrintJobCompletionHandler` | `AqutterPrintJobCompletionHandler` | 僅加前綴 |
| `PrintJobController` | `AqutterPrintJobController` | 僅加前綴 |
| `PrintJobDialogKind` | `AqutterPrintJobDialogKind` | 僅加前綴 |
| `PrintJobDisposition` | `AqutterPrintJobDisposition` | 僅加前綴 |
| `PrintJobDuplexMode` | `AqutterPrintJobDuplexMode` | 僅加前綴 |
| `PrintJobInfo` | `AqutterPrintJobInfo` | 僅加前綴 |
| `PrintJobMediaSize` | `AqutterPrintJobMediaSize` | 僅加前綴 |
| `PrintJobOrientation` | `AqutterPrintJobOrientation` | 僅加前綴 |
| `PrintJobOutputType` | `AqutterPrintJobOutputType` | 僅加前綴 |
| `PrintJobPageOrder` | `AqutterPrintJobPageOrder` | 僅加前綴 |
| `PrintJobPaginationMode` | `AqutterPrintJobPaginationMode` | 僅加前綴 |
| `PrintJobRenderingQuality` | `AqutterPrintJobRenderingQuality` | 僅加前綴 |
| `PrintJobResolution` | `AqutterPrintJobResolution` | 僅加前綴 |
| `PrintJobSettings` | `AqutterPrintJobSettings` | 僅加前綴 |
| `PrintJobSettingsProperty` | `AqutterPrintJobSettingsProperty` | 僅加前綴 |
| `PrintJobState` | `AqutterPrintJobState` | 僅加前綴 |
| `Printer` | `AqutterPrinter` | 僅加前綴 |
| `ProcessFailedDetail` | `AqutterProcessFailedDetail` | 僅加前綴 |
| `ProcessFailedKind` | `AqutterProcessFailedKind` | 僅加前綴 |
| `ProcessFailedReason` | `AqutterProcessFailedReason` | 僅加前綴 |
| `ProcessGlobalConfig` | `AqutterProcessGlobalConfig` | 僅加前綴 |
| `ProcessGlobalConfigDirectoryBasePaths` | `AqutterProcessGlobalConfigDirectoryBasePaths` | 僅加前綴 |
| `ProcessGlobalConfigSettings` | `AqutterProcessGlobalConfigSettings` | 僅加前綴 |
| `ProcessGlobalConfigSettingsProperty` | `AqutterProcessGlobalConfigSettingsProperty` | 僅加前綴 |
| `ProxyController` | `AqutterProxyController` | 僅加前綴 |
| `ProxyRelayHop` | `AqutterProxyRelayHop` | 僅加前綴 |
| `ProxyRule` | `AqutterProxyRule` | 僅加前綴 |
| `ProxySchemeFilter` | `AqutterProxySchemeFilter` | 僅加前綴 |
| `ProxySettings` | `AqutterProxySettings` | 僅加前綴 |
| `ProxySettingsProperty` | `AqutterProxySettingsProperty` | 僅加前綴 |
| `PullToRefreshController` | `AqutterPullToRefreshController` | 僅加前綴 |
| `PullToRefreshOptions` | `AqutterPullToRefreshOptions` | 僅加前綴 |
| `PullToRefreshSettings` | `AqutterPullToRefreshSettings` | 僅加前綴 |
| `PullToRefreshSettingsProperty` | `AqutterPullToRefreshSettingsProperty` | 僅加前綴 |
| `PullToRefreshSize` | `AqutterPullToRefreshSize` | 僅加前綴 |
| `ReferrerPolicy` | `AqutterReferrerPolicy` | 僅加前綴 |
| `RenderProcessGoneDetail` | `AqutterRenderProcessGoneDetail` | 僅加前綴 |
| `RendererPriority` | `AqutterRendererPriority` | 僅加前綴 |
| `RendererPriorityPolicy` | `AqutterRendererPriorityPolicy` | 僅加前綴 |
| `RequestFocusNodeHrefResult` | `AqutterRequestFocusNodeHrefResult` | 僅加前綴 |
| `RequestImageRefResult` | `AqutterRequestImageRefResult` | 僅加前綴 |
| `ResourcesPathHandler` | `AqutterResourcesPathHandler` | 僅加前綴 |
| `SafeBrowsingResponse` | `AqutterSafeBrowsingResponse` | 僅加前綴 |
| `SafeBrowsingResponseAction` | `AqutterSafeBrowsingResponseAction` | 僅加前綴 |
| `SafeBrowsingThreat` | `AqutterSafeBrowsingThreat` | 僅加前綴 |
| `Sandbox` | `AqutterSandbox` | 僅加前綴 |
| `SaveAsKind` | `AqutterSaveAsKind` | 僅加前綴 |
| `SaveAsUIResult` | `AqutterSaveAsUIResult` | 僅加前綴 |
| `SaveAsUIShowingRequest` | `AqutterSaveAsUIShowingRequest` | 僅加前綴 |
| `SaveAsUIShowingResponse` | `AqutterSaveAsUIShowingResponse` | 僅加前綴 |
| `SaveFileSecurityCheckStartingRequest` | `AqutterSaveFileSecurityCheckStartingRequest` | 僅加前綴 |
| `SaveFileSecurityCheckStartingResponse` | `AqutterSaveFileSecurityCheckStartingResponse` | 僅加前綴 |
| `ScreenCaptureStartingRequest` | `AqutterScreenCaptureStartingRequest` | 僅加前綴 |
| `ScreenCaptureStartingResponse` | `AqutterScreenCaptureStartingResponse` | 僅加前綴 |
| `ScreenshotConfiguration` | `AqutterScreenshotConfiguration` | 僅加前綴 |
| `ScriptHtmlTagAttributes` | `AqutterScriptHtmlTagAttributes` | 僅加前綴 |
| `ScrollBarStyle` | `AqutterScrollBarStyle` | 僅加前綴 |
| `ScrollViewContentInsetAdjustmentBehavior` | `AqutterScrollViewContentInsetAdjustmentBehavior` | 僅加前綴 |
| `ScrollViewDecelerationRate` | `AqutterScrollViewDecelerationRate` | 僅加前綴 |
| `SearchResultDisplayStyle` | `AqutterSearchResultDisplayStyle` | 僅加前綴 |
| `SecurityOrigin` | `AqutterSecurityOrigin` | 僅加前綴 |
| `SelectionGranularity` | `AqutterSelectionGranularity` | 僅加前綴 |
| `ServerTrustAuthResponse` | `AqutterServerTrustAuthResponse` | 僅加前綴 |
| `ServerTrustAuthResponseAction` | `AqutterServerTrustAuthResponseAction` | 僅加前綴 |
| `ServerTrustChallenge` | `AqutterServerTrustChallenge` | 僅加前綴 |
| `ServiceWorkerClient` | `AqutterServiceWorkerClient` | 僅加前綴 |
| `ServiceWorkerClientProperty` | `AqutterServiceWorkerClientProperty` | 僅加前綴 |
| `ServiceWorkerController` | `AqutterServiceWorkerController` | 僅加前綴 |
| `SessionStorage` | `AqutterSessionStorage` | 僅加前綴 |
| `ShouldAllowDeprecatedTLSAction` | `AqutterShouldAllowDeprecatedTLSAction` | 僅加前綴 |
| `ShowFileChooserRequest` | `AqutterShowFileChooserRequest` | 僅加前綴 |
| `ShowFileChooserRequestMode` | `AqutterShowFileChooserRequestMode` | 僅加前綴 |
| `ShowFileChooserResponse` | `AqutterShowFileChooserResponse` | 僅加前綴 |
| `SslCertificate` | `AqutterSslCertificate` | 僅加前綴 |
| `SslCertificateDName` | `AqutterSslCertificateDName` | 僅加前綴 |
| `SslError` | `AqutterSslError` | 僅加前綴 |
| `SslErrorType` | `AqutterSslErrorType` | 僅加前綴 |
| `Storage` | `AqutterStorage` | 僅加前綴 |
| `SubjectKeyIdentifierExtension` | `AqutterSubjectKeyIdentifierExtension` | 僅加前綴 |
| `TextDirectionKind` | `AqutterTextDirectionKind` | 僅加前綴 |
| `TracingCategory` | `AqutterTracingCategory` | 僅加前綴 |
| `TracingController` | `AqutterTracingController` | 僅加前綴 |
| `TracingMode` | `AqutterTracingMode` | 僅加前綴 |
| `TracingSettings` | `AqutterTracingSettings` | 僅加前綴 |
| `TracingSettingsProperty` | `AqutterTracingSettingsProperty` | 僅加前綴 |
| `TrustedWebActivityDefaultDisplayMode` | `AqutterTrustedWebActivityDefaultDisplayMode` | 僅加前綴 |
| `TrustedWebActivityDisplayMode` | `AqutterTrustedWebActivityDisplayMode` | 僅加前綴 |
| `TrustedWebActivityImmersiveDisplayMode` | `AqutterTrustedWebActivityImmersiveDisplayMode` | 僅加前綴 |
| `TrustedWebActivityScreenOrientation` | `AqutterTrustedWebActivityScreenOrientation` | 僅加前綴 |
| `UIEventAttribution` | `AqutterUIEventAttribution` | 僅加前綴 |
| `UIImage` | `AqutterUIImage` | 僅加前綴 |
| `URLAuthenticationChallenge` | `AqutterURLAuthenticationChallenge` | 僅加前綴 |
| `URLCredential` | `AqutterURLCredential` | 僅加前綴 |
| `URLCredentialPersistence` | `AqutterURLCredentialPersistence` | 僅加前綴 |
| `URLProtectionSpace` | `AqutterURLProtectionSpace` | 僅加前綴 |
| `URLProtectionSpaceAuthenticationMethod` | `AqutterURLProtectionSpaceAuthenticationMethod` | 僅加前綴 |
| `URLProtectionSpaceHttpAuthCredentials` | `AqutterURLProtectionSpaceHttpAuthCredentials` | 僅加前綴 |
| `URLProtectionSpaceProxyType` | `AqutterURLProtectionSpaceProxyType` | 僅加前綴 |
| `URLRequest` | `AqutterURLRequest` | 僅加前綴 |
| `URLRequestAttribution` | `AqutterURLRequestAttribution` | 僅加前綴 |
| `URLRequestCachePolicy` | `AqutterURLRequestCachePolicy` | 僅加前綴 |
| `URLRequestNetworkServiceType` | `AqutterURLRequestNetworkServiceType` | 僅加前綴 |
| `URLResponse` | `AqutterURLResponse` | 僅加前綴 |
| `UnderlineStyle` | `AqutterUnderlineStyle` | 僅加前綴 |
| `UserPreferredContentMode` | `AqutterUserPreferredContentMode` | 僅加前綴 |
| `UserScript` | `AqutterUserScript` | 僅加前綴 |
| `UserScriptInjectionTime` | `AqutterUserScriptInjectionTime` | 僅加前綴 |
| `VerticalScrollbarPosition` | `AqutterVerticalScrollbarPosition` | 僅加前綴 |
| `WebArchiveFormat` | `AqutterWebArchiveFormat` | 僅加前綴 |
| `WebAuthenticationSession` | `AqutterWebAuthenticationSession` | 僅加前綴 |
| `WebAuthenticationSessionCompletionHandler` | `AqutterWebAuthenticationSessionCompletionHandler` | 僅加前綴 |
| `WebAuthenticationSessionError` | `AqutterWebAuthenticationSessionError` | 僅加前綴 |
| `WebAuthenticationSessionSettings` | `AqutterWebAuthenticationSessionSettings` | 僅加前綴 |
| `WebAuthenticationSessionSettingsProperty` | `AqutterWebAuthenticationSessionSettingsProperty` | 僅加前綴 |
| `WebHistory` | `AqutterWebHistory` | 僅加前綴 |
| `WebHistoryItem` | `AqutterWebHistoryItem` | 僅加前綴 |
| `WebMessage` | `AqutterWebMessage` | 僅加前綴 |
| `WebMessageCallback` | `AqutterWebMessageCallback` | 僅加前綴 |
| `WebMessageChannel` | `AqutterWebMessageChannel` | 僅加前綴 |
| `WebMessageListener` | `AqutterWebMessageListener` | 僅加前綴 |
| `WebMessagePort` | `AqutterWebMessagePort` | 僅加前綴 |
| `WebMessageType` | `AqutterWebMessageType` | 僅加前綴 |
| `WebNotification` | `AqutterWebNotification` | 僅加前綴 |
| `WebNotificationCloseHandler` | `AqutterWebNotificationCloseHandler` | 僅加前綴 |
| `WebNotificationController` | `AqutterWebNotificationController` | 僅加前綴 |
| `WebResourceContext` | `AqutterWebResourceContext` | 僅加前綴 |
| `WebResourceError` | `AqutterWebResourceError` | 僅加前綴 |
| `WebResourceErrorType` | `AqutterWebResourceErrorType` | 僅加前綴 |
| `WebResourceRequest` | `AqutterWebResourceRequest` | 僅加前綴 |
| `WebResourceRequestSourceKind` | `AqutterWebResourceRequestSourceKind` | 僅加前綴 |
| `WebResourceResponse` | `AqutterWebResourceResponse` | 僅加前綴 |
| `WebStorage` | `AqutterWebStorage` | 僅加前綴 |
| `WebStorageItem` | `AqutterWebStorageItem` | 僅加前綴 |
| `WebStorageManager` | `AqutterWebStorageManager` | 僅加前綴 |
| `WebStorageOrigin` | `AqutterWebStorageOrigin` | 僅加前綴 |
| `WebStorageType` | `AqutterWebStorageType` | 僅加前綴 |
| `WebUri` | `AqutterWebUri` | 僅加前綴 |
| `WebViewAssetLoader` | `AqutterWebViewAssetLoader` | 僅加前綴 |
| `WebViewEnvironment` | `AqutterWebViewEnvironment` | 僅加前綴 |
| `WebViewEnvironmentSettings` | `AqutterWebViewEnvironmentSettings` | 僅加前綴 |
| `WebViewEnvironmentSettingsProperty` | `AqutterWebViewEnvironmentSettingsProperty` | 僅加前綴 |
| `WebViewFeature` | `AqutterWebViewFeature` | 僅加前綴 |
| `WebViewInterface` | `AqutterWebViewInterface` | 僅加前綴 |
| `WebViewOptions` | `AqutterWebViewOptions` | 僅加前綴 |
| `WebViewPackageInfo` | `AqutterWebViewPackageInfo` | 僅加前綴 |
| `WebViewRenderProcessAction` | `AqutterWebViewRenderProcessAction` | 僅加前綴 |
| `WebsiteDataRecord` | `AqutterWebsiteDataRecord` | 僅加前綴 |
| `WebsiteDataType` | `AqutterWebsiteDataType` | 僅加前綴 |
| `WindowFeatures` | `AqutterWindowFeatures` | 僅加前綴 |
| `WindowStyleMask` | `AqutterWindowStyleMask` | 僅加前綴 |
| `WindowTitlebarSeparatorStyle` | `AqutterWindowTitlebarSeparatorStyle` | 僅加前綴 |
| `WindowType` | `AqutterWindowType` | 僅加前綴 |
| `X509BlockPosition` | `AqutterX509BlockPosition` | 僅加前綴 |
| `X509Certificate` | `AqutterX509Certificate` | 僅加前綴 |
| `X509Extension` | `AqutterX509Extension` | 僅加前綴 |
| `X509PublicKey` | `AqutterX509PublicKey` | 僅加前綴 |

## 小寫識別字（43）

| 舊名 | 新名 |
|---|---|
| `_androidHeadlessInAppWebView` | `_androidHeadlessWebView` |
| `_getHeadlessInAppWebViewDefinition` | `_getHeadlessWebViewDefinition` |
| `_getInAppBrowserDefinition` | `_getBrowserDefinition` |
| `_getInAppWebViewControllerDefinition` | `_getWebViewControllerDefinition` |
| `_getInAppWebViewEventsDefinition` | `_getWebViewEventsDefinition` |
| `_inAppBrowser` | `_browser` |
| `_inAppBrowserEventHandler` | `_browserEventHandler` |
| `_iosHeadlessInAppWebView` | `_iosHeadlessWebView` |
| `_macosHeadlessInAppWebView` | `_macosHeadlessWebView` |
| `_windowsHeadlessInAppWebView` | `_windowsHeadlessWebView` |
| `buildInAppWebView` | `buildWebView` |
| `convertToInAppWebView` | `convertToWebView` |
| `createPlatformHeadlessInAppWebView` | `createPlatformHeadlessWebView` |
| `createPlatformHeadlessInAppWebViewStatic` | `createPlatformHeadlessWebViewStatic` |
| `createPlatformInAppBrowser` | `createPlatformBrowser` |
| `createPlatformInAppBrowserStatic` | `createPlatformBrowserStatic` |
| `createPlatformInAppLocalhostServer` | `createPlatformLocalhostServer` |
| `createPlatformInAppLocalhostServerStatic` | `createPlatformLocalhostServerStatic` |
| `createPlatformInAppWebViewController` | `createPlatformWebViewController` |
| `createPlatformInAppWebViewControllerStatic` | `createPlatformWebViewControllerStatic` |
| `createPlatformInAppWebViewWidget` | `createPlatformWebViewWidget` |
| `createPlatformInAppWebViewWidgetStatic` | `createPlatformWebViewWidgetStatic` |
| `defaultInAppWebViewSettings` | `defaultWebViewSettings` |
| `defaultInAppWebViewSettingsMap` | `defaultWebViewSettingsMap` |
| `fromInAppBrowser` | `fromBrowser` |
| `fromPlatformHeadlessInAppWebViewCreationParams` | `fromPlatformHeadlessWebViewCreationParams` |
| `fromPlatformInAppBrowserCreationParams` | `fromPlatformBrowserCreationParams` |
| `fromPlatformInAppLocalhostServerCreationParams` | `fromPlatformLocalhostServerCreationParams` |
| `fromPlatformInAppWebViewControllerCreationParams` | `fromPlatformWebViewControllerCreationParams` |
| `fromPlatformInAppWebViewWidgetCreationParams` | `fromPlatformWebViewWidgetCreationParams` |
| `hasInAppBrowserEventHandler` | `hasBrowserEventHandler` |
| `headlessInAppWebViewStatic` | `headlessWebViewStatic` |
| `inAppBrowser` | `browser` |
| `inAppBrowserClassOptions` | `browserClassOptions` |
| `inAppBrowserStatic` | `browserStatic` |
| `inAppLocalhostServer` | `localhostServer` |
| `inAppLocalhostServerStatic` | `localhostServerStatic` |
| `inAppWebView` | `webView` |
| `inAppWebViewController` | `webViewController` |
| `inAppWebViewControllerStatic` | `webViewControllerStatic` |
| `inAppWebViewGroupOptions` | `webViewGroupOptions` |
| `inAppWebViewManager` | `webViewManager` |
| `inAppWebViewWidgetStatic` | `webViewWidgetStatic` |

## 檔案與目錄路徑（111）

| 舊路徑 | 新路徑 |
|---|---|
| `lib/src/in_app_browser/in_app_browser.dart` | `lib/src/browser/browser.dart` |
| `lib/src/in_app_browser/main.dart` | `lib/src/browser/main.dart` |
| `lib/src/in_app_localhost_server.dart` | `lib/src/localhost_server.dart` |
| `lib/src/in_app_webview/_static_channel.dart` | `lib/src/webview/_static_channel.dart` |
| `lib/src/in_app_webview/android/in_app_webview_controller.dart` | `lib/src/webview/android/webview_controller.dart` |
| `lib/src/in_app_webview/android/main.dart` | `lib/src/webview/android/main.dart` |
| `lib/src/in_app_webview/apple/in_app_webview_controller.dart` | `lib/src/webview/apple/webview_controller.dart` |
| `lib/src/in_app_webview/apple/main.dart` | `lib/src/webview/apple/main.dart` |
| `lib/src/in_app_webview/headless_in_app_webview.dart` | `lib/src/webview/headless_webview.dart` |
| `lib/src/in_app_webview/in_app_webview.dart` | `lib/src/webview/webview.dart` |
| `lib/src/in_app_webview/in_app_webview_controller.dart` | `lib/src/webview/webview_controller.dart` |
| `lib/src/in_app_webview/main.dart` | `lib/src/webview/main.dart` |
| `lib/src/platform_interface/flutter_inappwebview_platform_interface.dart` | `lib/src/platform_interface/flutter_webview_platform_interface.dart` |
| `lib/src/platform_interface/src/in_app_browser/android/in_app_browser_options.dart` | `lib/src/platform_interface/src/browser/android/browser_options.dart` |
| `lib/src/platform_interface/src/in_app_browser/android/main.dart` | `lib/src/platform_interface/src/browser/android/main.dart` |
| `lib/src/platform_interface/src/in_app_browser/apple/in_app_browser_options.dart` | `lib/src/platform_interface/src/browser/apple/browser_options.dart` |
| `lib/src/platform_interface/src/in_app_browser/apple/main.dart` | `lib/src/platform_interface/src/browser/apple/main.dart` |
| `lib/src/platform_interface/src/in_app_browser/in_app_browser_menu_item.dart` | `lib/src/platform_interface/src/browser/browser_menu_item.dart` |
| `lib/src/platform_interface/src/in_app_browser/in_app_browser_menu_item.g.dart` | `lib/src/platform_interface/src/browser/browser_menu_item.g.dart` |
| `lib/src/platform_interface/src/in_app_browser/in_app_browser_settings.dart` | `lib/src/platform_interface/src/browser/browser_settings.dart` |
| `lib/src/platform_interface/src/in_app_browser/in_app_browser_settings.g.dart` | `lib/src/platform_interface/src/browser/browser_settings.g.dart` |
| `lib/src/platform_interface/src/in_app_browser/main.dart` | `lib/src/platform_interface/src/browser/main.dart` |
| `lib/src/platform_interface/src/in_app_browser/platform_in_app_browser.dart` | `lib/src/platform_interface/src/browser/platform_browser.dart` |
| `lib/src/platform_interface/src/in_app_browser/platform_in_app_browser.g.dart` | `lib/src/platform_interface/src/browser/platform_browser.g.dart` |
| `lib/src/platform_interface/src/in_app_localhost_server.dart` | `lib/src/platform_interface/src/localhost_server.dart` |
| `lib/src/platform_interface/src/in_app_webview/android/in_app_webview_options.dart` | `lib/src/platform_interface/src/webview/android/webview_options.dart` |
| `lib/src/platform_interface/src/in_app_webview/android/main.dart` | `lib/src/platform_interface/src/webview/android/main.dart` |
| `lib/src/platform_interface/src/in_app_webview/apple/in_app_webview_options.dart` | `lib/src/platform_interface/src/webview/apple/webview_options.dart` |
| `lib/src/platform_interface/src/in_app_webview/apple/main.dart` | `lib/src/platform_interface/src/webview/apple/main.dart` |
| `lib/src/platform_interface/src/in_app_webview/in_app_webview_keep_alive.dart` | `lib/src/platform_interface/src/webview/webview_keep_alive.dart` |
| `lib/src/platform_interface/src/in_app_webview/in_app_webview_settings.dart` | `lib/src/platform_interface/src/webview/webview_settings.dart` |
| `lib/src/platform_interface/src/in_app_webview/in_app_webview_settings.g.dart` | `lib/src/platform_interface/src/webview/webview_settings.g.dart` |
| `lib/src/platform_interface/src/in_app_webview/main.dart` | `lib/src/platform_interface/src/webview/main.dart` |
| `lib/src/platform_interface/src/in_app_webview/platform_headless_in_app_webview.dart` | `lib/src/platform_interface/src/webview/platform_headless_webview.dart` |
| `lib/src/platform_interface/src/in_app_webview/platform_headless_in_app_webview.g.dart` | `lib/src/platform_interface/src/webview/platform_headless_webview.g.dart` |
| `lib/src/platform_interface/src/in_app_webview/platform_inappwebview_controller.dart` | `lib/src/platform_interface/src/webview/platform_webview_controller.dart` |
| `lib/src/platform_interface/src/in_app_webview/platform_inappwebview_controller.g.dart` | `lib/src/platform_interface/src/webview/platform_webview_controller.g.dart` |
| `lib/src/platform_interface/src/in_app_webview/platform_inappwebview_widget.dart` | `lib/src/platform_interface/src/webview/platform_webview_widget.dart` |
| `lib/src/platform_interface/src/in_app_webview/platform_inappwebview_widget.g.dart` | `lib/src/platform_interface/src/webview/platform_webview_widget.g.dart` |
| `lib/src/platform_interface/src/in_app_webview/platform_webview.dart` | `lib/src/platform_interface/src/webview/platform_webview.dart` |
| `lib/src/platform_interface/src/in_app_webview/platform_webview.g.dart` | `lib/src/platform_interface/src/webview/platform_webview.g.dart` |
| `lib/src/platform_interface/src/inappwebview_platform.dart` | `lib/src/platform_interface/src/webview_platform.dart` |
| `lib/src/platform_interface/src/platform_in_app_localhost_server.dart` | `lib/src/platform_interface/src/platform_localhost_server.dart` |
| `lib/src/platform_interface/src/platform_in_app_localhost_server.g.dart` | `lib/src/platform_interface/src/platform_localhost_server.g.dart` |
| `lib/src/platform_interface/src/types/in_app_webview_hit_test_result.dart` | `lib/src/platform_interface/src/types/webview_hit_test_result.dart` |
| `lib/src/platform_interface/src/types/in_app_webview_hit_test_result.g.dart` | `lib/src/platform_interface/src/types/webview_hit_test_result.g.dart` |
| `lib/src/platform_interface/src/types/in_app_webview_hit_test_result_type.dart` | `lib/src/platform_interface/src/types/webview_hit_test_result_type.dart` |
| `lib/src/platform_interface/src/types/in_app_webview_hit_test_result_type.g.dart` | `lib/src/platform_interface/src/types/webview_hit_test_result_type.g.dart` |
| `lib/src/platform_interface/src/types/in_app_webview_initial_data.dart` | `lib/src/platform_interface/src/types/webview_initial_data.dart` |
| `lib/src/platform_interface/src/types/in_app_webview_initial_data.g.dart` | `lib/src/platform_interface/src/types/webview_initial_data.g.dart` |
| `lib/src/platform_interface/src/types/in_app_webview_rect.dart` | `lib/src/platform_interface/src/types/webview_rect.dart` |
| `lib/src/platform_interface/src/types/in_app_webview_rect.g.dart` | `lib/src/platform_interface/src/types/webview_rect.g.dart` |
| `lib/src/platforms/android/flutter_inappwebview_android.dart` | `lib/src/platforms/android/flutter_webview_android.dart` |
| `lib/src/platforms/android/src/in_app_browser/in_app_browser.dart` | `lib/src/platforms/android/src/browser/browser.dart` |
| `lib/src/platforms/android/src/in_app_browser/main.dart` | `lib/src/platforms/android/src/browser/main.dart` |
| `lib/src/platforms/android/src/in_app_webview/_static_channel.dart` | `lib/src/platforms/android/src/webview/_static_channel.dart` |
| `lib/src/platforms/android/src/in_app_webview/headless_in_app_webview.dart` | `lib/src/platforms/android/src/webview/headless_webview.dart` |
| `lib/src/platforms/android/src/in_app_webview/in_app_webview.dart` | `lib/src/platforms/android/src/webview/webview.dart` |
| `lib/src/platforms/android/src/in_app_webview/in_app_webview_controller.dart` | `lib/src/platforms/android/src/webview/webview_controller.dart` |
| `lib/src/platforms/android/src/in_app_webview/main.dart` | `lib/src/platforms/android/src/webview/main.dart` |
| `lib/src/platforms/android/src/inappwebview_platform.dart` | `lib/src/platforms/android/src/webview_platform.dart` |
| `lib/src/platforms/ios/flutter_inappwebview_ios.dart` | `lib/src/platforms/ios/flutter_webview_ios.dart` |
| `lib/src/platforms/ios/src/in_app_browser/in_app_browser.dart` | `lib/src/platforms/ios/src/browser/browser.dart` |
| `lib/src/platforms/ios/src/in_app_browser/main.dart` | `lib/src/platforms/ios/src/browser/main.dart` |
| `lib/src/platforms/ios/src/in_app_webview/_static_channel.dart` | `lib/src/platforms/ios/src/webview/_static_channel.dart` |
| `lib/src/platforms/ios/src/in_app_webview/headless_in_app_webview.dart` | `lib/src/platforms/ios/src/webview/headless_webview.dart` |
| `lib/src/platforms/ios/src/in_app_webview/in_app_webview.dart` | `lib/src/platforms/ios/src/webview/webview.dart` |
| `lib/src/platforms/ios/src/in_app_webview/in_app_webview_controller.dart` | `lib/src/platforms/ios/src/webview/webview_controller.dart` |
| `lib/src/platforms/ios/src/in_app_webview/main.dart` | `lib/src/platforms/ios/src/webview/main.dart` |
| `lib/src/platforms/ios/src/inappwebview_platform.dart` | `lib/src/platforms/ios/src/webview_platform.dart` |
| `lib/src/platforms/linux/flutter_inappwebview_linux.dart` | `lib/src/platforms/linux/flutter_webview_linux.dart` |
| `lib/src/platforms/linux/src/in_app_browser/in_app_browser.dart` | `lib/src/platforms/linux/src/browser/browser.dart` |
| `lib/src/platforms/linux/src/in_app_browser/main.dart` | `lib/src/platforms/linux/src/browser/main.dart` |
| `lib/src/platforms/linux/src/in_app_webview/_static_channel.dart` | `lib/src/platforms/linux/src/webview/_static_channel.dart` |
| `lib/src/platforms/linux/src/in_app_webview/custom_platform_view.dart` | `lib/src/platforms/linux/src/webview/custom_platform_view.dart` |
| `lib/src/platforms/linux/src/in_app_webview/headless_in_app_webview.dart` | `lib/src/platforms/linux/src/webview/headless_webview.dart` |
| `lib/src/platforms/linux/src/in_app_webview/in_app_webview.dart` | `lib/src/platforms/linux/src/webview/webview.dart` |
| `lib/src/platforms/linux/src/in_app_webview/in_app_webview_controller.dart` | `lib/src/platforms/linux/src/webview/webview_controller.dart` |
| `lib/src/platforms/linux/src/in_app_webview/key_mappings.dart` | `lib/src/platforms/linux/src/webview/key_mappings.dart` |
| `lib/src/platforms/linux/src/in_app_webview/main.dart` | `lib/src/platforms/linux/src/webview/main.dart` |
| `lib/src/platforms/linux/src/inappwebview_platform.dart` | `lib/src/platforms/linux/src/webview_platform.dart` |
| `lib/src/platforms/macos/flutter_inappwebview_macos.dart` | `lib/src/platforms/macos/flutter_webview_macos.dart` |
| `lib/src/platforms/macos/src/in_app_browser/in_app_browser.dart` | `lib/src/platforms/macos/src/browser/browser.dart` |
| `lib/src/platforms/macos/src/in_app_browser/main.dart` | `lib/src/platforms/macos/src/browser/main.dart` |
| `lib/src/platforms/macos/src/in_app_webview/_static_channel.dart` | `lib/src/platforms/macos/src/webview/_static_channel.dart` |
| `lib/src/platforms/macos/src/in_app_webview/headless_in_app_webview.dart` | `lib/src/platforms/macos/src/webview/headless_webview.dart` |
| `lib/src/platforms/macos/src/in_app_webview/in_app_webview.dart` | `lib/src/platforms/macos/src/webview/webview.dart` |
| `lib/src/platforms/macos/src/in_app_webview/in_app_webview_controller.dart` | `lib/src/platforms/macos/src/webview/webview_controller.dart` |
| `lib/src/platforms/macos/src/in_app_webview/main.dart` | `lib/src/platforms/macos/src/webview/main.dart` |
| `lib/src/platforms/macos/src/inappwebview_platform.dart` | `lib/src/platforms/macos/src/webview_platform.dart` |
| `lib/src/platforms/web/flutter_inappwebview_web.dart` | `lib/src/platforms/web/flutter_webview_web.dart` |
| `lib/src/platforms/web/src/in_app_webview/_static_channel.dart` | `lib/src/platforms/web/src/webview/_static_channel.dart` |
| `lib/src/platforms/web/src/in_app_webview/headless_in_app_webview.dart` | `lib/src/platforms/web/src/webview/headless_webview.dart` |
| `lib/src/platforms/web/src/in_app_webview/in_app_webview.dart` | `lib/src/platforms/web/src/webview/webview.dart` |
| `lib/src/platforms/web/src/in_app_webview/in_app_webview_controller.dart` | `lib/src/platforms/web/src/webview/webview_controller.dart` |
| `lib/src/platforms/web/src/in_app_webview/main.dart` | `lib/src/platforms/web/src/webview/main.dart` |
| `lib/src/platforms/web/src/inappwebview_platform.dart` | `lib/src/platforms/web/src/webview_platform.dart` |
| `lib/src/platforms/web/web/headless_in_app_web_view_web_element.dart` | `lib/src/platforms/web/web/headless_web_view_web_element.dart` |
| `lib/src/platforms/web/web/headless_inappwebview_manager.dart` | `lib/src/platforms/web/web/headless_webview_manager.dart` |
| `lib/src/platforms/web/web/in_app_web_view_web_element.dart` | `lib/src/platforms/web/web/web_view_web_element.dart` |
| `lib/src/platforms/web/web/in_app_webview_manager.dart` | `lib/src/platforms/web/web/webview_manager.dart` |
| `lib/src/platforms/windows/flutter_inappwebview_windows.dart` | `lib/src/platforms/windows/flutter_webview_windows.dart` |
| `lib/src/platforms/windows/src/in_app_browser/in_app_browser.dart` | `lib/src/platforms/windows/src/browser/browser.dart` |
| `lib/src/platforms/windows/src/in_app_browser/main.dart` | `lib/src/platforms/windows/src/browser/main.dart` |
| `lib/src/platforms/windows/src/in_app_webview/_static_channel.dart` | `lib/src/platforms/windows/src/webview/_static_channel.dart` |
| `lib/src/platforms/windows/src/in_app_webview/custom_platform_view.dart` | `lib/src/platforms/windows/src/webview/custom_platform_view.dart` |
| `lib/src/platforms/windows/src/in_app_webview/headless_in_app_webview.dart` | `lib/src/platforms/windows/src/webview/headless_webview.dart` |
| `lib/src/platforms/windows/src/in_app_webview/in_app_webview.dart` | `lib/src/platforms/windows/src/webview/webview.dart` |
| `lib/src/platforms/windows/src/in_app_webview/in_app_webview_controller.dart` | `lib/src/platforms/windows/src/webview/webview_controller.dart` |
| `lib/src/platforms/windows/src/in_app_webview/main.dart` | `lib/src/platforms/windows/src/webview/main.dart` |
| `lib/src/platforms/windows/src/inappwebview_platform.dart` | `lib/src/platforms/windows/src/webview_platform.dart` |

## 實作層與內部類別

`lib/src/platforms/**` 的實作類別、不對外的內部類別與 `example` 自訂類別，同樣套用「前綴 `Aqutter`、移除 `InApp`」。例外：兩個舊式子類 `AqutterInAppWebViewOptions`、`AqutterInAppBrowserOptions` 保留；與公開類別同名的兩個實作類別加 `Impl` 後綴（公開版已佔用不帶 `Impl` 的名稱）。

共 75 個名稱：

| 舊名 | 新名 |
|---|---|
| `AndroidHeadlessInAppWebView` | `AqutterAndroidHeadlessWebView` |
| `AndroidHeadlessInAppWebViewCreationParams` | `AqutterAndroidHeadlessWebViewCreationParams` |
| `AndroidInAppBrowser` | `AqutterAndroidBrowser` |
| `AndroidInAppBrowserCreationParams` | `AqutterAndroidBrowserCreationParams` |
| `AndroidInAppWebViewController` | `AqutterAndroidWebViewControllerImpl` |
| `AndroidInAppWebViewControllerCreationParams` | `AqutterAndroidWebViewControllerCreationParams` |
| `AndroidInAppWebViewWidget` | `AqutterAndroidWebViewWidget` |
| `AndroidInAppWebViewWidgetCreationParams` | `AqutterAndroidWebViewWidgetCreationParams` |
| `HeadlessInAppWebViewManager` | `AqutterHeadlessWebViewManager` |
| `HeadlessInAppWebViewWebElement` | `AqutterHeadlessWebViewWebElement` |
| `IOSHeadlessInAppWebView` | `AqutterIOSHeadlessWebView` |
| `IOSHeadlessInAppWebViewCreationParams` | `AqutterIOSHeadlessWebViewCreationParams` |
| `IOSInAppBrowser` | `AqutterIOSBrowser` |
| `IOSInAppBrowserCreationParams` | `AqutterIOSBrowserCreationParams` |
| `IOSInAppWebViewController` | `AqutterIOSWebViewControllerImpl` |
| `IOSInAppWebViewControllerCreationParams` | `AqutterIOSWebViewControllerCreationParams` |
| `IOSInAppWebViewWidget` | `AqutterIOSWebViewWidget` |
| `IOSInAppWebViewWidgetCreationParams` | `AqutterIOSWebViewWidgetCreationParams` |
| `InAppBrowserScreen` | `AqutterBrowserScreen` |
| `InAppWebViewAjaxTest` | `AqutterWebViewAjaxTest` |
| `InAppWebViewFetchTest` | `AqutterWebViewFetchTest` |
| `InAppWebViewInitialFileTest` | `AqutterWebViewInitialFileTest` |
| `InAppWebViewManager` | `AqutterWebViewManager` |
| `InAppWebViewOnDownloadStartTest` | `AqutterWebViewOnDownloadStartTest` |
| `InAppWebViewPointerEventKind` | `AqutterWebViewPointerEventKind` |
| `InAppWebViewWebElement` | `AqutterWebViewWebElement` |
| `InternalHeadlessInAppWebView` | `AqutterInternalHeadlessWebView` |
| `InternalInAppBrowser` | `AqutterInternalBrowser` |
| `InternalInAppWebViewController` | `AqutterInternalWebViewController` |
| `InternalInAppWebViewKeepAlive` | `AqutterInternalWebViewKeepAlive` |
| `LinuxHeadlessInAppWebView` | `AqutterLinuxHeadlessWebView` |
| `LinuxHeadlessInAppWebViewCreationParams` | `AqutterLinuxHeadlessWebViewCreationParams` |
| `LinuxInAppBrowser` | `AqutterLinuxBrowser` |
| `LinuxInAppBrowserCreationParams` | `AqutterLinuxBrowserCreationParams` |
| `LinuxInAppWebViewController` | `AqutterLinuxWebViewController` |
| `LinuxInAppWebViewControllerCreationParams` | `AqutterLinuxWebViewControllerCreationParams` |
| `LinuxInAppWebViewWidget` | `AqutterLinuxWebViewWidget` |
| `LinuxInAppWebViewWidgetCreationParams` | `AqutterLinuxWebViewWidgetCreationParams` |
| `MacOSHeadlessInAppWebView` | `AqutterMacOSHeadlessWebView` |
| `MacOSHeadlessInAppWebViewCreationParams` | `AqutterMacOSHeadlessWebViewCreationParams` |
| `MacOSInAppBrowser` | `AqutterMacOSBrowser` |
| `MacOSInAppBrowserCreationParams` | `AqutterMacOSBrowserCreationParams` |
| `MacOSInAppWebViewController` | `AqutterMacOSWebViewController` |
| `MacOSInAppWebViewControllerCreationParams` | `AqutterMacOSWebViewControllerCreationParams` |
| `MacOSInAppWebViewWidget` | `AqutterMacOSWebViewWidget` |
| `MacOSInAppWebViewWidgetCreationParams` | `AqutterMacOSWebViewWidgetCreationParams` |
| `MockPlatformHeadlessInAppWebView` | `AqutterMockPlatformHeadlessWebView` |
| `MockPlatformInAppBrowser` | `AqutterMockPlatformBrowser` |
| `MockPlatformInAppWebViewController` | `AqutterMockPlatformWebViewController` |
| `MockPlatformInAppWebViewControllerStatic` | `AqutterMockPlatformWebViewControllerStatic` |
| `MockPlatformInAppWebViewWidget` | `AqutterMockPlatformWebViewWidget` |
| `MyInAppBrowser` | `AqutterMyBrowser` |
| `PlatformInAppWebView` | `AqutterPlatformWebView` |
| `TestInAppBrowser` | `AqutterTestBrowser` |
| `WebPlatformHeadlessInAppWebView` | `AqutterWebPlatformHeadlessWebView` |
| `WebPlatformHeadlessInAppWebViewCreationParams` | `AqutterWebPlatformHeadlessWebViewCreationParams` |
| `WebPlatformInAppBrowser` | `AqutterWebPlatformBrowser` |
| `WebPlatformInAppWebViewController` | `AqutterWebPlatformWebViewController` |
| `WebPlatformInAppWebViewControllerCreationParams` | `AqutterWebPlatformWebViewControllerCreationParams` |
| `WebPlatformInAppWebViewPlatform` | `AqutterWebPlatformWebViewPlatform` |
| `WebPlatformInAppWebViewWidget` | `AqutterWebPlatformWebViewWidget` |
| `WebPlatformInAppWebViewWidgetCreationParams` | `AqutterWebPlatformWebViewWidgetCreationParams` |
| `WindowsHeadlessInAppWebView` | `AqutterWindowsHeadlessWebView` |
| `WindowsHeadlessInAppWebViewCreationParams` | `AqutterWindowsHeadlessWebViewCreationParams` |
| `WindowsInAppBrowser` | `AqutterWindowsBrowser` |
| `WindowsInAppBrowserCreationParams` | `AqutterWindowsBrowserCreationParams` |
| `WindowsInAppWebViewController` | `AqutterWindowsWebViewController` |
| `WindowsInAppWebViewControllerCreationParams` | `AqutterWindowsWebViewControllerCreationParams` |
| `WindowsInAppWebViewWidget` | `AqutterWindowsWebViewWidget` |
| `WindowsInAppWebViewWidgetCreationParams` | `AqutterWindowsWebViewWidgetCreationParams` |
| `_InAppBrowserScreenState` | `_AqutterBrowserScreenState` |
| `_InAppWebViewState` | `_AqutterWebViewState` |
| `_PlatformInAppBrowser` | `_AqutterPlatformBrowser` |
| `_PlatformInAppLocalhostServer` | `_AqutterPlatformLocalhostServer` |
| `createInAppWebView` | `createAqutterWebView` |
