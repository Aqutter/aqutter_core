import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [LinuxProxyController].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformProxyControllerCreationParams] for
/// more information.
@immutable
class LinuxProxyControllerCreationParams
    extends AqutterPlatformProxyControllerCreationParams {
  /// Creates a new [LinuxProxyControllerCreationParams] instance.
  const LinuxProxyControllerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformProxyControllerCreationParams params,
  ) : super();

  /// Creates a [LinuxProxyControllerCreationParams] instance based on [AqutterPlatformProxyControllerCreationParams].
  factory LinuxProxyControllerCreationParams.fromPlatformProxyControllerCreationParams(
    AqutterPlatformProxyControllerCreationParams params,
  ) {
    return LinuxProxyControllerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformProxyController}
///
/// Linux implementation of [AqutterPlatformProxyController] using WPE WebKit's
/// [WebKitNetworkProxySettings](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/struct.NetworkProxySettings.html).
class LinuxProxyController extends AqutterPlatformProxyController {
  static const MethodChannel _channel = MethodChannel(
    'com.github.aqutter/webview_proxycontroller',
  );

  /// Creates a new [LinuxProxyController].
  LinuxProxyController(AqutterPlatformProxyControllerCreationParams params)
    : super.implementation(
        params is LinuxProxyControllerCreationParams
            ? params
            : LinuxProxyControllerCreationParams.fromPlatformProxyControllerCreationParams(
                params,
              ),
      );

  static LinuxProxyController? _instance;

  /// Gets the [LinuxProxyController] shared instance.
  static LinuxProxyController instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static LinuxProxyController _init() {
    _instance = LinuxProxyController(
      LinuxProxyControllerCreationParams(
        const AqutterPlatformProxyControllerCreationParams(),
      ),
    );
    return _instance!;
  }

  static final LinuxProxyController _staticValue = LinuxProxyController(
    LinuxProxyControllerCreationParams(
      const AqutterPlatformProxyControllerCreationParams(),
    ),
  );

  /// Provide static access.
  factory LinuxProxyController.static() {
    return _staticValue;
  }

  @override
  Future<void> setProxyOverride({required AqutterProxySettings settings}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("settings", () => settings.toMap());
    await _channel.invokeMethod('setProxyOverride', args);
  }

  @override
  Future<void> clearProxyOverride() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await _channel.invokeMethod('clearProxyOverride', args);
  }
}
