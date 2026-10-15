// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookie.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents a cookie returned by the [AqutterPlatformCookieManager].
class AqutterCookie {
  ///The cookie domain.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Android WebView:
  ///    - available on Android only if [AqutterWebViewFeature.GET_COOKIE_INFO] feature is supported.
  ///- Windows WebView2
  String? domain;

  ///The cookie expiration date in milliseconds.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Android WebView:
  ///    - available on Android only if [AqutterWebViewFeature.GET_COOKIE_INFO] feature is supported.
  ///- Windows WebView2
  int? expiresDate;

  ///Indicates if the cookie is a http only cookie.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Android WebView:
  ///    - available on Android only if [AqutterWebViewFeature.GET_COOKIE_INFO] feature is supported.
  ///- Windows WebView2
  bool? isHttpOnly;

  ///Indicates if the cookie is secure or not.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Android WebView:
  ///    - available on Android only if [AqutterWebViewFeature.GET_COOKIE_INFO] feature is supported.
  ///- Windows WebView2
  bool? isSecure;

  ///Indicates if the cookie is a session only cookie.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  bool? isSessionOnly;

  ///The cookie name.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Android WebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  String name;

  ///The cookie path.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Android WebView:
  ///    - available on Android only if [AqutterWebViewFeature.GET_COOKIE_INFO] feature is supported.
  ///- Windows WebView2
  String? path;

  ///The cookie same site policy.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Android WebView:
  ///    - available on Android only if [AqutterWebViewFeature.GET_COOKIE_INFO] feature is supported.
  ///- Windows WebView2
  AqutterHTTPCookieSameSitePolicy? sameSite;

  ///The cookie value.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Android WebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  dynamic value;
  AqutterCookie({
    this.domain,
    this.expiresDate,
    this.isHttpOnly,
    this.isSecure,
    this.isSessionOnly,
    required this.name,
    this.path,
    this.sameSite,
    this.value,
  });

  ///Gets a possible [AqutterCookie] instance from a [Map] value.
  static AqutterCookie? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterCookie(
      domain: map['domain'],
      expiresDate: map['expiresDate'],
      isHttpOnly: map['isHttpOnly'],
      isSecure: map['isSecure'],
      isSessionOnly: map['isSessionOnly'],
      name: map['name'],
      path: map['path'],
      sameSite: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterHTTPCookieSameSitePolicy.fromNativeValue(map['sameSite']),
        AqutterEnumMethod.value => AqutterHTTPCookieSameSitePolicy.fromValue(
          map['sameSite'],
        ),
        AqutterEnumMethod.name => AqutterHTTPCookieSameSitePolicy.byName(
          map['sameSite'],
        ),
      },
      value: map['value'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "domain": domain,
      "expiresDate": expiresDate,
      "isHttpOnly": isHttpOnly,
      "isSecure": isSecure,
      "isSessionOnly": isSessionOnly,
      "name": name,
      "path": path,
      "sameSite": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => sameSite?.toNativeValue(),
        AqutterEnumMethod.value => sameSite?.toValue(),
        AqutterEnumMethod.name => sameSite?.name(),
      },
      "value": value,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterCookie{domain: $domain, expiresDate: $expiresDate, isHttpOnly: $isHttpOnly, isSecure: $isSecure, isSessionOnly: $isSessionOnly, name: $name, path: $path, sameSite: $sameSite, value: $value}';
  }
}
