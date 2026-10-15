// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_browser.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformBrowserClassSupported on AqutterPlatformBrowser {
  ///{@template aqutter_core.AqutterPlatformBrowser.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit ([Official API - GtkWindow + WPE WebKit](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.WebView.html))
  ///
  ///Use the [AqutterPlatformBrowser.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.windows,
          TargetPlatform.linux,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformBrowser]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformBrowserProperty {
  ///Can be used to check if the [AqutterPlatformBrowser.contextMenu] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.contextMenu.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformBrowser.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  contextMenu,

  ///Can be used to check if the [AqutterPlatformBrowser.findInteractionController] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.findInteractionController.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPlatformBrowser.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  findInteractionController,

  ///Can be used to check if the [AqutterPlatformBrowser.id] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.id.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformBrowser.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  id,

  ///Can be used to check if the [AqutterPlatformBrowser.initialUserScripts] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.initialUserScripts.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView:
  ///    - This property will be ignored if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to iOS window WebViews. This is a limitation of the native WebKit APIs.
  ///- macOS WKWebView:
  ///    - This property will be ignored if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to iOS window WebViews. This is a limitation of the native WebKit APIs.
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformBrowser.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  initialUserScripts,

  ///Can be used to check if the [AqutterPlatformBrowser.pullToRefreshController] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.pullToRefreshController.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformBrowser.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  pullToRefreshController,

  ///Can be used to check if the [AqutterPlatformBrowser.webViewEnvironment] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.webViewEnvironment.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformBrowser.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  webViewEnvironment,

  ///Can be used to check if the [AqutterPlatformBrowser.windowId] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.windowId.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformBrowser.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  windowId,
}

