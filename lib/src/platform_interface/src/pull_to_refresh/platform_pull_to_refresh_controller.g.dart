// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_pull_to_refresh_controller.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformPullToRefreshControllerCreationParamsClassSupported
    on AqutterPlatformPullToRefreshControllerCreationParams {
  ///{@template aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformPullToRefreshControllerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformPullToRefreshControllerCreationParams]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformPullToRefreshControllerCreationParamsProperty {
  ///Can be used to check if the [AqutterPlatformPullToRefreshControllerCreationParams.onRefresh] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.onRefresh.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformPullToRefreshControllerCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onRefresh,

  ///Can be used to check if the [AqutterPlatformPullToRefreshControllerCreationParams.options] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.options.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformPullToRefreshControllerCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use settings instead')
  options,

  ///Can be used to check if the [AqutterPlatformPullToRefreshControllerCreationParams.settings] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.settings.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformPullToRefreshControllerCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  settings,
}

extension _AqutterPlatformPullToRefreshControllerCreationParamsPropertySupported
    on AqutterPlatformPullToRefreshControllerCreationParams {
  static bool isPropertySupported(
    AqutterPlatformPullToRefreshControllerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformPullToRefreshControllerCreationParamsProperty
          .onRefresh:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerCreationParamsProperty.options:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerCreationParamsProperty
          .settings:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

extension _AqutterPlatformPullToRefreshControllerClassSupported
    on AqutterPlatformPullToRefreshController {
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - **NOTE**: to be able to use the "pull-to-refresh" feature, [AqutterWebViewSettings.useHybridComposition] must be `true`.
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformPullToRefreshController]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformPullToRefreshControllerMethod {
  ///Can be used to check if the [AqutterPlatformPullToRefreshController.beginRefreshing] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.beginRefreshing.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - SwipeRefreshLayout.setRefreshing](https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setRefreshing(boolean)))
  ///- iOS WKWebView ([Official API - UIRefreshControl.beginRefreshing](https://developer.apple.com/documentation/uikit/uirefreshcontrol/1624842-beginrefreshing))
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  beginRefreshing,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.dispose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.dispose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [isKeepAlive]: all platforms
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dispose,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.endRefreshing] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.endRefreshing.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - SwipeRefreshLayout.setRefreshing](https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setRefreshing(boolean)))
  ///- iOS WKWebView ([Official API - UIRefreshControl.endRefreshing](https://developer.apple.com/documentation/uikit/uirefreshcontrol/1624846-endrefreshing))
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  endRefreshing,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.getDefaultSlingshotDistance] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.getDefaultSlingshotDistance.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - SwipeRefreshLayout.DEFAULT_SLINGSHOT_DISTANCE](https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#DEFAULT_SLINGSHOT_DISTANCE()))
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getDefaultSlingshotDistance,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.isEnabled] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.isEnabled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - View.isEnabled](https://developer.android.com/reference/android/view/View#isEnabled()))
  ///- iOS WKWebView ([Official API - UIScrollView.refreshControl](https://developer.apple.com/documentation/uikit/uiscrollview/2127691-refreshcontrol))
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isEnabled,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.isRefreshing] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.isRefreshing.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - SwipeRefreshLayout.isRefreshing](https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#isRefreshing()))
  ///- iOS WKWebView ([Official API - UIRefreshControl.isRefreshing](https://developer.apple.com/documentation/uikit/uirefreshcontrol/1624844-isrefreshing))
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isRefreshing,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.setAttributedTitle] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setAttributedTitle.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - UIRefreshControl.attributedTitle](https://developer.apple.com/documentation/uikit/uirefreshcontrol/1624845-attributedtitle))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [attributedTitle]: all platforms
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use setStyledTitle instead')
  setAttributedTitle,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.setBackgroundColor] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setBackgroundColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - SwipeRefreshLayout.setProgressBackgroundColorSchemeColor](https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setProgressBackgroundColorSchemeColor(int)))
  ///- iOS WKWebView ([Official API - UIView.backgroundColor](https://developer.apple.com/documentation/uikit/uiview/1622591-backgroundcolor))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [color]: all platforms
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setBackgroundColor,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.setColor] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - SwipeRefreshLayout.setColorSchemeColors](https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setColorSchemeColors(int...)))
  ///- iOS WKWebView ([Official API - UIRefreshControl.tintColor](https://developer.apple.com/documentation/uikit/uirefreshcontrol/1624847-tintcolor))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [color]: all platforms
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setColor,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.setDistanceToTriggerSync] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setDistanceToTriggerSync.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - SwipeRefreshLayout.setDistanceToTriggerSync](https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setDistanceToTriggerSync(int)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [distanceToTriggerSync]: all platforms
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setDistanceToTriggerSync,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.setEnabled] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setEnabled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - SwipeRefreshLayout.setEnabled](https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setEnabled(boolean)))
  ///- iOS WKWebView ([Official API - UIScrollView.refreshControl](https://developer.apple.com/documentation/uikit/uiscrollview/2127691-refreshcontrol))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [enabled]: all platforms
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setEnabled,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.setIndicatorSize] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setIndicatorSize.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - SwipeRefreshLayout.setSize](https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setSize(int)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [size]: all platforms
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setIndicatorSize,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.setSize] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setSize.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - SwipeRefreshLayout.setSize](https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setSize(int)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [size]: all platforms
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  @Deprecated('Use setIndicatorSize instead')
  setSize,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.setSlingshotDistance] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setSlingshotDistance.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - SwipeRefreshLayout.setSlingshotDistance](https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setSlingshotDistance(int)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [slingshotDistance]: all platforms
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setSlingshotDistance,

  ///Can be used to check if the [AqutterPlatformPullToRefreshController.setStyledTitle] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setStyledTitle.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - UIRefreshControl.attributedTitle](https://developer.apple.com/documentation/uikit/uirefreshcontrol/1624845-attributedtitle))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [attributedTitle]: all platforms
  ///
  ///Use the [AqutterPlatformPullToRefreshController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setStyledTitle,
}

extension _AqutterPlatformPullToRefreshControllerMethodSupported
    on AqutterPlatformPullToRefreshController {
  static bool isMethodSupported(
    AqutterPlatformPullToRefreshControllerMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformPullToRefreshControllerMethod.beginRefreshing:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod.dispose:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod.endRefreshing:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod
          .getDefaultSlingshotDistance:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod.isEnabled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod.isRefreshing:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod.setAttributedTitle:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod.setBackgroundColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod.setColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod
          .setDistanceToTriggerSync:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod.setEnabled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod.setIndicatorSize:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod.setSize:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod.setSlingshotDistance:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformPullToRefreshControllerMethod.setStyledTitle:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
    }
  }
}
