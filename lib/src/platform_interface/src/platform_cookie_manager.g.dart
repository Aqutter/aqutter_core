// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_cookie_manager.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformCookieManagerCreationParamsClassSupported
    on AqutterPlatformCookieManagerCreationParams {
  ///{@template aqutter_core.AqutterPlatformCookieManagerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- Linux WPE WebKit
  ///- macOS WKWebView
  ///- Web \<iframe\> but requires same origin
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformCookieManagerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return kIsWeb && platform == null
        ? true
        : ((kIsWeb && platform != null) || !kIsWeb) &&
              [
                TargetPlatform.android,
                TargetPlatform.iOS,
                TargetPlatform.linux,
                TargetPlatform.macOS,
                TargetPlatform.windows,
              ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformCookieManagerCreationParams]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformCookieManagerCreationParamsProperty {
  ///Can be used to check if the [AqutterPlatformCookieManagerCreationParams.webViewEnvironment] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformCookieManagerCreationParams.webViewEnvironment.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformCookieManagerCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  webViewEnvironment,
}

extension _AqutterPlatformCookieManagerCreationParamsPropertySupported
    on AqutterPlatformCookieManagerCreationParams {
  static bool isPropertySupported(
    AqutterPlatformCookieManagerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformCookieManagerCreationParamsProperty
          .webViewEnvironment:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

extension _AqutterPlatformCookieManagerClassSupported
    on AqutterPlatformCookieManager {
  ///{@template aqutter_core.AqutterPlatformCookieManager.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - It is implemented using [AqutterCookieManager](https://developer.android.com/reference/android/webkit/AqutterCookieManager).
  ///- iOS WKWebView:
  ///    - It is implemented using [WKHTTPCookieStore](https://developer.apple.com/documentation/webkit/wkhttpcookiestore). On iOS below 11.0, it is implemented using JavaScript. See https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies for JavaScript restrictions.
  ///- Linux WPE WebKit ([Official API - WebKitCookieManager](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.AqutterCookieManager.html)):
  ///    - It is implemented using WebKitCookieManager from WPE WebKit.
  ///- macOS WKWebView:
  ///    - It is implemented using [WKHTTPCookieStore](https://developer.apple.com/documentation/webkit/wkhttpcookiestore).
  ///- Web \<iframe\> but requires same origin:
  ///    - It is implemented using JavaScript. See https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies for JavaScript restrictions.
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformCookieManager.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return kIsWeb && platform == null
        ? true
        : ((kIsWeb && platform != null) || !kIsWeb) &&
              [
                TargetPlatform.android,
                TargetPlatform.iOS,
                TargetPlatform.linux,
                TargetPlatform.macOS,
                TargetPlatform.windows,
              ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformCookieManager]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformCookieManagerMethod {
  ///Can be used to check if the [AqutterPlatformCookieManager.deleteAllCookies] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformCookieManager.deleteAllCookies.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterCookieManager.removeAllCookies](https://developer.android.com/reference/android/webkit/AqutterCookieManager#removeAllCookies(android.webkit.ValueCallback%3Cjava.lang.Boolean%3E)))
  ///- iOS WKWebView 11.0+ ([Official API - WKWebsiteDataStore.removeData](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532938-removedata)):
  ///    - It will return always `true`.
  ///- macOS WKWebView 10.13+ ([Official API - WKWebsiteDataStore.removeData](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532938-removedata)):
  ///    - It will return always `true`.
  ///- Windows WebView2
  ///- Linux WPE WebKit ([Official API - webkit_website_data_manager_clear](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebsiteDataManager.clear.html)):
  ///    - Uses WebsiteDataManager to clear all cookie data.
  ///
  ///Use the [AqutterPlatformCookieManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  deleteAllCookies,

  ///Can be used to check if the [AqutterPlatformCookieManager.deleteCookie] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformCookieManager.deleteCookie.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterCookieManager.getCookie](https://developer.android.com/reference/android/webkit/AqutterCookieManager#getCookie(java.lang.String)))
  ///- iOS WKWebView ([Official API - WKHTTPCookieStore.delete](https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882009-delete)):
  ///    - On iOS below 11.0, the [webViewController] is used for deleting the cookie (also session-only cookie) using JavaScript (cookie with `isHttpOnly` enabled cannot be deleted, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) from the current context of the `WebView` managed by that controller. JavaScript must be enabled in order to work. In this case the [url] parameter is ignored. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to delete the cookie (session-only cookie and cookie with `isHttpOnly` enabled won't be deleted!). In this case, this method will return always `true`.
  ///- macOS WKWebView ([Official API - WKHTTPCookieStore.delete](https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882009-delete)):
  ///    - On macOS below 10.13, the [webViewController] is used for deleting the cookie (also session-only cookie) using JavaScript (cookie with `isHttpOnly` enabled cannot be deleted, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) from the current context of the `WebView` managed by that controller. JavaScript must be enabled in order to work. In this case the [url] parameter is ignored. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to delete the cookie (session-only cookie and cookie with `isHttpOnly` enabled won't be deleted!). In this case, this method will return always `true`.
  ///- Web \<iframe\> but requires same origin:
  ///    - The [webViewController] is used for deleting the cookie (also session-only cookie) using JavaScript (cookie with `isHttpOnly` enabled cannot be deleted, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) from the current context of the `WebView` managed by that controller. JavaScript must be enabled in order to work. In this case the [url] parameter is ignored. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to delete the cookie (session-only cookie and cookie with `isHttpOnly` enabled won't be deleted!). In this case, this method will return always `true`.
  ///- Windows WebView2:
  ///    - The [webViewController] could be used to access cookies accessible only on the WebView managed by that controller, such as cookie with partition key.
  ///- Linux WPE WebKit ([Official API - webkit_cookie_manager_delete_cookie](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.AqutterCookieManager.delete_cookie.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [name]: all platforms
  ///- [path]: all platforms
  ///- [domain]: all platforms
  ///- [webViewController]:
  ///    - macOS WKWebView
  ///    - iOS WKWebView
  ///    - Web \<iframe\> but requires same origin
  ///    - Windows WebView2
  ///
  ///Use the [AqutterPlatformCookieManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  deleteCookie,

  ///Can be used to check if the [AqutterPlatformCookieManager.deleteCookies] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformCookieManager.deleteCookies.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterCookieManager.getCookie](https://developer.android.com/reference/android/webkit/AqutterCookieManager#getCookie(java.lang.String)))
  ///- iOS WKWebView ([Official API - WKHTTPCookieStore.delete](https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882009-delete)):
  ///    - On iOS below 11.0, the [webViewController] is used for deleting the cookies (also session-only cookies) using JavaScript (cookies with `isHttpOnly` enabled cannot be deleted, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) from the current context of the `WebView` managed by that controller. JavaScript must be enabled in order to work. In this case the [url] parameter is ignored. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to delete the cookies (session-only cookies and cookies with `isHttpOnly` enabled won't be deleted!). In this case, this method will return always `true`.
  ///- macOS WKWebView ([Official API - WKHTTPCookieStore.delete](https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882009-delete)):
  ///    - On macOS below 10.13, the [webViewController] is used for deleting the cookies (also session-only cookies) using JavaScript (cookies with `isHttpOnly` enabled cannot be deleted, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) from the current context of the `WebView` managed by that controller. JavaScript must be enabled in order to work. In this case the [url] parameter is ignored. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to delete the cookies (session-only cookies and cookies with `isHttpOnly` enabled won't be deleted!). In this case, this method will return always `true`.
  ///- Web \<iframe\> but requires same origin:
  ///    - The [webViewController] is used for deleting the cookies (also session-only cookies) using JavaScript (cookies with `isHttpOnly` enabled cannot be deleted, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) from the current context of the `WebView` managed by that controller. JavaScript must be enabled in order to work. In this case the [url] parameter is ignored. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to delete the cookies (session-only cookies and cookies with `isHttpOnly` enabled won't be deleted!). In this case, this method will return always `true`.
  ///- Windows WebView2:
  ///    - The [webViewController] could be used to access cookies accessible only on the WebView managed by that controller, such as cookie with partition key.
  ///- Linux WPE WebKit ([Official API - webkit_cookie_manager_delete_cookie](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.AqutterCookieManager.delete_cookie.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [path]: all platforms
  ///- [domain]: all platforms
  ///- [webViewController]:
  ///    - macOS WKWebView
  ///    - iOS WKWebView
  ///    - Web \<iframe\> but requires same origin
  ///    - Windows WebView2
  ///
  ///Use the [AqutterPlatformCookieManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  deleteCookies,

  ///Can be used to check if the [AqutterPlatformCookieManager.flush] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformCookieManager.flush.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterCookieManager.flush](https://developer.android.com/reference/android/webkit/AqutterCookieManager#flush()))
  ///
  ///Use the [AqutterPlatformCookieManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  flush,

  ///Can be used to check if the [AqutterPlatformCookieManager.getAllCookies] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformCookieManager.getAllCookies.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 11.0+ ([Official API - WKHTTPCookieStore.getAllCookies](https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882005-getallcookies))
  ///- macOS WKWebView 10.13+ ([Official API - WKHTTPCookieStore.getAllCookies](https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882005-getallcookies))
  ///- Linux WPE WebKit ([Official API - webkit_cookie_manager_get_all_cookies](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.AqutterCookieManager.get_all_cookies.html))
  ///
  ///Use the [AqutterPlatformCookieManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getAllCookies,

  ///Can be used to check if the [AqutterPlatformCookieManager.getCookie] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformCookieManager.getCookie.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterCookieManager.getCookie](https://developer.android.com/reference/android/webkit/AqutterCookieManager#getCookie(java.lang.String)))
  ///- iOS WKWebView ([Official API - WKHTTPCookieStore.getAllCookies](https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882005-getallcookies)):
  ///    - On iOS below 11.0, the [webViewController] is used for getting the cookie (also session-only cookie) using JavaScript (cookie with `isHttpOnly` enabled cannot be found, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) from the current context of the `WebView` managed by that controller. JavaScript must be enabled in order to work. In this case the [url] parameter is ignored. All the cookies returned this way will have all the properties to `null` except for [AqutterCookie.name] and [AqutterCookie.value]. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to get the cookie (session-only cookie and cookie with `isHttpOnly` enabled won't be found!).
  ///- macOS WKWebView ([Official API - WKHTTPCookieStore.getAllCookies](https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882005-getallcookies)):
  ///    - On macOS below 10.13, the [webViewController] is used for getting the cookie (also session-only cookie) using JavaScript (cookie with `isHttpOnly` enabled cannot be found, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) from the current context of the `WebView` managed by that controller. JavaScript must be enabled in order to work. In this case the [url] parameter is ignored. All the cookies returned this way will have all the properties to `null` except for [AqutterCookie.name] and [AqutterCookie.value]. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to get the cookie (session-only cookie and cookie with `isHttpOnly` enabled won't be found!).
  ///- Web \<iframe\> but requires same origin:
  ///    - The [webViewController] is used for getting the cookie (also session-only cookie) using JavaScript (cookie with `isHttpOnly` enabled cannot be found, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) from the current context of the `WebView` managed by that controller. JavaScript must be enabled in order to work. In this case the [url] parameter is ignored. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to get the cookie (session-only cookie and cookie with `isHttpOnly` enabled won't be found!).
  ///- Windows WebView2:
  ///    - The [webViewController] could be used to access cookies accessible only on the WebView managed by that controller, such as cookie with partition key.
  ///- Linux WPE WebKit ([Official API - webkit_cookie_manager_get_cookies](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.AqutterCookieManager.get_cookies.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [name]: all platforms
  ///- [webViewController]:
  ///    - macOS WKWebView
  ///    - iOS WKWebView
  ///    - Web \<iframe\> but requires same origin
  ///    - Windows WebView2
  ///
  ///Use the [AqutterPlatformCookieManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getCookie,

  ///Can be used to check if the [AqutterPlatformCookieManager.getCookies] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformCookieManager.getCookies.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterCookieManager.getCookie](https://developer.android.com/reference/android/webkit/AqutterCookieManager#getCookie(java.lang.String)))
  ///- iOS WKWebView ([Official API - WKHTTPCookieStore.getAllCookies](https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882005-getallcookies)):
  ///    - On iOS below 11.0, the [webViewController] is used for getting the cookies (also session-only cookies) using JavaScript (cookies with `isHttpOnly` enabled cannot be found, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) from the current context of the `WebView` managed by that controller. JavaScript must be enabled in order to work. In this case the [url] parameter is ignored. All the cookies returned this way will have all the properties to `null` except for [AqutterCookie.name] and [AqutterCookie.value]. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to get the cookies (session-only cookies and cookies with `isHttpOnly` enabled won't be found!).
  ///- macOS WKWebView ([Official API - WKHTTPCookieStore.getAllCookies](https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882005-getallcookies)):
  ///    - On macOS below 10.13, the [webViewController] is used for getting the cookies (also session-only cookies) using JavaScript (cookies with `isHttpOnly` enabled cannot be found, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) from the current context of the `WebView` managed by that controller. JavaScript must be enabled in order to work. In this case the [url] parameter is ignored. All the cookies returned this way will have all the properties to `null` except for [AqutterCookie.name] and [AqutterCookie.value]. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to get the cookies (session-only cookies and cookies with `isHttpOnly` enabled won't be found!).
  ///- Web \<iframe\> but requires same origin:
  ///    - The [webViewController] is used for getting the cookies (also session-only cookies) using JavaScript (cookies with `isHttpOnly` enabled cannot be found, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) from the current context of the `WebView` managed by that controller. JavaScript must be enabled in order to work. In this case the [url] parameter is ignored. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to get the cookies (session-only cookies and cookies with `isHttpOnly` enabled won't be found!).
  ///- Windows WebView2:
  ///    - The [webViewController] could be used to access cookies accessible only on the WebView managed by that controller, such as cookie with partition key.
  ///- Linux WPE WebKit ([Official API - webkit_cookie_manager_get_cookies](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.AqutterCookieManager.get_cookies.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [webViewController]:
  ///    - macOS WKWebView
  ///    - iOS WKWebView
  ///    - Web \<iframe\> but requires same origin
  ///    - Windows WebView2
  ///
  ///Use the [AqutterPlatformCookieManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getCookies,

  ///Can be used to check if the [AqutterPlatformCookieManager.removeSessionCookies] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformCookieManager.removeSessionCookies.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterCookieManager.removeSessionCookies](https://developer.android.com/reference/android/webkit/AqutterCookieManager#removeSessionCookies(android.webkit.ValueCallback%3Cjava.lang.Boolean%3E)))
  ///
  ///Use the [AqutterPlatformCookieManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  removeSessionCookies,

  ///Can be used to check if the [AqutterPlatformCookieManager.setCookie] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformCookieManager.setCookie.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterCookieManager.setCookie](https://developer.android.com/reference/android/webkit/AqutterCookieManager#setCookie(java.lang.String,%20java.lang.String,%20android.webkit.ValueCallback%3Cjava.lang.Boolean%3E)))
  ///- iOS WKWebView ([Official API - WKHTTPCookieStore.setCookie](https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882007-setcookie)):
  ///    - On iOS below 11.0, the [webViewController] could be used if you need to set a session-only cookie using JavaScript (so [isHttpOnly] cannot be set, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) on the current URL of the `WebView` managed by that controller. JavaScript must be enabled in order to work. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to set the cookie (session-only cookie won't work! In that case, you should set also [expiresDate] or [maxAge]). In this case, this method will return always `true`.
  ///- macOS WKWebView ([Official API - WKHTTPCookieStore.setCookie](https://developer.apple.com/documentation/webkit/wkhttpcookiestore/2882007-setcookie)):
  ///    - On macOS below 10.13, the [webViewController] could be used if you need to set a session-only cookie using JavaScript (so [isHttpOnly] cannot be set, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) on the current URL of the `WebView` managed by that controller. JavaScript must be enabled in order to work. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to set the cookie (session-only cookie won't work! In that case, you should set also [expiresDate] or [maxAge]). In this case, this method will return always `true`.
  ///- Web \<iframe\> but requires same origin:
  ///    - The [webViewController] could be used if you need to set a session-only cookie using JavaScript (so [isHttpOnly] cannot be set, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies) on the current URL of the `WebView` managed by that controller. JavaScript must be enabled in order to work. If [webViewController] is `null` or JavaScript is disabled for it, it will try to use a [AqutterPlatformHeadlessWebView] to set the cookie (session-only cookie won't work! In that case, you should set also [expiresDate] or [maxAge]). In this case, this method will return always `true`.
  ///- Windows WebView2:
  ///    - The [webViewController] could be used to access cookies accessible only on the WebView managed by that controller, such as cookie with partition key.
  ///- Linux WPE WebKit ([Official API - webkit_cookie_manager_add_cookie](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.AqutterCookieManager.add_cookie.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [name]: all platforms
  ///- [value]: all platforms
  ///- [path]: all platforms
  ///- [domain]: all platforms
  ///- [expiresDate]: all platforms
  ///- [maxAge]: all platforms
  ///- [isSecure]: all platforms
  ///- [isHttpOnly]: all platforms
  ///- [sameSite]: all platforms
  ///- [webViewController]:
  ///    - macOS WKWebView
  ///    - iOS WKWebView
  ///    - Web \<iframe\> but requires same origin
  ///    - Windows WebView2
  ///
  ///Use the [AqutterPlatformCookieManager.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setCookie,
}

extension _AqutterPlatformCookieManagerMethodSupported
    on AqutterPlatformCookieManager {
  static bool isMethodSupported(
    AqutterPlatformCookieManagerMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformCookieManagerMethod.deleteAllCookies:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformCookieManagerMethod.deleteCookie:
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
      case AqutterPlatformCookieManagerMethod.deleteCookies:
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
      case AqutterPlatformCookieManagerMethod.flush:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformCookieManagerMethod.getAllCookies:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformCookieManagerMethod.getCookie:
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
      case AqutterPlatformCookieManagerMethod.getCookies:
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
      case AqutterPlatformCookieManagerMethod.removeSessionCookies:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformCookieManagerMethod.setCookie:
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
}
