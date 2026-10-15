// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ajax_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents a JavaScript [XMLHttpRequest](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest) object.
class AqutterAjaxRequest {
  ///Indicates the [AqutterAjaxRequestAction] that can be used to control the `XMLHttpRequest` request.
  AqutterAjaxRequestAction? action;

  ///Data passed as a parameter to the `XMLHttpRequest.send()` method.
  dynamic data;

  ///Event type of the `XMLHttpRequest` request.
  AqutterAjaxRequestEvent? event;

  ///The HTTP request headers.
  AqutterAjaxRequestHeaders? headers;

  ///An optional Boolean parameter, defaulting to true, indicating whether or not the request is performed asynchronously.
  bool? isAsync;

  ///The HTTP request method of the `XMLHttpRequest` request.
  String? method;

  ///The optional password to use for authentication purposes; by default, this is the null value.
  String? password;

  ///The state of the `XMLHttpRequest` request.
  AqutterAjaxRequestReadyState? readyState;

  ///The response's body content. The content-type depends on the [AqutterAjaxRequest.responseType].
  dynamic response;

  ///All the response headers or returns null if no response has been received. If a network error happened, an empty string is returned.
  Map<String, dynamic>? responseHeaders;

  ///The text received from a server following a request being sent.
  String? responseText;

  ///It is an enumerated string value specifying the type of data contained in the response.
  ///It also lets the author change the [response type](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/responseType).
  ///If an empty string is set as the value of responseType, the default value of text is used.
  String? responseType;

  ///The serialized URL of the response or the empty string if the URL is null.
  ///If the URL is returned, any URL fragment present in the URL will be stripped away.
  ///The value of responseURL will be the final URL obtained after any redirects.
  AqutterWebUri? responseURL;

  ///The HTML or XML string retrieved by the request or null if the request was unsuccessful, has not yet been sent, or if the data can't be parsed as XML or HTML.
  String? responseXML;

  ///The numerical HTTP [status code](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status) of the `XMLHttpRequest`'s response.
  int? status;

  ///A String containing the response's status message as returned by the HTTP server.
  ///Unlike [AqutterAjaxRequest.status] which indicates a numerical status code, this property contains the text of the response status, such as "OK" or "Not Found".
  ///If the request's readyState is in [AqutterAjaxRequestReadyState.UNSENT] or [AqutterAjaxRequestReadyState.OPENED] state, the value of statusText will be an empty string.
  ///If the server response doesn't explicitly specify a status text, statusText will assume the default value "OK".
  String? statusText;

  ///The URL of the `XMLHttpRequest` request.
  AqutterWebUri? url;

  ///The optional user name to use for authentication purposes; by default, this is the null value.
  String? user;

  ///The XMLHttpRequest.withCredentials property is a Boolean that indicates whether or not cross-site Access-Control requests
  ///should be made using credentials such as cookies, authorization headers or TLS client certificates.
  ///Setting withCredentials has no effect on same-site requests.
  ///In addition, this flag is also used to indicate when cookies are to be ignored in the response. The default is false.
  bool? withCredentials;
  AqutterAjaxRequest({
    AqutterAjaxRequestAction? action,
    this.data,
    this.event,
    this.headers,
    this.isAsync,
    this.method,
    this.password,
    this.readyState,
    this.response,
    this.responseHeaders,
    this.responseText,
    this.responseType,
    this.responseURL,
    this.responseXML,
    this.status,
    this.statusText,
    this.url,
    this.user,
    this.withCredentials,
  }) : action = action ?? AqutterAjaxRequestAction.PROCEED;

  ///Gets a possible [AqutterAjaxRequest] instance from a [Map] value.
  static AqutterAjaxRequest? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterAjaxRequest(
      data: map['data'],
      event: AqutterAjaxRequestEvent.fromMap(
        map['event']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      headers: AqutterAjaxRequestHeaders.fromMap(
        map['headers']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      isAsync: map['isAsync'],
      method: map['method'],
      password: map['password'],
      readyState: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterAjaxRequestReadyState.fromNativeValue(map['readyState']),
        AqutterEnumMethod.value => AqutterAjaxRequestReadyState.fromValue(
          map['readyState'],
        ),
        AqutterEnumMethod.name => AqutterAjaxRequestReadyState.byName(
          map['readyState'],
        ),
      },
      response: map['response'],
      responseHeaders: map['responseHeaders']?.cast<String, dynamic>(),
      responseText: map['responseText'],
      responseType: map['responseType'],
      responseURL: map['responseURL'] != null
          ? AqutterWebUri(map['responseURL'])
          : null,
      responseXML: map['responseXML'],
      status: map['status'],
      statusText: map['statusText'],
      url: map['url'] != null ? AqutterWebUri(map['url']) : null,
      user: map['user'],
      withCredentials: map['withCredentials'],
    );
    instance.action = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue => AqutterAjaxRequestAction.fromNativeValue(
        map['action'],
      ),
      AqutterEnumMethod.value => AqutterAjaxRequestAction.fromValue(
        map['action'],
      ),
      AqutterEnumMethod.name => AqutterAjaxRequestAction.byName(map['action']),
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
      "data": data,
      "event": event?.toMap(enumMethod: enumMethod),
      "headers": headers?.toMap(enumMethod: enumMethod),
      "isAsync": isAsync,
      "method": method,
      "password": password,
      "readyState": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => readyState?.toNativeValue(),
        AqutterEnumMethod.value => readyState?.toValue(),
        AqutterEnumMethod.name => readyState?.name(),
      },
      "response": response,
      "responseHeaders": responseHeaders,
      "responseText": responseText,
      "responseType": responseType,
      "responseURL": responseURL?.toString(),
      "responseXML": responseXML,
      "status": status,
      "statusText": statusText,
      "url": url?.toString(),
      "user": user,
      "withCredentials": withCredentials,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterAjaxRequest{action: $action, data: $data, event: $event, headers: $headers, isAsync: $isAsync, method: $method, password: $password, readyState: $readyState, response: $response, responseHeaders: $responseHeaders, responseText: $responseText, responseType: $responseType, responseURL: $responseURL, responseXML: $responseXML, status: $status, statusText: $statusText, url: $url, user: $user, withCredentials: $withCredentials}';
  }
}
