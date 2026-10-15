import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformTracingController}
///
///{@macro aqutter_core.AqutterPlatformTracingController.supported_platforms}
class AqutterTracingController {
  ///{@macro aqutter_core.AqutterPlatformTracingController}
  AqutterTracingController()
    : this.fromPlatformCreationParams(
        const AqutterPlatformTracingControllerCreationParams(),
      );

  /// Constructs a [AqutterTracingController] from creation params for a specific
  /// platform.
  AqutterTracingController.fromPlatformCreationParams(
    AqutterPlatformTracingControllerCreationParams params,
  ) : this.fromPlatform(AqutterPlatformTracingController(params));

  /// Constructs a [AqutterTracingController] from a specific platform
  /// implementation.
  AqutterTracingController.fromPlatform(this.platform);

  /// Implementation of [AqutterPlatformTracingController] for the current platform.
  final AqutterPlatformTracingController platform;

  static AqutterTracingController? _instance;

  ///Gets the [AqutterTracingController] shared instance.
  static AqutterTracingController instance() {
    if (_instance == null) {
      _instance = AqutterTracingController();
    }
    return _instance!;
  }

  ///{@macro aqutter_core.AqutterPlatformTracingController.start}
  ///
  ///{@macro aqutter_core.AqutterPlatformTracingController.start.supported_platforms}
  Future<void> start({required AqutterTracingSettings settings}) =>
      platform.start(settings: settings);

  ///{@macro aqutter_core.AqutterPlatformTracingController.stop}
  ///
  ///{@macro aqutter_core.AqutterPlatformTracingController.stop.supported_platforms}
  Future<bool> stop({String? filePath}) => platform.stop(filePath: filePath);

  ///{@macro aqutter_core.AqutterPlatformTracingController.isTracing}
  ///
  ///{@macro aqutter_core.AqutterPlatformTracingController.isTracing.supported_platforms}
  Future<bool> isTracing() => platform.isTracing();

  ///{@macro aqutter_core.AqutterPlatformTracingControllerCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformTracingController.static().isClassSupported(platform: platform);

  ///{@macro aqutter_core.AqutterPlatformTracingController.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformTracingControllerMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformTracingController.static().isMethodSupported(
    method,
    platform: platform,
  );
}
