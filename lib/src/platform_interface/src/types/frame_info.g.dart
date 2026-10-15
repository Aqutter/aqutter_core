// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame_info.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///An object that contains information about a frame on a webpage.
class AqutterFrameInfo {
  ///The unique identifier of the frame associated with the current [AqutterFrameInfo].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  int? frameId;

  ///A Boolean value indicating whether the frame is the web site's main frame or a subframe.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  bool isMainFrame;

  ///The kind of the frame.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  AqutterFrameKind? kind;

  ///Gets the name attribute of the frame, as in <iframe name="frame-name">...</iframe>.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  String? name;

  ///The frame’s current request.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  AqutterURLRequest? request;

  ///The frame’s security origin.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  AqutterSecurityOrigin? securityOrigin;
  AqutterFrameInfo({
    this.frameId,
    required this.isMainFrame,
    this.kind,
    this.name,
    this.request,
    this.securityOrigin,
  });

  ///Gets a possible [AqutterFrameInfo] instance from a [Map] value.
  static AqutterFrameInfo? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterFrameInfo(
      frameId: map['frameId'],
      isMainFrame: map['isMainFrame'],
      kind: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterFrameKind.fromNativeValue(
          map['kind'],
        ),
        AqutterEnumMethod.value => AqutterFrameKind.fromValue(map['kind']),
        AqutterEnumMethod.name => AqutterFrameKind.byName(map['kind']),
      },
      name: map['name'],
      request: AqutterURLRequest.fromMap(
        map['request']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      securityOrigin: AqutterSecurityOrigin.fromMap(
        map['securityOrigin']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "frameId": frameId,
      "isMainFrame": isMainFrame,
      "kind": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => kind?.toNativeValue(),
        AqutterEnumMethod.value => kind?.toValue(),
        AqutterEnumMethod.name => kind?.name(),
      },
      "name": name,
      "request": request?.toMap(enumMethod: enumMethod),
      "securityOrigin": securityOrigin?.toMap(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterFrameInfo{frameId: $frameId, isMainFrame: $isMainFrame, kind: $kind, name: $name, request: $request, securityOrigin: $securityOrigin}';
  }
}

///An object that contains information about a frame on a webpage.
///
///**NOTE**: available only on iOS.
///
///Use [AqutterFrameInfo] instead.
@Deprecated('Use AqutterFrameInfo instead')
class AqutterIOSWKFrameInfo {
  ///A Boolean value indicating whether the frame is the web site's main frame or a subframe.
  bool isMainFrame;

  ///The frame’s current request.
  AqutterURLRequest? request;

  ///The frame’s security origin.
  AqutterIOSWKSecurityOrigin? securityOrigin;
  AqutterIOSWKFrameInfo({
    required this.isMainFrame,
    this.request,
    this.securityOrigin,
  });

  ///Gets a possible [AqutterIOSWKFrameInfo] instance from a [Map] value.
  static AqutterIOSWKFrameInfo? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterIOSWKFrameInfo(
      isMainFrame: map['isMainFrame'],
      request: AqutterURLRequest.fromMap(
        map['request']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      securityOrigin: AqutterIOSWKSecurityOrigin.fromMap(
        map['securityOrigin']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "isMainFrame": isMainFrame,
      "request": request?.toMap(enumMethod: enumMethod),
      "securityOrigin": securityOrigin?.toMap(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterIOSWKFrameInfo{isMainFrame: $isMainFrame, request: $request, securityOrigin: $securityOrigin}';
  }
}
