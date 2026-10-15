// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_window_action.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the navigation request used by the [AqutterPlatformWebViewCreationParams.onCreateWindow] event.
class AqutterCreateWindowAction extends AqutterNavigationAction {
  ///Use [isDialog] instead.
  @Deprecated('Use isDialog instead')
  bool? androidIsDialog;

  ///Use [windowFeatures] instead.
  @Deprecated('Use windowFeatures instead')
  AqutterIOSWKWindowFeatures? iosWindowFeatures;

  ///Indicates if the new window should be a dialog, rather than a full-size window.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  bool? isDialog;

  ///Window features requested by the webpage.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKWindowFeatures](https://developer.apple.com/documentation/webkit/wkwindowfeatures))
  ///- macOS WKWebView ([Official API - WKWindowFeatures](https://developer.apple.com/documentation/webkit/wkwindowfeatures))
  ///- Windows WebView2 ([Official API - ICoreWebView2WindowFeatures](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2windowfeatures?view=webview2-1.0.2210.55))
  AqutterWindowFeatures? windowFeatures;

  ///The window id. Used by `WebView` to create a new WebView.
  int windowId;
  AqutterCreateWindowAction({
    @Deprecated('Use isDialog instead') this.androidIsDialog,
    @Deprecated('Use windowFeatures instead') this.iosWindowFeatures,
    this.isDialog,
    this.windowFeatures,
    required this.windowId,
    required AqutterURLRequest request,
    required bool isForMainFrame,
    @Deprecated('Use hasGesture instead') bool? androidHasGesture,
    bool? hasGesture,
    @Deprecated('Use isRedirect instead') bool? androidIsRedirect,
    bool? isRedirect,
    @Deprecated('Use navigationType instead')
    AqutterIOSWKNavigationType? iosWKNavigationType,
    AqutterNavigationType? navigationType,
    @Deprecated('Use sourceFrame instead')
    AqutterIOSWKFrameInfo? iosSourceFrame,
    AqutterFrameInfo? sourceFrame,
    @Deprecated('Use targetFrame instead')
    AqutterIOSWKFrameInfo? iosTargetFrame,
    AqutterFrameInfo? targetFrame,
    bool? shouldPerformDownload,
  }) : super(
         request: request,
         isForMainFrame: isForMainFrame,
         androidHasGesture: androidHasGesture,
         hasGesture: hasGesture,
         androidIsRedirect: androidIsRedirect,
         isRedirect: isRedirect,
         iosWKNavigationType: iosWKNavigationType,
         navigationType: navigationType,
         iosSourceFrame: iosSourceFrame,
         sourceFrame: sourceFrame,
         iosTargetFrame: iosTargetFrame,
         targetFrame: targetFrame,
         shouldPerformDownload: shouldPerformDownload,
       ) {
    isDialog = isDialog ?? androidIsDialog;
    windowFeatures =
        windowFeatures ??
        AqutterWindowFeatures.fromMap(iosWindowFeatures?.toMap());
  }

  ///Gets a possible [AqutterCreateWindowAction] instance from a [Map] value.
  static AqutterCreateWindowAction? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterCreateWindowAction(
      request: AqutterURLRequest.fromMap(
        map['request']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      )!,
      isForMainFrame: map['isForMainFrame'],
      androidIsDialog: map['isDialog'],
      iosWindowFeatures: AqutterIOSWKWindowFeatures.fromMap(
        map['windowFeatures']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      isDialog: map['isDialog'],
      windowFeatures: AqutterWindowFeatures.fromMap(
        map['windowFeatures']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      windowId: map['windowId'],
    );
    instance.androidHasGesture = map['hasGesture'];
    instance.hasGesture = map['hasGesture'];
    instance.androidIsRedirect = map['isRedirect'];
    instance.isRedirect = map['isRedirect'];
    instance.iosWKNavigationType = switch (enumMethod ??
        AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterIOSWKNavigationType.fromNativeValue(map['navigationType']),
      AqutterEnumMethod.value => AqutterIOSWKNavigationType.fromValue(
        map['navigationType'],
      ),
      AqutterEnumMethod.name => AqutterIOSWKNavigationType.byName(
        map['navigationType'],
      ),
    };
    instance.navigationType = switch (enumMethod ??
        AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue => AqutterNavigationType.fromNativeValue(
        map['navigationType'],
      ),
      AqutterEnumMethod.value => AqutterNavigationType.fromValue(
        map['navigationType'],
      ),
      AqutterEnumMethod.name => AqutterNavigationType.byName(
        map['navigationType'],
      ),
    };
    instance.iosSourceFrame = AqutterIOSWKFrameInfo.fromMap(
      map['sourceFrame']?.cast<String, dynamic>(),
      enumMethod: enumMethod,
    );
    instance.sourceFrame = AqutterFrameInfo.fromMap(
      map['sourceFrame']?.cast<String, dynamic>(),
      enumMethod: enumMethod,
    );
    instance.iosTargetFrame = AqutterIOSWKFrameInfo.fromMap(
      map['targetFrame']?.cast<String, dynamic>(),
      enumMethod: enumMethod,
    );
    instance.targetFrame = AqutterFrameInfo.fromMap(
      map['targetFrame']?.cast<String, dynamic>(),
      enumMethod: enumMethod,
    );
    instance.shouldPerformDownload = map['shouldPerformDownload'];
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "request": request.toMap(enumMethod: enumMethod),
      "isForMainFrame": isForMainFrame,
      "hasGesture": hasGesture,
      "isRedirect": isRedirect,
      "navigationType": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => navigationType?.toNativeValue(),
        AqutterEnumMethod.value => navigationType?.toValue(),
        AqutterEnumMethod.name => navigationType?.name(),
      },
      "sourceFrame": sourceFrame?.toMap(enumMethod: enumMethod),
      "targetFrame": targetFrame?.toMap(enumMethod: enumMethod),
      "shouldPerformDownload": shouldPerformDownload,
      "isDialog": isDialog,
      "windowFeatures": windowFeatures?.toMap(enumMethod: enumMethod),
      "windowId": windowId,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterCreateWindowAction{request: $request, isForMainFrame: $isForMainFrame, hasGesture: $hasGesture, isRedirect: $isRedirect, navigationType: $navigationType, sourceFrame: $sourceFrame, targetFrame: $targetFrame, shouldPerformDownload: $shouldPerformDownload, isDialog: $isDialog, windowFeatures: $windowFeatures, windowId: $windowId}';
  }
}
