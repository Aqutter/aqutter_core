import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [AndroidProcessGlobalConfig].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformProcessGlobalConfigCreationParams] for
/// more information.
@immutable
class AndroidProcessGlobalConfigCreationParams
    extends AqutterPlatformProcessGlobalConfigCreationParams {
  /// Creates a new [AndroidProcessGlobalConfigCreationParams] instance.
  const AndroidProcessGlobalConfigCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformProcessGlobalConfigCreationParams params,
  ) : super();

  /// Creates a [AndroidProcessGlobalConfigCreationParams] instance based on [AqutterPlatformProcessGlobalConfigCreationParams].
  factory AndroidProcessGlobalConfigCreationParams.fromPlatformProcessGlobalConfigCreationParams(
    AqutterPlatformProcessGlobalConfigCreationParams params,
  ) {
    return AndroidProcessGlobalConfigCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformProcessGlobalConfig}
class AndroidProcessGlobalConfig extends AqutterPlatformProcessGlobalConfig
    with ChannelController {
  /// Creates a new [AndroidProcessGlobalConfig].
  AndroidProcessGlobalConfig(AqutterPlatformProcessGlobalConfigCreationParams params)
    : super.implementation(
        params is AndroidProcessGlobalConfigCreationParams
            ? params
            : AndroidProcessGlobalConfigCreationParams.fromPlatformProcessGlobalConfigCreationParams(
                params,
              ),
      ) {
    channel = const MethodChannel(
      'com.github.aqutter/webview_processglobalconfig',
    );
    handler = handleMethod;
    initMethodCallHandler();
  }

  static AndroidProcessGlobalConfig? _instance;

  ///Gets the [AndroidProcessGlobalConfig] shared instance.
  static AndroidProcessGlobalConfig instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static AndroidProcessGlobalConfig _init() {
    _instance = AndroidProcessGlobalConfig(
      AndroidProcessGlobalConfigCreationParams(
        const AqutterPlatformProcessGlobalConfigCreationParams(),
      ),
    );
    return _instance!;
  }

  static final AndroidProcessGlobalConfig _staticValue =
      AndroidProcessGlobalConfig(
        AndroidProcessGlobalConfigCreationParams(
          const AqutterPlatformProcessGlobalConfigCreationParams(),
        ),
      );

  /// Provide static access.
  factory AndroidProcessGlobalConfig.static() {
    return _staticValue;
  }

  Future<dynamic> _handleMethod(MethodCall call) async {}

  @override
  Future<void> apply({required AqutterProcessGlobalConfigSettings settings}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("settings", () => settings.toMap());
    await channel?.invokeMethod('apply', args);
  }

  @override
  void dispose() {
    // empty
  }
}

extension InternalProcessGlobalConfig on AndroidProcessGlobalConfig {
  get handleMethod => _handleMethod;
}
