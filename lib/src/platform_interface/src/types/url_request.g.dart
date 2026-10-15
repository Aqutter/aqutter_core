// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///A URL load request that is independent of protocol or URL scheme.
class AqutterURLRequest {
  ///A Boolean value indicating whether the request is allowed to use the built-in cellular radios to satisfy the request.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - AqutterURLRequest.allowsCellularAccess](https://developer.apple.com/documentation/foundation/urlrequest/2011607-allowscellularaccess/))
  ///- macOS WKWebView ([Official API - AqutterURLRequest.allowsCellularAccess](https://developer.apple.com/documentation/foundation/urlrequest/2011607-allowscellularaccess/))
  bool? allowsCellularAccess;

  ///A Boolean value that indicates whether the request may use the network when the user has specified Low Data Mode.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 13.0+ ([Official API - AqutterURLRequest.allowsConstrainedNetworkAccess](https://developer.apple.com/documentation/foundation/urlrequest/3358304-allowsconstrainednetworkaccess))
  ///- macOS WKWebView 10.15+ ([Official API - AqutterURLRequest.allowsConstrainedNetworkAccess](https://developer.apple.com/documentation/foundation/urlrequest/3358304-allowsconstrainednetworkaccess))
  bool? allowsConstrainedNetworkAccess;

  ///A Boolean value that indicates whether connections may use a network interface that the system considers expensive.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 13.0+ ([Official API - AqutterURLRequest.allowsExpensiveNetworkAccess](https://developer.apple.com/documentation/foundation/urlrequest/3358305-allowsexpensivenetworkaccess))
  ///- macOS WKWebView 10.15+ ([Official API - AqutterURLRequest.allowsExpensiveNetworkAccess](https://developer.apple.com/documentation/foundation/urlrequest/3358305-allowsexpensivenetworkaccess))
  bool? allowsExpensiveNetworkAccess;

  ///`true` if server endpoint is known to support HTTP/3. Enables QUIC racing
  ///without HTTP/3 service discovery. Defaults to `false`.
  ///The default may be `true` in a future OS update.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 14.5+ ([Official API - AqutterURLRequest.assumesHTTP3Capable](https://developer.apple.com/documentation/foundation/urlrequest/3738175-assumeshttp3capable))
  ///- macOS WKWebView 11.3+ ([Official API - AqutterURLRequest.assumesHTTP3Capable](https://developer.apple.com/documentation/foundation/urlrequest/3738175-assumeshttp3capable))
  bool? assumesHTTP3Capable;

  ///The entities that can make a network request.
  ///
  ///If you don’t set a value, the system assumes [AqutterURLRequestAttribution.DEVELOPER].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 15.0+ ([Official API - AqutterURLRequest.attribution](https://developer.apple.com/documentation/foundation/urlrequest/3767318-attribution))
  ///- macOS WKWebView 12.0+ ([Official API - AqutterURLRequest.attribution](https://developer.apple.com/documentation/foundation/urlrequest/3767318-attribution))
  AqutterURLRequestAttribution? attribution;

  ///The data sent as the message body of a request, such as for an HTTP POST request.
  Uint8List? body;

  ///The request’s cache policy.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - AqutterURLRequest.cachePolicy](https://developer.apple.com/documentation/foundation/urlrequest/2011593-cachepolicy))
  ///- macOS WKWebView ([Official API - AqutterURLRequest.cachePolicy](https://developer.apple.com/documentation/foundation/urlrequest/2011593-cachepolicy))
  AqutterURLRequestCachePolicy? cachePolicy;

  ///A dictionary containing all of the HTTP header fields for a request.
  Map<String, String>? headers;

  ///A Boolean value indicating whether cookies will be sent with and set for this request.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - AqutterURLRequest.httpShouldHandleCookies](https://developer.apple.com/documentation/foundation/urlrequest/2011548-httpshouldhandlecookies))
  ///- macOS WKWebView ([Official API - AqutterURLRequest.httpShouldHandleCookies](https://developer.apple.com/documentation/foundation/urlrequest/2011548-httpshouldhandlecookies))
  bool? httpShouldHandleCookies;

