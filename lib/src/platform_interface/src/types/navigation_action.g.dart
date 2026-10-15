// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_action.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///An object that contains information about an action that causes navigation to occur.
class AqutterNavigationAction {
  ///Use [hasGesture] instead.
  @Deprecated('Use hasGesture instead')
  bool? androidHasGesture;

  ///Use [isRedirect] instead.
  @Deprecated('Use isRedirect instead')
  bool? androidIsRedirect;

  ///Gets whether a gesture (such as a click) was associated with the request.
  ///For security reasons in certain situations this method may return `false` even though
  ///the sequence of events which caused the request to be created was initiated by a user
  ///gesture.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 21+ ([Official API - AqutterWebResourceRequest.hasGesture](https://developer.android.com/reference/android/webkit/AqutterWebResourceRequest#hasGesture())):
  ///    - On Android < 21, this is always `false`
  ///- Windows WebView2:
  ///    - Available only if the request is associated to the [AqutterPlatformWebViewCreationParams.onCreateWindow] event
  bool? hasGesture;

  ///Use [sourceFrame] instead.
  @Deprecated('Use sourceFrame instead')
  AqutterIOSWKFrameInfo? iosSourceFrame;

  ///Use [targetFrame] instead.
  @Deprecated('Use targetFrame instead')
  AqutterIOSWKFrameInfo? iosTargetFrame;

  ///Use [navigationType] instead.
  @Deprecated('Use navigationType instead')
  AqutterIOSWKNavigationType? iosWKNavigationType;

  ///Indicates whether the request was made for the main frame.
  ///
  ///**NOTE for Android and Windows**: If the request is associated to the [AqutterPlatformWebViewCreationParams.onCreateWindow] event, this is always `true`.
  ///Also, on Android < 21, this is always `true`.
  bool isForMainFrame;

  ///Gets whether the request was a result of a server-side redirect.
  ///
  ///**NOTE**: If the request is associated to the [AqutterPlatformWebViewCreationParams.onCreateWindow] event, this is always `false`.
  ///Also, on Android < 21, this is always `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 21+ ([Official API - AqutterWebResourceRequest.isRedirect](https://developer.android.com/reference/android/webkit/AqutterWebResourceRequest#isRedirect()))
  ///- Windows WebView2
  bool? isRedirect;

  ///The type of action triggering the navigation.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationAction.navigationType](https://developer.apple.com/documentation/webkit/wknavigationaction/1401914-navigationtype))
  ///- macOS WKWebView ([Official API - WKNavigationAction.navigationType](https://developer.apple.com/documentation/webkit/wknavigationaction/1401914-navigationtype))
  ///- Windows WebView2
  AqutterNavigationType? navigationType;

  ///The URL request object associated with the navigation action.
  ///
  ///**NOTE for Android**: If the request is associated to the [AqutterPlatformWebViewCreationParams.onCreateWindow] event
  ///and the window has been created using JavaScript, [request.url] will be `null`,
  ///the [request.method] is always `GET`, and [request.headers] value is always `null`.
  ///Also, on Android < 21, the [request.method]  is always `GET` and [request.headers] value is always `null`.
  AqutterURLRequest request;

  ///A value indicating whether the web content used a download attribute to indicate that this should be downloaded.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 14.5+ ([Official API - WKNavigationAction.shouldPerformDownload](https://developer.apple.com/documentation/webkit/wknavigationaction/3727357-shouldperformdownload))
  ///- macOS WKWebView 11.3+ ([Official API - WKNavigationAction.shouldPerformDownload](https://developer.apple.com/documentation/webkit/wknavigationaction/3727357-shouldperformdownload))
  bool? shouldPerformDownload;

  ///The frame that requested the navigation.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationAction.sourceFrame](https://developer.apple.com/documentation/webkit/wknavigationaction/1401926-sourceframe))
  ///- macOS WKWebView ([Official API - WKNavigationAction.sourceFrame](https://developer.apple.com/documentation/webkit/wknavigationaction/1401926-sourceframe))
  AqutterFrameInfo? sourceFrame;

