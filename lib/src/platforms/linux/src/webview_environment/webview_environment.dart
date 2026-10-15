import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [LinuxWebViewEnvironment].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
@immutable
class LinuxWebViewEnvironmentCreationParams
    extends AqutterPlatformWebViewEnvironmentCreationParams {
  /// Creates a new [LinuxWebViewEnvironmentCreationParams] instance.
  const LinuxWebViewEnvironmentCreationParams({super.settings});

  /// Creates a [LinuxWebViewEnvironmentCreationParams] instance based on [AqutterPlatformWebViewEnvironmentCreationParams].
  factory LinuxWebViewEnvironmentCreationParams.fromPlatformWebViewEnvironmentCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebViewEnvironmentCreationParams params,
  ) {
    return LinuxWebViewEnvironmentCreationParams(settings: params.settings);
  }
}

/// Linux implementation of [AqutterPlatformWebViewEnvironment].
///
/// This class provides access to WPE WebKit version information and
/// WebKitWebContext management on Linux.
///
///**Officially Supported Platforms/Implementations**:
///- Linux
class LinuxWebViewEnvironment extends AqutterPlatformWebViewEnvironment
    with ChannelController {
  /// Static method channel for AqutterWebViewEnvironment operations.
  static final MethodChannel _staticChannel = MethodChannel(
    'com.github.aqutter/webview_environment',
  );

  @override
  final String id = IdGenerator.generate();

  /// Creates a new [LinuxWebViewEnvironment].
  LinuxWebViewEnvironment(AqutterPlatformWebViewEnvironmentCreationParams params)
    : super.implementation(
        params is LinuxWebViewEnvironmentCreationParams
            ? params
            : LinuxWebViewEnvironmentCreationParams.fromPlatformWebViewEnvironmentCreationParams(
                params,
              ),
      );

  /// Static instance for accessing static methods.
  static final LinuxWebViewEnvironment _staticValue = LinuxWebViewEnvironment(
    LinuxWebViewEnvironmentCreationParams(),
  );

  /// Factory constructor for accessing static methods.
  factory LinuxWebViewEnvironment.static() {
    return _staticValue;
  }

  _debugLog(String method, dynamic args) {
    debugLog(
      className: runtimeType.toString(),
      id: id,
      debugLoggingSettings: AqutterPlatformWebViewEnvironment.debugLoggingSettings,
      method: method,
      args: args,
    );
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    if (AqutterPlatformWebViewEnvironment.debugLoggingSettings.enabled) {
      _debugLog(call.method, call.arguments);
    }

    switch (call.method) {
      default:
        throw UnimplementedError("Unimplemented ${call.method} method");
    }
  }

  /// {@macro aqutter_core.AqutterPlatformWebViewEnvironment.create}
  ///
  /// On Linux, this creates a new WebKitWebContext instance.
  @override
  Future<LinuxWebViewEnvironment> create({
    AqutterWebViewEnvironmentSettings? settings,
  }) async {
    final env = LinuxWebViewEnvironment(
      LinuxWebViewEnvironmentCreationParams(settings: settings),
    );

    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('id', () => env.id);
    if (settings != null) {
      args.putIfAbsent('settings', () => settings.toMap());
    }
    await _staticChannel.invokeMethod('create', args);

    env.channel = MethodChannel(
      'com.github.aqutter/webview_environment_${env.id}',
    );
    env.handler = env.handleMethod;
    env.initMethodCallHandler();
    return env;
  }

  /// {@macro aqutter_core.AqutterPlatformWebViewEnvironment.getAvailableVersion}
  ///
  /// On Linux, this returns the WPE WebKit version (e.g., "2.42.0").
  ///
  /// The [browserExecutableFolder] parameter is ignored on Linux as WPE WebKit
  /// is a system library.
  @override
  Future<String?> getAvailableVersion({String? browserExecutableFolder}) async {
    return await _staticChannel.invokeMethod<String>('getAvailableVersion');
  }

  /// {@macro aqutter_core.AqutterPlatformWebViewEnvironment.isSpellCheckingEnabled}
  @override
  Future<bool> isSpellCheckingEnabled() async {
    return await channel?.invokeMethod<bool>('isSpellCheckingEnabled') ?? false;
  }

  /// {@macro aqutter_core.AqutterPlatformWebViewEnvironment.getSpellCheckingLanguages}
  @override
  Future<List<String>> getSpellCheckingLanguages() async {
    final result = await channel?.invokeMethod<List>(
      'getSpellCheckingLanguages',
    );
    return result?.cast<String>() ?? [];
  }

  /// {@macro aqutter_core.AqutterPlatformWebViewEnvironment.getCacheModel}
  @override
  Future<AqutterCacheModel?> getCacheModel() async {
    final result = await channel?.invokeMethod<int>('getCacheModel');
    return AqutterCacheModel.fromNativeValue(result);
  }

  /// {@macro aqutter_core.AqutterPlatformWebViewEnvironment.isAutomationAllowed}
  @override
  Future<bool> isAutomationAllowed() async {
    return await channel?.invokeMethod<bool>('isAutomationAllowed') ?? false;
  }

  @override
  Future<void> dispose() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('dispose', args);
    disposeChannel();
  }
}

extension InternalLinuxWebViewEnvironment on LinuxWebViewEnvironment {
  get handleMethod => _handleMethod;
}
