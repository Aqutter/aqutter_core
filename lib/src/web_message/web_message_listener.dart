import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformWebMessageListener}
///
///{@macro aqutter_core.AqutterPlatformWebMessageListener.supported_platforms}
class AqutterWebMessageListener {
  ///{@macro aqutter_core.AqutterPlatformWebMessageListener}
  AqutterWebMessageListener({
    required String jsObjectName,
    Set<String>? allowedOriginRules,
    AqutterOnPostMessageCallback? onPostMessage,
  }) : this.fromPlatformCreationParams(
         params: AqutterPlatformWebMessageListenerCreationParams(
           jsObjectName: jsObjectName,
           allowedOriginRules: allowedOriginRules,
           onPostMessage: onPostMessage,
         ),
       );

  /// Constructs a [AqutterWebMessageListener].
  ///
  /// See [AqutterWebMessageListener.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterWebMessageListener.fromPlatformCreationParams({
    required AqutterPlatformWebMessageListenerCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformWebMessageListener(params));

  /// Constructs a [AqutterWebMessageListener] from a specific platform implementation.
  AqutterWebMessageListener.fromPlatform({required this.platform});

  /// Implementation of [AqutterPlatformWebMessageListener] for the current platform.
  final AqutterPlatformWebMessageListener platform;

  /// Provide static access.
  static AqutterWebMessageListener static() {
    return AqutterWebMessageListener.fromPlatform(
      platform: AqutterPlatformWebMessageListener.static(),
    );
  }

  ///{@macro aqutter_core.AqutterPlatformWebMessageListenerCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformWebMessageListener.static().isClassSupported(platform: platform);

  ///{@macro aqutter_core.AqutterPlatformWebMessageListener.isPropertySupported}
  static bool isPropertySupported(
    AqutterPlatformWebMessageListenerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebMessageListener.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformWebMessageListener.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformWebMessageListenerMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebMessageListener.static().isMethodSupported(
    method,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformWebMessageListener.jsObjectName}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageListener.jsObjectName.supported_platforms}
  String get jsObjectName => platform.jsObjectName;

  ///{@macro aqutter_core.AqutterPlatformWebMessageListener.allowedOriginRules}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageListener.allowedOriginRules.supported_platforms}
  Set<String>? get allowedOriginRules => platform.allowedOriginRules;

  ///{@macro aqutter_core.AqutterPlatformWebMessageListener.onPostMessage}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageListener.onPostMessage.supported_platforms}
  AqutterOnPostMessageCallback? get onPostMessage => platform.onPostMessage;

  ///{@macro aqutter_core.AqutterPlatformWebMessageListener.dispose}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageListener.dispose.supported_platforms}
  void dispose() => platform.dispose();

  Map<String, dynamic> toMap() => platform.toMap();

  Map<String, dynamic> toJson() => platform.toJson();

  @override
  String toString() => platform.toString();
}

///{@macro aqutter_core.AqutterPlatformJavaScriptReplyProxy}
///
///{@macro aqutter_core.AqutterPlatformJavaScriptReplyProxy.supported_platforms}
class AqutterJavaScriptReplyProxy {
  ///{@macro aqutter_core.AqutterPlatformJavaScriptReplyProxy}
  AqutterJavaScriptReplyProxy({required AqutterPlatformWebMessageListener webMessageListener})
    : this.fromPlatformCreationParams(
        params: AqutterPlatformJavaScriptReplyProxyCreationParams(
          webMessageListener: webMessageListener,
        ),
      );

  /// Constructs a [AqutterJavaScriptReplyProxy].
  ///
  /// See [AqutterJavaScriptReplyProxy.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterJavaScriptReplyProxy.fromPlatformCreationParams({
    required AqutterPlatformJavaScriptReplyProxyCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformJavaScriptReplyProxy(params));

  /// Constructs a [AqutterJavaScriptReplyProxy] from a specific platform implementation.
  AqutterJavaScriptReplyProxy.fromPlatform({required this.platform});

  /// Implementation of [AqutterPlatformJavaScriptReplyProxy] for the current platform.
  final AqutterPlatformJavaScriptReplyProxy platform;

  ///{@macro aqutter_core.AqutterPlatformJavaScriptReplyProxy.postMessage}
  ///
  ///{@macro aqutter_core.AqutterPlatformJavaScriptReplyProxy.postMessage.supported_platforms}
  Future<void> postMessage(AqutterWebMessage message) => platform.postMessage(message);

  @override
  String toString() {
    return 'AqutterJavaScriptReplyProxy{}';
  }
}
