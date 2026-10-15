import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [AndroidWebMessageListener].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebMessageListenerCreationParams] for
/// more information.
@immutable
class AndroidWebMessageListenerCreationParams
    extends AqutterPlatformWebMessageListenerCreationParams {
  /// Creates a new [AndroidWebMessageListenerCreationParams] instance.
  const AndroidWebMessageListenerCreationParams({
    required this.allowedOriginRules,
    required super.jsObjectName,
    super.onPostMessage,
  });

  /// Creates a [AndroidWebMessageListenerCreationParams] instance based on [AqutterPlatformWebMessageListenerCreationParams].
  factory AndroidWebMessageListenerCreationParams.fromPlatformWebMessageListenerCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebMessageListenerCreationParams params,
  ) {
    return AndroidWebMessageListenerCreationParams(
      allowedOriginRules: params.allowedOriginRules ?? Set.from(["*"]),
      jsObjectName: params.jsObjectName,
      onPostMessage: params.onPostMessage,
    );
  }

  @override
  final Set<String> allowedOriginRules;

  @override
  String toString() {
    return 'AndroidWebMessageListenerCreationParams{jsObjectName: $jsObjectName, allowedOriginRules: $allowedOriginRules, onPostMessage: $onPostMessage}';
  }
}

///{@macro aqutter_core.AqutterPlatformWebMessageListener}
class AndroidWebMessageListener extends AqutterPlatformWebMessageListener
    with ChannelController {
  /// Constructs a [AndroidWebMessageListener].
  AndroidWebMessageListener(AqutterPlatformWebMessageListenerCreationParams params)
    : super.implementation(
        params is AndroidWebMessageListenerCreationParams
            ? params
            : AndroidWebMessageListenerCreationParams.fromPlatformWebMessageListenerCreationParams(
                params,
              ),
      ) {
    assert(
      !this._androidParams.allowedOriginRules.contains(""),
      "allowedOriginRules cannot contain empty strings",
    );
    channel = MethodChannel(
      'com.github.aqutter/webview_web_message_listener_${_id}_${params.jsObjectName}',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }

  static final AndroidWebMessageListener _staticValue =
      AndroidWebMessageListener(
        AndroidWebMessageListenerCreationParams(
          jsObjectName: '',
          allowedOriginRules: Set.from(["*"]),
        ),
      );

  /// Provide static access.
  factory AndroidWebMessageListener.static() {
    return _staticValue;
  }

  ///Message Listener ID used internally.
  final String _id = IdGenerator.generate();

  AndroidJavaScriptReplyProxy? _replyProxy;

  AndroidWebMessageListenerCreationParams get _androidParams =>
      params as AndroidWebMessageListenerCreationParams;

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "onPostMessage":
        if (_replyProxy == null) {
          _replyProxy = AndroidJavaScriptReplyProxy(
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
      "allowedOriginRules": _androidParams.allowedOriginRules.toList(),
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return this.toMap();
  }

  @override
  String toString() {
    return 'AndroidWebMessageListener{id: ${_id}, jsObjectName: ${params.jsObjectName}, allowedOriginRules: ${params.allowedOriginRules}, replyProxy: $_replyProxy}';
  }
}

/// Object specifying creation parameters for creating a [AndroidJavaScriptReplyProxy].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformJavaScriptReplyProxyCreationParams] for
/// more information.
@immutable
class AndroidJavaScriptReplyProxyCreationParams
    extends AqutterPlatformJavaScriptReplyProxyCreationParams {
  /// Creates a new [AndroidJavaScriptReplyProxyCreationParams] instance.
  const AndroidJavaScriptReplyProxyCreationParams({
    required super.webMessageListener,
  });

  /// Creates a [AndroidJavaScriptReplyProxyCreationParams] instance based on [AqutterPlatformJavaScriptReplyProxyCreationParams].
  factory AndroidJavaScriptReplyProxyCreationParams.fromPlatformJavaScriptReplyProxyCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformJavaScriptReplyProxyCreationParams params,
  ) {
    return AndroidJavaScriptReplyProxyCreationParams(
      webMessageListener: params.webMessageListener,
    );
  }
}

///{@macro aqutter_core.AqutterJavaScriptReplyProxy}
class AndroidJavaScriptReplyProxy extends AqutterPlatformJavaScriptReplyProxy {
  /// Constructs a [AndroidWebMessageListener].
  AndroidJavaScriptReplyProxy(AqutterPlatformJavaScriptReplyProxyCreationParams params)
    : super.implementation(
        params is AndroidJavaScriptReplyProxyCreationParams
            ? params
            : AndroidJavaScriptReplyProxyCreationParams.fromPlatformJavaScriptReplyProxyCreationParams(
                params,
              ),
      );

  AndroidWebMessageListener get _androidWebMessageListener =>
      params.webMessageListener as AndroidWebMessageListener;

  @override
  Future<void> postMessage(AqutterWebMessage message) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('message', () => message.toMap());
    await _androidWebMessageListener.channel?.invokeMethod('postMessage', args);
  }

  @override
  String toString() {
    return 'AndroidJavaScriptReplyProxy{}';
  }
}