extension _AqutterPlatformBrowserPropertySupported on AqutterPlatformBrowser {
  static bool isPropertySupported(
    AqutterPlatformBrowserProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformBrowserProperty.contextMenu:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserProperty.findInteractionController:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserProperty.id:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserProperty.initialUserScripts:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserProperty.pullToRefreshController:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserProperty.webViewEnvironment:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserProperty.windowId:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

///List of [AqutterPlatformBrowser]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformBrowserMethod {
  ///Can be used to check if the [AqutterPlatformBrowser.addMenuItem] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.addMenuItem.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView 14.0+
  ///- macOS WKWebView 10.15+
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [menuItem]: all platforms
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  addMenuItem,

  ///Can be used to check if the [AqutterPlatformBrowser.addMenuItems] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.addMenuItems.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView 14.0+
  ///- macOS WKWebView 10.15+
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [menuItems]: all platforms
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  addMenuItems,

  ///Can be used to check if the [AqutterPlatformBrowser.close] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.close.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  close,

  ///Can be used to check if the [AqutterPlatformBrowser.dispose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.dispose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dispose,

  ///Can be used to check if the [AqutterPlatformBrowser.getOptions] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.getOptions.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use getSettings instead')
  getOptions,

  ///Can be used to check if the [AqutterPlatformBrowser.getSettings] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.getSettings.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getSettings,

  ///Can be used to check if the [AqutterPlatformBrowser.hasMenuItem] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.hasMenuItem.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView 14.0+
  ///- macOS WKWebView 10.15+
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [menuItem]: all platforms
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  hasMenuItem,

  ///Can be used to check if the [AqutterPlatformBrowser.hide] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.hide.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  hide,

  ///Can be used to check if the [AqutterPlatformBrowser.isHidden] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.isHidden.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isHidden,

  ///Can be used to check if the [AqutterPlatformBrowser.isOpened] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.isOpened.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isOpened,

  ///Can be used to check if the [AqutterPlatformBrowser.openData] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.openData.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [data]: all platforms
  ///- [mimeType]: all platforms
  ///- [encoding]: all platforms
  ///- [baseUrl]: all platforms
  ///- [historyUrl]: all platforms
  ///- [settings]: all platforms
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  openData,

  ///Can be used to check if the [AqutterPlatformBrowser.openFile] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.openFile.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [assetFilePath]: all platforms
  ///- [settings]: all platforms
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  openFile,

  ///Can be used to check if the [AqutterPlatformBrowser.openUrlRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.openUrlRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [urlRequest]: all platforms
  ///- [settings]: all platforms
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  openUrlRequest,

  ///Can be used to check if the [AqutterPlatformBrowser.openWithSystemBrowser] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.openWithSystemBrowser.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  openWithSystemBrowser,

  ///Can be used to check if the [AqutterPlatformBrowser.removeAllMenuItem] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.removeAllMenuItem.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView 14.0+
  ///- macOS WKWebView 10.15+
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  removeAllMenuItem,

  ///Can be used to check if the [AqutterPlatformBrowser.removeMenuItem] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.removeMenuItem.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView 14.0+
  ///- macOS WKWebView 10.15+
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [menuItem]: all platforms
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  removeMenuItem,

  ///Can be used to check if the [AqutterPlatformBrowser.removeMenuItems] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.removeMenuItems.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView 14.0+
  ///- macOS WKWebView 10.15+
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [menuItems]: all platforms
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  removeMenuItems,

  ///Can be used to check if the [AqutterPlatformBrowser.setOptions] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.setOptions.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [options]: all platforms
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use setSettings instead')
  setOptions,

  ///Can be used to check if the [AqutterPlatformBrowser.setSettings] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.setSettings.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [settings]: all platforms
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setSettings,

  ///Can be used to check if the [AqutterPlatformBrowser.show] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowser.show.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  show,
}

extension _AqutterPlatformBrowserMethodSupported on AqutterPlatformBrowser {
  static bool isMethodSupported(
    AqutterPlatformBrowserMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformBrowserMethod.addMenuItem:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.addMenuItems:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.close:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.dispose:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.getOptions:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.getSettings:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.hasMenuItem:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.hide:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.isHidden:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.isOpened:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.openData:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.openFile:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.openUrlRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.openWithSystemBrowser:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.removeAllMenuItem:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.removeMenuItem:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.removeMenuItems:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.setOptions:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.setSettings:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserMethod.show:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

///List of [AqutterPlatformBrowserEvents]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformBrowserEventsMethod {
  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidOnFormResubmission] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidOnFormResubmission.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onFormResubmission instead')
  androidOnFormResubmission,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidOnGeolocationPermissionsHidePrompt] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidOnGeolocationPermissionsHidePrompt.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onGeolocationPermissionsHidePrompt instead')
  androidOnGeolocationPermissionsHidePrompt,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidOnGeolocationPermissionsShowPrompt] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidOnGeolocationPermissionsShowPrompt.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [origin]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onGeolocationPermissionsShowPrompt instead')
  androidOnGeolocationPermissionsShowPrompt,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidOnJsBeforeUnload] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidOnJsBeforeUnload.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [jsBeforeUnloadRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onJsBeforeUnload instead')
  androidOnJsBeforeUnload,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidOnPermissionRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidOnPermissionRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [origin]: all platforms
  ///- [resources]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onPermissionRequest instead')
  androidOnPermissionRequest,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidOnReceivedIcon] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidOnReceivedIcon.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [icon]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onReceivedIcon instead')
  androidOnReceivedIcon,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidOnReceivedLoginRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidOnReceivedLoginRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [loginRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onReceivedLoginRequest instead')
  androidOnReceivedLoginRequest,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidOnReceivedTouchIconUrl] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidOnReceivedTouchIconUrl.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [precomposed]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onReceivedTouchIconUrl instead')
  androidOnReceivedTouchIconUrl,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidOnRenderProcessGone] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidOnRenderProcessGone.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [detail]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onRenderProcessGone instead')
  androidOnRenderProcessGone,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidOnRenderProcessResponsive] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidOnRenderProcessResponsive.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onRenderProcessResponsive instead')
  androidOnRenderProcessResponsive,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidOnRenderProcessUnresponsive] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidOnRenderProcessUnresponsive.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onRenderProcessUnresponsive instead')
  androidOnRenderProcessUnresponsive,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidOnSafeBrowsingHit] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidOnSafeBrowsingHit.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [threatType]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onSafeBrowsingHit instead')
  androidOnSafeBrowsingHit,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidOnScaleChanged] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidOnScaleChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [oldScale]: all platforms
  ///- [newScale]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onZoomScaleChanged instead')
  androidOnScaleChanged,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.androidShouldInterceptRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.androidShouldInterceptRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use shouldInterceptRequest instead')
  androidShouldInterceptRequest,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.iosOnDidReceiveServerRedirectForProvisionalNavigation] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.iosOnDidReceiveServerRedirectForProvisionalNavigation.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onDidReceiveServerRedirectForProvisionalNavigation instead')
  iosOnDidReceiveServerRedirectForProvisionalNavigation,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.iosOnNavigationResponse] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.iosOnNavigationResponse.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [navigationResponse]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onNavigationResponse instead')
  iosOnNavigationResponse,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.iosOnWebContentProcessDidTerminate] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.iosOnWebContentProcessDidTerminate.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onWebContentProcessDidTerminate instead')
  iosOnWebContentProcessDidTerminate,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.iosShouldAllowDeprecatedTLS] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.iosShouldAllowDeprecatedTLS.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [challenge]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use shouldAllowDeprecatedTLS instead')
  iosShouldAllowDeprecatedTLS,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onAcceleratorKeyPressed] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onAcceleratorKeyPressed.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2Controller.add_AcceleratorKeyPressed](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller?view=webview2-1.0.2849.39#add_acceleratorkeypressed))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [detail]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onAcceleratorKeyPressed,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onAjaxProgress] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onAjaxProgress.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - In order to be able to listen this event, check the [AqutterWebViewSettings.useShouldInterceptAjaxRequest] and [AqutterWebViewSettings.useOnAjaxProgress] settings documentation. Also, on Android that doesn't support the [AqutterWebViewFeature.DOCUMENT_START_SCRIPT], unlike iOS that has [WKUserScript](https://developer.apple.com/documentation/webkit/wkuserscript) that can inject javascript code right after the document element is created but before any other content is loaded, in Android the javascript code used to intercept ajax requests is loaded as soon as possible so it won't be instantaneous as iOS. In that case, after the `window.addEventListener("aqutterPlatformReady")` event is dispatched, the ajax requests can be intercept for sure.
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [ajaxRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onAjaxProgress,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onAjaxReadyStateChange] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onAjaxReadyStateChange.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - In order to be able to listen this event, check the [AqutterWebViewSettings.useShouldInterceptAjaxRequest] and [AqutterWebViewSettings.useOnAjaxReadyStateChange] settings documentation. Also, on Android that doesn't support the [AqutterWebViewFeature.DOCUMENT_START_SCRIPT], unlike iOS that has [WKUserScript](https://developer.apple.com/documentation/webkit/wkuserscript) that can inject javascript code right after the document element is created but before any other content is loaded, in Android the javascript code used to intercept ajax requests is loaded as soon as possible so it won't be instantaneous as iOS. In that case, after the `window.addEventListener("aqutterPlatformReady")` event is dispatched, the ajax requests can be intercept for sure.
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [ajaxRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onAjaxReadyStateChange,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onBrowserCreated] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onBrowserCreated.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onBrowserCreated,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onCameraCaptureStateChanged] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onCameraCaptureStateChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 15.0+
  ///- macOS WKWebView 12.0+
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [oldState]: all platforms
  ///- [newState]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onCameraCaptureStateChanged,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onCloseWindow] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onCloseWindow.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onCloseWindow](https://developer.android.com/reference/android/webkit/WebChromeClient#onCloseWindow(android.webkit.WebView)))
  ///- iOS WKWebView ([Official API - WKUIDelegate.webViewDidClose](https://developer.apple.com/documentation/webkit/wkuidelegate/1537390-webviewdidclose))
  ///- macOS WKWebView ([Official API - WKUIDelegate.webViewDidClose](https://developer.apple.com/documentation/webkit/wkuidelegate/1537390-webviewdidclose))
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_WindowCloseRequested](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_windowcloserequested))
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onCloseWindow,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onConsoleMessage] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onConsoleMessage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onConsoleMessage](https://developer.android.com/reference/android/webkit/WebChromeClient#onConsoleMessage(android.webkit.AqutterConsoleMessage)))
  ///- iOS WKWebView:
  ///    - This event is implemented using JavaScript.
  ///- macOS WKWebView:
  ///    - This event is implemented using JavaScript.
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [consoleMessage]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onConsoleMessage,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onContentLoading] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onContentLoading.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ContentLoading](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_contentloading))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onContentLoading,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onContentSizeChanged] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onContentSizeChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [oldContentSize]: all platforms
  ///- [newContentSize]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onContentSizeChanged,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onCreateWindow] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onCreateWindow.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onCreateWindow](https://developer.android.com/reference/android/webkit/WebChromeClient#onCreateWindow(android.webkit.WebView,%20boolean,%20boolean,%20android.os.Message))):
  ///    - You need to set [AqutterWebViewSettings.supportMultipleWindows] setting to `true`. Also, if the request has been created using JavaScript (`window.open()`), then there are some limitation: check the [AqutterNavigationAction] class.
  ///- iOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1536907-webview)):
  ///    - Setting these initial settings [AqutterWebViewSettings.supportZoom], [AqutterWebViewSettings.useOnLoadResource], [AqutterWebViewSettings.useShouldInterceptAjaxRequest], [AqutterWebViewSettings.useShouldInterceptFetchRequest], [AqutterWebViewSettings.applicationNameForUserAgent], [AqutterWebViewSettings.javaScriptCanOpenWindowsAutomatically], [AqutterWebViewSettings.javaScriptEnabled], [AqutterWebViewSettings.minimumFontSize], [AqutterWebViewSettings.preferredContentMode], [AqutterWebViewSettings.incognito], [AqutterWebViewSettings.cacheEnabled], [AqutterWebViewSettings.mediaPlaybackRequiresUserGesture], [AqutterWebViewSettings.resourceCustomSchemes], [AqutterWebViewSettings.sharedCookiesEnabled], [AqutterWebViewSettings.enableViewportScale], [AqutterWebViewSettings.allowsAirPlayForMediaPlayback], [AqutterWebViewSettings.allowsPictureInPictureMediaPlayback], [AqutterWebViewSettings.isFraudulentWebsiteWarningEnabled], [AqutterWebViewSettings.allowsInlineMediaPlayback], [AqutterWebViewSettings.suppressesIncrementalRendering], [AqutterWebViewSettings.selectionGranularity], [AqutterWebViewSettings.ignoresViewportScaleLimits], [AqutterWebViewSettings.limitsNavigationsToAppBoundDomains], [AqutterWebViewSettings.upgradeKnownHostsToHTTPS], will have no effect due to a `WKWebView` limitation when creating the new window WebView: it's impossible to return the new `WKWebView` with a different `WKWebViewConfiguration` instance (see https://developer.apple.com/documentation/webkit/wkuidelegate/1536907-webview). So, these options will be inherited from the caller WebView. Also, note that calling [AqutterWebViewController.setSettings] method using the controller of the new created WebView, it will update also the WebView options of the caller WebView.
  ///- macOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1536907-webview)):
  ///    - Setting these initial settings [AqutterWebViewSettings.supportZoom], [AqutterWebViewSettings.useOnLoadResource], [AqutterWebViewSettings.useShouldInterceptAjaxRequest], [AqutterWebViewSettings.useShouldInterceptFetchRequest], [AqutterWebViewSettings.applicationNameForUserAgent], [AqutterWebViewSettings.javaScriptCanOpenWindowsAutomatically], [AqutterWebViewSettings.javaScriptEnabled], [AqutterWebViewSettings.minimumFontSize], [AqutterWebViewSettings.preferredContentMode], [AqutterWebViewSettings.incognito], [AqutterWebViewSettings.cacheEnabled], [AqutterWebViewSettings.mediaPlaybackRequiresUserGesture], [AqutterWebViewSettings.resourceCustomSchemes], [AqutterWebViewSettings.sharedCookiesEnabled], [AqutterWebViewSettings.enableViewportScale], [AqutterWebViewSettings.allowsAirPlayForMediaPlayback], [AqutterWebViewSettings.allowsPictureInPictureMediaPlayback], [AqutterWebViewSettings.isFraudulentWebsiteWarningEnabled], [AqutterWebViewSettings.allowsInlineMediaPlayback], [AqutterWebViewSettings.suppressesIncrementalRendering], [AqutterWebViewSettings.selectionGranularity], [AqutterWebViewSettings.ignoresViewportScaleLimits], [AqutterWebViewSettings.limitsNavigationsToAppBoundDomains], [AqutterWebViewSettings.upgradeKnownHostsToHTTPS], will have no effect due to a `WKWebView` limitation when creating the new window WebView: it's impossible to return the new `WKWebView` with a different `WKWebViewConfiguration` instance (see https://developer.apple.com/documentation/webkit/wkuidelegate/1536907-webview). So, these options will be inherited from the caller WebView. Also, note that calling [AqutterWebViewController.setSettings] method using the controller of the new created WebView, it will update also the WebView options of the caller WebView.
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_NewWindowRequested](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_newwindowrequested))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [createWindowAction]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onCreateWindow,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onDOMContentLoaded] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onDOMContentLoaded.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2_2.add_DOMContentLoaded](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_2?view=webview2-1.0.2210.55#add_domcontentloaded))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onDOMContentLoaded,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onDidReceiveServerRedirectForProvisionalNavigation] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onDidReceiveServerRedirectForProvisionalNavigation.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455627-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455627-webview))
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onDidReceiveServerRedirectForProvisionalNavigation,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onDownloadStart] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onDownloadStart.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onDownloadStarting instead')
  onDownloadStart,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onDownloadStartRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onDownloadStartRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [downloadStartRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onDownloadStarting instead')
  onDownloadStartRequest,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onDownloadStarting] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onDownloadStarting.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebView.setDownloadListener]((https://developer.android.com/reference/android/webkit/WebView#setDownloadListener(android.webkit.DownloadListener)))
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2 ([Official API - ICoreWebView2_4.add_DownloadStarting](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_4?view=webview2-1.0.2849.39#add_downloadstarting))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [downloadStartRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onDownloadStarting,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onEnterFullscreen] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onEnterFullscreen.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onShowCustomView](https://developer.android.com/reference/android/webkit/WebChromeClient#onShowCustomView(android.view.View,%20android.webkit.WebChromeClient.CustomViewCallback)))
  ///- iOS WKWebView ([Official API - UIWindow.didBecomeVisibleNotification](https://developer.apple.com/documentation/uikit/uiwindow/1621621-didbecomevisiblenotification))
  ///- macOS WKWebView ([Official API - NSWindow.didEnterFullScreenNotification](https://developer.apple.com/documentation/appkit/nswindow/1419651-didenterfullscreennotification))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ContainsFullScreenElementChanged](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_containsfullscreenelementchanged))
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onEnterFullscreen,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onExit] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onExit.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onExit,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onExitFullscreen] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onExitFullscreen.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onHideCustomView](https://developer.android.com/reference/android/webkit/WebChromeClient#onHideCustomView()))
  ///- iOS WKWebView ([Official API - UIWindow.didBecomeHiddenNotification](https://developer.apple.com/documentation/uikit/uiwindow/1621617-didbecomehiddennotification))
  ///- macOS WKWebView ([Official API - NSWindow.didExitFullScreenNotification](https://developer.apple.com/documentation/appkit/nswindow/1419177-didexitfullscreennotification))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ContainsFullScreenElementChanged](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_containsfullscreenelementchanged))
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onExitFullscreen,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onFaviconChanged] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onFaviconChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onReceivedIcon](https://developer.android.com/reference/android/webkit/WebChromeClient#onReceivedIcon(android.webkit.WebView,%20android.graphics.Bitmap)))
  ///- Windows WebView2 ([Official API - ICoreWebView2_15.add_FaviconChanged](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_15?view=webview2-1.0.2849.39#add_faviconchanged))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [faviconChangedRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onFaviconChanged,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onFindResultReceived] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onFindResultReceived.supported_platforms}
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
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated(
    'Use AqutterFindInteractionController.onFindResultReceived instead',
  )
  onFindResultReceived,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onFormResubmission] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onFormResubmission.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onFormResubmission](https://developer.android.com/reference/android/webkit/WebViewClient#onFormResubmission(android.webkit.WebView,%20android.os.Message,%20android.os.Message)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onFormResubmission,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onGeolocationPermissionsHidePrompt] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onGeolocationPermissionsHidePrompt.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onGeolocationPermissionsHidePrompt](https://developer.android.com/reference/android/webkit/WebChromeClient#onGeolocationPermissionsHidePrompt()))
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onGeolocationPermissionsHidePrompt,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onGeolocationPermissionsShowPrompt] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onGeolocationPermissionsShowPrompt.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onGeolocationPermissionsShowPrompt](https://developer.android.com/reference/android/webkit/WebChromeClient#onGeolocationPermissionsShowPrompt(java.lang.String,%20android.webkit.GeolocationPermissions.Callback)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [origin]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onGeolocationPermissionsShowPrompt,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onJsAlert] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onJsAlert.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onJsAlert](https://developer.android.com/reference/android/webkit/WebChromeClient#onJsAlert(android.webkit.WebView,%20java.lang.String,%20java.lang.String,%20android.webkit.JsResult)))
  ///- iOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1537406-webview))
  ///- macOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1537406-webview))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [jsAlertRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onJsAlert,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onJsConfirm] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onJsConfirm.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onJsConfirm](https://developer.android.com/reference/android/webkit/WebChromeClient#onJsConfirm(android.webkit.WebView,%20java.lang.String,%20java.lang.String,%20android.webkit.JsResult)))
  ///- iOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1536489-webview))
  ///- macOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1536489-webview))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [jsConfirmRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onJsConfirm,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onJsPrompt] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onJsPrompt.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onJsPrompt](https://developer.android.com/reference/android/webkit/WebChromeClient#onJsPrompt(android.webkit.WebView,%20java.lang.String,%20java.lang.String,%20java.lang.String,%20android.webkit.JsPromptResult)))
  ///- iOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1538086-webview))
  ///- macOS WKWebView ([Official API - WKUIDelegate.webView](https://developer.apple.com/documentation/webkit/wkuidelegate/1538086-webview))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [jsPromptRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onJsPrompt,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onLaunchingExternalUriScheme] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onLaunchingExternalUriScheme.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2_18.add_LaunchingExternalUriScheme](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_18?view=webview2-1.0.2849.39#add_launchingexternalurischeme))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onLaunchingExternalUriScheme,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onLoadError] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onLoadError.supported_platforms}
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
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onReceivedError instead')
  onLoadError,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onLoadHttpError] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onLoadHttpError.supported_platforms}
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
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onReceivedHttpError instead')
  onLoadHttpError,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onLoadResource] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onLoadResource.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - This event is implemented using JavaScript.
  ///- iOS WKWebView:
  ///    - This event is implemented using JavaScript.
  ///- macOS WKWebView:
  ///    - This event is implemented using JavaScript.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [resource]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onLoadResource,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onLoadResourceCustomScheme] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onLoadResourceCustomScheme.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onLoadResourceWithCustomScheme instead')
  onLoadResourceCustomScheme,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onLoadResourceWithCustomScheme] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onLoadResourceWithCustomScheme.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView ([Official API - WKURLSchemeHandler](https://developer.apple.com/documentation/webkit/wkurlschemehandler))
  ///- macOS WKWebView ([Official API - WKURLSchemeHandler](https://developer.apple.com/documentation/webkit/wkurlschemehandler))
  ///- Windows WebView2
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onLoadResourceWithCustomScheme,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onLoadStart] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onLoadStart.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onPageStarted](https://developer.android.com/reference/android/webkit/WebViewClient#onPageStarted(android.webkit.WebView,%20java.lang.String,%20android.graphics.Bitmap)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455621-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455621-webview))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_NavigationStarting](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/iwebview2webview?view=webview2-0.8.355#add_navigationstarting))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onLoadStart,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onLoadStop] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onLoadStop.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onPageFinished](https://developer.android.com/reference/android/webkit/WebViewClient#onPageFinished(android.webkit.WebView,%20java.lang.String)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455629-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455629-webview))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_NavigationCompleted](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/iwebview2webview?view=webview2-0.8.355#add_navigationcompleted))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onLoadStop,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onLongPressHitTestResult] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onLongPressHitTestResult.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - View.setOnLongClickListener](https://developer.android.com/reference/android/view/View#setOnLongClickListener(android.view.View.OnLongClickListener)))
  ///- iOS WKWebView ([Official API - UILongPressGestureRecognizer](https://developer.apple.com/documentation/uikit/uilongpressgesturerecognizer))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [hitTestResult]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onLongPressHitTestResult,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onMainWindowWillClose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onMainWindowWillClose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onMainWindowWillClose,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onMicrophoneCaptureStateChanged] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onMicrophoneCaptureStateChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 15.0+
  ///- macOS WKWebView 12.0+
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [oldState]: all platforms
  ///- [newState]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onMicrophoneCaptureStateChanged,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onNavigationResponse] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onNavigationResponse.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455643-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455643-webview))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [navigationResponse]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onNavigationResponse,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onNotificationReceived] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onNotificationReceived.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2_24.add_NotificationReceived](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_24?view=webview2-1.0.2849.39#add_notificationreceived))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onNotificationReceived,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onOverScrolled] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onOverScrolled.supported_platforms}
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
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onOverScrolled,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onPageCommitVisible] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onPageCommitVisible.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onPageCommitVisible](https://developer.android.com/reference/android/webkit/WebViewClient#onPageCommitVisible(android.webkit.WebView,%20java.lang.String)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455635-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455635-webview))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onPageCommitVisible,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onPermissionRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onPermissionRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 21+ ([Official API - WebChromeClient.onPermissionRequest](https://developer.android.com/reference/android/webkit/WebChromeClient#onPermissionRequest(android.webkit.AqutterPermissionRequest)))
  ///- iOS WKWebView 15.0+:
  ///    - The default [AqutterPermissionResponse.action] is [AqutterPermissionResponseAction.PROMPT].
  ///- macOS WKWebView 12.0+:
  ///    - The default [AqutterPermissionResponse.action] is [AqutterPermissionResponseAction.PROMPT].
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_PermissionRequested](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_permissionrequested))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [permissionRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onPermissionRequest,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onPermissionRequestCanceled] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onPermissionRequestCanceled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 21+ ([Official API - WebChromeClient.onPermissionRequestCanceled](https://developer.android.com/reference/android/webkit/WebChromeClient#onPermissionRequestCanceled(android.webkit.AqutterPermissionRequest)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [permissionRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onPermissionRequestCanceled,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onPrint] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onPrint.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onPrintRequest instead')
  onPrint,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onPrintRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onPrintRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - View.scrollBy](https://developer.android.com/reference/android/view/View#scrollBy(int,%20int)))
  ///- iOS WKWebView ([Official API - UIScrollView.setContentOffset](https://developer.apple.com/documentation/uikit/uiscrollview/1619400-setcontentoffset))
  ///- macOS WKWebView:
  ///    - This method is implemented using JavaScript.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [printJobController]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onPrintRequest,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onProcessFailed] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onProcessFailed.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ProcessFailed](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2849.39#add_processfailed))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [detail]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onProcessFailed,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onProgressChanged] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onProgressChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onProgressChanged](https://developer.android.com/reference/android/webkit/WebChromeClient#onProgressChanged(android.webkit.WebView,%20int)))
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [progress]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onProgressChanged,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onReceivedClientCertRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onReceivedClientCertRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onReceivedClientCertRequest](https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedClientCertRequest(android.webkit.WebView,%20android.webkit.ClientCertRequest)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview))
  ///- Windows WebView2 ([Official API - ICoreWebView2_5.add_ClientCertificateRequested](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_5?view=webview2-1.0.2849.39#add_clientcertificaterequested))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [challenge]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onReceivedClientCertRequest,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onReceivedError] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onReceivedError.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onReceivedError](https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedError(android.webkit.WebView,%20android.webkit.AqutterWebResourceRequest,%20android.webkit.AqutterWebResourceError)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455623-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455623-webview))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_NavigationCompleted](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/iwebview2webview?view=webview2-0.8.355#add_navigationcompleted))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///- [error]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onReceivedError,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onReceivedHttpAuthRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onReceivedHttpAuthRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onReceivedHttpAuthRequest](https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedHttpAuthRequest(android.webkit.WebView,%20android.webkit.HttpAuthHandler,%20java.lang.String,%20java.lang.String)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview))
  ///- Windows WebView2 ([Official API - ICoreWebView2_10.add_BasicAuthenticationRequested](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_10?view=webview2-1.0.2849.39#add_basicauthenticationrequested))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [challenge]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onReceivedHttpAuthRequest,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onReceivedHttpError] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onReceivedHttpError.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 23+ ([Official API - WebViewClient.onReceivedHttpError](https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedHttpError(android.webkit.WebView,%20android.webkit.AqutterWebResourceRequest,%20android.webkit.AqutterWebResourceResponse)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455643-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455643-webview))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_NavigationCompleted](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/iwebview2webview?view=webview2-0.8.355#add_navigationcompleted))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///- [errorResponse]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onReceivedHttpError,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onReceivedIcon] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onReceivedIcon.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onReceivedIcon](https://developer.android.com/reference/android/webkit/WebChromeClient#onReceivedIcon(android.webkit.WebView,%20android.graphics.Bitmap)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [icon]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use onFaviconChanged instead')
  onReceivedIcon,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onReceivedLoginRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onReceivedLoginRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onReceivedLoginRequest](https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedLoginRequest(android.webkit.WebView,%20java.lang.String,%20java.lang.String,%20java.lang.String)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [loginRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onReceivedLoginRequest,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onReceivedServerTrustAuthRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onReceivedServerTrustAuthRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onReceivedSslError](https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedSslError(android.webkit.WebView,%20android.webkit.SslErrorHandler,%20android.net.http.AqutterSslError)))
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview)):
  ///    - To override the certificate verification logic, you have to provide ATS (App Transport Security) exceptions in your iOS/macOS `Info.plist`. See `NSAppTransportSecurity` in the [Information Property List Key Reference](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW1) for details.
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview)):
  ///    - To override the certificate verification logic, you have to provide ATS (App Transport Security) exceptions in your iOS/macOS `Info.plist`. See `NSAppTransportSecurity` in the [Information Property List Key Reference](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW1) for details.
  ///- Windows WebView2 ([Official API - ICoreWebView2_14.add_ServerCertificateErrorDetected](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_14?view=webview2-1.0.2792.45#add_servercertificateerrordetected))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [challenge]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onReceivedServerTrustAuthRequest,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onReceivedTouchIconUrl] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onReceivedTouchIconUrl.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onReceivedTouchIconUrl](https://developer.android.com/reference/android/webkit/WebChromeClient#onReceivedTouchIconUrl(android.webkit.WebView,%20java.lang.String,%20boolean)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [precomposed]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onReceivedTouchIconUrl,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onRenderProcessGone] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onRenderProcessGone.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 26+ ([Official API - WebViewClient.onRenderProcessGone](https://developer.android.com/reference/android/webkit/WebViewClient#onRenderProcessGone(android.webkit.WebView,%20android.webkit.AqutterRenderProcessGoneDetail)))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ProcessFailed](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2849.39#add_processfailed))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [detail]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onRenderProcessGone,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onRenderProcessResponsive] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onRenderProcessResponsive.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 29+ ([Official API - WebViewRenderProcessClient.onRenderProcessResponsive](https://developer.android.com/reference/android/webkit/WebViewRenderProcessClient#onRenderProcessResponsive(android.webkit.WebView,%20android.webkit.WebViewRenderProcess)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onRenderProcessResponsive,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onRenderProcessUnresponsive] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onRenderProcessUnresponsive.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 29+ ([Official API - WebViewRenderProcessClient.onRenderProcessUnresponsive](https://developer.android.com/reference/android/webkit/WebViewRenderProcessClient#onRenderProcessUnresponsive(android.webkit.WebView,%20android.webkit.WebViewRenderProcess)))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ProcessFailed](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2849.39#add_processfailed))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onRenderProcessUnresponsive,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onRequestFocus] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onRequestFocus.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onRequestFocus](https://developer.android.com/reference/android/webkit/WebChromeClient#onRequestFocus(android.webkit.WebView)))
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onRequestFocus,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onSafeBrowsingHit] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onSafeBrowsingHit.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 27+ ([Official API - WebViewClient.onSafeBrowsingHit](https://developer.android.com/reference/android/webkit/WebViewClient#onSafeBrowsingHit(android.webkit.WebView,%20android.webkit.AqutterWebResourceRequest,%20int,%20android.webkit.AqutterSafeBrowsingResponse)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [threatType]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onSafeBrowsingHit,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onSaveAsUIShowing] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onSaveAsUIShowing.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2_25.add_SaveAsUIShowing](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_25?view=webview2-1.0.2849.39#add_saveasuishowing))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onSaveAsUIShowing,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onSaveFileSecurityCheckStarting] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onSaveFileSecurityCheckStarting.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2_26.add_SaveFileSecurityCheckStarting](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_26?view=webview2-1.0.2849.39#add_savefilesecuritycheckstarting))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onSaveFileSecurityCheckStarting,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onScreenCaptureStarting] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onScreenCaptureStarting.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2_27.add_ScreenCaptureStarting](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_27?view=webview2-1.0.2849.39#add_screencapturestarting))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onScreenCaptureStarting,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onScrollChanged] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onScrollChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebView.onScrollChanged](https://developer.android.com/reference/android/webkit/WebView#onScrollChanged(int,%20int,%20int,%20int)))
  ///- iOS WKWebView ([Official API - UIScrollViewDelegate.scrollViewDidScroll](https://developer.apple.com/documentation/uikit/uiscrollviewdelegate/1619392-scrollviewdidscroll))
  ///- macOS WKWebView:
  ///    - This event is implemented using JavaScript.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [x]: all platforms
  ///- [y]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onScrollChanged,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onShowFileChooser] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onShowFileChooser.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onShowFileChooser](https://developer.android.com/reference/android/webkit/WebChromeClient#onShowFileChooser(android.webkit.WebView,%20android.webkit.ValueCallback%3Candroid.net.Uri[]%3E,%20android.webkit.WebChromeClient.FileChooserParams)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onShowFileChooser,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onTitleChanged] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onTitleChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebChromeClient.onReceivedTitle](https://developer.android.com/reference/android/webkit/WebChromeClient#onReceivedTitle(android.webkit.WebView,%20java.lang.String)))
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_DocumentTitleChanged](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_documenttitlechanged))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [title]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onTitleChanged,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onUpdateVisitedHistory] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onUpdateVisitedHistory.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.doUpdateVisitedHistory](https://developer.android.com/reference/android/webkit/WebViewClient#doUpdateVisitedHistory(android.webkit.WebView,%20java.lang.String,%20boolean)))
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_HistoryChanged](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_historychanged))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [isReload]:
  ///    - Android WebView
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onUpdateVisitedHistory,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onWebContentProcessDidTerminate] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onWebContentProcessDidTerminate.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webViewWebContentProcessDidTerminate](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455639-webviewwebcontentprocessdidtermi))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webViewWebContentProcessDidTerminate](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455639-webviewwebcontentprocessdidtermi))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_ProcessFailed](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2849.39#add_processfailed))
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onWebContentProcessDidTerminate,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onWindowBlur] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onWindowBlur.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onWindowBlur,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onWindowFocus] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onWindowFocus.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onWindowFocus,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.onZoomScaleChanged] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onZoomScaleChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.onScaleChanged](https://developer.android.com/reference/android/webkit/WebViewClient#onScaleChanged(android.webkit.WebView,%20float,%20float)))
  ///- iOS WKWebView ([Official API - UIScrollViewDelegate.scrollViewDidZoom](https://developer.apple.com/documentation/uikit/uiscrollviewdelegate/1619409-scrollviewdidzoom))
  ///- Windows WebView2 ([Official API - ICoreWebView2Controller.add_ZoomFactorChanged](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller?view=webview2-1.0.2849.39#add_zoomfactorchanged))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [oldScale]: all platforms
  ///- [newScale]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onZoomScaleChanged,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.shouldAllowDeprecatedTLS] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.shouldAllowDeprecatedTLS.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 14.0+ ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/3601237-webview))
  ///- macOS WKWebView 11.0+ ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/3601237-webview))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [challenge]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  shouldAllowDeprecatedTLS,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.shouldInterceptAjaxRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.shouldInterceptAjaxRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - In order to be able to listen this event, check the [AqutterWebViewSettings.useShouldInterceptAjaxRequest] setting documentation. Also, on Android that doesn't support the [AqutterWebViewFeature.DOCUMENT_START_SCRIPT], unlike iOS that has [WKUserScript](https://developer.apple.com/documentation/webkit/wkuserscript) that can inject javascript code right after the document element is created but before any other content is loaded, in Android the javascript code used to intercept ajax requests is loaded as soon as possible so it won't be instantaneous as iOS. In that case, after the `window.addEventListener("aqutterPlatformReady")` event is dispatched, the ajax requests can be intercept for sure.
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [ajaxRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  shouldInterceptAjaxRequest,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.shouldInterceptFetchRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.shouldInterceptFetchRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - In order to be able to listen this event, check the [AqutterWebViewSettings.useShouldInterceptFetchRequest] setting documentation. Also, on Android that doesn't support the [AqutterWebViewFeature.DOCUMENT_START_SCRIPT], unlike iOS that has [WKUserScript](https://developer.apple.com/documentation/webkit/wkuserscript) that can inject javascript code right after the document element is created but before any other content is loaded, in Android the javascript code used to intercept ajax requests is loaded as soon as possible so it won't be instantaneous as iOS. In that case, after the `window.addEventListener("aqutterPlatformReady")` event is dispatched, the ajax requests can be intercept for sure.
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [fetchRequest]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  shouldInterceptFetchRequest,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.shouldInterceptRequest] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.shouldInterceptRequest.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.shouldInterceptRequest](https://developer.android.com/reference/android/webkit/WebViewClient#shouldInterceptRequest(android.webkit.WebView,%20android.webkit.AqutterWebResourceRequest)))
  ///- Windows WebView2 ([Official API - ICoreWebView2.add_WebResourceRequested](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2478.35#add_webresourcerequested))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [request]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  shouldInterceptRequest,

  ///Can be used to check if the [AqutterPlatformBrowserEvents.shouldOverrideUrlLoading] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.shouldOverrideUrlLoading.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - WebViewClient.shouldOverrideUrlLoading](https://developer.android.com/reference/android/webkit/WebViewClient#shouldOverrideUrlLoading(android.webkit.WebView,%20java.lang.String))):
  ///    - There isn't any way to load an URL for a frame that is not the main frame, so if the request is not for the main frame, the navigation is allowed by default. However, if you want to cancel requests for subframes, you can use the [AqutterWebViewSettings.regexToCancelSubFramesLoading] setting to write a Regular Expression that, if the url request of a subframe matches, then the request of that subframe is canceled. Instead, the [AqutterWebViewSettings.regexToAllowSyncUrlLoading] setting could be used to allow navigation requests synchronously, as this event is synchronous on native side and the current plugin implementation will always cancel the current request and load a new request if this event returns [AqutterNavigationActionPolicy.ALLOW] because Flutter method channels work only asynchronously. Also, this event is not called for POST requests and is not called on the first page load.
  ///- iOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455641-webview))
  ///- macOS WKWebView ([Official API - WKNavigationDelegate.webView](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455641-webview))
  ///- Windows WebView2
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [navigationAction]: all platforms
  ///
  ///Use the [AqutterPlatformBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  shouldOverrideUrlLoading,
}

