import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [MacOSProxyController].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformProxyControllerCreationParams] for
/// more information.
@immutable
class MacOSProxyControllerCreationParams
    extends AqutterPlatformProxyControllerCreationParams {
  /// Creates a new [MacOSProxyControllerCreationParams] instance.
  const MacOSProxyControllerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformProxyControllerCreationParams params,
  ) : super();

  /// Creates a [MacOSProxyControllerCreationParams] instance based on [AqutterPlatformProxyControllerCreationParams].
  factory MacOSProxyControllerCreationParams.fromPlatformProxyControllerCreationParams(
    AqutterPlatformProxyControllerCreationParams params,
  ) {
    return MacOSProxyControllerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformProxyController}
class MacOSProxyController extends AqutterPlatformProxyController
    with ChannelController {
  /// Creates a new [MacOSProxyController].
  MacOSProxyController(AqutterPlatformProxyControllerCreationParams params)
    : super.implementation(
        params is MacOSProxyControllerCreationParams
            ? params
            : MacOSProxyControllerCreationParams.fromPlatformProxyControllerCreationParams(
                params,
              ),
      ) {
    channel = const MethodChannel(
      'com.github.aqutter/webview_proxycontroller',
    );
    handler = handleMethod;
    initMethodCallHandler();
  }

  static MacOSProxyController? _instance;

  ///Gets the [MacOSProxyController] shared instance.
  static MacOSProxyController instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static MacOSProxyController _init() {
    _instance = MacOSProxyController(
      MacOSProxyControllerCreationParams(
        const AqutterPlatformProxyControllerCreationParams(),
      ),
    );
    return _instance!;
  }

  static final MacOSProxyController _staticValue = MacOSProxyController(
    MacOSProxyControllerCreationParams(
      const AqutterPlatformProxyControllerCreationParams(),
    ),
  );

  /// Provide static access.
  factory MacOSProxyController.static() {
    return _staticValue;
  }

  Future<dynamic> _handleMethod(MethodCall call) async {}

  @override
  Future<void> setProxyOverride({required AqutterProxySettings settings}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("settings", () => settings.toMap());
    await channel?.invokeMethod('setProxyOverride', args);
  }

  @override
  Future<void> clearProxyOverride() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('clearProxyOverride', args);
  }

  @override
  void dispose() {
    // empty
  }
}

extension InternalProxyController on MacOSProxyController {
  get handleMethod => _handleMethod;
}
