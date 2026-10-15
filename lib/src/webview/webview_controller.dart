import 'dart:core';

import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../print_job/main.dart';
import '../web_message/main.dart';
import '../web_storage/web_storage.dart';
import 'android/webview_controller.dart';
import 'apple/webview_controller.dart';

///{@macro aqutter_core.AqutterPlatformWebViewController}
///
///{@macro aqutter_core.AqutterPlatformWebViewController.supported_platforms}
class AqutterWebViewController {
  ///Use [AqutterWebViewController] instead.
  @Deprecated("Use AqutterWebViewController instead")
  late AqutterAndroidWebViewController android;

  ///Use [AqutterWebViewController] instead.
  @Deprecated("Use AqutterWebViewController instead")
  late AqutterIOSWebViewController ios;

  /// Constructs a [AqutterWebViewController].
  ///
  /// See [AqutterWebViewController.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterWebViewController.fromPlatformCreationParams({
    required AqutterPlatformWebViewControllerCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformWebViewController(params));

  /// Constructs a [AqutterWebViewController] from a specific platform implementation.
  AqutterWebViewController.fromPlatform({required this.platform}) {
    android = AqutterAndroidWebViewController(controller: this.platform);
    ios = AqutterIOSWebViewController(controller: this.platform);
  }

  /// Implementation of [AqutterPlatformWebViewController] for the current platform.
  final AqutterPlatformWebViewController platform;

  ///{@macro aqutter_core.AqutterPlatformWebViewController.webStorage}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.webStorage.supported_platforms}
  AqutterWebStorage get webStorage =>
      AqutterWebStorage.fromPlatform(platform: platform.webStorage);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getUrl}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getUrl.supported_platforms}
  Future<AqutterWebUri?> getUrl() => platform.getUrl();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getTitle}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getTitle.supported_platforms}
  Future<String?> getTitle() => platform.getTitle();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getFrameId}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getFrameId.supported_platforms}
  Future<int?> getFrameId() => platform.getFrameId();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getProgress}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getProgress.supported_platforms}
  Future<int?> getProgress() => platform.getProgress();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getHtml}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getHtml.supported_platforms}
  Future<String?> getHtml() => platform.getHtml();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getFavicons}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getFavicons.supported_platforms}
  Future<List<AqutterFavicon>> getFavicons() => platform.getFavicons();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getFavicon}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getFavicon.supported_platforms}
  Future<Uint8List?> getFavicon({
    required AqutterWebUri url,
    AqutterFaviconImageFormat faviconImageFormat = AqutterFaviconImageFormat.PNG,
  }) => platform.getFavicon(url: url, faviconImageFormat: faviconImageFormat);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.showSaveAsUI}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.showSaveAsUI.supported_platforms}
  Future<AqutterSaveAsUIResult?> showSaveAsUI() => platform.showSaveAsUI();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getMemoryUsageTargetLevel}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getMemoryUsageTargetLevel.supported_platforms}
  Future<AqutterMemoryUsageTargetLevel?> getMemoryUsageTargetLevel() =>
      platform.getMemoryUsageTargetLevel();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setMemoryUsageTargetLevel}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setMemoryUsageTargetLevel.supported_platforms}
  Future<void> setMemoryUsageTargetLevel(AqutterMemoryUsageTargetLevel level) =>
      platform.setMemoryUsageTargetLevel(level);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.loadUrl}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.loadUrl.supported_platforms}
  Future<void> loadUrl({
    required AqutterURLRequest urlRequest,
    @Deprecated('Use allowingReadAccessTo instead')
    Uri? iosAllowingReadAccessTo,
    AqutterWebUri? allowingReadAccessTo,
  }) => platform.loadUrl(
    urlRequest: urlRequest,
    iosAllowingReadAccessTo: iosAllowingReadAccessTo,
    allowingReadAccessTo: allowingReadAccessTo,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.postUrl}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.postUrl.supported_platforms}
  Future<void> postUrl({required AqutterWebUri url, required Uint8List postData}) =>
      platform.postUrl(url: url, postData: postData);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.loadData}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.loadData.supported_platforms}
  Future<void> loadData({
    required String data,
    String mimeType = "text/html",
    String encoding = "utf8",
    AqutterWebUri? baseUrl,
    @Deprecated('Use historyUrl instead') Uri? androidHistoryUrl,
    AqutterWebUri? historyUrl,
    @Deprecated('Use allowingReadAccessTo instead')
    Uri? iosAllowingReadAccessTo,
    AqutterWebUri? allowingReadAccessTo,
  }) => platform.loadData(
    data: data,
    mimeType: mimeType,
    encoding: encoding,
    baseUrl: baseUrl,
    androidHistoryUrl: androidHistoryUrl,
    historyUrl: historyUrl,
    iosAllowingReadAccessTo: iosAllowingReadAccessTo,
    allowingReadAccessTo: allowingReadAccessTo,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.loadFile}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.loadFile.supported_platforms}
  Future<void> loadFile({required String assetFilePath}) =>
      platform.loadFile(assetFilePath: assetFilePath);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.reload}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.reload.supported_platforms}
  Future<void> reload() => platform.reload();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.goBack}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.goBack.supported_platforms}
  Future<void> goBack() => platform.goBack();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.canGoBack}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.canGoBack.supported_platforms}
  Future<bool> canGoBack() => platform.canGoBack();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.goForward}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.goForward.supported_platforms}
  Future<void> goForward() => platform.goForward();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.canGoForward}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.canGoForward.supported_platforms}
  Future<bool> canGoForward() => platform.canGoForward();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.goBackOrForward}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.goBackOrForward.supported_platforms}
  Future<void> goBackOrForward({required int steps}) =>
      platform.goBackOrForward(steps: steps);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.canGoBackOrForward}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.canGoBackOrForward.supported_platforms}
  Future<bool> canGoBackOrForward({required int steps}) =>
      platform.canGoBackOrForward(steps: steps);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.goTo}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.goTo.supported_platforms}
  Future<void> goTo({required AqutterWebHistoryItem historyItem}) =>
      platform.goTo(historyItem: historyItem);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.isLoading}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isLoading.supported_platforms}
  Future<bool> isLoading() => platform.isLoading();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.stopLoading}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.stopLoading.supported_platforms}
  Future<void> stopLoading() => platform.stopLoading();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.evaluateJavascript}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.evaluateJavascript.supported_platforms}
  Future<dynamic> evaluateJavascript({
    required String source,
    AqutterContentWorld? contentWorld,
  }) => platform.evaluateJavascript(source: source, contentWorld: contentWorld);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectJavascriptFileFromUrl}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectJavascriptFileFromUrl.supported_platforms}
  Future<void> injectJavascriptFileFromUrl({
    required AqutterWebUri urlFile,
    AqutterScriptHtmlTagAttributes? scriptHtmlTagAttributes,
  }) => platform.injectJavascriptFileFromUrl(
    urlFile: urlFile,
    scriptHtmlTagAttributes: scriptHtmlTagAttributes,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectJavascriptFileFromAsset}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectJavascriptFileFromAsset.supported_platforms}
  Future<dynamic> injectJavascriptFileFromAsset({
    required String assetFilePath,
  }) => platform.injectJavascriptFileFromAsset(assetFilePath: assetFilePath);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectCSSCode}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectCSSCode.supported_platforms}
  Future<void> injectCSSCode({required String source}) =>
      platform.injectCSSCode(source: source);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectCSSFileFromUrl}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectCSSFileFromUrl.supported_platforms}
  Future<void> injectCSSFileFromUrl({
    required AqutterWebUri urlFile,
    AqutterCSSLinkHtmlTagAttributes? cssLinkHtmlTagAttributes,
  }) => platform.injectCSSFileFromUrl(
    urlFile: urlFile,
    cssLinkHtmlTagAttributes: cssLinkHtmlTagAttributes,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectCSSFileFromAsset}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectCSSFileFromAsset.supported_platforms}
  Future<void> injectCSSFileFromAsset({required String assetFilePath}) =>
      platform.injectCSSFileFromAsset(assetFilePath: assetFilePath);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.addJavaScriptHandler}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.addJavaScriptHandler.supported_platforms}
  void addJavaScriptHandler({
    required String handlerName,
    required Function callback,
  }) => platform.addJavaScriptHandler(
    handlerName: handlerName,
    callback: callback,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeJavaScriptHandler}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeJavaScriptHandler.supported_platforms}
  Function? removeJavaScriptHandler({required String handlerName}) =>
      platform.removeJavaScriptHandler(handlerName: handlerName);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.hasJavaScriptHandler}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.hasJavaScriptHandler.supported_platforms}
  bool hasJavaScriptHandler({required String handlerName}) =>
      platform.hasJavaScriptHandler(handlerName: handlerName);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.takeScreenshot}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.takeScreenshot.supported_platforms}
  Future<Uint8List?> takeScreenshot({
    AqutterScreenshotConfiguration? screenshotConfiguration,
  }) =>
      platform.takeScreenshot(screenshotConfiguration: screenshotConfiguration);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setOptions}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setOptions.supported_platforms}
  @Deprecated('Use setSettings instead')
  Future<void> setOptions({required AqutterWebViewGroupOptions options}) =>
      platform.setOptions(options: options);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getOptions}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getOptions.supported_platforms}
  @Deprecated('Use getSettings instead')
  Future<AqutterWebViewGroupOptions?> getOptions() => platform.getOptions();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setSettings}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setSettings.supported_platforms}
  Future<void> setSettings({required AqutterWebViewSettings settings}) =>
      platform.setSettings(settings: settings);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getSettings}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getSettings.supported_platforms}
  Future<AqutterWebViewSettings?> getSettings() => platform.getSettings();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getCopyBackForwardList}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getCopyBackForwardList.supported_platforms}
  Future<AqutterWebHistory?> getCopyBackForwardList() =>
      platform.getCopyBackForwardList();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearCache}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearCache.supported_platforms}
  @Deprecated("Use AqutterWebViewController.clearAllCache instead")
  Future<void> clearCache() => platform.clearCache();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.findAllAsync}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.findAllAsync.supported_platforms}
  @Deprecated("Use AqutterFindInteractionController.findAll instead")
  Future<void> findAllAsync({required String find}) =>
      platform.findAllAsync(find: find);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.findNext}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.findNext.supported_platforms}
  @Deprecated("Use AqutterFindInteractionController.findNext instead")
  Future<void> findNext({required bool forward}) =>
      platform.findNext(forward: forward);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearMatches}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearMatches.supported_platforms}
  @Deprecated("Use AqutterFindInteractionController.clearMatches instead")
  Future<void> clearMatches() => platform.clearMatches();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getTRexRunnerHtml}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getTRexRunnerHtml.supported_platforms}
  @Deprecated("Use tRexRunnerHtml instead")
  Future<String> getTRexRunnerHtml() => platform.getTRexRunnerHtml();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getTRexRunnerCss}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getTRexRunnerCss.supported_platforms}
  @Deprecated("Use tRexRunnerCss instead")
  Future<String> getTRexRunnerCss() => platform.getTRexRunnerCss();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.scrollTo}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.scrollTo.supported_platforms}
  Future<void> scrollTo({
    required int x,
    required int y,
    bool animated = false,
  }) => platform.scrollTo(x: x, y: y, animated: animated);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.scrollBy}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.scrollBy.supported_platforms}
  Future<void> scrollBy({
    required int x,
    required int y,
    bool animated = false,
  }) => platform.scrollBy(x: x, y: y, animated: animated);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.pauseTimers}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.pauseTimers.supported_platforms}
  Future<void> pauseTimers() => platform.pauseTimers();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.resumeTimers}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.resumeTimers.supported_platforms}
  Future<void> resumeTimers() => platform.resumeTimers();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.printCurrentPage}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.printCurrentPage.supported_platforms}
  Future<AqutterPrintJobController?> printCurrentPage({
    AqutterPrintJobSettings? settings,
  }) async {
    final printJobControllerPlatform = await platform.printCurrentPage(
      settings: settings,
    );
    if (printJobControllerPlatform == null) {
      return null;
    }
    return AqutterPrintJobController.fromPlatform(
      platform: printJobControllerPlatform,
    );
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getContentHeight}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getContentHeight.supported_platforms}
  Future<int?> getContentHeight() => platform.getContentHeight();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getContentWidth}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getContentWidth.supported_platforms}
  Future<int?> getContentWidth() => platform.getContentWidth();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.zoomBy}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.zoomBy.supported_platforms}
  Future<void> zoomBy({
    required double zoomFactor,
    @Deprecated('Use animated instead') bool? iosAnimated,
    bool animated = false,
  }) => platform.zoomBy(
    zoomFactor: zoomFactor,
    iosAnimated: iosAnimated,
    animated: animated,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getOriginalUrl}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getOriginalUrl.supported_platforms}
  Future<AqutterWebUri?> getOriginalUrl() => platform.getOriginalUrl();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getZoomScale}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getZoomScale.supported_platforms}
  Future<double?> getZoomScale() => platform.getZoomScale();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getScale}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getScale.supported_platforms}
  @Deprecated('Use getZoomScale instead')
  Future<double?> getScale() => platform.getScale();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getSelectedText}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getSelectedText.supported_platforms}
  Future<String?> getSelectedText() => platform.getSelectedText();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getHitTestResult}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getHitTestResult.supported_platforms}
  Future<AqutterWebViewHitTestResult?> getHitTestResult() =>
      platform.getHitTestResult();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestFocus}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestFocus.supported_platforms}
  Future<bool?> requestFocus({
    AqutterFocusDirection? direction,
    AqutterWebViewRect? previouslyFocusedRect,
  }) => platform.requestFocus(
    direction: direction,
    previouslyFocusedRect: previouslyFocusedRect,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearFocus}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearFocus.supported_platforms}
  Future<void> clearFocus() => platform.clearFocus();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setInputMethodEnabled}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setInputMethodEnabled.supported_platforms}
  Future<void> setInputMethodEnabled(bool enabled) =>
      platform.setInputMethodEnabled(enabled);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.showInputMethod}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.showInputMethod.supported_platforms}
  Future<void> showInputMethod() => platform.showInputMethod();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.hideInputMethod}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.hideInputMethod.supported_platforms}
  Future<void> hideInputMethod() => platform.hideInputMethod();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setContextMenu}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setContextMenu.supported_platforms}
  Future<void> setContextMenu(AqutterContextMenu? contextMenu) =>
      platform.setContextMenu(contextMenu);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestFocusNodeHref}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestFocusNodeHref.supported_platforms}
  Future<AqutterRequestFocusNodeHrefResult?> requestFocusNodeHref() =>
      platform.requestFocusNodeHref();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestImageRef}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestImageRef.supported_platforms}
  Future<AqutterRequestImageRefResult?> requestImageRef() =>
      platform.requestImageRef();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getMetaTags}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getMetaTags.supported_platforms}
  Future<List<AqutterMetaTag>> getMetaTags() => platform.getMetaTags();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getMetaThemeColor}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getMetaThemeColor.supported_platforms}
  Future<Color?> getMetaThemeColor() => platform.getMetaThemeColor();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getScrollX}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getScrollX.supported_platforms}
  Future<int?> getScrollX() => platform.getScrollX();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getScrollY}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getScrollY.supported_platforms}
  Future<int?> getScrollY() => platform.getScrollY();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getCertificate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getCertificate.supported_platforms}
  Future<AqutterSslCertificate?> getCertificate() => platform.getCertificate();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.addUserScript}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.addUserScript.supported_platforms}
  Future<void> addUserScript({required AqutterUserScript userScript}) =>
      platform.addUserScript(userScript: userScript);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.addUserScripts}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.addUserScripts.supported_platforms}
  Future<void> addUserScripts({required List<AqutterUserScript> userScripts}) =>
      platform.addUserScripts(userScripts: userScripts);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeUserScript}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeUserScript.supported_platforms}
  Future<bool> removeUserScript({required AqutterUserScript userScript}) =>
      platform.removeUserScript(userScript: userScript);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeUserScriptsByGroupName}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeUserScriptsByGroupName.supported_platforms}
  Future<void> removeUserScriptsByGroupName({required String groupName}) =>
      platform.removeUserScriptsByGroupName(groupName: groupName);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeUserScripts}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeUserScripts.supported_platforms}
  Future<void> removeUserScripts({required List<AqutterUserScript> userScripts}) =>
      platform.removeUserScripts(userScripts: userScripts);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeAllUserScripts}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeAllUserScripts.supported_platforms}
  Future<void> removeAllUserScripts() => platform.removeAllUserScripts();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.hasUserScript}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.hasUserScript.supported_platforms}
  bool hasUserScript({required AqutterUserScript userScript}) =>
      platform.hasUserScript(userScript: userScript);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.callAsyncJavaScript}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.callAsyncJavaScript.supported_platforms}
  Future<AqutterCallAsyncJavaScriptResult?> callAsyncJavaScript({
    required String functionBody,
    Map<String, dynamic> arguments = const <String, dynamic>{},
    AqutterContentWorld? contentWorld,
  }) => platform.callAsyncJavaScript(
    functionBody: functionBody,
    arguments: arguments,
    contentWorld: contentWorld,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.saveWebArchive}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.saveWebArchive.supported_platforms}
  Future<String?> saveWebArchive({
    required String filePath,
    bool autoname = false,
  }) => platform.saveWebArchive(filePath: filePath, autoname: autoname);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.isSecureContext}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isSecureContext.supported_platforms}
  Future<bool> isSecureContext() => platform.isSecureContext();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.createWebMessageChannel}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.createWebMessageChannel.supported_platforms}
  Future<AqutterWebMessageChannel?> createWebMessageChannel() async {
    final webMessagePlatform = await platform.createWebMessageChannel();
    if (webMessagePlatform == null) {
      return null;
    }
    return AqutterWebMessageChannel.fromPlatform(platform: webMessagePlatform);
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewController.postWebMessage}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.postWebMessage.supported_platforms}
  Future<void> postWebMessage({
    required AqutterWebMessage message,
    AqutterWebUri? targetOrigin,
  }) => platform.postWebMessage(message: message, targetOrigin: targetOrigin);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.addWebMessageListener}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.addWebMessageListener.supported_platforms}
  Future<void> addWebMessageListener(AqutterWebMessageListener webMessageListener) =>
      platform.addWebMessageListener(webMessageListener.platform);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.hasWebMessageListener}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.hasWebMessageListener.supported_platforms}
  bool hasWebMessageListener(AqutterWebMessageListener webMessageListener) =>
      platform.hasWebMessageListener(webMessageListener.platform);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.canScrollVertically}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.canScrollVertically.supported_platforms}
  Future<bool> canScrollVertically() => platform.canScrollVertically();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.canScrollHorizontally}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.canScrollHorizontally.supported_platforms}
  Future<bool> canScrollHorizontally() => platform.canScrollHorizontally();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.startSafeBrowsing}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.startSafeBrowsing.supported_platforms}
  Future<bool> startSafeBrowsing() => platform.startSafeBrowsing();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearSslPreferences}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearSslPreferences.supported_platforms}
  Future<void> clearSslPreferences() => platform.clearSslPreferences();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.pause}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.pause.supported_platforms}
  Future<void> pause() => platform.pause();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.resume}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.resume.supported_platforms}
  Future<void> resume() => platform.resume();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.pageDown}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.pageDown.supported_platforms}
  Future<bool> pageDown({required bool bottom}) =>
      platform.pageDown(bottom: bottom);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.pageUp}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.pageUp.supported_platforms}
  Future<bool> pageUp({required bool top}) => platform.pageUp(top: top);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.zoomIn}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.zoomIn.supported_platforms}
  Future<bool> zoomIn() => platform.zoomIn();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.zoomOut}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.zoomOut.supported_platforms}
  Future<bool> zoomOut() => platform.zoomOut();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearHistory}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearHistory.supported_platforms}
  Future<void> clearHistory() => platform.clearHistory();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.reloadFromOrigin}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.reloadFromOrigin.supported_platforms}
  Future<void> reloadFromOrigin() => platform.reloadFromOrigin();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.createPdf}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.createPdf.supported_platforms}
  Future<Uint8List?> createPdf({
    @Deprecated("Use pdfConfiguration instead")
    // ignore: deprecated_member_use_from_same_package
    AqutterIOSWKPDFConfiguration? iosWKPdfConfiguration,
    AqutterPDFConfiguration? pdfConfiguration,
  }) => platform.createPdf(
    iosWKPdfConfiguration: iosWKPdfConfiguration,
    pdfConfiguration: pdfConfiguration,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.createWebArchiveData}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.createWebArchiveData.supported_platforms}
  Future<Uint8List?> createWebArchiveData() => platform.createWebArchiveData();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.hasOnlySecureContent}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.hasOnlySecureContent.supported_platforms}
  Future<bool> hasOnlySecureContent() => platform.hasOnlySecureContent();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.pauseAllMediaPlayback}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.pauseAllMediaPlayback.supported_platforms}
  Future<void> pauseAllMediaPlayback() => platform.pauseAllMediaPlayback();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setAllMediaPlaybackSuspended}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setAllMediaPlaybackSuspended.supported_platforms}
  Future<void> setAllMediaPlaybackSuspended({required bool suspended}) =>
      platform.setAllMediaPlaybackSuspended(suspended: suspended);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.closeAllMediaPresentations}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.closeAllMediaPresentations.supported_platforms}
  Future<void> closeAllMediaPresentations() =>
      platform.closeAllMediaPresentations();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestMediaPlaybackState}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestMediaPlaybackState.supported_platforms}
  Future<AqutterMediaPlaybackState?> requestMediaPlaybackState() =>
      platform.requestMediaPlaybackState();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.isInFullscreen}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isInFullscreen.supported_platforms}
  Future<bool> isInFullscreen() => platform.isInFullscreen();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestEnterFullscreen}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestEnterFullscreen.supported_platforms}
  Future<void> requestEnterFullscreen() => platform.requestEnterFullscreen();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestExitFullscreen}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestExitFullscreen.supported_platforms}
  Future<void> requestExitFullscreen() => platform.requestExitFullscreen();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setVisible}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setVisible.supported_platforms}
  Future<void> setVisible({required bool visible}) =>
      platform.setVisible(visible: visible);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setTargetRefreshRate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setTargetRefreshRate.supported_platforms}
  Future<void> setTargetRefreshRate({required int rate}) =>
      platform.setTargetRefreshRate(rate: rate);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getTargetRefreshRate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getTargetRefreshRate.supported_platforms}
  Future<int> getTargetRefreshRate() => platform.getTargetRefreshRate();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getScreenScale}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getScreenScale.supported_platforms}
  Future<double> getScreenScale() => platform.getScreenScale();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setScreenScale}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setScreenScale.supported_platforms}
  Future<void> setScreenScale({required double scale}) =>
      platform.setScreenScale(scale: scale);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.isVisible}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isVisible.supported_platforms}
  Future<bool> isVisible() => platform.isVisible();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestPointerLock}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestPointerLock.supported_platforms}
  Future<bool> requestPointerLock() => platform.requestPointerLock();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestPointerUnlock}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestPointerUnlock.supported_platforms}
  Future<bool> requestPointerUnlock() => platform.requestPointerUnlock();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearFormData}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearFormData.supported_platforms}
  Future<void> clearFormData() => platform.clearFormData();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getCameraCaptureState}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getCameraCaptureState.supported_platforms}
  Future<AqutterMediaCaptureState?> getCameraCaptureState() =>
      platform.getCameraCaptureState();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setCameraCaptureState}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setCameraCaptureState.supported_platforms}
  Future<void> setCameraCaptureState({required AqutterMediaCaptureState state}) =>
      platform.setCameraCaptureState(state: state);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getMicrophoneCaptureState}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getMicrophoneCaptureState.supported_platforms}
  Future<AqutterMediaCaptureState?> getMicrophoneCaptureState() =>
      platform.getMicrophoneCaptureState();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setMicrophoneCaptureState}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setMicrophoneCaptureState.supported_platforms}
  Future<void> setMicrophoneCaptureState({required AqutterMediaCaptureState state}) =>
      platform.setMicrophoneCaptureState(state: state);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.isPlayingAudio}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isPlayingAudio.supported_platforms}
  Future<bool> isPlayingAudio() => platform.isPlayingAudio();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.isMuted}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isMuted.supported_platforms}
  Future<bool> isMuted() => platform.isMuted();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setMuted}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setMuted.supported_platforms}
  Future<void> setMuted({required bool muted}) =>
      platform.setMuted(muted: muted);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.terminateWebProcess}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.terminateWebProcess.supported_platforms}
  Future<void> terminateWebProcess() => platform.terminateWebProcess();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.loadSimulatedRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.loadSimulatedRequest.supported_platforms}
  Future<void> loadSimulatedRequest({
    required AqutterURLRequest urlRequest,
    required Uint8List data,
    AqutterURLResponse? urlResponse,
  }) => platform.loadSimulatedRequest(urlRequest: urlRequest, data: data);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.openDevTools}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.openDevTools.supported_platforms}
  Future<void> openDevTools() => platform.openDevTools();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.callDevToolsProtocolMethod}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.callDevToolsProtocolMethod.supported_platforms}
  Future<dynamic> callDevToolsProtocolMethod({
    required String methodName,
    Map<String, dynamic>? parameters,
  }) => platform.callDevToolsProtocolMethod(
    methodName: methodName,
    parameters: parameters,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.addDevToolsProtocolEventListener}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.addDevToolsProtocolEventListener.supported_platforms}
  Future<void> addDevToolsProtocolEventListener({
    required String eventName,
    required Function(dynamic data) callback,
  }) => platform.addDevToolsProtocolEventListener(
    eventName: eventName,
    callback: callback,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeDevToolsProtocolEventListener}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeDevToolsProtocolEventListener.supported_platforms}
  Future<void> removeDevToolsProtocolEventListener({
    required String eventName,
  }) => platform.removeDevToolsProtocolEventListener(eventName: eventName);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.isInterfaceSupported}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isInterfaceSupported.supported_platforms}
  Future<bool> isInterfaceSupported(AqutterWebViewInterface interface) =>
      platform.isInterfaceSupported(interface);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.saveState}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.saveState.supported_platforms}
  Future<Uint8List?> saveState() => platform.saveState();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.restoreState}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.restoreState.supported_platforms}
  Future<bool> restoreState(Uint8List state) => platform.restoreState(state);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getIFrameId}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getIFrameId.supported_platforms}
  Future<String?> getIFrameId() => platform.getIFrameId();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getDefaultUserAgent}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getDefaultUserAgent.supported_platforms}
  static Future<String> getDefaultUserAgent() =>
      AqutterPlatformWebViewController.static().getDefaultUserAgent();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearClientCertPreferences}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearClientCertPreferences.supported_platforms}
  static Future<void> clearClientCertPreferences() =>
      AqutterPlatformWebViewController.static().clearClientCertPreferences();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getSafeBrowsingPrivacyPolicyUrl}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getSafeBrowsingPrivacyPolicyUrl.supported_platforms}
  static Future<AqutterWebUri?> getSafeBrowsingPrivacyPolicyUrl() =>
      AqutterPlatformWebViewController.static().getSafeBrowsingPrivacyPolicyUrl();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setSafeBrowsingWhitelist}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setSafeBrowsingWhitelist.supported_platforms}
  @Deprecated("Use setSafeBrowsingAllowlist instead")
  static Future<bool> setSafeBrowsingWhitelist({required List<String> hosts}) =>
      AqutterPlatformWebViewController.static().setSafeBrowsingWhitelist(
        hosts: hosts,
      );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setSafeBrowsingAllowlist}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setSafeBrowsingAllowlist.supported_platforms}
  static Future<bool> setSafeBrowsingAllowlist({required List<String> hosts}) =>
      AqutterPlatformWebViewController.static().setSafeBrowsingAllowlist(
        hosts: hosts,
      );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getCurrentWebViewPackage}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getCurrentWebViewPackage.supported_platforms}
  static Future<AqutterWebViewPackageInfo?> getCurrentWebViewPackage() =>
      AqutterPlatformWebViewController.static().getCurrentWebViewPackage();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setWebContentsDebuggingEnabled}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setWebContentsDebuggingEnabled.supported_platforms}
  static Future<void> setWebContentsDebuggingEnabled(bool debuggingEnabled) =>
      AqutterPlatformWebViewController.static().setWebContentsDebuggingEnabled(
        debuggingEnabled,
      );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getVariationsHeader}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getVariationsHeader.supported_platforms}
  static Future<String?> getVariationsHeader() =>
      AqutterPlatformWebViewController.static().getVariationsHeader();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.isMultiProcessEnabled}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isMultiProcessEnabled.supported_platforms}
  static Future<bool> isMultiProcessEnabled() =>
      AqutterPlatformWebViewController.static().isMultiProcessEnabled();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.disableWebView}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.disableWebView.supported_platforms}
  static Future<void> disableWebView() =>
      AqutterPlatformWebViewController.static().disableWebView();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.handlesURLScheme}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.handlesURLScheme.supported_platforms}
  static Future<bool> handlesURLScheme(String urlScheme) =>
      AqutterPlatformWebViewController.static().handlesURLScheme(urlScheme);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.disposeKeepAlive}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.disposeKeepAlive.supported_platforms}
  static Future<void> disposeKeepAlive(AqutterWebViewKeepAlive keepAlive) =>
      AqutterPlatformWebViewController.static().disposeKeepAlive(keepAlive);

  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearAllCache}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearAllCache.supported_platforms}
  static Future<void> clearAllCache({bool includeDiskFiles = true}) =>
      AqutterPlatformWebViewController.static().clearAllCache(
        includeDiskFiles: includeDiskFiles,
      );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.enableSlowWholeDocumentDraw}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.enableSlowWholeDocumentDraw.supported_platforms}
  static Future<void> enableSlowWholeDocumentDraw() =>
      AqutterPlatformWebViewController.static().enableSlowWholeDocumentDraw();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.setJavaScriptBridgeName}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setJavaScriptBridgeName.supported_platforms}
  static Future<void> setJavaScriptBridgeName(String bridgeName) =>
      AqutterPlatformWebViewController.static().setJavaScriptBridgeName(
        bridgeName,
      );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getJavaScriptBridgeName}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getJavaScriptBridgeName.supported_platforms}
  static Future<String> getJavaScriptBridgeName() =>
      AqutterPlatformWebViewController.static().getJavaScriptBridgeName();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.tRexRunnerHtml}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.tRexRunnerHtml.supported_platforms}
  static Future<String> get tRexRunnerHtml =>
      AqutterPlatformWebViewController.static().tRexRunnerHtml;

  ///{@macro aqutter_core.AqutterPlatformWebViewController.tRexRunnerCss}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.tRexRunnerCss.supported_platforms}
  static Future<String> get tRexRunnerCss =>
      AqutterPlatformWebViewController.static().tRexRunnerCss;

  ///{@macro aqutter_core.AqutterPlatformWebViewController.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformWebViewController.static().isClassSupported(
        platform: platform,
      );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.isPropertySupported}
  static bool isPropertySupported(
    AqutterPlatformWebViewControllerProperty property, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebViewController.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformWebViewControllerMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebViewController.static().isMethodSupported(
    method,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewController.getViewId}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getViewId.supported_platforms}
  dynamic getViewId() => platform.getViewId();

  ///{@macro aqutter_core.AqutterPlatformWebViewController.dispose}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.dispose.supported_platforms}
  void dispose({bool isKeepAlive = false}) =>
      platform.dispose(isKeepAlive: isKeepAlive);
}
