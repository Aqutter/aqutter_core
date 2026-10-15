import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import 'webview/headless_webview.dart';
import 'platform_util.dart';

/// Object specifying creation parameters for creating a [MacOSCookieManager].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformCookieManagerCreationParams] for
/// more information.
@immutable
class MacOSCookieManagerCreationParams
    extends AqutterPlatformCookieManagerCreationParams {
  /// Creates a new [MacOSCookieManagerCreationParams] instance.
  const MacOSCookieManagerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformCookieManagerCreationParams params,
  ) : super();

  /// Creates a [MacOSCookieManagerCreationParams] instance based on [AqutterPlatformCookieManagerCreationParams].
  factory MacOSCookieManagerCreationParams.fromPlatformCookieManagerCreationParams(
    AqutterPlatformCookieManagerCreationParams params,
  ) {
    return MacOSCookieManagerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformCookieManager}
class MacOSCookieManager extends AqutterPlatformCookieManager with ChannelController {
  /// Creates a new [MacOSCookieManager].
  MacOSCookieManager(AqutterPlatformCookieManagerCreationParams params)
    : super.implementation(
        params is MacOSCookieManagerCreationParams
            ? params
            : MacOSCookieManagerCreationParams.fromPlatformCookieManagerCreationParams(
                params,
              ),
      ) {
    channel = const MethodChannel(
      'com.github.aqutter/webview_cookiemanager',
    );
    handler = handleMethod;
    initMethodCallHandler();
  }

  static final MacOSCookieManager _staticValue = MacOSCookieManager(
    MacOSCookieManagerCreationParams(AqutterPlatformCookieManagerCreationParams()),
  );

  factory MacOSCookieManager.static() {
    return _staticValue;
  }

  static MacOSCookieManager? _instance;

