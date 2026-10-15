import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [IOSWebMessageListener].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebMessageListenerCreationParams] for
/// more information.
@immutable
class IOSWebMessageListenerCreationParams
    extends AqutterPlatformWebMessageListenerCreationParams {
  /// Creates a new [IOSWebMessageListenerCreationParams] instance.
  const IOSWebMessageListenerCreationParams({
    required this.allowedOriginRules,
    required super.jsObjectName,
    super.onPostMessage,
  });

  /// Creates a [IOSWebMessageListenerCreationParams] instance based on [AqutterPlatformWebMessageListenerCreationParams].
  factory IOSWebMessageListenerCreationParams.fromPlatformWebMessageListenerCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebMessageListenerCreationParams params,
  ) {
    return IOSWebMessageListenerCreationParams(
      allowedOriginRules: params.allowedOriginRules ?? Set.from(["*"]),
      jsObjectName: params.jsObjectName,
      onPostMessage: params.onPostMessage,
    );
  }

  @override
  final Set<String> allowedOriginRules;

  @override
  String toString() {
    return 'IOSWebMessageListenerCreationParams{jsObjectName: $jsObjectName, allowedOriginRules: $allowedOriginRules, onPostMessage: $onPostMessage}';
  }
}

///{@macro aqutter_core.AqutterPlatformWebMessageListener}
class IOSWebMessageListener extends AqutterPlatformWebMessageListener
    with ChannelController {
  /// Constructs a [IOSWebMessageListener].
  IOSWebMessageListener(AqutterPlatformWebMessageListenerCreationParams params)
    : super.implementation(
        params is IOSWebMessageListenerCreationParams
            ? params
            : IOSWebMessageListenerCreationParams.fromPlatformWebMessageListenerCreationParams(
                params,
              ),
      ) {
    assert(
      !this._iosParams.allowedOriginRules.contains(""),
      "allowedOriginRules cannot contain empty strings",
    );
    channel = MethodChannel(
      'com.github.aqutter/webview_web_message_listener_${_id}_${params.jsObjectName}',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }

  static final IOSWebMessageListener _staticValue = IOSWebMessageListener(
    IOSWebMessageListenerCreationParams(
      jsObjectName: '',
      allowedOriginRules: Set.from(["*"]),
    ),
  );

  /// Provide static access.
  factory IOSWebMessageListener.static() {
    return _staticValue;
  }

  ///Message Listener ID used internally.
  final String _id = IdGenerator.generate();

  IOSJavaScriptReplyProxy? _replyProxy;

  IOSWebMessageListenerCreationParams get _iosParams =>
      params as IOSWebMessageListenerCreationParams;

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "onPostMessage":
        if (_replyProxy == null) {
          _replyProxy = IOSJavaScriptReplyProxy(
            AqutterPlatformJavaScriptReplyProxyCreationParams(
              webMessageListener: this,
            ),
          );
        }
        if (onPostMessage != null) {
          AqutterWebMessage? message = call.arguments["message"] != null
              ? AqutterWebMessage.fromMap(
                  call.arguments["message"].cast<String, dynamic>(),
                )
              : null;
          AqutterWebUri? sourceOrigin = call.arguments["sourceOrigin"] != null
              ? AqutterWebUri(call.arguments["sourceOrigin"])
              : null;
          bool isMainFrame = call.arguments["isMainFrame"];
          onPostMessage!(message, sourceOrigin, isMainFrame, _replyProxy!);
        }
        break;
      default:
        throw UnimplementedError("Unimplemented ${call.method} method");
    }
    return null;
  }

  @override
  void dispose() {
    disposeChannel();
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": _id,
      "jsObjectName": params.jsObjectName,
      "allowedOriginRules": _iosParams.allowedOriginRules.toList(),
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return this.toMap();
  }

  @override
  String toString() {
    return 'IOSWebMessageListener{id: ${_id}, jsObjectName: ${params.jsObjectName}, allowedOriginRules: ${params.allowedOriginRules}, replyProxy: $_replyProxy}';
  }
}

/// Object specifying creation parameters for creating a [IOSJavaScriptReplyProxy].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformJavaScriptReplyProxyCreationParams] for
/// more information.
@immutable
class IOSJavaScriptReplyProxyCreationParams
    extends AqutterPlatformJavaScriptReplyProxyCreationParams {
  /// Creates a new [IOSJavaScriptReplyProxyCreationParams] instance.
  const IOSJavaScriptReplyProxyCreationParams({
    required super.webMessageListener,
  });

  /// Creates a [IOSJavaScriptReplyProxyCreationParams] instance based on [AqutterPlatformJavaScriptReplyProxyCreationParams].
  factory IOSJavaScriptReplyProxyCreationParams.fromPlatformJavaScriptReplyProxyCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformJavaScriptReplyProxyCreationParams params,
  ) {
    return IOSJavaScriptReplyProxyCreationParams(
      webMessageListener: params.webMessageListener,
    );
  }
}

///{@macro aqutter_core.AqutterJavaScriptReplyProxy}
class IOSJavaScriptReplyProxy extends AqutterPlatformJavaScriptReplyProxy {
  /// Constructs a [IOSWebMessageListener].
  IOSJavaScriptReplyProxy(AqutterPlatformJavaScriptReplyProxyCreationParams params)
    : super.implementation(
        params is IOSJavaScriptReplyProxyCreationParams
            ? params
            : IOSJavaScriptReplyProxyCreationParams.fromPlatformJavaScriptReplyProxyCreationParams(
                params,
              ),
      );

  IOSWebMessageListener get _iosWebMessageListener =>
      params.webMessageListener as IOSWebMessageListener;

  @override
  Future<void> postMessage(AqutterWebMessage message) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('message', () => message.toMap());
    await _iosWebMessageListener.channel?.invokeMethod('postMessage', args);
  }

  @override
  String toString() {
    return 'IOSJavaScriptReplyProxy{}';
  }
}
