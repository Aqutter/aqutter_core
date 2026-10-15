import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import 'web_message_channel.dart';

/// Object specifying creation parameters for creating a [IOSWebMessagePort].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebMessagePortCreationParams] for
/// more information.
@immutable
class IOSWebMessagePortCreationParams
    extends AqutterPlatformWebMessagePortCreationParams {
  /// Creates a new [IOSWebMessagePortCreationParams] instance.
  const IOSWebMessagePortCreationParams({required super.index});

  /// Creates a [IOSWebMessagePortCreationParams] instance based on [AqutterPlatformWebMessagePortCreationParams].
  factory IOSWebMessagePortCreationParams.fromPlatformWebMessagePortCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebMessagePortCreationParams params,
  ) {
    return IOSWebMessagePortCreationParams(index: params.index);
  }

  @override
  String toString() {
    return 'IOSWebMessagePortCreationParams{index: $index}';
  }
}

///{@macro aqutter_core.AqutterPlatformWebMessagePort}
class IOSWebMessagePort extends AqutterPlatformWebMessagePort {
  AqutterWebMessageCallback? _onMessage;
  late IOSWebMessageChannel _webMessageChannel;

  /// Constructs a [IOSWebMessagePort].
  IOSWebMessagePort(AqutterPlatformWebMessagePortCreationParams params)
    : super.implementation(
        params is IOSWebMessagePortCreationParams
            ? params
            : IOSWebMessagePortCreationParams.fromPlatformWebMessagePortCreationParams(
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
    this._onMessage = onMessage;
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
      "webMessageChannelId": this._webMessageChannel.params.id,
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'IOSWebMessagePort{index: ${params.index}}';
  }
}

extension InternalWebMessagePort on IOSWebMessagePort {
  AqutterWebMessageCallback? get onMessage => _onMessage;
  void set onMessage(AqutterWebMessageCallback? value) => _onMessage = value;

  IOSWebMessageChannel get webMessageChannel => _webMessageChannel;
  void set webMessageChannel(IOSWebMessageChannel value) =>
      _webMessageChannel = value;
}