  ///A Boolean value indicating whether the request should transmit before the previous response is received.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - AqutterURLRequest.httpShouldUsePipelining](https://developer.apple.com/documentation/foundation/urlrequest/2011508-httpshouldusepipelining))
  ///- macOS WKWebView ([Official API - AqutterURLRequest.httpShouldUsePipelining](https://developer.apple.com/documentation/foundation/urlrequest/2011508-httpshouldusepipelining))
  bool? httpShouldUsePipelining;

  ///Use [allowsCellularAccess] instead.
  @Deprecated('Use allowsCellularAccess instead')
  bool? iosAllowsCellularAccess;

  ///Use [allowsConstrainedNetworkAccess] instead.
  @Deprecated('Use allowsConstrainedNetworkAccess instead')
  bool? iosAllowsConstrainedNetworkAccess;

  ///Use [allowsExpensiveNetworkAccess] instead.
  @Deprecated('Use allowsExpensiveNetworkAccess instead')
  bool? iosAllowsExpensiveNetworkAccess;

  ///Use [cachePolicy] instead.
  @Deprecated('Use cachePolicy instead')
  AqutterIOSURLRequestCachePolicy? iosCachePolicy;

  ///Use [httpShouldHandleCookies] instead.
  @Deprecated('Use httpShouldHandleCookies instead')
  bool? iosHttpShouldHandleCookies;

  ///Use [httpShouldUsePipelining] instead.
  @Deprecated('Use httpShouldUsePipelining instead')
  bool? iosHttpShouldUsePipelining;

  ///Use [mainDocumentURL] instead.
  @Deprecated('Use mainDocumentURL instead')
  Uri? iosMainDocumentURL;

  ///Use [networkServiceType] instead.
  @Deprecated('Use networkServiceType instead')
  AqutterIOSURLRequestNetworkServiceType? iosNetworkServiceType;

  ///Use [timeoutInterval] instead.
  @Deprecated('Use timeoutInterval instead')
  double? iosTimeoutInterval;

  ///The main document URL associated with this request.
  ///This URL is used for the cookie “same domain as main document” policy.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - AqutterURLRequest.mainDocumentURL](https://developer.apple.com/documentation/foundation/urlrequest/2011552-maindocumenturl))
  ///- macOS WKWebView ([Official API - AqutterURLRequest.mainDocumentURL](https://developer.apple.com/documentation/foundation/urlrequest/2011552-maindocumenturl))
  AqutterWebUri? mainDocumentURL;

  ///The HTTP request method.
  ///
  ///**NOTE for Android**: it supports only "GET" and "POST" methods.
  String? method;

  ///The service type associated with this request.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - AqutterURLRequest.networkServiceType](https://developer.apple.com/documentation/foundation/urlrequest/2011409-networkservicetype))
  ///- macOS WKWebView ([Official API - AqutterURLRequest.networkServiceType](https://developer.apple.com/documentation/foundation/urlrequest/2011409-networkservicetype))
  AqutterURLRequestNetworkServiceType? networkServiceType;

  ///The timeout interval of the request.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - AqutterURLRequest.timeoutInterval](https://developer.apple.com/documentation/foundation/urlrequest/2011509-timeoutinterval))
  ///- macOS WKWebView ([Official API - AqutterURLRequest.timeoutInterval](https://developer.apple.com/documentation/foundation/urlrequest/2011509-timeoutinterval))
  double? timeoutInterval;

