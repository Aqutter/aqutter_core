import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformPullToRefreshController}
///
///{@macro aqutter_core.AqutterPlatformPullToRefreshController.supported_platforms}
class AqutterPullToRefreshController {
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.supported_platforms}
  AqutterPullToRefreshController({
    void Function()? onRefresh,
    @Deprecated("Use settings instead") AqutterPullToRefreshOptions? options,
    AqutterPullToRefreshSettings? settings,
  }) : this.fromPlatformCreationParams(
         params: AqutterPlatformPullToRefreshControllerCreationParams(
           onRefresh: onRefresh,
           options: options,
           settings: settings,
         ),
       );

  /// Constructs a [AqutterPullToRefreshController].
  ///
  /// See [AqutterPullToRefreshController.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterPullToRefreshController.fromPlatformCreationParams({
    required AqutterPlatformPullToRefreshControllerCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformPullToRefreshController(params));

  /// Constructs a [AqutterPullToRefreshController] from a specific platform implementation.
  AqutterPullToRefreshController.fromPlatform({required this.platform});

  /// Implementation of [AqutterPlatformPullToRefreshController] for the current platform.
  final AqutterPlatformPullToRefreshController platform;

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.options}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.options.supported_platforms}
  @Deprecated("Use settings instead")
  AqutterPullToRefreshOptions get options => platform.options;

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.settings}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.settings.supported_platforms}
  AqutterPullToRefreshSettings get settings => platform.settings;

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.onRefresh}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.onRefresh.supported_platforms}
  void Function()? get onRefresh => platform.onRefresh;

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setEnabled}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setEnabled.supported_platforms}
  Future<void> setEnabled(bool enabled) => platform.setEnabled(enabled);

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.isEnabled}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.isEnabled.supported_platforms}
  Future<bool> isEnabled() => platform.isEnabled();

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.beginRefreshing}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.beginRefreshing.supported_platforms}
  Future<void> beginRefreshing() => platform.beginRefreshing();

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.endRefreshing}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.endRefreshing.supported_platforms}
  Future<void> endRefreshing() => platform.endRefreshing();

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.isRefreshing}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.isRefreshing.supported_platforms}
  Future<bool> isRefreshing() => platform.isRefreshing();

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setColor}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setColor.supported_platforms}
  Future<void> setColor(Color color) => platform.setColor(color);

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setBackgroundColor}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setBackgroundColor.supported_platforms}
  Future<void> setBackgroundColor(Color color) =>
      platform.setBackgroundColor(color);

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setDistanceToTriggerSync}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setDistanceToTriggerSync.supported_platforms}
  Future<void> setDistanceToTriggerSync(int distanceToTriggerSync) =>
      platform.setDistanceToTriggerSync(distanceToTriggerSync);

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setSlingshotDistance}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setSlingshotDistance.supported_platforms}
  Future<void> setSlingshotDistance(int slingshotDistance) =>
      platform.setSlingshotDistance(slingshotDistance);

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.getDefaultSlingshotDistance}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.getDefaultSlingshotDistance.supported_platforms}
  Future<int> getDefaultSlingshotDistance() =>
      platform.getDefaultSlingshotDistance();

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setSize}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setSize.supported_platforms}
  @Deprecated("Use setIndicatorSize instead")
  Future<void> setSize(AqutterAndroidPullToRefreshSize size) => platform.setSize(size);

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setIndicatorSize}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setIndicatorSize.supported_platforms}
  Future<void> setIndicatorSize(AqutterPullToRefreshSize size) =>
      platform.setIndicatorSize(size);

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setAttributedTitle}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setAttributedTitle.supported_platforms}
  @Deprecated("Use setStyledTitle instead")
  Future<void> setAttributedTitle(AqutterIOSNSAttributedString attributedTitle) =>
      platform.setAttributedTitle(attributedTitle);

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setStyledTitle}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.setStyledTitle.supported_platforms}
  Future<void> setStyledTitle(AqutterAttributedString attributedTitle) =>
      platform.setStyledTitle(attributedTitle);

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.dispose}
  ///
  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.dispose.supported_platforms}
  void dispose({bool isKeepAlive = false}) =>
      platform.dispose(isKeepAlive: isKeepAlive);

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformPullToRefreshController.static().isClassSupported(
        platform: platform,
      );

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.isPropertySupported}
  static bool isPropertySupported(
    AqutterPlatformPullToRefreshControllerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => AqutterPlatformPullToRefreshController.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformPullToRefreshController.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformPullToRefreshControllerMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformPullToRefreshController.static().isMethodSupported(
    method,
    platform: platform,
  );
}
