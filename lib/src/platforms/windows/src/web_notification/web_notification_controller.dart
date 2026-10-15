import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [WindowsWebNotificationController].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebNotificationControllerCreationParams] for
/// more information.
@immutable
class WindowsWebNotificationControllerCreationParams
    extends AqutterPlatformWebNotificationControllerCreationParams {
  /// Creates a new [WindowsWebNotificationControllerCreationParams] instance.
  const WindowsWebNotificationControllerCreationParams({
    required super.id,
    required super.notification,
  });

  /// Creates a [WindowsWebNotificationControllerCreationParams] instance based on [AqutterPlatformWebNotificationControllerCreationParams].
  factory WindowsWebNotificationControllerCreationParams.fromPlatformWebNotificationControllerCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebNotificationControllerCreationParams params,
  ) {
    return WindowsWebNotificationControllerCreationParams(
      id: params.id,
      notification: params.notification,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformWebNotificationController}
class WindowsWebNotificationController extends AqutterPlatformWebNotificationController
    with ChannelController {
  /// Constructs a [WindowsWebNotificationController].
  WindowsWebNotificationController(
    AqutterPlatformWebNotificationControllerCreationParams params,
  ) : super.implementation(
        params is WindowsWebNotificationControllerCreationParams
            ? params
            : WindowsWebNotificationControllerCreationParams.fromPlatformWebNotificationControllerCreationParams(
                params,
              ),
      ) {
    channel = MethodChannel(
      'com.github.aqutter/webview_webnotificationcontroller_${params.id}',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }

  static final WindowsWebNotificationController _staticValue =
      WindowsWebNotificationController(
        WindowsWebNotificationControllerCreationParams(
          id: '',
          notification: AqutterWebNotification(),
        ),
      );

  /// Provide static access.
  factory WindowsWebNotificationController.static() {
    return _staticValue;
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "onClose":
        if (onClose != null) {
          onClose!();
        }
        break;
      default:
        throw UnimplementedError("Unimplemented ${call.method} method");
    }
  }

  @override
  Future<void> reportShown() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('reportShown', args);
  }

  @override
  Future<void> reportClicked() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('reportClicked', args);
  }

  @override
  Future<void> reportClosed() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('reportClosed', args);
  }

  @override
  Future<void> dispose() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('dispose', args);
    disposeChannel();
  }
}
