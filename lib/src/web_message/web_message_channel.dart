import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';
import 'web_message_port.dart';

///{@macro aqutter_core.AqutterPlatformWebMessageChannel}
///
///{@macro aqutter_core.AqutterPlatformWebMessageChannel.supported_platforms}
class AqutterWebMessageChannel {
  ///{@macro aqutter_core.AqutterPlatformWebMessageChannel}
  AqutterWebMessageChannel({
    required String id,
    required AqutterWebMessagePort port1,
    required AqutterWebMessagePort port2,
  }) : this.fromPlatformCreationParams(
         params: AqutterPlatformWebMessageChannelCreationParams(
           id: id,
           port1: port1.platform,
           port2: port2.platform,
         ),
       );

  /// Constructs a [AqutterWebMessageChannel].
  ///
  /// See [AqutterWebMessageChannel.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterWebMessageChannel.fromPlatformCreationParams({
    required AqutterPlatformWebMessageChannelCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformWebMessageChannel(params));

  /// Constructs a [AqutterWebMessageChannel] from a specific platform implementation.
  AqutterWebMessageChannel.fromPlatform({required this.platform});

  /// Implementation of [AqutterPlatformWebMessageChannel] for the current platform.
  final AqutterPlatformWebMessageChannel platform;

  /// Provide static access.
  static AqutterWebMessageChannel static() {
    return AqutterWebMessageChannel.fromPlatform(
      platform: AqutterPlatformWebMessageChannel.static(),
    );
  }

  ///{@macro aqutter_core.AqutterPlatformWebMessageChannelCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformWebMessageChannel.static().isClassSupported(platform: platform);

  ///{@macro aqutter_core.AqutterPlatformWebMessageChannel.isPropertySupported}
  static bool isPropertySupported(
    AqutterPlatformWebMessageChannelCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebMessageChannel.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformWebMessageChannel.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformWebMessageChannelMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebMessageChannel.static().isMethodSupported(
    method,
    platform: platform,
  );

  static AqutterWebMessageChannel? fromMap(Map<String, dynamic>? map) {
    AqutterPlatformWebMessageChannel? platform = AqutterPlatformWebMessageChannel.static()
        .fromMap(map);
    if (platform == null) {
      return null;
    }
    return AqutterWebMessageChannel.fromPlatform(platform: platform);
  }

  ///{@macro aqutter_core.AqutterPlatformWebMessageChannel.id}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageChannel.id.supported_platforms}
  String get id => platform.id;

  ///{@macro aqutter_core.AqutterPlatformWebMessageChannel.port1}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageChannel.port1.supported_platforms}
  AqutterWebMessagePort get port1 =>
      AqutterWebMessagePort.fromPlatform(platform: platform.port1);

  ///{@macro aqutter_core.AqutterPlatformWebMessageChannel.port2}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageChannel.port2.supported_platforms}
  AqutterWebMessagePort get port2 =>
      AqutterWebMessagePort.fromPlatform(platform: platform.port2);

  ///{@macro aqutter_core.AqutterPlatformWebMessageChannel.dispose}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageChannel.dispose.supported_platforms}
  void dispose() => platform.dispose();

  @override
  String toString() => platform.toString();
}
