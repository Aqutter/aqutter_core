import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [AndroidCookieManager].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformCookieManagerCreationParams] for
/// more information.
@immutable
class AndroidCookieManagerCreationParams
    extends AqutterPlatformCookieManagerCreationParams {
  /// Creates a new [AndroidCookieManagerCreationParams] instance.
  const AndroidCookieManagerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformCookieManagerCreationParams params,
  ) : super();

  /// Creates a [AndroidCookieManagerCreationParams] instance based on [AqutterPlatformCookieManagerCreationParams].
  factory AndroidCookieManagerCreationParams.fromPlatformCookieManagerCreationParams(
    AqutterPlatformCookieManagerCreationParams params,
  ) {
    return AndroidCookieManagerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformCookieManager}
class AndroidCookieManager extends AqutterPlatformCookieManager
    with ChannelController {
  /// Creates a new [AndroidCookieManager].
  AndroidCookieManager(AqutterPlatformCookieManagerCreationParams params)
    : super.implementation(
        params is AndroidCookieManagerCreationParams
            ? params
            : AndroidCookieManagerCreationParams.fromPlatformCookieManagerCreationParams(
                params,
              ),
      ) {
    channel = const MethodChannel(
      'com.github.aqutter/webview_cookiemanager',
    );
    handler = handleMethod;
    initMethodCallHandler();
  }

  static final AndroidCookieManager _staticValue = AndroidCookieManager(
    AndroidCookieManagerCreationParams(AqutterPlatformCookieManagerCreationParams()),
  );

  factory AndroidCookieManager.static() {
    return _staticValue;
  }

  static AndroidCookieManager? _instance;

  ///Gets the [AndroidCookieManager] shared instance.
  static AndroidCookieManager instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static AndroidCookieManager _init() {
    _instance = AndroidCookieManager(
      AndroidCookieManagerCreationParams(
        const AqutterPlatformCookieManagerCreationParams(),
      ),
    );
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
    args.putIfAbsent('expiresDate', () => expiresDate?.toString());
    args.putIfAbsent('maxAge', () => maxAge);
    args.putIfAbsent('isSecure', () => isSecure);
    args.putIfAbsent('isHttpOnly', () => isHttpOnly);
    args.putIfAbsent('sameSite', () => sameSite?.toNativeValue());

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
    return await channel?.invokeMethod<bool>('deleteCookies', args) ?? false;
  }

  @override
  Future<bool> deleteAllCookies() async {
    Map<String, dynamic> args = <String, dynamic>{};
    return await channel?.invokeMethod<bool>('deleteAllCookies', args) ?? false;
  }

  @override
  Future<bool> removeSessionCookies() async {
    Map<String, dynamic> args = <String, dynamic>{};
    return await channel?.invokeMethod<bool>('removeSessionCookies', args) ??
        false;
  }

  @override
  Future<void> flush() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('flush', args);
  }

  @override
  void dispose() {
    // empty
  }
}

extension InternalCookieManager on AndroidCookieManager {
  get handleMethod => _handleMethod;
}
