import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import 'webview/webview_controller.dart';
import 'webview_environment/webview_environment.dart';

///{@macro aqutter_core.AqutterPlatformCookieManager}
///
///{@macro aqutter_core.AqutterPlatformCookieManager.supported_platforms}
class AqutterCookieManager {
  ///{@macro aqutter_core.AqutterPlatformCookieManager}
  ///
  ///{@macro aqutter_core.AqutterPlatformCookieManager.supported_platforms}
  AqutterCookieManager()
    : this.fromPlatformCreationParams(
        const AqutterPlatformCookieManagerCreationParams(),
      );

  /// Constructs a [AqutterCookieManager] from creation params for a specific
  /// platform.
  AqutterCookieManager.fromPlatformCreationParams(
    AqutterPlatformCookieManagerCreationParams params,
  ) : this.fromPlatform(AqutterPlatformCookieManager(params));

  /// Constructs a [AqutterCookieManager] from a specific platform
  /// implementation.
  AqutterCookieManager.fromPlatform(this.platform);

  /// Implementation of [AqutterPlatformCookieManager] for the current platform.
  final AqutterPlatformCookieManager platform;

  ///Use [AqutterCookieManager] instead.
  @Deprecated("Use AqutterCookieManager instead")
  AqutterIOSCookieManager ios = AqutterIOSCookieManager.instance();

  static AqutterCookieManager? _instance;

  ///Gets the [AqutterCookieManager] shared instance.
  ///
  ///[webViewEnvironment] (Supported only on Windows) - Used to create the [AqutterCookieManager] using the specified environment.
  static AqutterCookieManager instance({AqutterWebViewEnvironment? webViewEnvironment}) {
    if (webViewEnvironment == null) {
      if (_instance == null) {
        _instance = AqutterCookieManager();
      }
      return _instance!;
    } else {
      return AqutterCookieManager.fromPlatformCreationParams(
        AqutterPlatformCookieManagerCreationParams(
          webViewEnvironment: webViewEnvironment.platform,
        ),
      );
    }
  }

  ///{@macro aqutter_core.AqutterPlatformCookieManager.setCookie}
  ///
  ///{@macro aqutter_core.AqutterPlatformCookieManager.setCookie.supported_platforms}
  Future<bool> setCookie({
    required AqutterWebUri url,
    required String name,
    required String value,
    String path = "/",
    String? domain,
    int? expiresDate,
    int? maxAge,
    bool? isSecure,
    bool? isHttpOnly,
    AqutterHTTPCookieSameSitePolicy? sameSite,
    @Deprecated("Use webViewController instead")
    AqutterWebViewController? iosBelow11WebViewController,
    AqutterWebViewController? webViewController,
  }) => platform.setCookie(
    url: url,
    name: name,
    value: value,
    path: path,
    domain: domain,
    expiresDate: expiresDate,
    maxAge: maxAge,
    isSecure: isSecure,
    isHttpOnly: isHttpOnly,
    sameSite: sameSite,
    iosBelow11WebViewController: iosBelow11WebViewController?.platform,
    webViewController: webViewController?.platform,
  );

  ///{@macro aqutter_core.AqutterPlatformCookieManager.getCookies}
  ///
  ///{@macro aqutter_core.AqutterPlatformCookieManager.getCookies.supported_platforms}
  Future<List<AqutterCookie>> getCookies({
    required AqutterWebUri url,
    @Deprecated("Use webViewController instead")
    AqutterWebViewController? iosBelow11WebViewController,
    AqutterWebViewController? webViewController,
  }) => platform.getCookies(
    url: url,
    iosBelow11WebViewController: iosBelow11WebViewController?.platform,
    webViewController: webViewController?.platform,
  );

  ///{@macro aqutter_core.AqutterPlatformCookieManager.getCookie}
  ///
  ///{@macro aqutter_core.AqutterPlatformCookieManager.getCookie.supported_platforms}
  Future<AqutterCookie?> getCookie({
    required AqutterWebUri url,
    required String name,
    @Deprecated("Use webViewController instead")
    AqutterWebViewController? iosBelow11WebViewController,
    AqutterWebViewController? webViewController,
  }) => platform.getCookie(
    url: url,
    name: name,
    iosBelow11WebViewController: iosBelow11WebViewController?.platform,
    webViewController: webViewController?.platform,
  );

