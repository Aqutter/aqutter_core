// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents a HTTP request created with JavaScript using the [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch).
class AqutterFetchRequest {
  ///Indicates the [AqutterFetchRequestAction] that can be used to control the request.
  AqutterFetchRequestAction? action;

  ///Body of the request.
  dynamic body;

  ///The cache mode used by the request.
  String? cache;

  ///The request credentials used by the request.
  AqutterFetchRequestCredential? credentials;

  ///The HTTP request headers.
  Map<String, dynamic>? headers;

  ///Contains the subresource integrity value of the request.
  String? integrity;

  ///The keepalive option used to allow the request to outlive the page.
  bool? keepalive;

  ///The HTTP request method used of the request.
  String? method;

  ///The mode used by the request.
  String? mode;

  ///The redirect mode used by the request.
  String? redirect;

  ///A String specifying no-referrer, client, or a URL.
  String? referrer;

  ///The value of the referer HTTP header.
  AqutterReferrerPolicy? referrerPolicy;

  ///The URL of the request.
  AqutterWebUri? url;
  AqutterFetchRequest({
    AqutterFetchRequestAction? action,
    this.body,
    this.cache,
    this.credentials,
    this.headers,
    this.integrity,
    this.keepalive,
    this.method,
    this.mode,
    this.redirect,
    this.referrer,
    this.referrerPolicy,
    this.url,
  }) : action = action ?? AqutterFetchRequestAction.PROCEED;

  ///Gets a possible [AqutterFetchRequest] instance from a [Map] value.
  static AqutterFetchRequest? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterFetchRequest(
      body: map['body'],
      cache: map['cache'],
      credentials: _fetchRequestCredentialDeserializer(
        map['credentials'],
        enumMethod: enumMethod,
      ),
      headers: map['headers']?.cast<String, dynamic>(),
      integrity: map['integrity'],
      keepalive: map['keepalive'],
      method: map['method'],
      mode: map['mode'],
      redirect: map['redirect'],
      referrer: map['referrer'],
      referrerPolicy: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterReferrerPolicy.fromNativeValue(
          map['referrerPolicy'],
        ),
        AqutterEnumMethod.value => AqutterReferrerPolicy.fromValue(
          map['referrerPolicy'],
        ),
        AqutterEnumMethod.name => AqutterReferrerPolicy.byName(
          map['referrerPolicy'],
        ),
      },
      url: map['url'] != null ? AqutterWebUri(map['url']) : null,
    );
    instance.action = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterFetchRequestAction.fromNativeValue(map['action']),
      AqutterEnumMethod.value => AqutterFetchRequestAction.fromValue(
        map['action'],
      ),
      AqutterEnumMethod.name => AqutterFetchRequestAction.byName(map['action']),
    };
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "action": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => action?.toNativeValue(),
        AqutterEnumMethod.value => action?.toValue(),
        AqutterEnumMethod.name => action?.name(),
      },
      "body": body,
      "cache": cache,
      "credentials": credentials?.toMap(enumMethod: enumMethod),
      "headers": headers,
      "integrity": integrity,
      "keepalive": keepalive,
      "method": method,
      "mode": mode,
      "redirect": redirect,
      "referrer": referrer,
      "referrerPolicy": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => referrerPolicy?.toNativeValue(),
        AqutterEnumMethod.value => referrerPolicy?.toValue(),
        AqutterEnumMethod.name => referrerPolicy?.name(),
      },
      "url": url?.toString(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterFetchRequest{action: $action, body: $body, cache: $cache, credentials: $credentials, headers: $headers, integrity: $integrity, keepalive: $keepalive, method: $method, mode: $mode, redirect: $redirect, referrer: $referrer, referrerPolicy: $referrerPolicy, url: $url}';
  }
}
