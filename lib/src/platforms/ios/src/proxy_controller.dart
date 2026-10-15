import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [IOSProxyController].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformProxyControllerCreationParams] for
/// more information.
@immutable
class IOSProxyControllerCreationParams
    extends AqutterPlatformProxyControllerCreationParams {
  /// Creates a new [IOSProxyControllerCreationParams] instance.
  const IOSProxyControllerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformProxyControllerCreationParams params,
  ) : super();

  /// Creates a [IOSProxyControllerCreationParams] instance based on [AqutterPlatformProxyControllerCreationParams].
  factory IOSProxyControllerCreationParams.fromPlatformProxyControllerCreationParams(
    AqutterPlatformProxyControllerCreationParams params,
  ) {
    return IOSProxyControllerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformProxyController}
class IOSProxyController extends AqutterPlatformProxyController
    with ChannelController {
  /// Creates a new [IOSProxyController].
  IOSProxyController(AqutterPlatformProxyControllerCreationParams params)
    : super.implementation(
        params is IOSProxyControllerCreationParams
            ? params
            : IOSProxyControllerCreationParams.fromPlatformProxyControllerCreationParams(
                params,
              ),
      ) {
    channel = const MethodChannel(
      'com.github.aqutter/webview_proxycontroller',
    );
    handler = handleMethod;
    initMethodCallHandler();
  }

  static IOSProxyController? _instance;

  ///Gets the [IOSProxyController] shared instance.
  static IOSProxyController instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static IOSProxyController _init() {
    _instance = IOSProxyController(
      IOSProxyControllerCreationParams(
        const AqutterPlatformProxyControllerCreationParams(),
      ),
    );
    return _instance!;
  }

  static final IOSProxyController _staticValue = IOSProxyController(
    IOSProxyControllerCreationParams(
      const AqutterPlatformProxyControllerCreationParams(),
    ),
  );

  /// Provide static access.
  factory IOSProxyController.static() {
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

extension InternalProxyController on IOSProxyController {
  get handleMethod => _handleMethod;
}
