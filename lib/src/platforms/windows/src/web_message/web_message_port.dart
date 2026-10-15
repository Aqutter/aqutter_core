import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import 'web_message_channel.dart';

/// Object specifying creation parameters for creating a [WindowsWebMessagePort].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebMessagePortCreationParams] for
/// more information.
@immutable
class WindowsWebMessagePortCreationParams
    extends AqutterPlatformWebMessagePortCreationParams {
  /// Creates a new [WindowsWebMessagePortCreationParams] instance.
  const WindowsWebMessagePortCreationParams({required super.index});

  /// Creates a [WindowsWebMessagePortCreationParams] instance based on [AqutterPlatformWebMessagePortCreationParams].
  factory WindowsWebMessagePortCreationParams.fromPlatformWebMessagePortCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebMessagePortCreationParams params,
  ) {
    return WindowsWebMessagePortCreationParams(index: params.index);
  }

  @override
  String toString() {
    return 'WindowsWebMessagePortCreationParams{index: $index}';
  }
}

///{@macro aqutter_core.AqutterPlatformWebMessagePort}
class WindowsWebMessagePort extends AqutterPlatformWebMessagePort {
  AqutterWebMessageCallback? _onMessage;
  late WindowsWebMessageChannel _webMessageChannel;

  /// Constructs a [WindowsWebMessagePort].
  WindowsWebMessagePort(AqutterPlatformWebMessagePortCreationParams params)
    : super.implementation(
        params is WindowsWebMessagePortCreationParams
            ? params
            : WindowsWebMessagePortCreationParams.fromPlatformWebMessagePortCreationParams(
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
    return 'WindowsWebMessagePort{index: ${params.index}}';
  }
}

extension InternalWebMessagePort on WindowsWebMessagePort {
  AqutterWebMessageCallback? get onMessage => _onMessage;
  set onMessage(AqutterWebMessageCallback? value) => _onMessage = value;

  WindowsWebMessageChannel get webMessageChannel => _webMessageChannel;
  set webMessageChannel(WindowsWebMessageChannel value) =>
      _webMessageChannel = value;
}
