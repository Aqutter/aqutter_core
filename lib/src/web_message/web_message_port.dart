import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformWebMessagePort}
///
///{@macro aqutter_core.AqutterPlatformWebMessagePort.supported_platforms}
class AqutterWebMessagePort implements AqutterIWebMessagePort {
  ///{@macro aqutter_core.AqutterPlatformWebMessagePort}
  AqutterWebMessagePort({required int index})
    : this.fromPlatformCreationParams(
        params: AqutterPlatformWebMessagePortCreationParams(index: index),
      );

  /// Constructs a [AqutterWebMessagePort].
  ///
  /// See [AqutterWebMessagePort.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterWebMessagePort.fromPlatformCreationParams({
    required AqutterPlatformWebMessagePortCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformWebMessagePort(params));

  /// Constructs a [AqutterWebMessagePort] from a specific platform implementation.
  AqutterWebMessagePort.fromPlatform({required this.platform});

  /// Implementation of [AqutterPlatformWebMessagePort] for the current platform.
  final AqutterPlatformWebMessagePort platform;

  ///{@macro aqutter_core.AqutterPlatformWebMessagePort.setWebMessageCallback}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessagePort.setWebMessageCallback.supported_platforms}
  Future<void> setWebMessageCallback(AqutterWebMessageCallback? onMessage) =>
      platform.setWebMessageCallback(onMessage);

  ///{@macro aqutter_core.AqutterPlatformWebMessagePort.postMessage}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessagePort.postMessage.supported_platforms}
  Future<void> postMessage(AqutterWebMessage message) => platform.postMessage(message);

  ///{@macro aqutter_core.AqutterPlatformWebMessagePort.close}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessagePort.close.supported_platforms}
  Future<void> close() => platform.close();

  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) =>
      platform.toMap(enumMethod: enumMethod);

  Map<String, dynamic> toJson() => platform.toJson();

  @override
  String toString() => platform.toString();
}
