import 'dart:collection';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../context_menu/main.dart';
import '../debug_logging_settings.dart';
import '../find_interaction/platform_find_interaction_controller.dart';
import '../browser/platform_browser.dart';
import '../webview_platform.dart';
import '../platform_webview_feature.dart';
import '../print_job/main.dart';
import '../types/main.dart';
import '../web_message/main.dart';
import '../web_storage/platform_web_storage.dart';
import '../web_uri.dart';
import 'webview_keep_alive.dart';
import 'webview_settings.dart';
import 'platform_headless_webview.dart';
import 'platform_webview_widget.dart';
import 'platform_webview.dart';

part 'platform_webview_controller.g.dart';

///List of forbidden names for JavaScript handlers used internally bu the plugin.
final kJavaScriptHandlerForbiddenNames = UnmodifiableListView<String>([
  "onLoadResource",
  "onConsoleMessage",
  "shouldInterceptAjaxRequest",
  "onAjaxReadyStateChange",
  "onAjaxProgress",
  "shouldInterceptFetchRequest",
  "onPrintRequest",
  "onWindowFocus",
  "onWindowBlur",
  "callAsyncJavaScript",
  "evaluateJavaScriptWithContentWorld",
  "onFindResultReceived",
  "onCallAsyncJavaScriptResultBelowIOS14Received",
  "onWebMessagePortMessageReceived",
  "onWebMessageListenerPostMessageReceived",
  "onScrollChanged",
]);

/// Object specifying creation parameters for creating a [AqutterPlatformWebViewController].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
@immutable
class AqutterPlatformWebViewControllerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformWebViewController].
  const AqutterPlatformWebViewControllerCreationParams({
    required this.id,
    this.webviewParams,
  });

  ///{@macro aqutter_core.AqutterPlatformWebViewController.id}
  final dynamic id;

  ///{@macro aqutter_core.AqutterPlatformWebViewController.webviewParams}
  final AqutterPlatformWebViewCreationParams? webviewParams;
}

