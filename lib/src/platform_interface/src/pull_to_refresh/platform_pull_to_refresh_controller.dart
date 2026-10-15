import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../debug_logging_settings.dart';
import '../browser/platform_browser.dart';
import '../webview/webview_settings.dart';
import '../webview/platform_webview.dart';
import '../webview_platform.dart';
import '../types/main.dart';
import 'pull_to_refresh_settings.dart';

// ignore: uri_has_not_been_generated
part 'platform_pull_to_refresh_controller.g.dart';

///{@template aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformPullToRefreshController].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
class AqutterPlatformPullToRefreshControllerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformPullToRefreshController].
  AqutterPlatformPullToRefreshControllerCreationParams({
    @Deprecated("Use settings instead") AqutterPullToRefreshOptions? options,
    AqutterPullToRefreshSettings? settings,
    this.onRefresh,
  }) : this.options = options ?? AqutterPullToRefreshOptions(),
       this.settings = settings ?? AqutterPullToRefreshSettings();

  ///{@template aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.options}
  /// Use [settings] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.options.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  @Deprecated("Use settings instead")
  late AqutterPullToRefreshOptions options;

  ///{@template aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.settings}
  /// Initial settings.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.settings.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  late AqutterPullToRefreshSettings settings;

  ///{@template aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.onRefresh}
  ///Event called when a swipe gesture triggers a refresh.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.onRefresh.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  final void Function()? onRefresh;

  ///{@template aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformPullToRefreshControllerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformPullToRefreshControllerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) =>
      _AqutterPlatformPullToRefreshControllerCreationParamsPropertySupported.isPropertySupported(
        property,
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformPullToRefreshController}
///A standard controller that can initiate the refreshing of a scroll view’s contents.
///This should be used whenever the user can refresh the contents of a WebView via a vertical swipe gesture.
///
///All the methods should be called only when the WebView has been created or is already running
///(for example [AqutterPlatformWebViewCreationParams.onWebViewCreated] or [AqutterPlatformBrowserEvents.onBrowserCreated]).
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformPullToRefreshController.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(
      note:
          '**NOTE**: to be able to use the "pull-to-refresh" feature, [AqutterWebViewSettings.useHybridComposition] must be `true`.',
    ),
    IOSPlatform(),
  ],
)
abstract class AqutterPlatformPullToRefreshController extends PlatformInterface
    implements AqutterDisposable {
  ///Debug settings.
  static AqutterDebugLoggingSettings debugLoggingSettings = AqutterDebugLoggingSettings();

  /// Creates a new [AqutterPlatformPullToRefreshController]
  factory AqutterPlatformPullToRefreshController(
    AqutterPlatformPullToRefreshControllerCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformPullToRefreshController webViewControllerDelegate =
        AqutterWebViewPlatform.instance!.createPlatformPullToRefreshController(
          params,
        );
    PlatformInterface.verify(webViewControllerDelegate, _token);
    return webViewControllerDelegate;
  }

  /// Creates a new empty [AqutterPlatformPullToRefreshController] to access static methods.
  factory AqutterPlatformPullToRefreshController.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `aqutter` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformPullToRefreshController controllerStatic =
        AqutterWebViewPlatform.instance!
            .createPlatformPullToRefreshControllerStatic();
    PlatformInterface.verify(controllerStatic, _token);
    return controllerStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformPullToRefreshController].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformPullToRefreshController.implementation(this.params)
    : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformPullToRefreshController].
  final AqutterPlatformPullToRefreshControllerCreationParams params;

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.options}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.options.supported_platforms}
  @Deprecated("Use settings instead")
  AqutterPullToRefreshOptions get options => params.options;

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.settings}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.settings.supported_platforms}
  AqutterPullToRefreshSettings get settings => params.settings;

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.onRefresh}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.onRefresh.supported_platforms}
  void Function()? get onRefresh => params.onRefresh;

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setEnabled}
  ///Sets whether the pull-to-refresh feature is enabled or not.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setEnabled.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'SwipeRefreshLayout.setEnabled',
        apiUrl:
            'https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setEnabled(boolean)',
      ),
      IOSPlatform(
        apiName: 'UIScrollView.refreshControl',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiscrollview/2127691-refreshcontrol',
      ),
    ],
  )
  Future<void> setEnabled(bool enabled) {
    throw UnimplementedError(
      'setEnabled is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.isEnabled}
  ///Returns `true` is pull-to-refresh feature is enabled, otherwise `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.isEnabled.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'View.isEnabled',
        apiUrl:
            'https://developer.android.com/reference/android/view/View#isEnabled()',
      ),
      IOSPlatform(
        apiName: 'UIScrollView.refreshControl',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiscrollview/2127691-refreshcontrol',
      ),
    ],
  )
  Future<bool> isEnabled() {
    throw UnimplementedError(
      'isEnabled is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.beginRefreshing}
  ///Tells the controller that a refresh operation was started programmatically.
  ///
  ///Call this method when an external event source triggers a programmatic refresh of your scrolling view.
  ///This method updates the state of the refresh control to reflect the in-progress refresh operation.
  ///When the refresh operation ends, be sure to call the [endRefreshing] method to return the controller to its default state.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.beginRefreshing.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'SwipeRefreshLayout.setRefreshing',
        apiUrl:
            'https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setRefreshing(boolean)',
      ),
      IOSPlatform(
        apiName: 'UIRefreshControl.beginRefreshing',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uirefreshcontrol/1624842-beginrefreshing',
      ),
    ],
  )
  Future<void> beginRefreshing() {
    throw UnimplementedError(
      'beginRefreshing is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.endRefreshing}
  ///Tells the controller that a refresh operation has ended.
  ///
  ///Call this method at the end of any refresh operation (whether it was initiated programmatically or by the user)
  ///to return the refresh control to its default state.
  ///If the refresh control is at least partially visible, calling this method also hides it.
  ///If animations are also enabled, the control is hidden using an animation.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.endRefreshing.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'SwipeRefreshLayout.setRefreshing',
        apiUrl:
            'https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setRefreshing(boolean)',
      ),
      IOSPlatform(
        apiName: 'UIRefreshControl.endRefreshing',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uirefreshcontrol/1624846-endrefreshing',
      ),
    ],
  )
  Future<void> endRefreshing() {
    throw UnimplementedError(
      'endRefreshing is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.isRefreshing}
  ///Returns whether a refresh operation has been triggered and is in progress.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.isRefreshing.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'SwipeRefreshLayout.isRefreshing',
        apiUrl:
            'https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#isRefreshing()',
      ),
      IOSPlatform(
        apiName: 'UIRefreshControl.isRefreshing',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uirefreshcontrol/1624844-isrefreshing',
      ),
    ],
  )
  Future<bool> isRefreshing() {
    throw UnimplementedError(
      'isRefreshing is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setColor}
  ///Sets the color of the refresh control.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setColor.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'SwipeRefreshLayout.setColorSchemeColors',
        apiUrl:
            'https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setColorSchemeColors(int...)',
      ),
      IOSPlatform(
        apiName: 'UIRefreshControl.tintColor',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uirefreshcontrol/1624847-tintcolor',
      ),
    ],
  )
  Future<void> setColor(Color color) {
    throw UnimplementedError(
      'setColor is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setBackgroundColor}
  ///Sets the background color of the refresh control.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setBackgroundColor.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'SwipeRefreshLayout.setProgressBackgroundColorSchemeColor',
        apiUrl:
            'https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setProgressBackgroundColorSchemeColor(int)',
      ),
      IOSPlatform(
        apiName: 'UIView.backgroundColor',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiview/1622591-backgroundcolor',
      ),
    ],
  )
  Future<void> setBackgroundColor(Color color) {
    throw UnimplementedError(
      'setBackgroundColor is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setDistanceToTriggerSync}
  ///Set the distance to trigger a sync in dips.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setDistanceToTriggerSync.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'SwipeRefreshLayout.setDistanceToTriggerSync',
        apiUrl:
            'https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setDistanceToTriggerSync(int)',
      ),
    ],
  )
  Future<void> setDistanceToTriggerSync(int distanceToTriggerSync) {
    throw UnimplementedError(
      'setDistanceToTriggerSync is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setSlingshotDistance}
  ///Sets the distance that the refresh indicator can be pulled beyond its resting position during a swipe gesture.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setSlingshotDistance.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'SwipeRefreshLayout.setSlingshotDistance',
        apiUrl:
            'https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setSlingshotDistance(int)',
      ),
    ],
  )
  Future<void> setSlingshotDistance(int slingshotDistance) {
    throw UnimplementedError(
      'setSlingshotDistance is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.getDefaultSlingshotDistance}
  ///Gets the default distance that the refresh indicator can be pulled beyond its resting position during a swipe gesture.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.getDefaultSlingshotDistance.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'SwipeRefreshLayout.DEFAULT_SLINGSHOT_DISTANCE',
        apiUrl:
            'https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#DEFAULT_SLINGSHOT_DISTANCE()',
      ),
    ],
  )
  Future<int> getDefaultSlingshotDistance() {
    throw UnimplementedError(
      'getDefaultSlingshotDistance is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setSize}
  ///Use [setIndicatorSize] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setSize.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'SwipeRefreshLayout.setSize',
        apiUrl:
            'https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setSize(int)',
      ),
    ],
  )
  @Deprecated("Use setIndicatorSize instead")
  Future<void> setSize(AqutterAndroidPullToRefreshSize size) {
    throw UnimplementedError(
      'setSize is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setIndicatorSize}
  ///Sets the size of the refresh indicator. One of [AqutterPullToRefreshSize.DEFAULT], or [AqutterPullToRefreshSize.LARGE].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setIndicatorSize.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'SwipeRefreshLayout.setSize',
        apiUrl:
            'https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout#setSize(int)',
      ),
    ],
  )
  Future<void> setIndicatorSize(AqutterPullToRefreshSize size) {
    throw UnimplementedError(
      'setIndicatorSize is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setAttributedTitle}
  ///Use [setStyledTitle] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setAttributedTitle.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'UIRefreshControl.attributedTitle',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uirefreshcontrol/1624845-attributedtitle',
      ),
    ],
  )
  @Deprecated("Use setStyledTitle instead")
  Future<void> setAttributedTitle(AqutterIOSNSAttributedString attributedTitle) {
    throw UnimplementedError(
      'setAttributedTitle is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.setStyledTitle}
  ///Sets the styled title text to display in the refresh control.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setStyledTitle.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'UIRefreshControl.attributedTitle',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uirefreshcontrol/1624845-attributedtitle',
      ),
    ],
  )
  Future<void> setStyledTitle(AqutterAttributedString attributedTitle) {
    throw UnimplementedError(
      'setStyledTitle is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.dispose}
  ///Disposes the controller.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.dispose.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  @override
  void dispose({bool isKeepAlive = false}) {
    throw UnimplementedError(
      'dispose is not implemented on the current platform',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshControllerCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformPullToRefreshControllerClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformPullToRefreshControllerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => params.isPropertySupported(property, platform: platform);

  ///{@template aqutter_core.AqutterPlatformPullToRefreshController.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformPullToRefreshControllerMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformPullToRefreshControllerMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}
