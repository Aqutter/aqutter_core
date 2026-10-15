import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [AndroidProxyController].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformProxyControllerCreationParams] for
/// more information.
@immutable
class AndroidProxyControllerCreationParams
    extends AqutterPlatformProxyControllerCreationParams {
  /// Creates a new [AndroidProxyControllerCreationParams] instance.
  const AndroidProxyControllerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformProxyControllerCreationParams params,
  ) : super();

  /// Creates a [AndroidProxyControllerCreationParams] instance based on [AqutterPlatformProxyControllerCreationParams].
  factory AndroidProxyControllerCreationParams.fromPlatformProxyControllerCreationParams(
    AqutterPlatformProxyControllerCreationParams params,
  ) {
    return AndroidProxyControllerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformProxyController}
class AndroidProxyController extends AqutterPlatformProxyController
    with ChannelController {
  /// Creates a new [AndroidProxyController].
  AndroidProxyController(AqutterPlatformProxyControllerCreationParams params)
    : super.implementation(
        params is AndroidProxyControllerCreationParams
            ? params
            : AndroidProxyControllerCreationParams.fromPlatformProxyControllerCreationParams(
                params,
              ),
      ) {
    channel = const MethodChannel(
      'com.github.aqutter/webview_proxycontroller',
    );
    handler = handleMethod;
    initMethodCallHandler();
  }

  static AndroidProxyController? _instance;

  ///Gets the [AndroidProxyController] shared instance.
  static AndroidProxyController instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static AndroidProxyController _init() {
    _instance = AndroidProxyController(
      AndroidProxyControllerCreationParams(
        const AqutterPlatformProxyControllerCreationParams(),
      ),
    );
    return _instance!;
  }

  static final AndroidProxyController _staticValue = AndroidProxyController(
    AndroidProxyControllerCreationParams(
      const AqutterPlatformProxyControllerCreationParams(),
    ),
  );

  /// Provide static access.
  factory AndroidProxyController.static() {
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

extension InternalProxyController on AndroidProxyController {
  get handleMethod => _handleMethod;
}