///{@template aqutter_core.AqutterPlatformWebViewController}
///Controls a WebView, such as an [AqutterWebView] widget instance, a [AqutterHeadlessWebView] instance or [AqutterPlatformBrowser] WebView instance.
///
///If you are using the [AqutterWebView] widget, an [AqutterPlatformWebViewController] instance can be obtained by setting the [AqutterWebView.onWebViewCreated]
///callback. Instead, if you are using an [AqutterPlatformBrowser] instance, you can get it through the [AqutterPlatformBrowser.webViewController] attribute.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebViewController.supported_platforms}
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
abstract class AqutterPlatformWebViewController extends PlatformInterface
    implements AqutterDisposable {
  ///Debug settings used by [AqutterPlatformWebViewWidget], [AqutterPlatformHeadlessWebView] and [AqutterPlatformBrowser].
  ///The default value excludes the [AqutterPlatformWebViewCreationParams.onScrollChanged], [AqutterPlatformWebViewCreationParams.onOverScrolled] and [AqutterPlatformWebViewCreationParams.onReceivedIcon] events.
  static AqutterDebugLoggingSettings debugLoggingSettings = AqutterDebugLoggingSettings(
    maxLogMessageLength: 1000,
    excludeFilter: [
      RegExp(r"onScrollChanged"),
      RegExp(r"onOverScrolled"),
      RegExp(r"onReceivedIcon"),
    ],
  );

  /// Creates a new [AqutterPlatformWebViewController]
  factory AqutterPlatformWebViewController(
    AqutterPlatformWebViewControllerCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebViewController webViewController =
        AqutterWebViewPlatform.instance!.createPlatformWebViewController(
          params,
        );
    PlatformInterface.verify(webViewController, _token);
    return webViewController;
  }

  /// Creates a new [AqutterPlatformWebViewController] to access static methods.
  factory AqutterPlatformWebViewController.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebViewController webViewControllerStatic =
        AqutterWebViewPlatform.instance!
            .createPlatformWebViewControllerStatic();
    PlatformInterface.verify(webViewControllerStatic, _token);
    return webViewControllerStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformWebViewController].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformWebViewController.implementation(this.params)
    : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformWebViewController].
  final AqutterPlatformWebViewControllerCreationParams params;

  ///{@template aqutter_core.AqutterPlatformWebViewController.id}
  /// WebView ID.
  ///{@endtemplate}
  dynamic get id => params.id;

  ///{@template aqutter_core.AqutterPlatformWebViewController.webviewParams}
  /// WebView params.
  ///{@endtemplate}
  AqutterPlatformWebViewCreationParams? get webviewParams => params.webviewParams;

  ///{@template aqutter_core.AqutterPlatformWebViewController.webStorage}
  ///Provides access to the JavaScript [Web AqutterStorage API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Storage_API): `window.sessionStorage` and `window.localStorage`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.webStorage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  AqutterPlatformWebStorage get webStorage => throw UnimplementedError(
    '${AqutterPlatformWebViewControllerProperty.webStorage.name} is not implemented on the current platform',
  );

  ///{@template aqutter_core.AqutterPlatformWebViewController.getUrl}
  ///Gets the URL for the current page.
  ///This is not always the same as the URL passed to [AqutterPlatformWebViewCreationParams.onLoadStart] because although the load for that URL has begun, the current page may not have changed.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getUrl.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.getUrl',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#getUrl()',
      ),
      IOSPlatform(
        apiName: 'WKWebView.url',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1415005-url',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.url',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1415005-url',
      ),
      WebPlatform(
        note:
            "If `window.location.href` isn't accessible inside the iframe, it will return the current value of the `iframe.src` attribute.",
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.get_Source',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#get_source',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_get_uri',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.get_uri.html',
      ),
    ],
  )
  Future<AqutterWebUri?> getUrl() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getUrl.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getTitle}
  ///Gets the title for the current page.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getTitle.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.getTitle',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#getTitle()',
      ),
      IOSPlatform(
        apiName: 'WKWebView.title',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1415015-title',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.title',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1415015-title',
      ),
      WebPlatform(),
      WindowsPlatform(
        apiName: 'ICoreWebView2.get_DocumentTitle',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#get_documenttitle',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_get_title',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.get_title.html',
      ),
    ],
  )
  Future<String?> getTitle() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getTitle.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getFrameId}
  ///Gets the ID of the main frame.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getFrameId.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2_20.get_FrameId',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_20?view=webview2-1.0.2849.39#get_frameid',
      ),
    ],
  )
  Future<int?> getFrameId() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getFrameId.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getMemoryUsageTargetLevel}
  ///Gets the WebView memory usage target level.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getMemoryUsageTargetLevel.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2_19.get_MemoryUsageTargetLevel',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_19?view=webview2-1.0.2849.39#get_memoryusagetargetlevel',
      ),
    ],
  )
  Future<AqutterMemoryUsageTargetLevel?> getMemoryUsageTargetLevel() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getMemoryUsageTargetLevel.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setMemoryUsageTargetLevel}
  ///Sets the WebView memory usage target level.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setMemoryUsageTargetLevel.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2_19.put_MemoryUsageTargetLevel',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_19?view=webview2-1.0.2849.39#put_memoryusagetargetlevel',
      ),
    ],
  )
  Future<void> setMemoryUsageTargetLevel(AqutterMemoryUsageTargetLevel level) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setMemoryUsageTargetLevel.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getProgress}
  ///Gets the progress for the current page. The progress value is between 0 and 100.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getProgress.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.getProgress',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#getProgress()',
      ),
      IOSPlatform(
        apiName: 'WKWebView.estimatedProgress',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1415007-estimatedprogress',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.estimatedProgress',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1415007-estimatedprogress',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_get_estimated_load_progress',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.get_estimated_load_progress.html',
      ),
      WindowsPlatform(
        note:
            'Progress is tracked through navigation events: NavigationStarting (0), ContentLoading (33), DOMContentLoaded (66), NavigationCompleted (100).',
      ),
    ],
  )
  Future<int?> getProgress() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getProgress.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getHtml}
  ///Gets the content html of the page. It first tries to get the content through javascript.
  ///If this doesn't work, it tries to get the content reading the file:
  ///- checking if it is an asset (`file:///`) or
  ///- downloading it using an `HttpClient` through the WebView's current url.
  ///
  ///Returns `null` if it was unable to get it.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getHtml.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      LinuxPlatform(note: 'This method is implemented using JavaScript.'),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<String?> getHtml() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getHtml.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getFavicons}
  ///Gets the list of all favicons for the current page.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getFavicons.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<List<AqutterFavicon>> getFavicons() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getFavicons.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getFavicon}
  ///Gets the favicon bytes for the given favicon [url].
  ///
  ///[faviconImageFormat] specifies the favicon image format to return.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getFavicon.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2_15.GetFavicon',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_15?view=webview2-1.0.2849.39#getfavicon',
      ),
    ],
  )
  Future<Uint8List?> getFavicon({
    required AqutterWebUri url,
    AqutterFaviconImageFormat faviconImageFormat = AqutterFaviconImageFormat.PNG,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getFavicon.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.loadUrl}
  ///Loads the given [urlRequest].
  ///
  ///- [allowingReadAccessTo], used in combination with [urlRequest] (using the `file://` scheme),
  ///it represents the URL from which to read the web content.
  ///This URL must be a file-based URL (using the `file://` scheme).
  ///Specify the same value as the URL parameter to prevent WebView from reading any other content.
  ///Specify a directory to give WebView permission to read additional files in the specified directory.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.loadUrl.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.loadUrl',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#loadUrl(java.lang.String)',
        note:
            'If method is "POST", [Official API - WebView.postUrl](https://developer.android.com/reference/android/webkit/WebView#postUrl(java.lang.String,%20byte[])). Also, when loading an URL Request using "POST" method, headers are ignored.',
      ),
      IOSPlatform(
        apiName: 'WKWebView.load',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414954-load',
        note:
            'If [allowingReadAccessTo] is used, [Official API - WKWebView.loadFileURL](https://developer.apple.com/documentation/webkit/wkwebview/1414973-loadfileurl)',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.load',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414954-load',
        note:
            'If [allowingReadAccessTo] is used, [Official API - WKWebView.loadFileURL](https://developer.apple.com/documentation/webkit/wkwebview/1414973-loadfileurl)',
      ),
      WebPlatform(
        note:
            'If method is "GET" and headers are empty, it will change the `src` of the iframe. For all other cases it will try to create an XMLHttpRequest and load the result inside the iframe.',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2_2.NavigateWithWebResourceRequest',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_2?view=webview2-1.0.2210.55#navigatewithwebresourcerequest',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_load_uri',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.load_uri.html',
      ),
    ],
  )
  Future<void> loadUrl({
    required AqutterURLRequest urlRequest,
    @Deprecated('Use allowingReadAccessTo instead')
    Uri? iosAllowingReadAccessTo,
    @SupportedPlatforms(platforms: [IOSPlatform(), MacOSPlatform()])
    AqutterWebUri? allowingReadAccessTo,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.loadUrl.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.postUrl}
  ///Loads the given [url] with [postData] (x-www-form-urlencoded) using `POST` method into this WebView.
  ///
  ///Example:
  ///```dart
  ///var postData = Uint8List.fromList(utf8.encode("firstname=Foo&surname=Bar"));
  ///controller.postUrl(url: AqutterWebUri("https://www.example.com/"), postData: postData);
  ///```
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.postUrl.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.postUrl',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#postUrl(java.lang.String,%20byte[])',
      ),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(
        note:
            'It will try to create an XMLHttpRequest and load the result inside the iframe.',
      ),
      WindowsPlatform(),
      LinuxPlatform(
        note:
            'Uses JavaScript to create an XMLHttpRequest and load the result.',
      ),
    ],
  )
  Future<void> postUrl({required AqutterWebUri url, required Uint8List postData}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.postUrl.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.loadData}
  ///Loads the given [data] into this WebView, using [baseUrl] as the base URL for the content.
  ///
  ///- [mimeType] argument specifies the format of the data. The default value is `"text/html"`.
  ///- [encoding] argument specifies the encoding of the data. The default value is `"utf8"`.
  ///- [historyUrl] represents the URL to use as the history entry. The default value is `about:blank`. If non-null, this must be a valid URL.
  ///- [allowingReadAccessTo], used in combination with [baseUrl] (using the `file://` scheme),
  ///it represents the URL from which to read the web content.
  ///This [baseUrl] must be a file-based URL (using the `file://` scheme).
  ///Specify the same value as the [baseUrl] parameter to prevent WebView from reading any other content.
  ///Specify a directory to give WebView permission to read additional files in the specified directory.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.loadData.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.loadDataWithBaseURL',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#loadDataWithBaseURL(java.lang.String,%20java.lang.String,%20java.lang.String,%20java.lang.String,%20java.lang.String)',
      ),
      IOSPlatform(
        apiName: 'WKWebView.loadHTMLString',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1415004-loadhtmlstring',
        note:
            'or [Official API - WKWebView.load](https://developer.apple.com/documentation/webkit/wkwebview/1415011-load)',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.loadHTMLString',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1415004-loadhtmlstring',
        note:
            'or [Official API - WKWebView.load](https://developer.apple.com/documentation/webkit/wkwebview/1415011-load)',
      ),
      WebPlatform(),
      WindowsPlatform(
        apiName: 'ICoreWebView2.NavigateToString',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#navigatetostring',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_load_html',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.load_html.html',
      ),
    ],
  )
  Future<void> loadData({
    required String data,
    @SupportedPlatforms(
      platforms: [
        AndroidPlatform(),
        IOSPlatform(),
        MacOSPlatform(),
        WebPlatform(),
      ],
    )
    String mimeType = "text/html",
    @SupportedPlatforms(
      platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
    )
    String encoding = "utf8",
    @SupportedPlatforms(
      platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
    )
    AqutterWebUri? baseUrl,
    @Deprecated('Use historyUrl instead') Uri? androidHistoryUrl,
    @SupportedPlatforms(platforms: [AndroidPlatform()]) AqutterWebUri? historyUrl,
    @Deprecated('Use allowingReadAccessTo instead')
    Uri? iosAllowingReadAccessTo,
    @SupportedPlatforms(platforms: [IOSPlatform(), MacOSPlatform()])
    AqutterWebUri? allowingReadAccessTo,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.loadData.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.loadFile}
  ///Loads the given [assetFilePath].
  ///
  ///To be able to load your local files (assets, js, css, etc.), you need to add them in the `assets` section of the `pubspec.yaml` file, otherwise they cannot be found!
  ///
  ///Example of a `pubspec.yaml` file:
  ///```yaml
  ///...
  ///
  ///# The following section is specific to Flutter.
  ///flutter:
  ///
  ///  # The following line ensures that the Material Icons font is
  ///  # included with your application, so that you can use the icons in
  ///  # the material Icons class.
  ///  uses-material-design: true
  ///
  ///  assets:
  ///    - assets/index.html
  ///    - assets/css/
  ///    - assets/images/
  ///
  ///...
  ///```
  ///Example:
  ///```dart
  ///...
  ///controller.loadFile(assetFilePath: "assets/index.html");
  ///...
  ///```
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.loadFile.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.loadUrl',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#loadUrl(java.lang.String)',
      ),
      IOSPlatform(
        apiName: 'WKWebView.load',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414954-load',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.load',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414954-load',
      ),
      WebPlatform(),
      WindowsPlatform(
        apiName: 'ICoreWebView2.Navigate',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#navigate',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_load_uri',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.load_uri.html',
      ),
    ],
  )
  Future<void> loadFile({required String assetFilePath}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.loadFile.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.reload}
  ///Reloads the WebView.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.reload.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.reload',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#reload()',
      ),
      IOSPlatform(
        apiName: 'WKWebView.reload',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414969-reload',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.reload',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414969-reload',
      ),
      WebPlatform(
        apiName: 'Location.reload',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/Location/reload',
        note:
            'if `window.location.reload()` is not accessible inside the iframe, it will reload using the iframe `src` attribute.',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.Reload',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#reload',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_reload',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.reload.html',
      ),
    ],
  )
  Future<void> reload() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.reload.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.goBack}
  ///Goes back in the history of the WebView.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.goBack.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.goBack',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#goBack()',
      ),
      IOSPlatform(
        apiName: 'WKWebView.goBack',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414952-goback',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.goBack',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414952-goback',
      ),
      WebPlatform(
        apiName: 'History.back',
        apiUrl: 'https://developer.mozilla.org/en-US/docs/Web/API/History/back',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.GoBack',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#goback',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_go_back',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.go_back.html',
      ),
    ],
  )
  Future<void> goBack() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.goBack.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.canGoBack}
  ///Returns a boolean value indicating whether the WebView can move backward.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.canGoBack.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.canGoBack',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#canGoBack()',
      ),
      IOSPlatform(
        apiName: 'WKWebView.canGoBack',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414966-cangoback',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.canGoBack',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414966-cangoback',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.get_CanGoBack',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#get_cangoback',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_can_go_back',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.can_go_back.html',
      ),
    ],
  )
  Future<bool> canGoBack() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.canGoBack.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.goForward}
  ///Goes forward in the history of the WebView.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.goForward.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.goForward',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#goForward()',
      ),
      IOSPlatform(
        apiName: 'WKWebView.goForward',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414993-goforward',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.goForward',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414993-goforward',
      ),
      WebPlatform(
        apiName: 'History.forward',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/History/forward',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.GoForward',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#goforward',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_go_forward',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.go_forward.html',
      ),
    ],
  )
  Future<void> goForward() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.goForward.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.canGoForward}
  ///Returns a boolean value indicating whether the WebView can move forward.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.canGoForward.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.canGoForward',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#canGoForward()',
      ),
      IOSPlatform(
        apiName: 'WKWebView.canGoForward',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414962-cangoforward',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.canGoForward',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414962-cangoforward',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.get_CanGoForward',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#get_cangoforward',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_can_go_forward',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.can_go_forward.html',
      ),
    ],
  )
  Future<bool> canGoForward() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.canGoForward.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.goBackOrForward}
  ///Goes to the history item that is the number of [steps] away from the current item. Steps is negative if backward and positive if forward.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.goBackOrForward.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.goBackOrForward',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#goBackOrForward(int)',
      ),
      IOSPlatform(
        apiName: 'WKWebView.go',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414991-go',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.go',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414991-go',
      ),
      WebPlatform(
        apiName: 'History.go',
        apiUrl: 'https://developer.mozilla.org/en-US/docs/Web/API/History/go',
      ),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> goBackOrForward({required int steps}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.goBackOrForward.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.canGoBackOrForward}
  ///Returns a boolean value indicating whether the WebView can go back or forward the given number of [steps].
  ///Steps is negative if backward and positive if forward.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.canGoBackOrForward.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.canGoBackOrForward',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#canGoBackOrForward(int)',
      ),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<bool> canGoBackOrForward({required int steps}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.canGoBackOrForward.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.goTo}
  ///Navigates to a [AqutterWebHistoryItem] from the back-forward [AqutterWebHistory.list] and sets it as the current item.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.goTo.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<void> goTo({required AqutterWebHistoryItem historyItem}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.goTo.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.isLoading}
  ///Check if the WebView instance is in a loading state.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isLoading.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      LinuxPlatform(
        apiName: 'webkit_web_view_is_loading',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.is_loading.html',
      ),
      MacOSPlatform(),
      WebPlatform(requiresSameOrigin: false),
      WindowsPlatform(),
    ],
  )
  Future<bool> isLoading() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.isLoading.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.stopLoading}
  ///Stops the WebView from loading.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.stopLoading.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.stopLoading',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#stopLoading()',
      ),
      IOSPlatform(
        apiName: 'WKWebView.stopLoading',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414981-stoploading',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.stopLoading',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414981-stoploading',
      ),
      WebPlatform(
        apiName: 'Window.stop',
        apiUrl: 'https://developer.mozilla.org/en-US/docs/Web/API/Window/stop',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.Stop',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#stop',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_stop_loading',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.stop_loading.html',
      ),
    ],
  )
  Future<void> stopLoading() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.stopLoading.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.evaluateJavascript}
  ///Evaluates JavaScript [source] code into the WebView and returns the result of the evaluation.
  ///
  ///[contentWorld], on iOS, it represents the namespace in which to evaluate the JavaScript [source] code.
  ///Instead, on Android, it will run the [source] code into an iframe, using `eval(source);` to get and return the result.
  ///This parameter doesn’t apply to changes you make to the underlying web content, such as the document’s DOM structure.
  ///Those changes remain visible to all scripts, regardless of which content world you specify.
  ///For more information about content worlds, see [AqutterContentWorld].
  ///
  ///**NOTE**: This method shouldn't be called in the [AqutterPlatformWebViewCreationParams.onWebViewCreated] or [AqutterPlatformWebViewCreationParams.onLoadStart] events,
  ///because, in these events, the `WebView` is not ready to handle it yet.
  ///Instead, you should call this method, for example, inside the [AqutterPlatformWebViewCreationParams.onLoadStop] event or in any other events
  ///where you know the page is ready "enough".
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.evaluateJavascript.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.evaluateJavascript',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#evaluateJavascript(java.lang.String,%20android.webkit.ValueCallback%3Cjava.lang.String%3E)',
      ),
      IOSPlatform(
        apiName: 'WKWebView.evaluateJavaScript',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3656442-evaluatejavascript',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.evaluateJavaScript',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3656442-evaluatejavascript',
      ),
      WebPlatform(
        apiName: 'Window.eval',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/eval',
      ),
      WindowsPlatform(),
      LinuxPlatform(
        apiName: 'webkit_web_view_evaluate_javascript',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.evaluate_javascript.html',
      ),
    ],
  )
  Future<dynamic> evaluateJavascript({
    required String source,
    @SupportedPlatforms(
      platforms: [
        AndroidPlatform(),
        IOSPlatform(available: '14.0'),
        MacOSPlatform(available: '11.0'),
        WindowsPlatform(),
      ],
    )
    AqutterContentWorld? contentWorld,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.evaluateJavascript.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.injectJavascriptFileFromUrl}
  ///Injects an external JavaScript file into the WebView from a defined url.
  ///
  ///[scriptHtmlTagAttributes] represents the possible the `<script>` HTML attributes to be set.
  ///
  ///**NOTE**: This method shouldn't be called in the [AqutterPlatformWebViewCreationParams.onWebViewCreated] or [AqutterPlatformWebViewCreationParams.onLoadStart] events,
  ///because, in these events, the `WebView` is not ready to handle it yet.
  ///Instead, you should call this method, for example, inside the [AqutterPlatformWebViewCreationParams.onLoadStop] event or in any other events
  ///where you know the page is ready "enough".
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectJavascriptFileFromUrl.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      LinuxPlatform(note: 'This method is implemented using JavaScript.'),
      MacOSPlatform(),
      WebPlatform(),
    ],
  )
  Future<void> injectJavascriptFileFromUrl({
    required AqutterWebUri urlFile,
    AqutterScriptHtmlTagAttributes? scriptHtmlTagAttributes,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.injectJavascriptFileFromUrl.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.injectJavascriptFileFromAsset}
  ///Evaluates the content of a JavaScript file into the WebView from the flutter assets directory.
  ///
  ///**NOTE**: This method shouldn't be called in the [AqutterPlatformWebViewCreationParams.onWebViewCreated] or [AqutterPlatformWebViewCreationParams.onLoadStart] events,
  ///because, in these events, the `WebView` is not ready to handle it yet.
  ///Instead, you should call this method, for example, inside the [AqutterPlatformWebViewCreationParams.onLoadStop] event or in any other events
  ///where you know the page is ready "enough".
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectJavascriptFileFromAsset.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<dynamic> injectJavascriptFileFromAsset({
    required String assetFilePath,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.injectJavascriptFileFromAsset.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.injectCSSCode}
  ///Injects CSS into the WebView.
  ///
  ///**NOTE**: This method shouldn't be called in the [AqutterPlatformWebViewCreationParams.onWebViewCreated] or [AqutterPlatformWebViewCreationParams.onLoadStart] events,
  ///because, in these events, the `WebView` is not ready to handle it yet.
  ///Instead, you should call this method, for example, inside the [AqutterPlatformWebViewCreationParams.onLoadStop] event or in any other events
  ///where you know the page is ready "enough".
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectCSSCode.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      LinuxPlatform(note: 'This method is implemented using JavaScript.'),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<void> injectCSSCode({required String source}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.injectCSSCode.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.injectCSSFileFromUrl}
  ///Injects an external CSS file into the WebView from a defined url.
  ///
  ///[cssLinkHtmlTagAttributes] represents the possible CSS stylesheet `<link>` HTML attributes to be set.
  ///
  ///**NOTE**: This method shouldn't be called in the [AqutterPlatformWebViewCreationParams.onWebViewCreated] or [AqutterPlatformWebViewCreationParams.onLoadStart] events,
  ///because, in these events, the `WebView` is not ready to handle it yet.
  ///Instead, you should call this method, for example, inside the [AqutterPlatformWebViewCreationParams.onLoadStop] event or in any other events
  ///where you know the page is ready "enough".
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectCSSFileFromUrl.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      LinuxPlatform(note: 'This method is implemented using JavaScript.'),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<void> injectCSSFileFromUrl({
    required AqutterWebUri urlFile,
    AqutterCSSLinkHtmlTagAttributes? cssLinkHtmlTagAttributes,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.injectCSSFileFromUrl.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.injectCSSFileFromAsset}
  ///Injects a CSS file into the WebView from the flutter assets directory.
  ///
  ///**NOTE**: This method shouldn't be called in the [AqutterPlatformWebViewCreationParams.onWebViewCreated] or [AqutterPlatformWebViewCreationParams.onLoadStart] events,
  ///because, in these events, the `WebView` is not ready to handle it yet.
  ///Instead, you should call this method, for example, inside the [AqutterPlatformWebViewCreationParams.onLoadStop] event or in any other events
  ///where you know the page is ready "enough".
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.injectCSSFileFromAsset.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
    ],
  )
  Future<void> injectCSSFileFromAsset({required String assetFilePath}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.injectCSSFileFromAsset.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.addJavaScriptHandler}
  ///Adds a JavaScript message handler [callback] ([AqutterJavaScriptHandlerCallback] or [AqutterJavaScriptHandlerFunction]) that listen to post messages sent from JavaScript by the handler with name [handlerName].
  ///Forbidden [handlerName]s are represented by [kJavaScriptHandlerForbiddenNames], they are used internally by this plugin.
  ///
  ///The JavaScript function that can be used to call the handler is `window.aqutter.callHandler(handlerName <String>, ...args)`,
  ///where `window.aqutter` is the default JavaScript bridge object injected in the WebView and
  ///`args` are [rest parameters](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/rest_parameters).
  ///The `args` will be stringified automatically using `JSON.stringify(args)` method and then they will be decoded on the Dart side.
  ///
  ///To get the default JavaScript bridge object name, you can use the [getJavaScriptBridgeName] method.
  ///To change the default JavaScript bridge object name, you can use the [setJavaScriptBridgeName] method.
  ///
  ///In order to call `window.aqutter.callHandler(handlerName <String>, ...args)` properly, you need to wait and listen the JavaScript event `aqutterPlatformReady`.
  ///This event will be dispatched as soon as the platform (Android or iOS) is ready to handle the `callHandler` method.
  ///```javascript
  ///   window.addEventListener("aqutterPlatformReady", function(event) {
  ///     console.log("ready");
  ///   });
  ///```
  ///
  ///`window.aqutter.callHandler` returns a JavaScript [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)
  ///that can be used to get the json result returned by [AqutterJavaScriptHandlerCallback] or [AqutterJavaScriptHandlerFunction].
  ///In this case, simply return data that you want to send and it will be automatically json encoded using [jsonEncode] from the `dart:convert` library.
  ///
  ///So, on the JavaScript side, to get data coming from the Dart side, you will use:
  ///```html
  ///<script>
  ///   window.addEventListener("aqutterPlatformReady", function(event) {
  ///     window.aqutter.callHandler('handlerFoo').then(function(result) {
  ///       console.log(result);
  ///     });
  ///
  ///     window.aqutter.callHandler('handlerFooWithArgs', 1, true, ['bar', 5], {foo: 'baz'}).then(function(result) {
  ///       console.log(result);
  ///     });
  ///   });
  ///</script>
  ///```
  ///
  ///Instead, on the `onLoadStop` WebView event, you can use `callHandler` directly:
  ///```dart
  ///  // Inject JavaScript that will receive data back from Flutter
  ///  webViewController.evaluateJavascript(source: """
  ///    window.aqutter.callHandler('test', 'Text from Javascript').then(function(result) {
  ///      console.log(result);
  ///    });
  ///  """);
  ///```
  ///
  ///There could be forbidden names for JavaScript handlers depending on the implementation platform.
  ///
  ///**NOTE**: This method should be called, for example, in the [AqutterPlatformWebViewCreationParams.onWebViewCreated] or [AqutterPlatformWebViewCreationParams.onLoadStart] events or, at least,
  ///before you know that your JavaScript code will call the `window.aqutter.callHandler` method,
  ///otherwise you won't be able to intercept the JavaScript message.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.addJavaScriptHandler.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  void addJavaScriptHandler({
    required String handlerName,
    required Function callback,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.addJavaScriptHandler.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.removeJavaScriptHandler}
  ///Removes a JavaScript message handler previously added with the [addJavaScriptHandler] associated to [handlerName] key.
  ///Returns the value associated with [handlerName] before it was removed.
  ///Returns `null` if [handlerName] was not found.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeJavaScriptHandler.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  Function? removeJavaScriptHandler({required String handlerName}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.removeJavaScriptHandler.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.hasJavaScriptHandler}
  ///Returns `true` if a JavaScript handler with [handlerName] already exists, otherwise `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.hasJavaScriptHandler.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  bool hasJavaScriptHandler({required String handlerName}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.hasJavaScriptHandler.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.takeScreenshot}
  ///Takes a screenshot of the WebView's visible viewport and returns a [Uint8List]. Returns `null` if it wasn't be able to take it.
  ///
  ///[screenshotConfiguration] represents the configuration data to use when generating an image from a web view’s contents.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.takeScreenshot.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        note:
            'To be able to take screenshots outside the visible viewport, you must call [AqutterPlatformWebViewController.enableSlowWholeDocumentDraw] before any WebViews are created.',
      ),
      IOSPlatform(
        apiName: 'WKWebView.takeSnapshot',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/2873260-takesnapshot',
        available: '11.0',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.takeSnapshot',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/2873260-takesnapshot',
        available: '10.13',
      ),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<Uint8List?> takeScreenshot({
    AqutterScreenshotConfiguration? screenshotConfiguration,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.takeScreenshot.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setSettings}
  ///Sets the WebView settings with the new [settings] and evaluates them.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setSettings.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      LinuxPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<void> setSettings({required AqutterWebViewSettings settings}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setSettings.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getSettings}
  ///Gets the current WebView settings. Returns `null` if it wasn't able to get them.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getSettings.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      LinuxPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<AqutterWebViewSettings?> getSettings() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getSettings.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getCopyBackForwardList}
  ///Gets the AqutterWebHistory for this WebView. This contains the back/forward list for use in querying each item in the history stack.
  ///This contains only a snapshot of the current state.
  ///Multiple calls to this method may return different objects.
  ///The object returned from this method will not be updated to reflect any new state.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getCopyBackForwardList.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.copyBackForwardList',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#copyBackForwardList()',
      ),
      IOSPlatform(
        apiName: 'WKWebView.backForwardList',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414977-backforwardlist',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.backForwardList',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414977-backforwardlist',
      ),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<AqutterWebHistory?> getCopyBackForwardList() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getCopyBackForwardList.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.clearCache}
  ///Use [AqutterPlatformWebViewController.clearAllCache] instead
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearCache.supported_platforms}
  @SupportedPlatforms(
    platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
  )
  @Deprecated("Use AqutterWebViewController.clearAllCache instead")
  Future<void> clearCache() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.clearCache.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.scrollTo}
  ///Scrolls the WebView to the position.
  ///
  ///[x] represents the x position to scroll to.
  ///
  ///[y] represents the y position to scroll to.
  ///
  ///[animated] `true` to animate the scroll transition, `false` to make the scoll transition immediate.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.scrollTo.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'View.scrollTo',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#scrollTo(int,%20int)',
      ),
      IOSPlatform(
        apiName: 'UIScrollView.setContentOffset',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiscrollview/1619400-setcontentoffset',
      ),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      LinuxPlatform(),
      WebPlatform(
        apiName: 'Window.scrollTo',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollTo',
      ),
      WindowsPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<void> scrollTo({
    required int x,
    required int y,
    bool animated = false,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.scrollTo.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.scrollBy}
  ///Moves the scrolled position of the WebView.
  ///
  ///[x] represents the amount of pixels to scroll by horizontally.
  ///
  ///[y] represents the amount of pixels to scroll by vertically.
  ///
  ///[animated] `true` to animate the scroll transition, `false` to make the scoll transition immediate.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.scrollBy.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'View.scrollBy',
        apiUrl:
            'https://developer.android.com/reference/android/view/View#scrollBy(int,%20int)',
      ),
      IOSPlatform(
        apiName: 'UIScrollView.setContentOffset',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiscrollview/1619400-setcontentoffset',
      ),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      LinuxPlatform(),
      WebPlatform(
        apiName: 'Window.scrollBy',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollBy',
      ),
      WindowsPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<void> scrollBy({
    required int x,
    required int y,
    bool animated = false,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.scrollBy.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.pauseTimers}
  ///On Android native WebView, it pauses all layout, parsing, and JavaScript timers for all WebViews.
  ///This is a global requests, not restricted to just this WebView. This can be useful if the application has been paused.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.pauseTimers.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.pauseTimers',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#pauseTimers()',
      ),
      IOSPlatform(
        note:
            'This method is implemented using JavaScript and it is restricted to just this WebView.',
      ),
      MacOSPlatform(
        note:
            'This method is implemented using JavaScript and it is restricted to just this WebView.',
      ),
    ],
  )
  Future<void> pauseTimers() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.pauseTimers.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.resumeTimers}
  ///On Android, it resumes all layout, parsing, and JavaScript timers for all WebViews. This will resume dispatching all timers.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.resumeTimers.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.resumeTimers',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#resumeTimers()',
      ),
      IOSPlatform(
        note:
            'This method is implemented using JavaScript and it is restricted to just this WebView.',
      ),
      MacOSPlatform(
        note:
            'This method is implemented using JavaScript and it is restricted to just this WebView.',
      ),
    ],
  )
  Future<void> resumeTimers() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.resumeTimers.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.printCurrentPage}
  ///Prints the current page.
  ///
  ///To obtain the [AqutterPlatformPrintJobController], use [settings] argument with [AqutterPrintJobSettings.handledByClient] to `true`.
  ///Otherwise this method will return `null` and the [AqutterPlatformPrintJobController] will be handled and disposed automatically by the system.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.printCurrentPage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'PrintManager.print',
        apiUrl:
            'https://developer.android.com/reference/android/print/PrintManager#print(java.lang.String,%20android.print.PrintDocumentAdapter,%20android.print.PrintAttributes)',
      ),
      IOSPlatform(
        apiName: 'UIPrintInteractionController.present',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiprintinteractioncontroller/1618149-present',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.printOperation',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3516861-printoperation',
        note:
            'If macOS version is less than 11.0, it will use [Official API - NSView.printView](https://developer.apple.com/documentation/appkit/nsview/1483705-printview).',
      ),
      WebPlatform(
        apiName: 'Window.print',
        apiUrl: 'https://developer.mozilla.org/en-US/docs/Web/API/Window/print',
        note: '[AqutterPlatformPrintJobController] is always `null`.',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2_16.Print',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_16?view=webview2-1.0.2849.39#print',
      ),
    ],
  )
  Future<AqutterPlatformPrintJobController?> printCurrentPage({
    AqutterPrintJobSettings? settings,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.printCurrentPage.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getContentHeight}
  ///Gets the height of the HTML content.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getContentHeight.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.getContentHeight',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#getContentHeight()',
      ),
      IOSPlatform(
        apiName: 'UIScrollView.contentSize',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiscrollview/1619399-contentsize',
      ),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      WebPlatform(
        apiName: 'Document.documentElement.scrollHeight',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollHeight',
      ),
      LinuxPlatform(),
      WindowsPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<int?> getContentHeight() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getContentHeight.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getContentWidth}
  ///Gets the width of the HTML content.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getContentWidth.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(note: 'This method is implemented using JavaScript.'),
      IOSPlatform(
        apiName: 'UIScrollView.contentSize',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiscrollview/1619399-contentsize',
      ),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      WebPlatform(
        apiName: 'Document.documentElement.scrollWidth',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollWidth',
      ),
      LinuxPlatform(),
      WindowsPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<int?> getContentWidth() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getContentWidth.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.zoomBy}
  ///Performs a zoom operation in this WebView.
  ///
  ///[zoomFactor] represents the zoom factor to apply. On Android, the zoom factor will be clamped to the Webview's zoom limits and, also, this value must be in the range 0.01 (excluded) to 100.0 (included).
  ///
  ///[animated] `true` to animate the transition to the new scale, `false` to make the transition immediate.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.zoomBy.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.zoomBy',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#zoomBy(float)',
        available: '21',
      ),
      IOSPlatform(
        apiName: 'UIScrollView.setZoomScale',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiscrollview/1619412-setzoomscale',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_set_zoom_level',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.set_zoom_level.html',
      ),
    ],
  )
  Future<void> zoomBy({
    required double zoomFactor,
    @Deprecated('Use animated instead') bool? iosAnimated,
    @SupportedPlatforms(platforms: [IOSPlatform()]) bool animated = false,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.zoomBy.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getOriginalUrl}
  ///Gets the URL that was originally requested for the current page.
  ///This is not always the same as the URL passed to [AqutterWebView.onLoadStart] because although the load for that URL has begun,
  ///the current page may not have changed. Also, there may have been redirects resulting in a different URL to that originally requested.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getOriginalUrl.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.getOriginalUrl',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#getOriginalUrl()',
      ),
      IOSPlatform(),
      LinuxPlatform(
        apiName: 'webkit_web_view_get_uri',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.get_uri.html',
        note:
            'Returns the current URL. WPE WebKit does not distinguish between original and current URL.',
      ),
      MacOSPlatform(),
      WebPlatform(
        note: 'It will return the current value of the `iframe.src` attribute.',
      ),
      WindowsPlatform(
        note:
            'Returns the current URL. WebView2 does not distinguish between original and current URL.',
      ),
    ],
  )
  Future<AqutterWebUri?> getOriginalUrl() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getOriginalUrl.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getZoomScale}
  ///Gets the current zoom scale of the WebView.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getZoomScale.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(
        apiName: 'UIScrollView.zoomScale',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiscrollview/1619419-zoomscale',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_get_zoom_level',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.get_zoom_level.html',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2Controller.get_ZoomFactor',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller?view=webview2-1.0.2849.39#get_zoomfactor',
      ),
    ],
  )
  Future<double?> getZoomScale() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getZoomScale.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getSelectedText}
  ///Gets the selected text.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getSelectedText.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(note: 'This method is implemented using JavaScript.'),
      IOSPlatform(note: 'This method is implemented using JavaScript.'),
      LinuxPlatform(note: 'This method is implemented using JavaScript.'),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      WebPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<String?> getSelectedText() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getSelectedText.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getHitTestResult}
  ///Gets the hit result for hitting an HTML elements.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getHitTestResult.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.getHitTestResult',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#getHitTestResult()',
      ),
      IOSPlatform(note: 'This method is implemented using JavaScript.'),
      LinuxPlatform(
        apiName: 'WebKitHitTestResult',
        apiUrl:
            'https://webkitgtk.org/reference/webkit2gtk/stable/WebKitHitTestResult.html',
        note:
            'This method uses native WebKitHitTestResult from the mouse-target-changed signal.',
      ),
    ],
  )
  Future<AqutterWebViewHitTestResult?> getHitTestResult() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getHitTestResult.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.requestFocus}
  ///Call this method when you want to try the WebView to be the first responder.
  ///
  ///On Android, call this to try to give focus to the WebView and
  ///give it hints about the [direction] and a specific [previouslyFocusedRect] that the focus is coming from.
  ///The [previouslyFocusedRect] can help give larger views a finer grained hint about where focus is coming from,
  ///and therefore, where to show selection, or forward focus change internally.
  ///
  ///Returns `true` whether this WebView actually took focus; otherwise, `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestFocus.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.requestFocus',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#requestFocus(int,%20android.graphics.Rect)',
      ),
      IOSPlatform(
        apiName: 'UIResponder.becomeFirstResponder',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiresponder/1621113-becomefirstresponder',
      ),
      MacOSPlatform(
        apiName: 'NSWindow.makeFirstResponder',
        apiUrl:
            'https://developer.apple.com/documentation/appkit/nswindow/1419366-makefirstresponder',
      ),
      LinuxPlatform(
        apiName: 'wpe_view_backend_add_activity_state',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-platform-2.0/func.view_backend_add_activity_state.html',
        note: 'Adds focused state to WPE backend',
      ),
    ],
  )
  Future<bool?> requestFocus({
    @SupportedPlatforms(platforms: [AndroidPlatform()])
    AqutterFocusDirection? direction,
    @SupportedPlatforms(platforms: [AndroidPlatform()])
    AqutterWebViewRect? previouslyFocusedRect,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.requestFocus.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.clearFocus}
  ///Clears the current focus. On iOS and Android native WebView, it will clear also, for example, the current text selection.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearFocus.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'ViewGroup.clearFocus',
        apiUrl:
            'https://developer.android.com/reference/android/view/ViewGroup#clearFocus()',
      ),
      IOSPlatform(
        apiName: 'UIResponder.resignFirstResponder',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiresponder/1621097-resignfirstresponder',
      ),
      MacOSPlatform(
        apiName: 'NSWindow.makeFirstResponder',
        apiUrl:
            'https://developer.apple.com/documentation/appkit/nswindow/1419366-makefirstresponder',
      ),
      LinuxPlatform(
        apiName: 'wpe_view_backend_remove_activity_state',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-platform-2.0/func.view_backend_remove_activity_state.html',
        note:
            'Removes focused state from WPE backend and blurs active element via JavaScript',
      ),
    ],
  )
  Future<void> clearFocus() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.clearFocus.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setInputMethodEnabled}
  ///Enables/Disables the input method (system-supplied keyboard) whilst interacting with the webview.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setInputMethodEnabled.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'UIResponder.inputView',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiresponder/1621092-inputview',
      ),
    ],
  )
  Future<void> setInputMethodEnabled(bool enabled) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setInputMethodEnabled.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.showInputMethod}
  ///Explicitly request that the current input method's soft input area be shown to the user, if needed.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.showInputMethod.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'InputMethodManager.showSoftInput',
        apiUrl:
            'https://developer.android.com/reference/android/view/inputmethod/InputMethodManager#showSoftInput(android.view.View,%20int)',
      ),
    ],
  )
  Future<void> showInputMethod() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.showInputMethod.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.hideInputMethod}
  ///Request to hide the soft input view from the context of the view that is currently accepting input.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.hideInputMethod.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'InputMethodManager.hideSoftInputFromWindow',
        apiUrl:
            'https://developer.android.com/reference/android/view/inputmethod/InputMethodManager#hideSoftInputFromWindow(android.os.IBinder,%20int)',
      ),
      IOSPlatform(
        apiName: 'UIView.endEditing',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiview/1619630-endediting',
      ),
    ],
  )
  Future<void> hideInputMethod() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.hideInputMethod.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setContextMenu}
  ///Sets or updates the WebView context menu to be used next time it will appear.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setContextMenu.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  Future<void> setContextMenu(AqutterContextMenu? contextMenu) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setContextMenu.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.requestFocusNodeHref}
  ///Requests the anchor or image element URL at the last tapped point.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestFocusNodeHref.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.requestFocusNodeHref',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#requestFocusNodeHref(android.os.Message)',
      ),
      IOSPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<AqutterRequestFocusNodeHrefResult?> requestFocusNodeHref() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.requestFocusNodeHref.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.requestImageRef}
  ///Requests the URL of the image last touched by the user.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestImageRef.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.requestImageRef',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#requestImageRef(android.os.Message)',
      ),
      IOSPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<AqutterRequestImageRefResult?> requestImageRef() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.requestImageRef.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getMetaTags}
  ///Returns the list of `<meta>` tags of the current WebView.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getMetaTags.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(note: 'This method is implemented using JavaScript.'),
      IOSPlatform(note: 'This method is implemented using JavaScript.'),
      LinuxPlatform(note: 'This method is implemented using JavaScript.'),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      WebPlatform(note: 'This method is implemented using JavaScript.'),
      WindowsPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<List<AqutterMetaTag>> getMetaTags() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getMetaTags.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getMetaThemeColor}
  ///Returns an instance of [Color] representing the `content` value of the
  ///`<meta name="theme-color" content="">` tag of the current WebView, if available, otherwise `null`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getMetaThemeColor.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(note: 'This method is implemented using JavaScript.'),
      IOSPlatform(
        apiName: 'WKWebView.themeColor',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3794258-themecolor',
        note: 'On iOS < 15.0, this method is implemented using JavaScript.',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_get_theme_color',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.get_theme_color.html',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.themeColor',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3794258-themecolor',
        note: 'On iOS < 12.0, this method is implemented using JavaScript.',
      ),
      WebPlatform(note: 'This method is implemented using JavaScript.'),
      WindowsPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<Color?> getMetaThemeColor() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getMetaThemeColor.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getScrollX}
  ///Returns the scrolled left position of the current WebView.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getScrollX.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'View.getScrollX',
        apiUrl:
            'https://developer.android.com/reference/android/view/View#getScrollX()',
      ),
      IOSPlatform(
        apiName: 'UIScrollView.contentOffset',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiscrollview/1619404-contentoffset',
      ),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      LinuxPlatform(),
      WebPlatform(
        apiName: 'Window.scrollX',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollX',
      ),
      WindowsPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<int?> getScrollX() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getScrollX.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getScrollY}
  ///Returns the scrolled top position of the current WebView.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getScrollY.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'View.getScrollY',
        apiUrl:
            'https://developer.android.com/reference/android/view/View#getScrollY()',
      ),
      IOSPlatform(
        apiName: 'UIScrollView.contentOffset',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiscrollview/1619404-contentoffset',
      ),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      LinuxPlatform(),
      WebPlatform(
        apiName: 'Window.scrollY',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollY',
      ),
      WindowsPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<int?> getScrollY() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getScrollY.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getCertificate}
  ///Gets the SSL certificate for the main top-level page or null if there is no certificate (the site is not secure).
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getCertificate.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.getCertificate',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#getCertificate()',
      ),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(
        apiName: 'webkit_web_view_get_tls_info',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.get_tls_info.html',
      ),
    ],
  )
  Future<AqutterSslCertificate?> getCertificate() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getCertificate.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.addUserScript}
  ///Injects the specified [userScript] into the webpage’s content.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.addUserScript.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(
        apiName: 'WKUserContentController.addUserScript',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkusercontentcontroller/1537448-adduserscript',
        note:
            "This method will throw an error if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to window WebViews. This is a limitation of the native WebKit APIs.",
      ),
      LinuxPlatform(
        apiName: 'webkit_user_content_manager_add_script',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.UserContentManager.add_script.html',
      ),
      MacOSPlatform(
        apiName: 'WKUserContentController.addUserScript',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkusercontentcontroller/1537448-adduserscript',
        note:
            "This method will throw an error if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to window WebViews. This is a limitation of the native WebKit APIs.",
      ),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<void> addUserScript({required AqutterUserScript userScript}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.addUserScript.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.addUserScripts}
  ///Injects the [userScripts] into the webpage’s content.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.addUserScripts.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(
        note:
            "This method will throw an error if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to window WebViews. This is a limitation of the native WebKit APIs.",
      ),
      LinuxPlatform(),
      MacOSPlatform(
        note:
            "This method will throw an error if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to window WebViews. This is a limitation of the native WebKit APIs.",
      ),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<void> addUserScripts({required List<AqutterUserScript> userScripts}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.addUserScripts.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.removeUserScript}
  ///Removes the specified [userScript] from the webpage’s content.
  ///User scripts already loaded into the webpage's content cannot be removed. This will have effect only on the next page load.
  ///Returns `true` if [userScript] was in the list, `false` otherwise.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeUserScript.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(
        note:
            "This method will throw an error if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to window WebViews. This is a limitation of the native WebKit APIs.",
      ),
      LinuxPlatform(),
      MacOSPlatform(
        note:
            "This method will throw an error if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to window WebViews. This is a limitation of the native WebKit APIs.",
      ),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<bool> removeUserScript({required AqutterUserScript userScript}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.removeUserScript.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.removeUserScriptsByGroupName}
  ///Removes all the [AqutterUserScript]s with [groupName] as group name from the webpage’s content.
  ///User scripts already loaded into the webpage's content cannot be removed. This will have effect only on the next page load.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeUserScriptsByGroupName.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(
        note:
            "This method will throw an error if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to window WebViews. This is a limitation of the native WebKit APIs.",
      ),
      LinuxPlatform(),
      MacOSPlatform(
        note:
            "This method will throw an error if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to window WebViews. This is a limitation of the native WebKit APIs.",
      ),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<void> removeUserScriptsByGroupName({required String groupName}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.removeUserScriptsByGroupName.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.removeUserScripts}
  ///Removes the [userScripts] from the webpage’s content.
  ///User scripts already loaded into the webpage's content cannot be removed. This will have effect only on the next page load.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeUserScripts.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(
        note:
            "This method will throw an error if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to window WebViews. This is a limitation of the native WebKit APIs.",
      ),
      LinuxPlatform(),
      MacOSPlatform(
        note:
            "This method will throw an error if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to window WebViews. This is a limitation of the native WebKit APIs.",
      ),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<void> removeUserScripts({required List<AqutterUserScript> userScripts}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.removeUserScripts.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.removeAllUserScripts}
  ///Removes all the user scripts from the webpage’s content.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeAllUserScripts.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(
        apiName: 'WKUserContentController.removeAllUserScripts',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkusercontentcontroller/1536540-removealluserscripts',
        note:
            "This method will throw an error if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to window WebViews. This is a limitation of the native WebKit APIs.",
      ),
      LinuxPlatform(
        apiName: 'webkit_user_content_manager_remove_all_scripts',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.UserContentManager.remove_all_scripts.html',
      ),
      MacOSPlatform(
        apiName: 'WKUserContentController.removeAllUserScripts',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkusercontentcontroller/1536540-removealluserscripts',
        note:
            "This method will throw an error if the [AqutterPlatformWebViewCreationParams.windowId] has been set. There isn't any way to add/remove user scripts specific to window WebViews. This is a limitation of the native WebKit APIs.",
      ),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<void> removeAllUserScripts() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.removeAllUserScripts.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.hasUserScript}
  ///Returns `true` if the [userScript] has been already added, otherwise `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.hasUserScript.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  bool hasUserScript({required AqutterUserScript userScript}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.hasUserScript.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.callAsyncJavaScript}
  ///Executes the specified string as an asynchronous JavaScript function.
  ///
  ///[functionBody] is the JavaScript string to use as the function body.
  ///This method treats the string as an anonymous JavaScript function body and calls it with the named arguments in the arguments parameter.
  ///
  ///[arguments] is a `Map` of the arguments to pass to the function call.
  ///Each key in the `Map` corresponds to the name of an argument in the [functionBody] string,
  ///and the value of that key is the value to use during the evaluation of the code.
  ///Supported value types can be found in the official Flutter docs:
  ///[Platform channel data types support and codecs](https://flutter.dev/docs/development/platform-integration/platform-channels#codec),
  ///except for [Uint8List], [Int32List], [Int64List], and [Float64List] that should be converted into a [List].
  ///All items in a `List` or `Map` must also be one of the supported types.
  ///
  ///[contentWorld], on iOS, it represents the namespace in which to evaluate the JavaScript [source] code.
  ///Instead, on Android, it will run the [source] code into an iframe.
  ///This parameter doesn’t apply to changes you make to the underlying web content, such as the document’s DOM structure.
  ///Those changes remain visible to all scripts, regardless of which content world you specify.
  ///For more information about content worlds, see [AqutterContentWorld].
  ///
  ///**NOTE**: This method shouldn't be called in the [AqutterPlatformWebViewCreationParams.onWebViewCreated] or [AqutterPlatformWebViewCreationParams.onLoadStart] events,
  ///because, in these events, the `WebView` is not ready to handle it yet.
  ///Instead, you should call this method, for example, inside the [AqutterPlatformWebViewCreationParams.onLoadStop] event or in any other events
  ///where you know the page is ready "enough".
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.callAsyncJavaScript.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(available: '21'),
      IOSPlatform(
        apiName: 'WKWebView.callAsyncJavaScript',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3656441-callasyncjavascript',
        available: '14.3',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.callAsyncJavaScript',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3656441-callasyncjavascript',
        available: '11.0',
      ),
      WindowsPlatform(),
      LinuxPlatform(
        apiName: 'webkit_web_view_call_async_javascript_function',
        apiUrl:
            'https://webkitgtk.org/reference/webkit2gtk/stable/method.WebView.call_async_javascript_function.html',
        available: '2.40',
        note:
            'Uses WPE WebKit call_async_javascript_function API which handles JavaScript Promises automatically.',
      ),
    ],
  )
  Future<AqutterCallAsyncJavaScriptResult?> callAsyncJavaScript({
    required String functionBody,
    Map<String, dynamic> arguments = const <String, dynamic>{},
    AqutterContentWorld? contentWorld,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.callAsyncJavaScript.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.saveWebArchive}
  ///Saves the current WebView as a web archive.
  ///Returns the file path under which the web archive file was saved, or `null` if saving the file failed.
  ///
  ///[filePath] represents the file path where the archive should be placed. This value cannot be `null`.
  ///
  ///[autoname] if `false`, takes [filePath] to be a file.
  ///If `true`, [filePath] is assumed to be a directory in which a filename will be chosen according to the URL of the current page.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.saveWebArchive.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.saveWebArchive',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#saveWebArchive(java.lang.String,%20boolean,%20android.webkit.ValueCallback%3Cjava.lang.String%3E)',
        note:
            'If [autoname] is `false`, the [filePath] must ends with the [AqutterWebArchiveFormat.MHT] file extension.',
      ),
      IOSPlatform(
        available: '14.0',
        note:
            'If [autoname] is `false`, the [filePath] must ends with the [AqutterWebArchiveFormat.WEBARCHIVE] file extension.',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_save_to_file',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.save_to_file.html',
        note:
            'If [autoname] is `false`, the [filePath] must ends with the [AqutterWebArchiveFormat.MHT] file extension.',
      ),
      MacOSPlatform(
        available: '11.0',
        note:
            'If [autoname] is `false`, the [filePath] must ends with the [AqutterWebArchiveFormat.WEBARCHIVE] file extension.',
      ),
    ],
  )
  Future<String?> saveWebArchive({
    required String filePath,
    bool autoname = false,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.saveWebArchive.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.showSaveAsUI}
  ///Shows the Save As UI for the current document.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.showSaveAsUI.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2_25.ShowSaveAsUI',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_25?view=webview2-1.0.2849.39#showsaveasui',
      ),
    ],
  )
  Future<AqutterSaveAsUIResult?> showSaveAsUI() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.showSaveAsUI.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.isSecureContext}
  ///Indicates whether the webpage context is capable of using features that require [secure contexts](https://developer.mozilla.org/en-US/docs/Web/Security/Secure_Contexts).
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isSecureContext.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        available: '21',
        note: 'This method is implemented using JavaScript.',
      ),
      IOSPlatform(note: 'This method is implemented using JavaScript.'),
      LinuxPlatform(note: 'This method is implemented using JavaScript.'),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      WebPlatform(
        apiName: 'Window.isSecureContext',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/Window/isSecureContext',
      ),
      WindowsPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<bool> isSecureContext() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.isSecureContext.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.createWebMessageChannel}
  ///Creates a message channel to communicate with JavaScript and returns the message channel with ports that represent the endpoints of this message channel.
  ///The HTML5 message channel functionality is described [here](https://html.spec.whatwg.org/multipage/comms.html#messagechannel).
  ///
  ///The returned message channels are entangled and already in started state.
  ///
  ///This method should be called when the page is loaded, for example, when the [AqutterPlatformWebViewCreationParams.onLoadStop] is fired, otherwise the [AqutterPlatformWebMessageChannel] won't work.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.createWebMessageChannel.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewCompat.createWebMessageChannel',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/WebViewCompat#createWebMessageChannel(android.webkit.WebView)',
        note:
            'This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.CREATE_WEB_MESSAGE_CHANNEL].',
      ),
      IOSPlatform(note: 'This method is implemented using JavaScript.'),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      LinuxPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
      WindowsPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
    ],
  )
  Future<AqutterPlatformWebMessageChannel?> createWebMessageChannel() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.createWebMessageChannel.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.postWebMessage}
  ///Post a message to main frame. The embedded application can restrict the messages to a certain target origin.
  ///See [HTML5 spec](https://html.spec.whatwg.org/multipage/comms.html#posting-messages) for how target origin can be used.
  ///
  ///A target origin can be set as a wildcard ("*"). However this is not recommended.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.postWebMessage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.postWebMessage',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/WebViewCompat#postWebMessage(android.webkit.WebView,%20androidx.webkit.WebMessageCompat,%20android.net.Uri)',
        note:
            'This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.POST_WEB_MESSAGE].',
      ),
      IOSPlatform(note: 'This method is implemented using JavaScript.'),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      LinuxPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
      WindowsPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
    ],
  )
  Future<void> postWebMessage({
    required AqutterWebMessage message,
    AqutterWebUri? targetOrigin,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.postWebMessage.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.addWebMessageListener}
  ///Adds a [AqutterPlatformWebMessageListener] to the WebView and injects a JavaScript object into each frame that the [AqutterPlatformWebMessageListener] will listen on.
  ///
  ///The injected JavaScript object will be named [AqutterPlatformWebMessageListener.jsObjectName] in the global scope.
  ///This will inject the JavaScript object in any frame whose origin matches [AqutterPlatformWebMessageListener.allowedOriginRules]
  ///for every navigation after this call, and the JavaScript object will be available immediately when the page begins to load.
  ///
  ///Each [AqutterPlatformWebMessageListener.allowedOriginRules] entry must follow the format `SCHEME "://" [ HOSTNAME_PATTERN [ ":" PORT ] ]`, each part is explained in the below table:
  ///
  ///<table>
  ///   <colgroup>
  ///      <col width="25%">
  ///   </colgroup>
  ///   <tbody>
  ///      <tr>
  ///         <th>Rule</th>
  ///         <th>Description</th>
  ///         <th>Example</th>
  ///      </tr>
  ///      <tr>
  ///         <td>http/https with hostname</td>
  ///         <td><code translate="no" dir="ltr">SCHEME</code> is http or https; <code translate="no" dir="ltr">HOSTNAME_<wbr>PATTERN</code> is a regular hostname; <code translate="no" dir="ltr">PORT</code> is optional, when not present, the rule will match port <code translate="no" dir="ltr">80</code> for http and port
  ///            <code translate="no" dir="ltr">443</code> for https.
  ///         </td>
  ///         <td>
  ///            <ul>
  ///               <li><code translate="no" dir="ltr">https://foobar.com:8080</code> - Matches https:// URL on port 8080, whose normalized
  ///                  host is foobar.com.
  ///               </li>
  ///               <li><code translate="no" dir="ltr">https://www.example.com</code> - Matches https:// URL on port 443, whose normalized host
  ///                  is www.example.com.
  ///               </li>
  ///            </ul>
  ///         </td>
  ///      </tr>
  ///      <tr>
  ///         <td>http/https with pattern matching</td>
  ///         <td><code translate="no" dir="ltr">SCHEME</code> is http or https; <code translate="no" dir="ltr">HOSTNAME_<wbr>PATTERN</code> is a sub-domain matching
  ///            pattern with a leading <code translate="no" dir="ltr">*.<wbr></code>; <code translate="no" dir="ltr">PORT</code> is optional, when not present, the rule will
  ///            match port <code translate="no" dir="ltr">80</code> for http and port <code translate="no" dir="ltr">443</code> for https.
  ///         </td>
  ///         <td>
  ///            <ul>
  ///               <li><code translate="no" dir="ltr">https://*.example.com</code> - Matches https://calendar.example.com and
  ///                  https://foo.bar.example.com but not https://example.com.
  ///               </li>
  ///               <li><code translate="no" dir="ltr">https://*.example.com:8080</code> - Matches https://calendar.example.com:8080</li>
  ///            </ul>
  ///         </td>
  ///      </tr>
  ///      <tr>
  ///         <td>http/https with IP literal</td>
  ///         <td><code translate="no" dir="ltr">SCHEME</code> is https or https; <code translate="no" dir="ltr">HOSTNAME_<wbr>PATTERN</code> is IP literal; <code translate="no" dir="ltr">PORT</code> is
  ///            optional, when not present, the rule will match port <code translate="no" dir="ltr">80</code> for http and port <code translate="no" dir="ltr">443</code>
  ///            for https.
  ///         </td>
  ///         <td>
  ///            <ul>
  ///               <li><code translate="no" dir="ltr">https://127.0.0.1</code> - Matches https:// URL on port 443, whose IPv4 address is
  ///                  127.0.0.1
  ///               </li>
  ///               <li><code translate="no" dir="ltr">https://[::1]</code> or <code translate="no" dir="ltr">https://[0:0::1]</code>- Matches any URL to the IPv6 loopback
  ///                  address with port 443.
  ///               </li>
  ///               <li><code translate="no" dir="ltr">https://[::1]:99</code> - Matches any https:// URL to the IPv6 loopback on port 99.</li>
  ///            </ul>
  ///         </td>
  ///      </tr>
  ///      <tr>
  ///         <td>Custom scheme</td>
  ///         <td><code translate="no" dir="ltr">SCHEME</code> is a custom scheme; <code translate="no" dir="ltr">HOSTNAME_<wbr>PATTERN</code> and <code translate="no" dir="ltr">PORT</code> must not be
  ///            present.
  ///         </td>
  ///         <td>
  ///            <ul>
  ///               <li><code translate="no" dir="ltr">my-app-scheme://</code> - Matches any my-app-scheme:// URL.</li>
  ///            </ul>
  ///         </td>
  ///      </tr>
  ///      <tr>
  ///         <td><code translate="no" dir="ltr">*</code></td>
  ///         <td>Wildcard rule, matches any origin.</td>
  ///         <td>
  ///            <ul>
  ///               <li><code translate="no" dir="ltr">*</code></li>
  ///            </ul>
  ///         </td>
  ///      </tr>
  ///   </tbody>
  ///</table>
  ///
  ///Note that this is a powerful API, as the JavaScript object will be injected when the frame's origin matches any one of the allowed origins.
  ///The HTTPS scheme is strongly recommended for security; allowing HTTP origins exposes the injected object to any potential network-based attackers.
  ///If a wildcard "*" is provided, it will inject the JavaScript object to all frames.
  ///A wildcard should only be used if the app wants **any** third party web page to be able to use the injected object.
  ///When using a wildcard, the app must treat received messages as untrustworthy and validate any data carefully.
  ///
  ///This method can be called multiple times to inject multiple JavaScript objects.
  ///
  ///Let's say the injected JavaScript object is named `myObject`. We will have following methods on that object once it is available to use:
  ///
  ///```javascript
  /// // Web page (in JavaScript)
  /// // message needs to be a JavaScript String, MessagePorts is an optional parameter.
  /// myObject.postMessage(message[, MessagePorts]) // on Android
  /// myObject.postMessage(message) // on iOS
  ///
  /// // To receive messages posted from the app side, assign a function to the "onmessage"
  /// // property. This function should accept a single "event" argument. "event" has a "data"
  /// // property, which is the message string from the app side.
  /// myObject.onmessage = function(event) { ... }
  ///
  /// // To be compatible with DOM EventTarget's addEventListener, it accepts type and listener
  /// // parameters, where type can be only "message" type and listener can only be a JavaScript
  /// // function for myObject. An event object will be passed to listener with a "data" property,
  /// // which is the message string from the app side.
  /// myObject.addEventListener(type, listener)
  ///
  /// // To be compatible with DOM EventTarget's removeEventListener, it accepts type and listener
  /// // parameters, where type can be only "message" type and listener can only be a JavaScript
  /// // function for myObject.
  /// myObject.removeEventListener(type, listener)
  ///```
  ///
  ///We start the communication between JavaScript and the app from the JavaScript side.
  ///In order to send message from the app to JavaScript, it needs to post a message from JavaScript first,
  ///so the app will have a [AqutterPlatformJavaScriptReplyProxy] object to respond. Example:
  ///
  ///```javascript
  /// // Web page (in JavaScript)
  /// myObject.onmessage = function(event) {
  ///   // prints "Got it!" when we receive the app's response.
  ///   console.log(event.data);
  /// }
  /// myObject.postMessage("I'm ready!");
  ///```
  ///
  ///```dart
  /// // Flutter App
  /// child: AqutterWebView(
  ///   onWebViewCreated: (controller) async {
  ///     if (defaultTargetPlatform != TargetPlatform.android || await AqutterWebViewFeature.isFeatureSupported(AqutterWebViewFeature.WEB_MESSAGE_LISTENER)) {
  ///       await controller.addWebMessageListener(AqutterWebMessageListener(
  ///         jsObjectName: "myObject",
  ///         onPostMessage: (message, sourceOrigin, isMainFrame, replyProxy) {
  ///           // do something about message, sourceOrigin and isMainFrame.
  ///           replyProxy.postMessage("Got it!");
  ///         },
  ///       ));
  ///     }
  ///     await controller.loadUrl(urlRequest: AqutterURLRequest(url: AqutterWebUri("https://www.example.com")));
  ///   },
  /// ),
  ///```
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.addWebMessageListener.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewCompat.AqutterWebMessageListener',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/WebViewCompat#addWebMessageListener(android.webkit.WebView,%20java.lang.String,%20java.util.Set%3Cjava.lang.String%3E,%20androidx.webkit.WebViewCompat.AqutterWebMessageListener)',
        note:
            'This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.WEB_MESSAGE_LISTENER].',
      ),
      IOSPlatform(note: 'This method is implemented using JavaScript.'),
      LinuxPlatform(
        note: 'This method is implemented using JavaScript.',
        apiName: 'webkit_user_content_manager_add_script',
        apiUrl:
            'https://webkitgtk.org/reference/webkit2gtk/stable/method.UserContentManager.add_script.html',
      ),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      WindowsPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  Future<void> addWebMessageListener(
    AqutterPlatformWebMessageListener webMessageListener,
  ) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.addWebMessageListener.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.hasWebMessageListener}
  ///Returns `true` if the [webMessageListener] has been already added, otherwise `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.hasWebMessageListener.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      LinuxPlatform(),
      MacOSPlatform(),
    ],
  )
  bool hasWebMessageListener(AqutterPlatformWebMessageListener webMessageListener) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.hasWebMessageListener.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.canScrollVertically}
  ///Returns `true` if the webpage can scroll vertically, otherwise `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.canScrollVertically.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      LinuxPlatform(note: 'This method is implemented using JavaScript.'),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      WebPlatform(),
    ],
  )
  Future<bool> canScrollVertically() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.canScrollVertically.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.canScrollHorizontally}
  ///Returns `true` if the webpage can scroll horizontally, otherwise `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.canScrollHorizontally.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      LinuxPlatform(note: 'This method is implemented using JavaScript.'),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
      WebPlatform(),
    ],
  )
  Future<bool> canScrollHorizontally() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.canScrollHorizontally.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.startSafeBrowsing}
  ///Starts Safe Browsing initialization.
  ///
  ///URL loads are not guaranteed to be protected by Safe Browsing until after the this method returns true.
  ///Safe Browsing is not fully supported on all devices. For those devices this method will returns false.
  ///
  ///This should not be called if Safe Browsing has been disabled by manifest tag or [AqutterAndroidWebViewOptions.safeBrowsingEnabled].
  ///This prepares resources used for Safe Browsing.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.startSafeBrowsing.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.startSafeBrowsing',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#startSafeBrowsing(android.content.Context,%20android.webkit.ValueCallback%3Cjava.lang.Boolean%3E)',
        note:
            'This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.START_SAFE_BROWSING].',
      ),
    ],
  )
  Future<bool> startSafeBrowsing() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.startSafeBrowsing.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.clearSslPreferences}
  ///Clears the SSL preferences table stored in response to proceeding with SSL certificate errors.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearSslPreferences.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.clearSslPreferences',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#clearSslPreferences()',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2_3.ClearServerCertificateErrorActions',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_14?view=webview2-1.0.2792.45#clearservercertificateerroractions',
      ),
    ],
  )
  Future<void> clearSslPreferences() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.clearSslPreferences.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.pause}
  ///Does a best-effort attempt to pause any processing that can be paused safely, such as animations and geolocation. Note that this call does not pause JavaScript.
  ///To pause JavaScript globally, use [AqutterPlatformWebViewController.pauseTimers]. To resume WebView, call [resume].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.pause.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.onPause',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#onPause()',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2_3.TrySuspend',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_3?view=webview2-1.0.2792.45#trysuspend',
      ),
    ],
  )
  Future<void> pause() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.pause.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.resume}
  ///Resumes a WebView after a previous call to [pause].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.resume.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.onResume',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#onResume()',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2_3.Resume',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_3?view=webview2-1.0.2792.45#resume',
      ),
    ],
  )
  Future<void> resume() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.resume.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.pageDown}
  ///Scrolls the contents of this WebView down by half the page size.
  ///Returns `true` if the page was scrolled.
  ///
  ///[bottom] `true` to jump to bottom of page.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.pageDown.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.pageDown',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#pageDown(boolean)',
      ),
    ],
  )
  Future<bool> pageDown({required bool bottom}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.pageDown.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.pageUp}
  ///Scrolls the contents of this WebView up by half the view size.
  ///Returns `true` if the page was scrolled.
  ///
  ///[top] `true` to jump to the top of the page.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.pageUp.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.pageUp',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#pageUp(boolean)',
      ),
    ],
  )
  Future<bool> pageUp({required bool top}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.pageUp.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.zoomIn}
  ///Performs zoom in in this WebView.
  ///Returns `true` if zoom in succeeds, `false` if no zoom changes.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.zoomIn.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.zoomIn',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#zoomIn()',
      ),
    ],
  )
  Future<bool> zoomIn() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.zoomIn.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.zoomOut}
  ///Performs zoom out in this WebView.
  ///Returns `true` if zoom out succeeds, `false` if no zoom changes.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.zoomOut.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.zoomOut',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#zoomOut()',
      ),
    ],
  )
  Future<bool> zoomOut() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.zoomOut.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.clearHistory}
  ///Clears the internal back/forward list.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearHistory.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.clearHistory',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#clearHistory()',
      ),
    ],
  )
  Future<void> clearHistory() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.clearHistory.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.clearFormData}
  ///Removes the autocomplete popup from the currently focused form field, if present.
  ///Note this only affects the display of the autocomplete popup,
  ///it does not remove any saved form data from this WebView's store.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearFormData.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.clearFormData',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#clearFormData()',
      ),
    ],
  )
  Future<void> clearFormData() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.clearFormData.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.reloadFromOrigin}
  ///Reloads the current page, performing end-to-end revalidation using cache-validating conditionals if possible.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.reloadFromOrigin.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.reloadFromOrigin',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414956-reloadfromorigin',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.reloadFromOrigin',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1414956-reloadfromorigin',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_reload_bypass_cache',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.reload_bypass_cache.html',
      ),
    ],
  )
  Future<void> reloadFromOrigin() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.reloadFromOrigin.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.createPdf}
  ///Generates PDF data from the web view’s contents asynchronously.
  ///Returns `null` if a problem occurred.
  ///
  ///[pdfConfiguration] represents the object that specifies the portion of the web view to capture as PDF data.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.createPdf.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.createPdf',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3650490-createpdf',
        available: '14.0',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.createPdf',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3650490-createpdf',
        available: '11.0',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2_16.PrintToPdfStream',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_16#printtopdfstream',
      ),
    ],
  )
  Future<Uint8List?> createPdf({
    @Deprecated("Use pdfConfiguration instead")
    // ignore: deprecated_member_use_from_same_package
    AqutterIOSWKPDFConfiguration? iosWKPdfConfiguration,
    AqutterPDFConfiguration? pdfConfiguration,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.createPdf.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.createWebArchiveData}
  ///Creates a web archive of the web view’s current contents asynchronously.
  ///Returns `null` if a problem occurred.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.createWebArchiveData.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.createWebArchiveData',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3650491-createwebarchivedata',
        available: '14.0',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.createWebArchiveData',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3650491-createwebarchivedata',
        available: '11.0',
      ),
    ],
  )
  Future<Uint8List?> createWebArchiveData() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.createWebArchiveData.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.hasOnlySecureContent}
  ///A Boolean value indicating whether all resources on the page have been loaded over securely encrypted connections.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.hasOnlySecureContent.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.hasOnlySecureContent',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1415002-hasonlysecurecontent',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.hasOnlySecureContent',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/1415002-hasonlysecurecontent',
      ),
    ],
  )
  Future<bool> hasOnlySecureContent() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.hasOnlySecureContent.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.pauseAllMediaPlayback}
  ///Pauses playback of all media in the web view.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.pauseAllMediaPlayback.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.pauseAllMediaPlayback',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3752240-pauseallmediaplayback',
        available: '15.0',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.pauseAllMediaPlayback',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3752240-pauseallmediaplayback',
        available: '12.0',
      ),
      LinuxPlatform(
        apiName: 'JavaScript HTMLMediaElement.pause()',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/pause',
        note: 'Uses JavaScript to pause all audio and video elements',
      ),
    ],
  )
  Future<void> pauseAllMediaPlayback() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.pauseAllMediaPlayback.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setAllMediaPlaybackSuspended}
  ///Changes whether the webpage is suspending playback of all media in the page.
  ///Pass `true` to pause all media the web view is playing. Neither the user nor the webpage can resume playback until you call this method again with `false`.
  ///
  ///[suspended] represents a [bool] value that indicates whether the webpage should suspend media playback.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setAllMediaPlaybackSuspended.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.setAllMediaPlaybackSuspended',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3752242-setallmediaplaybacksuspended',
        available: '15.0',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.setAllMediaPlaybackSuspended',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3752242-setallmediaplaybacksuspended',
        available: '12.0',
      ),
      LinuxPlatform(
        apiName: 'JavaScript HTMLMediaElement.pause()/play()',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement',
        note: 'Uses JavaScript to suspend/resume all media elements',
      ),
    ],
  )
  Future<void> setAllMediaPlaybackSuspended({required bool suspended}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setAllMediaPlaybackSuspended.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.closeAllMediaPresentations}
  ///Closes all media the web view is presenting, including picture-in-picture video and fullscreen video.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.closeAllMediaPresentations.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.closeAllMediaPresentations',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3752235-closeallmediapresentations',
        available: '14.5',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.closeAllMediaPresentations',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3752235-closeallmediapresentations',
        available: '11.3',
      ),
      LinuxPlatform(
        apiName: 'JavaScript Document.exitFullscreen()/exitPictureInPicture()',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/Document/exitFullscreen',
        note: 'Uses JavaScript to exit fullscreen and picture-in-picture modes',
      ),
    ],
  )
  Future<void> closeAllMediaPresentations() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.closeAllMediaPresentations.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.requestMediaPlaybackState}
  ///Requests the playback status of media in the web view.
  ///Returns a [AqutterMediaPlaybackState] that indicates whether the media in the web view is playing, paused, or suspended.
  ///If there’s no media in the web view to play, this method provides [AqutterMediaPlaybackState.NONE].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestMediaPlaybackState.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.requestMediaPlaybackState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3752241-requestmediaplaybackstate',
        available: '15.0',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.requestMediaPlaybackState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3752241-requestmediaplaybackstate',
        available: '12.0',
      ),
      LinuxPlatform(
        apiName: 'JavaScript HTMLMediaElement.paused',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/paused',
        note: 'Uses JavaScript to query media playback state',
      ),
    ],
  )
  Future<AqutterMediaPlaybackState?> requestMediaPlaybackState() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.requestMediaPlaybackState.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.isInFullscreen}
  ///Returns `true` if the `WebView` is in fullscreen mode, otherwise `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isInFullscreen.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<bool> isInFullscreen() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.isInFullscreen.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.requestEnterFullscreen}
  ///Requests the WebView to enter fullscreen mode.
  ///This dispatches a fullscreen request to the WPE backend.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestEnterFullscreen.supported_platforms}
  @SupportedPlatforms(platforms: [LinuxPlatform()])
  Future<void> requestEnterFullscreen() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.requestEnterFullscreen.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.requestExitFullscreen}
  ///Requests the WebView to exit fullscreen mode.
  ///This dispatches an exit fullscreen request to the WPE backend.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestExitFullscreen.supported_platforms}
  @SupportedPlatforms(platforms: [LinuxPlatform()])
  Future<void> requestExitFullscreen() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.requestExitFullscreen.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setVisible}
  ///Sets the visibility state of the WebView.
  ///When set to `false`, the WebView is marked as hidden which may reduce resource usage.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setVisible.supported_platforms}
  @SupportedPlatforms(platforms: [LinuxPlatform()])
  Future<void> setVisible({required bool visible}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setVisible.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setTargetRefreshRate}
  ///Sets the target refresh rate for the WebView in Hz.
  ///A value of 0 means the default rate.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setTargetRefreshRate.supported_platforms}
  @SupportedPlatforms(platforms: [LinuxPlatform()])
  Future<void> setTargetRefreshRate({required int rate}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setTargetRefreshRate.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getTargetRefreshRate}
  ///Gets the current target refresh rate for the WebView in Hz.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getTargetRefreshRate.supported_platforms}
  @SupportedPlatforms(platforms: [LinuxPlatform()])
  Future<int> getTargetRefreshRate() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getTargetRefreshRate.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getScreenScale}
  ///Gets the device pixel ratio (scale factor) of the screen where the WebView is displayed.
  ///
  ///The scale factor represents the ratio between physical pixels and logical pixels.
  ///For example, on a HiDPI display, this might return 2.0.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getScreenScale.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      LinuxPlatform(
        apiName: 'wpe_screen_get_scale',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-platform-1.0/method.Screen.get_scale.html',
      ),
    ],
  )
  Future<double> getScreenScale() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getScreenScale.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setScreenScale}
  ///Sets the device pixel ratio (scale factor) for the screen where the WebView is displayed.
  ///
  ///The scale factor represents the ratio between physical pixels and logical pixels.
  ///Setting this affects how content is rendered on HiDPI displays.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setScreenScale.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      LinuxPlatform(
        apiName: 'wpe_screen_set_scale',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-platform-1.0/method.Screen.set_scale.html',
      ),
    ],
  )
  Future<void> setScreenScale({required double scale}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setScreenScale.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.isVisible}
  ///Returns whether the WebView is currently visible.
  ///
  ///On Linux, this checks the WPE view visibility state.
  ///For the legacy FDO backend, this returns the last known visibility state.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isVisible.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      LinuxPlatform(
        apiName: 'wpe_view_get_visible',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-platform-1.0/method.View.get_visible.html',
      ),
    ],
  )
  Future<bool> isVisible() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.isVisible.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.requestPointerLock}
  ///Requests pointer lock for the WebView.
  ///Pointer lock is useful for games and immersive applications.
  ///Returns `true` if the request was granted, `false` otherwise.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestPointerLock.supported_platforms}
  @SupportedPlatforms(platforms: [LinuxPlatform()])
  Future<bool> requestPointerLock() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.requestPointerLock.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.requestPointerUnlock}
  ///Releases the pointer lock for the WebView.
  ///Returns `true` if the unlock was successful, `false` otherwise.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.requestPointerUnlock.supported_platforms}
  @SupportedPlatforms(platforms: [LinuxPlatform()])
  Future<bool> requestPointerUnlock() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.requestPointerUnlock.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getCameraCaptureState}
  ///Returns a [AqutterMediaCaptureState] that indicates whether the webpage is using the camera to capture images or video.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getCameraCaptureState.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.cameraCaptureState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3763093-cameracapturestate',
        available: '15.0',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_get_camera_capture_state',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.get_camera_capture_state.html',
        available: '2.34',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.cameraCaptureState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3763093-cameracapturestate',
        available: '12.0',
      ),
    ],
  )
  Future<AqutterMediaCaptureState?> getCameraCaptureState() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getCameraCaptureState.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setCameraCaptureState}
  ///Changes whether the webpage is using the camera to capture images or video.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setCameraCaptureState.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.setCameraCaptureState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3763097-setcameracapturestate',
        available: '15.0',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_set_camera_capture_state',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.set_camera_capture_state.html',
        available: '2.34',
        note:
            'Once state is set to NONE, it cannot be changed back. The page can request capture again using the mediaDevices API.',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.setCameraCaptureState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3763097-setcameracapturestate',
        available: '12.0',
      ),
    ],
  )
  Future<void> setCameraCaptureState({required AqutterMediaCaptureState state}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setCameraCaptureState.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getMicrophoneCaptureState}
  ///Returns a [AqutterMediaCaptureState] that indicates whether the webpage is using the microphone to capture audio.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getMicrophoneCaptureState.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.microphoneCaptureState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3763096-microphonecapturestate',
        available: '15.0',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_get_microphone_capture_state',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.get_microphone_capture_state.html',
        available: '2.34',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.microphoneCaptureState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3763096-microphonecapturestate',
        available: '12.0',
      ),
    ],
  )
  Future<AqutterMediaCaptureState?> getMicrophoneCaptureState() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getMicrophoneCaptureState.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setMicrophoneCaptureState}
  ///Changes whether the webpage is using the microphone to capture audio.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setMicrophoneCaptureState.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.setMicrophoneCaptureState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3763098-setmicrophonecapturestate',
        available: '15.0',
      ),
      LinuxPlatform(
        apiName: 'webkit_web_view_set_microphone_capture_state',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.set_microphone_capture_state.html',
        available: '2.34',
        note:
            'Once state is set to NONE, it cannot be changed back. The page can request capture again using the mediaDevices API.',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.setMicrophoneCaptureState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3763098-setmicrophonecapturestate',
        available: '12.0',
      ),
    ],
  )
  Future<void> setMicrophoneCaptureState({required AqutterMediaCaptureState state}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setMicrophoneCaptureState.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.isPlayingAudio}
  ///Returns whether the webpage is playing audio.
  ///
  ///Returns `true` if the page is playing audio, `false` otherwise.
  ///This is useful for providing visual feedback when a page is producing sound.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isPlayingAudio.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      LinuxPlatform(
        apiName: 'webkit_web_view_is_playing_audio',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.is_playing_audio.html',
        available: '2.8',
      ),
    ],
  )
  Future<bool> isPlayingAudio() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.isPlayingAudio.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.isMuted}
  ///Returns whether the webpage audio is muted.
  ///
  ///Returns `true` if the page audio is muted, `false` otherwise.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isMuted.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      LinuxPlatform(
        apiName: 'webkit_web_view_get_is_muted',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.get_is_muted.html',
        available: '2.30',
      ),
    ],
  )
  Future<bool> isMuted() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.isMuted.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setMuted}
  ///Sets the mute state of the webpage.
  ///
  ///When [muted] is `true`, the webpage audio will be muted.
  ///When [muted] is `false`, the webpage audio will be unmuted.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setMuted.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      LinuxPlatform(
        apiName: 'webkit_web_view_set_is_muted',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.set_is_muted.html',
        available: '2.30',
      ),
    ],
  )
  Future<void> setMuted({required bool muted}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setMuted.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.terminateWebProcess}
  ///Terminates the web process associated to the WebView.
  ///
  ///When the web process is terminated using this method, the
  ///[AqutterPlatformWebViewCreationParams.onRenderProcessGone] callback is invoked
  ///with the reason set to indicate the process was terminated by the API.
  ///
  ///**Note**: This is a destructive operation that will crash the web content.
  ///Use this only when you need to forcefully kill an unresponsive or
  ///misbehaving web process.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.terminateWebProcess.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      LinuxPlatform(
        apiName: 'webkit_web_view_terminate_web_process',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebView.terminate_web_process.html',
        available: '2.34',
      ),
    ],
  )
  Future<void> terminateWebProcess() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.terminateWebProcess.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.loadSimulatedRequest}
  ///Loads the web content from the data you provide as if the data were the response to the request.
  ///If [urlResponse] is `null`, it loads the web content from the data as an utf8 encoded HTML string as the response to the request.
  ///
  ///[urlRequest] represents a URL request that specifies the base URL and other loading details the system uses to interpret the data you provide.
  ///
  ///[urlResponse] represents a response the system uses to interpret the data you provide.
  ///
  ///[data] represents the data or the utf8 encoded HTML string to use as the contents of the webpage.
  ///
  ///Example:
  ///```dart
  ///controller.loadSimulatedRequest(urlRequest: AqutterURLRequest(
  ///    url: AqutterWebUri("https://flutter.dev"),
  ///  ),
  ///  data: Uint8List.fromList(utf8.encode("<h1>Hello</h1>"))
  ///);
  ///```
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.loadSimulatedRequest.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.loadSimulatedRequest(_:response:responseData:)',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3763094-loadsimulatedrequest',
        available: '15.0',
        note:
            'or [Official API - WKWebView.loadSimulatedRequest(_:responseHTML:)](https://developer.apple.com/documentation/webkit/wkwebview/3763095-loadsimulatedrequest)',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.loadSimulatedRequest(_:response:responseData:)',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3763094-loadsimulatedrequest',
        available: '12.0',
        note:
            'or [Official API - WKWebView.loadSimulatedRequest(_:responseHTML:)](https://developer.apple.com/documentation/webkit/wkwebview/3763095-loadsimulatedrequest)',
      ),
    ],
  )
  Future<void> loadSimulatedRequest({
    required AqutterURLRequest urlRequest,
    required Uint8List data,
    AqutterURLResponse? urlResponse,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.loadSimulatedRequest.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.openDevTools}
  ///Opens the DevTools window for the current document in the WebView.
  ///Does nothing if run when the DevTools window is already open.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.openDevTools.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2.OpenDevToolsWindow',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#opendevtoolswindow',
      ),
    ],
  )
  Future<void> openDevTools() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.openDevTools.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.callDevToolsProtocolMethod}
  ///Runs an asynchronous `DevToolsProtocol` method.
  ///
  ///For more information about available methods, navigate to [DevTools Protocol Viewer](https://chromedevtools.github.io/devtools-protocol/tot).
  ///The [methodName] parameter is the full name of the method in the `{domain}.{method}` format.
  ///The [parameters] will be a JSON formatted string containing the parameters for the corresponding method.
  ///This function throws an error if the [methodName] is unknown or the [parameters] has an error.
  ///In the case of such an error, the [parameters] parameter of the
  ///handler will include information about the error.
  ///Note even though WebView dispatches the CDP messages in the order called,
  ///CDP method calls may be processed out of order.
  ///If you require CDP methods to run in a particular order, you should wait for
  ///the previous method's completed handler to run before calling the next method.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.callDevToolsProtocolMethod.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2.CallDevToolsProtocolMethod',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#calldevtoolsprotocolmethod',
      ),
    ],
  )
  Future<dynamic> callDevToolsProtocolMethod({
    required String methodName,
    Map<String, dynamic>? parameters,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.callDevToolsProtocolMethod.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.addDevToolsProtocolEventListener}
  ///Subscribe to a `DevToolsProtocol` event.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.addDevToolsProtocolEventListener.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName:
            'ICoreWebView2DevToolsProtocolEventReceiver.add_DevToolsProtocolEventReceived',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2devtoolsprotocoleventreceiver?view=webview2-1.0.2210.55#add_devtoolsprotocoleventreceived',
      ),
    ],
  )
  Future<void> addDevToolsProtocolEventListener({
    required String eventName,
    required Function(dynamic data) callback,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.addDevToolsProtocolEventListener.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.removeDevToolsProtocolEventListener}
  ///Remove an event handler previously added with [addDevToolsProtocolEventListener].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.removeDevToolsProtocolEventListener.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName:
            'ICoreWebView2DevToolsProtocolEventReceiver.remove_DevToolsProtocolEventReceived',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2devtoolsprotocoleventreceiver?view=webview2-1.0.2210.55#remove_devtoolsprotocoleventreceived',
      ),
    ],
  )
  Future<void> removeDevToolsProtocolEventListener({
    required String eventName,
  }) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.removeDevToolsProtocolEventListener.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.isInterfaceSupported}
  ///Returns `true` if the WebView supports the specified [interface], otherwise `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isInterfaceSupported.supported_platforms}
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  Future<bool> isInterfaceSupported(AqutterWebViewInterface interface) async {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.isInterfaceSupported.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.saveState}
  ///Returns the current state of interaction in a web view so that you can restore
  ///that state later to another web view using the [restoreState] method.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.saveState.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.saveState',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#saveState(android.os.Bundle)',
        note: 'This method doesn\'t store the display data for this WebView.',
      ),
      IOSPlatform(
        apiName: 'WKWebView.interactionState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3752236-interactionstate',
        available: '15.0',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.interactionState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3752236-interactionstate',
        available: '12.0',
      ),
      LinuxPlatform(),
    ],
  )
  Future<Uint8List?> saveState() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.saveState.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.restoreState}
  ///Restores the state of this WebView from the given [state] returned by the [saveState] method.
  ///If it is called after this WebView has had a chance to build state (load pages, create a back/forward list, etc.),
  ///there may be undesirable side-effects.
  ///
  ///Returns `true` if the state was restored successfully, otherwise `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.restoreState.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.restoreState',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#restoreState(android.os.Bundle)',
        note: 'This method doesn\'t restore the display data for this WebView.',
      ),
      IOSPlatform(
        apiName: 'WKWebView.interactionState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3752236-interactionstate',
        available: '15.0',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.interactionState',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/3752236-interactionstate',
        available: '12.0',
      ),
      LinuxPlatform(),
    ],
  )
  Future<bool> restoreState(Uint8List state) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.restoreState.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getIFrameId}
  ///Returns the iframe `id` attribute used on the Web platform.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getIFrameId.supported_platforms}
  @SupportedPlatforms(platforms: [WebPlatform()])
  Future<String?> getIFrameId() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getIFrameId.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getViewId}
  ///View ID used internally.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getViewId.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  dynamic getViewId() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getViewId.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getDefaultUserAgent}
  ///Gets the default user agent.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getDefaultUserAgent.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebSettings.getDefaultUserAgent',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebSettings#getDefaultUserAgent(android.content.Context)',
      ),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(
        apiName: 'Navigator.userAgent',
        apiUrl:
            'https://developer.mozilla.org/en-US/docs/Web/API/Navigator/userAgent',
      ),
    ],
  )
  Future<String> getDefaultUserAgent() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getDefaultUserAgent.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.clearClientCertPreferences}
  ///Clears the client certificate preferences stored in response to proceeding/cancelling client cert requests.
  ///Note that WebView automatically clears these preferences when the system keychain is updated.
  ///The preferences are shared by all the WebViews that are created by the embedder application.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearClientCertPreferences.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.clearClientCertPreferences',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#clearClientCertPreferences(java.lang.Runnable)',
        available: '21',
      ),
    ],
  )
  Future<void> clearClientCertPreferences() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.clearClientCertPreferences.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getSafeBrowsingPrivacyPolicyUrl}
  ///Returns a URL pointing to the privacy policy for Safe Browsing reporting.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getSafeBrowsingPrivacyPolicyUrl.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewCompat.getSafeBrowsingPrivacyPolicyUrl',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/WebViewCompat#getSafeBrowsingPrivacyPolicyUrl()',
        note:
            'This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.SAFE_BROWSING_PRIVACY_POLICY_URL].',
      ),
    ],
  )
  Future<AqutterWebUri?> getSafeBrowsingPrivacyPolicyUrl() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getSafeBrowsingPrivacyPolicyUrl.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setSafeBrowsingAllowlist}
  ///Sets the list of hosts (domain names/IP addresses) that are exempt from SafeBrowsing checks. The list is global for all the WebViews.
  ///
  /// Each rule should take one of these:
  ///| Rule | Example | Matches Subdomain |
  ///| -- | -- | -- |
  ///| HOSTNAME | example.com | Yes |
  ///| .HOSTNAME | .example.com | No |
  ///| IPV4_LITERAL | 192.168.1.1 | No |
  ///| IPV6_LITERAL_WITH_BRACKETS | [10:20:30:40:50:60:70:80] | No |
  ///
  ///All other rules, including wildcards, are invalid. The correct syntax for hosts is defined by [RFC 3986](https://tools.ietf.org/html/rfc3986#section-3.2.2).
  ///
  ///[hosts] represents the list of hosts. This value must never be `null`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setSafeBrowsingAllowlist.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewCompat.setSafeBrowsingAllowlist',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/WebViewCompat#setSafeBrowsingAllowlist(java.util.Set%3Cjava.lang.String%3E,%20android.webkit.ValueCallback%3Cjava.lang.Boolean%3E)',
        note:
            'This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.SAFE_BROWSING_ALLOWLIST].',
      ),
    ],
  )
  Future<bool> setSafeBrowsingAllowlist({required List<String> hosts}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setSafeBrowsingAllowlist.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getCurrentWebViewPackage}
  ///If WebView has already been loaded into the current process this method will return the package that was used to load it.
  ///Otherwise, the package that would be used if the WebView was loaded right now will be returned;
  ///this does not cause WebView to be loaded, so this information may become outdated at any time.
  ///The WebView package changes either when the current WebView package is updated, disabled, or uninstalled.
  ///It can also be changed through a Developer Setting. If the WebView package changes, any app process that
  ///has loaded WebView will be killed.
  ///The next time the app starts and loads WebView it will use the new WebView package instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getCurrentWebViewPackage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewCompat.getCurrentWebViewPackage',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/WebViewCompat#getCurrentWebViewPackage(android.content.Context)',
        available: '21',
      ),
    ],
  )
  Future<AqutterWebViewPackageInfo?> getCurrentWebViewPackage() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getCurrentWebViewPackage.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setWebContentsDebuggingEnabled}
  ///Enables debugging of web contents (HTML / CSS / JavaScript) loaded into any WebViews of this application.
  ///This flag can be enabled in order to facilitate debugging of web layouts and JavaScript code running inside WebViews.
  ///Please refer to WebView documentation for the debugging guide. The default is `false`.
  ///
  ///[debuggingEnabled] whether to enable web contents debugging.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setWebContentsDebuggingEnabled.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.setWebContentsDebuggingEnabled',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#setWebContentsDebuggingEnabled(boolean)',
      ),
    ],
  )
  Future<void> setWebContentsDebuggingEnabled(bool debuggingEnabled) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setWebContentsDebuggingEnabled.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getVariationsHeader}
  ///Gets the WebView variations encoded to be used as the X-Client-Data HTTP header.
  ///
  ///The app is responsible for adding the X-Client-Data header to any request
  ///that may use variations metadata, such as requests to Google web properties.
  ///The returned string will be a base64 encoded ClientVariations proto:
  ///https://source.chromium.org/chromium/chromium/src/+/main:components/variations/proto/client_variations.proto
  ///
  ///The string may be empty if the header is not available.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getVariationsHeader.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewCompat.getVariationsHeader',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/WebViewCompat#getVariationsHeader()',
        note:
            'This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.GET_VARIATIONS_HEADER].',
      ),
    ],
  )
  Future<String?> getVariationsHeader() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getVariationsHeader.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.isMultiProcessEnabled}
  ///Returns `true` if WebView is running in multi process mode.
  ///
  ///In Android O and above, WebView may run in "multiprocess" mode.
  ///In multiprocess mode, rendering of web content is performed by a sandboxed
  ///renderer process separate to the application process.
  ///This renderer process may be shared with other WebViews in the application,
  ///but is not shared with other application processes.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.isMultiProcessEnabled.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewCompat.isMultiProcessEnabled',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/WebViewCompat#isMultiProcessEnabled()',
        note:
            'This method should only be called if [AqutterWebViewFeature.isFeatureSupported] returns `true` for [AqutterWebViewFeature.MULTI_PROCESS].',
      ),
    ],
  )
  Future<bool> isMultiProcessEnabled() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.isMultiProcessEnabled.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.disableWebView}
  ///Indicate that the current process does not intend to use WebView,
  ///and that an exception should be thrown if a WebView is created or any other
  ///methods in the `android.webkit` package are used.
  ///
  ///Applications with multiple processes may wish to call this in processes that
  ///are not intended to use WebView to avoid accidentally incurring the memory usage
  ///of initializing WebView in long-lived processes that have no need for it,
  ///and to prevent potential data directory conflicts (see [AqutterProcessGlobalConfigSettings.dataDirectorySuffix]).
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.disableWebView.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.disableWebView',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#disableWebView()',
        available: '28',
      ),
    ],
  )
  Future<void> disableWebView() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.disableWebView.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.handlesURLScheme}
  ///Returns a Boolean value that indicates whether WebKit natively supports resources with the specified URL scheme.
  ///
  ///[urlScheme] represents the URL scheme associated with the resource.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.handlesURLScheme.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKWebView.handlesURLScheme',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/2875370-handlesurlscheme',
        available: '11.0',
      ),
      MacOSPlatform(
        apiName: 'WKWebView.handlesURLScheme',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebview/2875370-handlesurlscheme',
        available: '10.13',
      ),
      LinuxPlatform(
        note:
            'Returns true for built-in schemes (http, https, file, ftp, data, blob, about, javascript).',
      ),
    ],
  )
  Future<bool> handlesURLScheme(String urlScheme) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.handlesURLScheme.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.disposeKeepAlive}
  ///Disposes the WebView that is using the [keepAlive] instance for the keep alive feature.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.disposeKeepAlive.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> disposeKeepAlive(AqutterWebViewKeepAlive keepAlive) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.disposeKeepAlive.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.clearAllCache}
  ///Clears the resource cache. Note that the cache is per-application, so this will clear the cache for all WebViews used.
  ///
  ///[includeDiskFiles] if `false`, only the RAM cache is cleared. The default value is `true`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearAllCache.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> clearAllCache({bool includeDiskFiles = true}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.clearAllCache.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.enableSlowWholeDocumentDraw}
  ///For apps targeting the L release, WebView has a new default behavior that reduces memory footprint and increases
  ///performance by intelligently choosing the portion of the HTML document that needs to be drawn.
  ///These optimizations are transparent to the developers.
  ///However, under certain circumstances, an App developer may want to disable them, for example
  ///when an app draws and accesses portions of the page that is way outside the visible portion of the page.
  ///Enabling drawing the entire HTML document has a significant performance cost.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.enableSlowWholeDocumentDraw.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.enableSlowWholeDocumentDraw',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#enableSlowWholeDocumentDraw()',
        available: '21',
        note: 'This method should be called before any WebViews are created.',
      ),
    ],
  )
  Future<void> enableSlowWholeDocumentDraw() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.enableSlowWholeDocumentDraw.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setJavaScriptBridgeName}
  ///Sets the name of the JavaScript Bridge object that will be used to interact with the WebView.
  ///This method should be called before any WebViews are created or when there are no WebViews.
  ///Calling this method after a WebView has been created will not change
  ///the current JavaScript Bridge object and could lead to errors.
  ///
  ///The [bridgeName] must be a non-empty string with only alphanumeric and underscore characters.
  ///It can't start with a number.
  ///
  ///The default name used by this plugin is `aqutter`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setJavaScriptBridgeName.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> setJavaScriptBridgeName(String bridgeName) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setJavaScriptBridgeName.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getJavaScriptBridgeName}
  ///Gets the name of the JavaScript Bridge object that is used to interact with the WebView.
  ///Use [setJavaScriptBridgeName] to set a custom name.
  ///The default name used by this plugin is `aqutter`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getJavaScriptBridgeName.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<String> getJavaScriptBridgeName() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getJavaScriptBridgeName.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.tRexRunnerHtml}
  ///Gets the html (with javascript) of the Chromium's t-rex runner game. Used in combination with [tRexRunnerCss].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.tRexRunnerHtml.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<String> get tRexRunnerHtml => throw UnimplementedError(
    '${AqutterPlatformWebViewControllerProperty.tRexRunnerHtml.name} is not implemented on the current platform',
  );

  ///{@template aqutter_core.AqutterPlatformWebViewController.tRexRunnerCss}
  ///Gets the css of the Chromium's t-rex runner game. Used in combination with [tRexRunnerHtml].ì
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.tRexRunnerCss.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<String> get tRexRunnerCss => throw UnimplementedError(
    '${AqutterPlatformWebViewControllerProperty.tRexRunnerCss.name} is not implemented on the current platform',
  );

  ///{@template aqutter_core.AqutterPlatformWebViewController.setOptions}
  ///Use [setSettings] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setOptions.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  @Deprecated('Use setSettings instead')
  Future<void> setOptions({required AqutterWebViewGroupOptions options}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setOptions.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getOptions}
  ///Use [getSettings] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getOptions.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  @Deprecated('Use getSettings instead')
  Future<AqutterWebViewGroupOptions?> getOptions() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getOptions.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.findAllAsync}
  ///Use [AqutterPlatformFindInteractionController.findAll] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.findAllAsync.supported_platforms}
  @SupportedPlatforms(
    platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
  )
  @Deprecated("Use AqutterFindInteractionController.findAll instead")
  Future<void> findAllAsync({required String find}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.findAllAsync.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.findNext}
  ///Use [AqutterPlatformFindInteractionController.findNext] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.findNext.supported_platforms}
  @SupportedPlatforms(
    platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
  )
  @Deprecated("Use AqutterFindInteractionController.findNext instead")
  Future<void> findNext({required bool forward}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.findNext.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.clearMatches}
  ///Use [AqutterPlatformFindInteractionController.clearMatches] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.clearMatches.supported_platforms}
  @SupportedPlatforms(
    platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
  )
  @Deprecated("Use AqutterFindInteractionController.clearMatches instead")
  Future<void> clearMatches() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.clearMatches.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getTRexRunnerHtml}
  ///Use [tRexRunnerHtml] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getTRexRunnerHtml.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  @Deprecated("Use tRexRunnerHtml instead")
  Future<String> getTRexRunnerHtml() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getTRexRunnerHtml.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getTRexRunnerCss}
  ///Use [tRexRunnerCss] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getTRexRunnerCss.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  @Deprecated("Use tRexRunnerCss instead")
  Future<String> getTRexRunnerCss() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getTRexRunnerCss.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.getScale}
  ///Use [getZoomScale] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.getScale.supported_platforms}
  @SupportedPlatforms(
    platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
  )
  @Deprecated('Use getZoomScale instead')
  Future<double?> getScale() {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.getScale.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.setSafeBrowsingWhitelist}
  ///Use [setSafeBrowsingAllowlist] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.setSafeBrowsingWhitelist.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated("Use setSafeBrowsingAllowlist instead")
  Future<bool> setSafeBrowsingWhitelist({required List<String> hosts}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.setSafeBrowsingWhitelist.name} is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewController.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebViewControllerClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformWebViewController.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformWebViewControllerProperty property, {
    TargetPlatform? platform,
  }) => _AqutterPlatformWebViewControllerPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );

  ///{@template aqutter_core.AqutterPlatformWebViewController.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformWebViewControllerMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformWebViewControllerMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );

  ///{@template aqutter_core.AqutterPlatformWebViewController.dispose}
  ///Disposes the controller.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewController.dispose.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  void dispose({bool isKeepAlive = false}) {
    throw UnimplementedError(
      '${AqutterPlatformWebViewControllerMethod.dispose.name} is not implemented on the current platform',
    );
  }
}
