// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the navigation response used by the [AqutterPlatformWebViewCreationParams.onNavigationResponse] event.
class AqutterNavigationResponse {
  ///A Boolean value that indicates whether WebKit is capable of displaying the response’s MIME type natively.
  bool canShowMIMEType;

  ///A Boolean value that indicates whether the response targets the web view’s main frame.
  bool isForMainFrame;

  ///The URL for the response.
  AqutterURLResponse? response;
  AqutterNavigationResponse({
    required this.canShowMIMEType,
    required this.isForMainFrame,
    this.response,
  });

  ///Gets a possible [AqutterNavigationResponse] instance from a [Map] value.
  static AqutterNavigationResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterNavigationResponse(
      canShowMIMEType: map['canShowMIMEType'],
      isForMainFrame: map['isForMainFrame'],
      response: AqutterURLResponse.fromMap(
        map['response']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "canShowMIMEType": canShowMIMEType,
      "isForMainFrame": isForMainFrame,
      "response": response?.toMap(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterNavigationResponse{canShowMIMEType: $canShowMIMEType, isForMainFrame: $isForMainFrame, response: $response}';
  }
}

///An iOS-specific Class that represents the navigation response used by the [AqutterPlatformWebViewCreationParams.onNavigationResponse] event.
///Use [AqutterNavigationResponse] instead.
@Deprecated('Use AqutterNavigationResponse instead')
class AqutterIOSWKNavigationResponse {
  ///A Boolean value that indicates whether WebKit is capable of displaying the response’s MIME type natively.
  bool canShowMIMEType;

  ///A Boolean value that indicates whether the response targets the web view’s main frame.
  bool isForMainFrame;

  ///The URL for the response.
  AqutterIOSURLResponse? response;
  AqutterIOSWKNavigationResponse({
    required this.canShowMIMEType,
    required this.isForMainFrame,
    this.response,
  });

  ///Gets a possible [AqutterIOSWKNavigationResponse] instance from a [Map] value.
  static AqutterIOSWKNavigationResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterIOSWKNavigationResponse(
      canShowMIMEType: map['canShowMIMEType'],
      isForMainFrame: map['isForMainFrame'],
      response: AqutterIOSURLResponse.fromMap(
        map['response']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "canShowMIMEType": canShowMIMEType,
      "isForMainFrame": isForMainFrame,
      "response": response?.toMap(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterIOSWKNavigationResponse{canShowMIMEType: $canShowMIMEType, isForMainFrame: $isForMainFrame, response: $response}';
  }
}
