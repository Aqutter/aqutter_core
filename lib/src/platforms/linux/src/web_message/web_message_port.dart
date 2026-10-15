import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import 'web_message_channel.dart';

/// Object specifying creation parameters for creating a [LinuxWebMessagePort].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebMessagePortCreationParams] for
/// more information.
@immutable
class LinuxWebMessagePortCreationParams
    extends AqutterPlatformWebMessagePortCreationParams {
  /// Creates a new [LinuxWebMessagePortCreationParams] instance.
  const LinuxWebMessagePortCreationParams({required super.index});

  /// Creates a [LinuxWebMessagePortCreationParams] instance based on [AqutterPlatformWebMessagePortCreationParams].
  factory LinuxWebMessagePortCreationParams.fromPlatformWebMessagePortCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebMessagePortCreationParams params,
  ) {
    return LinuxWebMessagePortCreationParams(index: params.index);
  }

  @override
  String toString() {
    return 'LinuxWebMessagePortCreationParams{index: $index}';
  }
}

///{@macro aqutter_core.AqutterPlatformWebMessagePort}
class LinuxWebMessagePort extends AqutterPlatformWebMessagePort {
  AqutterWebMessageCallback? _onMessage;
  late LinuxWebMessageChannel _webMessageChannel;

  /// Constructs a [LinuxWebMessagePort].
  LinuxWebMessagePort(AqutterPlatformWebMessagePortCreationParams params)
    : super.implementation(
        params is LinuxWebMessagePortCreationParams
            ? params
            : LinuxWebMessagePortCreationParams.fromPlatformWebMessagePortCreationParams(
                params,
              ),
      );

  @override
  Future<void> setWebMessageCallback(AqutterWebMessageCallback? onMessage) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('index', () => params.index);
    await _webMessageChannel.internalChannel?.invokeMethod(
      'setWebMessageCallback',
      args,
    );
    _onMessage = onMessage;
  }

  @override
  Future<void> postMessage(AqutterWebMessage message) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('index', () => params.index);
    args.putIfAbsent('message', () => message.toMap());
    await _webMessageChannel.internalChannel?.invokeMethod('postMessage', args);
  }

  @override
  Future<void> close() async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('index', () => params.index);
    await _webMessageChannel.internalChannel?.invokeMethod('close', args);
  }

  @override
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "index": params.index,
      "webMessageChannelId": _webMessageChannel.params.id,
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'LinuxWebMessagePort{index: ${params.index}}';
  }
}

extension InternalWebMessagePort on LinuxWebMessagePort {
  AqutterWebMessageCallback? get onMessage => _onMessage;
  set onMessage(AqutterWebMessageCallback? value) => _onMessage = value;

  LinuxWebMessageChannel get webMessageChannel => _webMessageChannel;
  set webMessageChannel(LinuxWebMessageChannel value) =>
      _webMessageChannel = value;
}