  ///The frame in which to display the new content.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationAction.targetFrame](https://developer.apple.com/documentation/webkit/wknavigationaction/1401918-targetframe))
  ///- macOS WKWebView ([Official API - WKNavigationAction.targetFrame](https://developer.apple.com/documentation/webkit/wknavigationaction/1401918-targetframe))
  AqutterFrameInfo? targetFrame;
  AqutterNavigationAction({
    @Deprecated('Use hasGesture instead') this.androidHasGesture,
    @Deprecated('Use isRedirect instead') this.androidIsRedirect,
    this.hasGesture,
    @Deprecated('Use sourceFrame instead') this.iosSourceFrame,
    @Deprecated('Use targetFrame instead') this.iosTargetFrame,
    @Deprecated('Use navigationType instead') this.iosWKNavigationType,
    required this.isForMainFrame,
    this.isRedirect,
    this.navigationType,
    required this.request,
    this.shouldPerformDownload,
    this.sourceFrame,
    this.targetFrame,
  }) {
    hasGesture = hasGesture ?? androidHasGesture;
    isRedirect = isRedirect ?? androidIsRedirect;
    sourceFrame =
        sourceFrame ?? AqutterFrameInfo.fromMap(iosSourceFrame?.toMap());
    targetFrame =
        targetFrame ?? AqutterFrameInfo.fromMap(iosTargetFrame?.toMap());
    navigationType =
        navigationType ??
        AqutterNavigationType.fromNativeValue(
          iosWKNavigationType?.toNativeValue(),
        );
  }

  ///Gets a possible [AqutterNavigationAction] instance from a [Map] value.
  static AqutterNavigationAction? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterNavigationAction(
      androidHasGesture: map['hasGesture'],
      androidIsRedirect: map['isRedirect'],
      hasGesture: map['hasGesture'],
      iosSourceFrame: AqutterIOSWKFrameInfo.fromMap(
        map['sourceFrame']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      iosTargetFrame: AqutterIOSWKFrameInfo.fromMap(
        map['targetFrame']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      iosWKNavigationType: switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterIOSWKNavigationType.fromNativeValue(map['navigationType']),
        AqutterEnumMethod.value => AqutterIOSWKNavigationType.fromValue(
          map['navigationType'],
        ),
        AqutterEnumMethod.name => AqutterIOSWKNavigationType.byName(
          map['navigationType'],
        ),
      },
      isForMainFrame: map['isForMainFrame'],
      isRedirect: map['isRedirect'],
      navigationType: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterNavigationType.fromNativeValue(
          map['navigationType'],
        ),
        AqutterEnumMethod.value => AqutterNavigationType.fromValue(
          map['navigationType'],
        ),
        AqutterEnumMethod.name => AqutterNavigationType.byName(
          map['navigationType'],
        ),
      },
      request: AqutterURLRequest.fromMap(
        map['request']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      )!,
      shouldPerformDownload: map['shouldPerformDownload'],
      sourceFrame: AqutterFrameInfo.fromMap(
        map['sourceFrame']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      targetFrame: AqutterFrameInfo.fromMap(
        map['targetFrame']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "hasGesture": hasGesture,
      "isForMainFrame": isForMainFrame,
      "isRedirect": isRedirect,
      "navigationType": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => navigationType?.toNativeValue(),
        AqutterEnumMethod.value => navigationType?.toValue(),
        AqutterEnumMethod.name => navigationType?.name(),
      },
      "request": request.toMap(enumMethod: enumMethod),
      "shouldPerformDownload": shouldPerformDownload,
      "sourceFrame": sourceFrame?.toMap(enumMethod: enumMethod),
      "targetFrame": targetFrame?.toMap(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterNavigationAction{hasGesture: $hasGesture, isForMainFrame: $isForMainFrame, isRedirect: $isRedirect, navigationType: $navigationType, request: $request, shouldPerformDownload: $shouldPerformDownload, sourceFrame: $sourceFrame, targetFrame: $targetFrame}';
  }
}
