import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformProcessGlobalConfig}
///
///{@macro aqutter_core.AqutterPlatformProcessGlobalConfig.supported_platforms}
class AqutterProcessGlobalConfig {
  ///{@macro aqutter_core.AqutterPlatformProcessGlobalConfig}
  AqutterProcessGlobalConfig()
    : this.fromPlatformCreationParams(
        const AqutterPlatformProcessGlobalConfigCreationParams(),
      );

  /// Constructs a [AqutterProcessGlobalConfig] from creation params for a specific
  /// platform.
  AqutterProcessGlobalConfig.fromPlatformCreationParams(
    AqutterPlatformProcessGlobalConfigCreationParams params,
  ) : this.fromPlatform(AqutterPlatformProcessGlobalConfig(params));

  /// Constructs a [AqutterProcessGlobalConfig] from a specific platform
  /// implementation.
  AqutterProcessGlobalConfig.fromPlatform(this.platform);

  /// Implementation of [AqutterPlatformProcessGlobalConfig] for the current platform.
  final AqutterPlatformProcessGlobalConfig platform;

  static AqutterProcessGlobalConfig? _instance;

  ///Gets the [AqutterProcessGlobalConfig] shared instance.
  static AqutterProcessGlobalConfig instance() {
    if (_instance == null) {
      _instance = AqutterProcessGlobalConfig();
    }
    return _instance!;
  }

  ///{@macro aqutter_core.AqutterPlatformProcessGlobalConfig.apply}
  ///
  ///{@macro aqutter_core.AqutterPlatformProcessGlobalConfig.apply.supported_platforms}
  Future<void> apply({required AqutterProcessGlobalConfigSettings settings}) =>
      platform.apply(settings: settings);

  ///{@macro aqutter_core.AqutterPlatformProcessGlobalConfigCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformProcessGlobalConfig.static().isClassSupported(platform: platform);

  ///{@macro aqutter_core.AqutterPlatformProcessGlobalConfig.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformProcessGlobalConfigMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformProcessGlobalConfig.static().isMethodSupported(
    method,
    platform: platform,
  );
}