  ///The URL of the request. Setting this to `null` will load `about:blank`.
  AqutterWebUri? url;
  AqutterURLRequest({
    this.allowsCellularAccess,
    this.allowsConstrainedNetworkAccess,
    this.allowsExpensiveNetworkAccess,
    this.assumesHTTP3Capable,
    this.attribution,
    this.body,
    this.cachePolicy,
    this.headers,
    this.httpShouldHandleCookies,
    this.httpShouldUsePipelining,
    @Deprecated('Use allowsCellularAccess instead')
    this.iosAllowsCellularAccess,
    @Deprecated('Use allowsConstrainedNetworkAccess instead')
    this.iosAllowsConstrainedNetworkAccess,
    @Deprecated('Use allowsExpensiveNetworkAccess instead')
    this.iosAllowsExpensiveNetworkAccess,
    @Deprecated('Use cachePolicy instead') this.iosCachePolicy,
    @Deprecated('Use httpShouldHandleCookies instead')
    this.iosHttpShouldHandleCookies,
    @Deprecated('Use httpShouldUsePipelining instead')
    this.iosHttpShouldUsePipelining,
    @Deprecated('Use mainDocumentURL instead') this.iosMainDocumentURL,
    @Deprecated('Use networkServiceType instead') this.iosNetworkServiceType,
    @Deprecated('Use timeoutInterval instead') this.iosTimeoutInterval,
    this.mainDocumentURL,
    this.method,
    this.networkServiceType,
    this.timeoutInterval,
    this.url,
  }) {
    allowsCellularAccess = allowsCellularAccess ?? iosAllowsCellularAccess;
    allowsConstrainedNetworkAccess =
        allowsConstrainedNetworkAccess ?? iosAllowsConstrainedNetworkAccess;
    allowsExpensiveNetworkAccess =
        allowsExpensiveNetworkAccess ?? iosAllowsExpensiveNetworkAccess;
    cachePolicy =
        cachePolicy ??
        AqutterURLRequestCachePolicy.fromNativeValue(
          iosCachePolicy?.toNativeValue(),
        );
    httpShouldHandleCookies =
        httpShouldHandleCookies ?? iosHttpShouldHandleCookies;
    httpShouldUsePipelining =
        httpShouldUsePipelining ?? iosHttpShouldUsePipelining;
    mainDocumentURL =
        mainDocumentURL ??
        (iosMainDocumentURL != null
            ? AqutterWebUri.uri(iosMainDocumentURL!)
            : null);
    networkServiceType =
        networkServiceType ??
        AqutterURLRequestNetworkServiceType.fromNativeValue(
          iosNetworkServiceType?.toNativeValue(),
        );
    timeoutInterval = timeoutInterval ?? iosTimeoutInterval;
  }