  ///Gets the [MacOSCookieManager] shared instance.
  static MacOSCookieManager instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static MacOSCookieManager _init() {
    _instance = MacOSCookieManager(
      MacOSCookieManagerCreationParams(
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
    webViewController = webViewController ?? iosBelow11WebViewController;

    assert(url.toString().isNotEmpty);
    assert(name.isNotEmpty);
    assert(path.isNotEmpty);

    if (await _shouldUseJavascript()) {
      await _setCookieWithJavaScript(
        url: url,
        name: name,
        value: value,
        domain: domain,
        path: path,
        expiresDate: expiresDate,
        maxAge: maxAge,
        isSecure: isSecure,
        sameSite: sameSite,
        webViewController: webViewController,
      );
      return true;
    }

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

  Future<void> _setCookieWithJavaScript({
    required AqutterWebUri url,
    required String name,
    required String value,
    String path = "/",
    String? domain,
    int? expiresDate,
    int? maxAge,
    bool? isSecure,
    AqutterHTTPCookieSameSitePolicy? sameSite,
    AqutterPlatformWebViewController? webViewController,
  }) async {
    var cookieValue = name + "=" + value + "; Path=" + path;

    if (domain != null) cookieValue += "; Domain=" + domain;

    if (expiresDate != null)
      cookieValue += "; Expires=" + await _getCookieExpirationDate(expiresDate);

    if (maxAge != null) cookieValue += "; Max-Age=" + maxAge.toString();

    if (isSecure != null && isSecure) cookieValue += "; Secure";

    if (sameSite != null && sameSite.isSupported())
      cookieValue += "; SameSite=" + sameSite.toNativeValue()!;

    cookieValue += ";";

    if (webViewController != null) {
      final javaScriptEnabled =
          (await webViewController.getSettings())?.javaScriptEnabled ?? false;
      if (javaScriptEnabled) {
        await webViewController.evaluateJavascript(
          source: 'document.cookie="$cookieValue"',
        );
        return;
      }
    }

    final setCookieCompleter = Completer<void>();
    final headlessWebView = AqutterMacOSHeadlessWebView(
      AqutterMacOSHeadlessWebViewCreationParams(
        initialUrlRequest: AqutterURLRequest(url: url),
        onLoadStop: (controller, url) async {
          await controller.evaluateJavascript(
            source: 'document.cookie="$cookieValue"',
          );
          setCookieCompleter.complete();
        },
      ),
    );
    await headlessWebView.run();
    await setCookieCompleter.future;
    await headlessWebView.dispose();
  }

  @override
  Future<List<AqutterCookie>> getCookies({
    required AqutterWebUri url,
    @Deprecated("Use webViewController instead")
    AqutterPlatformWebViewController? iosBelow11WebViewController,
    AqutterPlatformWebViewController? webViewController,
  }) async {
    assert(url.toString().isNotEmpty);

    webViewController = webViewController ?? iosBelow11WebViewController;

    if (await _shouldUseJavascript()) {
      return await _getCookiesWithJavaScript(
        url: url,
        webViewController: webViewController,
      );
    }

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

  Future<List<AqutterCookie>> _getCookiesWithJavaScript({
    required AqutterWebUri url,
    AqutterPlatformWebViewController? webViewController,
  }) async {
    assert(url.toString().isNotEmpty);

    List<AqutterCookie> cookies = [];

    if (webViewController != null) {
      final javaScriptEnabled =
          (await webViewController.getSettings())?.javaScriptEnabled ?? false;
      if (javaScriptEnabled) {
        List<String> documentCookies =
            (await webViewController.evaluateJavascript(
                      source: 'document.cookie',
                    )
                    as String)
                .split(';')
                .map((documentCookie) => documentCookie.trim())
                .toList();
        documentCookies.forEach((documentCookie) {
          List<String> cookie = documentCookie.split('=');
          if (cookie.length > 1) {
            cookies.add(AqutterCookie(name: cookie[0], value: cookie[1]));
          }
        });
        return cookies;
      }
    }

    final pageLoaded = Completer<void>();
    final headlessWebView = AqutterMacOSHeadlessWebView(
      AqutterMacOSHeadlessWebViewCreationParams(
        initialUrlRequest: AqutterURLRequest(url: url),
        onLoadStop: (controller, url) async {
          pageLoaded.complete();
        },
      ),
    );
    await headlessWebView.run();
    await pageLoaded.future;

    List<String> documentCookies =
        (await headlessWebView.webViewController!.evaluateJavascript(
                  source: 'document.cookie',
                )
                as String)
            .split(';')
            .map((documentCookie) => documentCookie.trim())
            .toList();
    documentCookies.forEach((documentCookie) {
      List<String> cookie = documentCookie.split('=');
      if (cookie.length > 1) {
        cookies.add(AqutterCookie(name: cookie[0], value: cookie[1]));
      }
    });
    await headlessWebView.dispose();
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

    webViewController = webViewController ?? iosBelow11WebViewController;

    if (await _shouldUseJavascript()) {
      List<AqutterCookie> cookies = await _getCookiesWithJavaScript(
        url: url,
        webViewController: webViewController,
      );
      return cookies.cast<AqutterCookie?>().firstWhere(
        (cookie) => cookie!.name == name,
        orElse: () => null,
      );
    }

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

    webViewController = webViewController ?? iosBelow11WebViewController;

    if (await _shouldUseJavascript()) {
      await _setCookieWithJavaScript(
        url: url,
        name: name,
        value: "",
        path: path,
        domain: domain,
        maxAge: -1,
        webViewController: webViewController,
      );
      return true;
    }

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

    webViewController = webViewController ?? iosBelow11WebViewController;

    if (await _shouldUseJavascript()) {
      List<AqutterCookie> cookies = await _getCookiesWithJavaScript(
        url: url,
        webViewController: webViewController,
      );
      for (var i = 0; i < cookies.length; i++) {
        await _setCookieWithJavaScript(
          url: url,
          name: cookies[i].name,
          value: "",
          path: path,
          domain: domain,
          maxAge: -1,
          webViewController: webViewController,
        );
      }
      return true;
    }

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
  Future<List<AqutterCookie>> getAllCookies() async {
    List<AqutterCookie> cookies = [];

    Map<String, dynamic> args = <String, dynamic>{};
    List<dynamic> cookieListMap =
        await channel?.invokeMethod<List>('getAllCookies', args) ?? [];
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

  Future<String> _getCookieExpirationDate(int expiresDate) async {
    var platformUtil = PlatformUtil.instance();
    var dateTime = DateTime.fromMillisecondsSinceEpoch(expiresDate).toUtc();
    return await platformUtil.formatDate(
      date: dateTime,
      format: 'EEE, dd MMM yyyy HH:mm:ss z',
      locale: 'en_US',
      timezone: 'GMT',
    );
  }

  Future<bool> _shouldUseJavascript() async {
    final platformUtil = PlatformUtil.instance();
    final systemVersion = await platformUtil.getSystemVersion();
    return systemVersion.compareTo("11") == -1;
  }

  @override
  void dispose() {
    // empty
  }
}

extension InternalCookieManager on MacOSCookieManager {
  get handleMethod => _handleMethod;
}