  ///{@macro aqutter_core.AqutterPlatformCookieManager.deleteCookie}
  ///
  ///{@macro aqutter_core.AqutterPlatformCookieManager.deleteCookie.supported_platforms}
  Future<bool> deleteCookie({
    required AqutterWebUri url,
    required String name,
    String path = "/",
    String? domain,
    @Deprecated("Use webViewController instead")
    AqutterWebViewController? iosBelow11WebViewController,
    AqutterWebViewController? webViewController,
  }) => platform.deleteCookie(
    url: url,
    name: name,
    path: path,
    domain: domain,
    iosBelow11WebViewController: iosBelow11WebViewController?.platform,
    webViewController: webViewController?.platform,
  );

  ///{@macro aqutter_core.AqutterPlatformCookieManager.deleteCookies}
  ///
  ///{@macro aqutter_core.AqutterPlatformCookieManager.deleteCookies.supported_platforms}
  Future<bool> deleteCookies({
    required AqutterWebUri url,
    String path = "/",
    String? domain,
    @Deprecated("Use webViewController instead")
    AqutterWebViewController? iosBelow11WebViewController,
    AqutterWebViewController? webViewController,
  }) => platform.deleteCookies(
    url: url,
    path: path,
    domain: domain,
    iosBelow11WebViewController: iosBelow11WebViewController?.platform,
    webViewController: webViewController?.platform,
  );

  ///{@macro aqutter_core.AqutterPlatformCookieManager.deleteAllCookies}
  ///
  ///{@macro aqutter_core.AqutterPlatformCookieManager.deleteAllCookies.supported_platforms}
  Future<bool> deleteAllCookies() => platform.deleteAllCookies();

  ///{@macro aqutter_core.AqutterPlatformCookieManager.getAllCookies}
  ///
  ///{@macro aqutter_core.AqutterPlatformCookieManager.getAllCookies.supported_platforms}
  Future<List<AqutterCookie>> getAllCookies() => platform.getAllCookies();

  ///{@macro aqutter_core.AqutterPlatformCookieManager.removeSessionCookies}
  ///
  ///{@macro aqutter_core.AqutterPlatformCookieManager.removeSessionCookies.supported_platforms}
  Future<bool> removeSessionCookies() => platform.removeSessionCookies();

  ///{@macro aqutter_core.AqutterPlatformCookieManager.flush}
  ///
  ///{@macro aqutter_core.AqutterPlatformCookieManager.flush.supported_platforms}
  Future<void> flush() => platform.flush();

  ///{@macro aqutter_core.AqutterPlatformCookieManagerCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformCookieManager.static().isClassSupported(platform: platform);

  ///{@macro aqutter_core.AqutterPlatformCookieManagerCreationParams.isPropertySupported}
  static bool isPropertySupported(
    AqutterPlatformCookieManagerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => AqutterPlatformCookieManager.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformCookieManager.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformCookieManagerMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformCookieManager.static().isMethodSupported(
    method,
    platform: platform,
  );
}

///Class that contains only iOS-specific methods of [AqutterCookieManager].
///Use [AqutterCookieManager] instead.
@Deprecated("Use AqutterCookieManager instead")
class AqutterIOSCookieManager {
  static AqutterIOSCookieManager? _instance;

  ///Gets the [AqutterIOSCookieManager] shared instance.
  static AqutterIOSCookieManager instance() {
    return (_instance != null) ? _instance! : _init();
  }

  AqutterIOSCookieManager._();

  static AqutterIOSCookieManager _init() {
    _instance = AqutterIOSCookieManager._();
    return _instance!;
  }

  ///Fetches all stored cookies.
  ///
  ///**NOTE**: available on iOS 11.0+.
  ///
  ///**Official iOS API**: https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882005-getallcookies
  Future<List<AqutterCookie>> getAllCookies() async {
    return AqutterCookieManager.instance().getAllCookies();
  }
}