  ///Gets a possible [AqutterURLRequest] instance from a [Map] value.
  static AqutterURLRequest? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterURLRequest(
      allowsCellularAccess: map['allowsCellularAccess'],
      allowsConstrainedNetworkAccess: map['allowsConstrainedNetworkAccess'],
      allowsExpensiveNetworkAccess: map['allowsExpensiveNetworkAccess'],
      assumesHTTP3Capable: map['assumesHTTP3Capable'],
      attribution: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterURLRequestAttribution.fromNativeValue(map['attribution']),
        AqutterEnumMethod.value => AqutterURLRequestAttribution.fromValue(
          map['attribution'],
        ),
        AqutterEnumMethod.name => AqutterURLRequestAttribution.byName(
          map['attribution'],
        ),
      },
      body: map['body'] != null
          ? Uint8List.fromList(map['body'].cast<int>())
          : null,
      cachePolicy: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterURLRequestCachePolicy.fromNativeValue(map['cachePolicy']),
        AqutterEnumMethod.value => AqutterURLRequestCachePolicy.fromValue(
          map['cachePolicy'],
        ),
        AqutterEnumMethod.name => AqutterURLRequestCachePolicy.byName(
          map['cachePolicy'],
        ),
      },
      headers: map['headers']?.cast<String, String>(),
      httpShouldHandleCookies: map['httpShouldHandleCookies'],
      httpShouldUsePipelining: map['httpShouldUsePipelining'],
      iosAllowsCellularAccess: map['allowsCellularAccess'],
      iosAllowsConstrainedNetworkAccess: map['allowsConstrainedNetworkAccess'],
      iosAllowsExpensiveNetworkAccess: map['allowsExpensiveNetworkAccess'],
      iosCachePolicy: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterIOSURLRequestCachePolicy.fromNativeValue(map['cachePolicy']),
        AqutterEnumMethod.value => AqutterIOSURLRequestCachePolicy.fromValue(
          map['cachePolicy'],
        ),
        AqutterEnumMethod.name => AqutterIOSURLRequestCachePolicy.byName(
          map['cachePolicy'],
        ),
      },
      iosHttpShouldHandleCookies: map['httpShouldHandleCookies'],
      iosHttpShouldUsePipelining: map['httpShouldUsePipelining'],
      iosMainDocumentURL: map['mainDocumentURL'] != null
          ? Uri.tryParse(map['mainDocumentURL'])
          : null,
      iosNetworkServiceType: switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterIOSURLRequestNetworkServiceType.fromNativeValue(
            map['networkServiceType'],
          ),
        AqutterEnumMethod.value =>
          AqutterIOSURLRequestNetworkServiceType.fromValue(
            map['networkServiceType'],
          ),
        AqutterEnumMethod.name => AqutterIOSURLRequestNetworkServiceType.byName(
          map['networkServiceType'],
        ),
      },
      iosTimeoutInterval: map['timeoutInterval'],
      mainDocumentURL: map['mainDocumentURL'] != null
          ? AqutterWebUri(map['mainDocumentURL'])
          : null,
      method: map['method'],
      networkServiceType: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterURLRequestNetworkServiceType.fromNativeValue(
            map['networkServiceType'],
          ),
        AqutterEnumMethod.value =>
          AqutterURLRequestNetworkServiceType.fromValue(
            map['networkServiceType'],
          ),
        AqutterEnumMethod.name => AqutterURLRequestNetworkServiceType.byName(
          map['networkServiceType'],
        ),
      },
      timeoutInterval: map['timeoutInterval'],
      url: map['url'] != null ? AqutterWebUri(map['url']) : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "allowsCellularAccess": allowsCellularAccess,
      "allowsConstrainedNetworkAccess": allowsConstrainedNetworkAccess,
      "allowsExpensiveNetworkAccess": allowsExpensiveNetworkAccess,
      "assumesHTTP3Capable": assumesHTTP3Capable,
      "attribution": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => attribution?.toNativeValue(),
        AqutterEnumMethod.value => attribution?.toValue(),
        AqutterEnumMethod.name => attribution?.name(),
      },
      "body": body,
      "cachePolicy": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => cachePolicy?.toNativeValue(),
        AqutterEnumMethod.value => cachePolicy?.toValue(),
        AqutterEnumMethod.name => cachePolicy?.name(),
      },
      "headers": headers,
      "httpShouldHandleCookies": httpShouldHandleCookies,
      "httpShouldUsePipelining": httpShouldUsePipelining,
      "mainDocumentURL": mainDocumentURL?.toString(),
      "method": method,
      "networkServiceType": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => networkServiceType?.toNativeValue(),
        AqutterEnumMethod.value => networkServiceType?.toValue(),
        AqutterEnumMethod.name => networkServiceType?.name(),
      },
      "timeoutInterval": timeoutInterval,
      "url": url?.toString(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterURLRequest{allowsCellularAccess: $allowsCellularAccess, allowsConstrainedNetworkAccess: $allowsConstrainedNetworkAccess, allowsExpensiveNetworkAccess: $allowsExpensiveNetworkAccess, assumesHTTP3Capable: $assumesHTTP3Capable, attribution: $attribution, body: $body, cachePolicy: $cachePolicy, headers: $headers, httpShouldHandleCookies: $httpShouldHandleCookies, httpShouldUsePipelining: $httpShouldUsePipelining, mainDocumentURL: $mainDocumentURL, method: $method, networkServiceType: $networkServiceType, timeoutInterval: $timeoutInterval, url: $url}';
  }
}
