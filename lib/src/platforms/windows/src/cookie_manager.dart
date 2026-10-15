import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import 'webview_environment/webview_environment.dart';

/// Object specifying creation parameters for creating a [WindowsCookieManager].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformCookieManagerCreationParams] for
/// more information.
@immutable
class WindowsCookieManagerCreationParams
    extends AqutterPlatformCookieManagerCreationParams {
  /// Creates a new [WindowsCookieManagerCreationParams] instance.
  const WindowsCookieManagerCreationParams({this.webViewEnvironment});

  /// Creates a [WindowsCookieManagerCreationParams] instance based on [AqutterPlatformCookieManagerCreationParams].
  factory WindowsCookieManagerCreationParams.fromPlatformCookieManagerCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformCookieManagerCreationParams params,
  ) {
    return WindowsCookieManagerCreationParams(
      webViewEnvironment:
          params.webViewEnvironment as WindowsWebViewEnvironment?,
    );
  }

  @override
  final WindowsWebViewEnvironment? webViewEnvironment;
}

///{@macro aqutter_core.AqutterPlatformCookieManager}
class WindowsCookieManager extends AqutterPlatformCookieManager
    with ChannelController {
  /// Creates a new [WindowsCookieManager].
  WindowsCookieManager(AqutterPlatformCookieManagerCreationParams params)
    : super.implementation(
        params is WindowsCookieManagerCreationParams
            ? params
            : WindowsCookieManagerCreationParams.fromPlatformCookieManagerCreationParams(
                params,
              ),
      ) {
    channel = const MethodChannel(
      'com.github.aqutter/webview_cookiemanager',
    );
    handler = handleMethod;
    initMethodCallHandler();
  }

  static final WindowsCookieManager _staticValue = WindowsCookieManager(
    WindowsCookieManagerCreationParams(),
  );

  factory WindowsCookieManager.static() {
    return _staticValue;
  }

  static WindowsCookieManager? _instance;

  ///Gets the [WindowsCookieManager] shared instance.
  static WindowsCookieManager instance({
    WindowsWebViewEnvironment? webViewEnvironment,
  }) {
    if (webViewEnvironment == null) {
      if (_instance == null) {
        _instance = _init();
      }
      return _instance!;
    } else {
      return WindowsCookieManager(
        WindowsCookieManagerCreationParams(
          webViewEnvironment: webViewEnvironment,
        ),
      );
    }
  }

  static WindowsCookieManager _init() {
    _instance = WindowsCookieManager(WindowsCookieManagerCreationParams());
    return _instance!;
  }

  Future<dynamic> _handleMethod(MethodCall call) async {}

  @override
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
    AqutterPlatformWebViewController? iosBelow11WebViewController,
    AqutterPlatformWebViewController? webViewController,
  }) async {
    assert(url.toString().isNotEmpty);
    assert(name.isNotEmpty);
    assert(path.isNotEmpty);

    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('url', () => url.toString());
    args.putIfAbsent('name', () => name);
    args.putIfAbsent('value', () => value);
    args.putIfAbsent('domain', () => domain);
    args.putIfAbsent('path', () => path);
    args.putIfAbsent('expiresDate', () => expiresDate);
    args.putIfAbsent('maxAge', () => maxAge);
    args.putIfAbsent('isSecure', () => isSecure);
    args.putIfAbsent('isHttpOnly', () => isHttpOnly);
    args.putIfAbsent('sameSite', () => sameSite?.toNativeValue());
    args.putIfAbsent(
      'webViewEnvironmentId',
      () => params.webViewEnvironment?.id,
    );
    args.putIfAbsent('webViewId', () => webViewController?.id);

    return await channel?.invokeMethod<bool>('setCookie', args) ?? false;
  }

  @override
  Future<List<AqutterCookie>> getCookies({
    required AqutterWebUri url,
    @Deprecated("Use webViewController instead")
    AqutterPlatformWebViewController? iosBelow11WebViewController,
    AqutterPlatformWebViewController? webViewController,
  }) async {
    assert(url.toString().isNotEmpty);

    List<AqutterCookie> cookies = [];

    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('url', () => url.toString());
    args.putIfAbsent(
      'webViewEnvironmentId',
      () => params.webViewEnvironment?.id,
    );
    args.putIfAbsent('webViewId', () => webViewController?.id);
    List<dynamic> cookieListMap =
        await channel?.invokeMethod<List>('getCookies', args) ?? [];
    cookieListMap = cookieListMap.cast<Map<dynamic, dynamic>>();

    cookieListMap.forEach((cookieMap) {
      cookies.add(
        AqutterCookie(
          name: cookieMap["name"],
          value: cookieMap["value"],
          expiresDate: cookieMap["expiresDate"],
          isSessionOnly: cookieMap["isSessionOnly"],
          domain: cookieMap["domain"],
          sameSite: AqutterHTTPCookieSameSitePolicy.fromNativeValue(
            cookieMap["sameSite"],
          ),
          isSecure: cookieMap["isSecure"],
          isHttpOnly: cookieMap["isHttpOnly"],
          path: cookieMap["path"],
        ),
      );
    });
    return cookies;
  }

  @override
  Future<AqutterCookie?> getCookie({
    required AqutterWebUri url,
    required String name,
    @Deprecated("Use webViewController instead")
    AqutterPlatformWebViewController? iosBelow11WebViewController,
    AqutterPlatformWebViewController? webViewController,
  }) async {
    assert(url.toString().isNotEmpty);
    assert(name.isNotEmpty);

    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('url', () => url.toString());
    args.putIfAbsent(
      'webViewEnvironmentId',
      () => params.webViewEnvironment?.id,
    );
    args.putIfAbsent('webViewId', () => webViewController?.id);
    List<dynamic> cookies =
        await channel?.invokeMethod<List>('getCookies', args) ?? [];
    cookies = cookies.cast<Map<dynamic, dynamic>>();
    for (var i = 0; i < cookies.length; i++) {
      cookies[i] = cookies[i].cast<String, dynamic>();
      if (cookies[i]["name"] == name)
        return AqutterCookie(
          name: cookies[i]["name"],
          value: cookies[i]["value"],
          expiresDate: cookies[i]["expiresDate"],
          isSessionOnly: cookies[i]["isSessionOnly"],
          domain: cookies[i]["domain"],
          sameSite: AqutterHTTPCookieSameSitePolicy.fromNativeValue(
            cookies[i]["sameSite"],
          ),
          isSecure: cookies[i]["isSecure"],
          isHttpOnly: cookies[i]["isHttpOnly"],
          path: cookies[i]["path"],
        );
    }
    return null;
  }

  @override
  Future<bool> deleteCookie({
    required AqutterWebUri url,
    required String name,
    String path = "/",
    String? domain,
    @Deprecated("Use webViewController instead")
    AqutterPlatformWebViewController? iosBelow11WebViewController,
    AqutterPlatformWebViewController? webViewController,
  }) async {
    assert(url.toString().isNotEmpty);
    assert(name.isNotEmpty);

    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('url', () => url.toString());
    args.putIfAbsent('name', () => name);
    args.putIfAbsent('domain', () => domain);
    args.putIfAbsent('path', () => path);
    args.putIfAbsent(
      'webViewEnvironmentId',
      () => params.webViewEnvironment?.id,
    );
    args.putIfAbsent('webViewId', () => webViewController?.id);
    return await channel?.invokeMethod<bool>('deleteCookie', args) ?? false;
  }

  @override
  Future<bool> deleteCookies({
    required AqutterWebUri url,
    String path = "/",
    String? domain,
    @Deprecated("Use webViewController instead")
    AqutterPlatformWebViewController? iosBelow11WebViewController,
    AqutterPlatformWebViewController? webViewController,
  }) async {
    assert(url.toString().isNotEmpty);

    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('url', () => url.toString());
    args.putIfAbsent('domain', () => domain);
    args.putIfAbsent('path', () => path);
    args.putIfAbsent(
      'webViewEnvironmentId',
      () => params.webViewEnvironment?.id,
    );
    args.putIfAbsent('webViewId', () => webViewController?.id);
    return await channel?.invokeMethod<bool>('deleteCookies', args) ?? false;
  }

  @override
  Future<bool> deleteAllCookies() async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent(
      'webViewEnvironmentId',
      () => params.webViewEnvironment?.id,
    );
    return await channel?.invokeMethod<bool>('deleteAllCookies', args) ?? false;
  }

  @override
  void dispose() {
    // empty
  }
}

extension InternalCookieManager on WindowsCookieManager {
  get handleMethod => _handleMethod;
}
