import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformProxyController}
///
///{@macro aqutter_core.AqutterPlatformProxyController.supported_platforms}
class AqutterProxyController {
  ///{@macro aqutter_core.AqutterPlatformProxyController}
  AqutterProxyController()
    : this.fromPlatformCreationParams(
        const AqutterPlatformProxyControllerCreationParams(),
      );

  /// Constructs a [AqutterProxyController] from creation params for a specific
  /// platform.
  AqutterProxyController.fromPlatformCreationParams(
    AqutterPlatformProxyControllerCreationParams params,
  ) : this.fromPlatform(AqutterPlatformProxyController(params));

  /// Constructs a [AqutterProxyController] from a specific platform
  /// implementation.
  AqutterProxyController.fromPlatform(this.platform);

  /// Implementation of [AqutterPlatformProxyController] for the current platform.
  final AqutterPlatformProxyController platform;

  static AqutterProxyController? _instance;

  ///Gets the [AqutterProxyController] shared instance.
  static AqutterProxyController instance() {
    if (_instance == null) {
      _instance = AqutterProxyController();
    }
    return _instance!;
  }

  ///{@macro aqutter_core.AqutterPlatformProxyController.setProxyOverride}
  ///
  ///{@macro aqutter_core.AqutterPlatformProxyController.setProxyOverride.supported_platforms}
  Future<void> setProxyOverride({required AqutterProxySettings settings}) =>
      platform.setProxyOverride(settings: settings);

  ///{@macro aqutter_core.AqutterPlatformProxyController.clearProxyOverride}
  ///
  ///{@macro aqutter_core.AqutterPlatformProxyController.clearProxyOverride.supported_platforms}
  Future<void> clearProxyOverride() => platform.clearProxyOverride();

  ///{@macro aqutter_core.AqutterPlatformProxyControllerCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformProxyController.static().isClassSupported(platform: platform);

  ///{@macro aqutter_core.AqutterPlatformProxyController.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformProxyControllerMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformProxyController.static().isMethodSupported(
    method,
    platform: platform,
  );
}