extension _AqutterPlatformBrowserEventsMethodSupported
    on AqutterPlatformBrowserEvents {
  static bool isMethodSupported(
    AqutterPlatformBrowserEventsMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformBrowserEventsMethod.androidOnFormResubmission:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod
          .androidOnGeolocationPermissionsHidePrompt:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod
          .androidOnGeolocationPermissionsShowPrompt:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.androidOnJsBeforeUnload:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.androidOnPermissionRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.androidOnReceivedIcon:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.androidOnReceivedLoginRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.androidOnReceivedTouchIconUrl:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.androidOnRenderProcessGone:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.androidOnRenderProcessResponsive:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod
          .androidOnRenderProcessUnresponsive:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.androidOnSafeBrowsingHit:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.androidOnScaleChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.androidShouldInterceptRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod
          .iosOnDidReceiveServerRedirectForProvisionalNavigation:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.iosOnNavigationResponse:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod
          .iosOnWebContentProcessDidTerminate:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.iosShouldAllowDeprecatedTLS:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onAcceleratorKeyPressed:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onAjaxProgress:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onAjaxReadyStateChange:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onBrowserCreated:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onCameraCaptureStateChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onCloseWindow:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onConsoleMessage:
        return kIsWeb && platform == null
            ? true
            : ((kIsWeb && platform != null) || !kIsWeb) &&
                  [
                    TargetPlatform.android,
                    TargetPlatform.iOS,
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                  ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onContentLoading:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onContentSizeChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onCreateWindow:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onDOMContentLoaded:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod
          .onDidReceiveServerRedirectForProvisionalNavigation:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onDownloadStart:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onDownloadStartRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onDownloadStarting:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onEnterFullscreen:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onExit:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onExitFullscreen:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onFaviconChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onFindResultReceived:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onFormResubmission:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod
          .onGeolocationPermissionsHidePrompt:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod
          .onGeolocationPermissionsShowPrompt:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onJsAlert:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onJsConfirm:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onJsPrompt:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onLaunchingExternalUriScheme:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onLoadError:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onLoadHttpError:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onLoadResource:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onLoadResourceCustomScheme:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onLoadResourceWithCustomScheme:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onLoadStart:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onLoadStop:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onLongPressHitTestResult:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onMainWindowWillClose:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onMicrophoneCaptureStateChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onNavigationResponse:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onNotificationReceived:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onOverScrolled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onPageCommitVisible:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onPermissionRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onPermissionRequestCanceled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onPrint:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onPrintRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onProcessFailed:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onProgressChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onReceivedClientCertRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onReceivedError:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onReceivedHttpAuthRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onReceivedHttpError:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onReceivedIcon:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onReceivedLoginRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onReceivedServerTrustAuthRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onReceivedTouchIconUrl:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onRenderProcessGone:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onRenderProcessResponsive:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onRenderProcessUnresponsive:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onRequestFocus:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onSafeBrowsingHit:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onSaveAsUIShowing:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onSaveFileSecurityCheckStarting:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onScreenCaptureStarting:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onScrollChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onShowFileChooser:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onTitleChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onUpdateVisitedHistory:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onWebContentProcessDidTerminate:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onWindowBlur:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onWindowFocus:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.onZoomScaleChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.shouldAllowDeprecatedTLS:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.shouldInterceptAjaxRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.shouldInterceptFetchRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.shouldInterceptRequest:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformBrowserEventsMethod.shouldOverrideUrlLoading:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
