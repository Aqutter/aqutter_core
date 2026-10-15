import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [WindowsWebMessageListener].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebMessageListenerCreationParams] for
/// more information.
@immutable
class WindowsWebMessageListenerCreationParams
    extends AqutterPlatformWebMessageListenerCreationParams {
  /// Creates a new [WindowsWebMessageListenerCreationParams] instance.
  const WindowsWebMessageListenerCreationParams({
    required this.allowedOriginRules,
    required super.jsObjectName,
    super.onPostMessage,
  });

  /// Creates a [WindowsWebMessageListenerCreationParams] instance based on [AqutterPlatformWebMessageListenerCreationParams].
  factory WindowsWebMessageListenerCreationParams.fromPlatformWebMessageListenerCreationParams(
    AqutterPlatformWebMessageListenerCreationParams params,
  ) {
    return WindowsWebMessageListenerCreationParams(
      allowedOriginRules: params.allowedOriginRules ?? Set.from(["*"]),
      jsObjectName: params.jsObjectName,
      onPostMessage: params.onPostMessage,
    );
  }

  @override
  final Set<String> allowedOriginRules;

  @override
  String toString() {
    return 'WindowsWebMessageListenerCreationParams{jsObjectName: $jsObjectName, allowedOriginRules: $allowedOriginRules, onPostMessage: $onPostMessage}';
  }
}

///{@macro aqutter_core.AqutterPlatformWebMessageListener}
class WindowsWebMessageListener extends AqutterPlatformWebMessageListener
    with ChannelController {
  /// Constructs a [WindowsWebMessageListener].
  WindowsWebMessageListener(AqutterPlatformWebMessageListenerCreationParams params)
    : super.implementation(
        params is WindowsWebMessageListenerCreationParams
            ? params
            : WindowsWebMessageListenerCreationParams.fromPlatformWebMessageListenerCreationParams(
                params,
              ),
      ) {
    assert(
      !this._windowsParams.allowedOriginRules.contains(""),
      "allowedOriginRules cannot contain empty strings",
    );
    channel = MethodChannel(
      'com.github.aqutter/webview_web_message_listener_${_id}_${params.jsObjectName}',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }

  static final WindowsWebMessageListener _staticValue =
      WindowsWebMessageListener(
        WindowsWebMessageListenerCreationParams(
          jsObjectName: '',
          allowedOriginRules: Set.from(["*"]),
        ),
      );

  /// Provide static access.
  factory WindowsWebMessageListener.static() {
    return _staticValue;
  }

  ///Message Listener ID used internally.
  final String _id = IdGenerator.generate();

  WindowsJavaScriptReplyProxy? _replyProxy;

  WindowsWebMessageListenerCreationParams get _windowsParams =>
      params as WindowsWebMessageListenerCreationParams;

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "onPostMessage":
        if (_replyProxy == null) {
          _replyProxy = WindowsJavaScriptReplyProxy(
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
      "allowedOriginRules": _windowsParams.allowedOriginRules.toList(),
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return this.toMap();
  }

  @override
  String toString() {
    return 'WindowsWebMessageListener{id: ${_id}, jsObjectName: ${params.jsObjectName}, allowedOriginRules: ${params.allowedOriginRules}, replyProxy: $_replyProxy}';
  }
}

/// Object specifying creation parameters for creating a [WindowsJavaScriptReplyProxy].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformJavaScriptReplyProxyCreationParams] for
/// more information.
@immutable
class WindowsJavaScriptReplyProxyCreationParams
    extends AqutterPlatformJavaScriptReplyProxyCreationParams {
  /// Creates a new [WindowsJavaScriptReplyProxyCreationParams] instance.
  const WindowsJavaScriptReplyProxyCreationParams({
    required super.webMessageListener,
  });

  /// Creates a [WindowsJavaScriptReplyProxyCreationParams] instance based on [AqutterPlatformJavaScriptReplyProxyCreationParams].
  factory WindowsJavaScriptReplyProxyCreationParams.fromPlatformJavaScriptReplyProxyCreationParams(
    AqutterPlatformJavaScriptReplyProxyCreationParams params,
  ) {
    return WindowsJavaScriptReplyProxyCreationParams(
      webMessageListener: params.webMessageListener,
    );
  }
}

///{@macro aqutter_core.AqutterJavaScriptReplyProxy}
class WindowsJavaScriptReplyProxy extends AqutterPlatformJavaScriptReplyProxy {
  /// Constructs a [WindowsWebMessageListener].
  WindowsJavaScriptReplyProxy(AqutterPlatformJavaScriptReplyProxyCreationParams params)
    : super.implementation(
        params is WindowsJavaScriptReplyProxyCreationParams
            ? params
            : WindowsJavaScriptReplyProxyCreationParams.fromPlatformJavaScriptReplyProxyCreationParams(
                params,
              ),
      );

  WindowsWebMessageListener get _windowsWebMessageListener =>
      params.webMessageListener as WindowsWebMessageListener;

  @override
  Future<void> postMessage(AqutterWebMessage message) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('message', () => message.toMap());
    await _windowsWebMessageListener.channel?.invokeMethod('postMessage', args);
  }

  @override
  String toString() {
    return 'WindowsJavaScriptReplyProxy{}';
  }
}
