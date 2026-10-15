import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:aqutter_core/src/platform_interface/src/types/disposable.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import '../webview/platform_webview_controller.dart';
import '../webview_platform.dart';
import '../types/main.dart';
import 'web_message.dart';

// ignore: uri_has_not_been_generated
part 'platform_web_message_listener.g.dart';

///{@template aqutter_core.AqutterPlatformWebMessageListenerCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformWebMessageListener].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebMessageListenerCreationParams.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    LinuxPlatform(),
    WindowsPlatform(),
  ],
)
@immutable
class AqutterPlatformWebMessageListenerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformWebMessageListener].
  const AqutterPlatformWebMessageListenerCreationParams({
    required this.jsObjectName,
    this.allowedOriginRules,
    this.onPostMessage,
  });

  ///{@template aqutter_core.AqutterPlatformWebMessageListenerCreationParams.jsObjectName}
  ///The name for the injected JavaScript object.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageListenerCreationParams.jsObjectName.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
      WindowsPlatform(),
    ],
  )
  final String jsObjectName;

  ///{@template aqutter_core.AqutterPlatformWebMessageListenerCreationParams.allowedOriginRules}
  ///A set of matching rules for the allowed origins.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageListenerCreationParams.allowedOriginRules.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
      WindowsPlatform(),
    ],
  )
  final Set<String>? allowedOriginRules;

  ///{@template aqutter_core.AqutterPlatformWebMessageListenerCreationParams.onPostMessage}
  ///Event that receives a message sent by a `postMessage()` on the injected JavaScript object.
  ///
  ///Note that when the frame is `file:` or `content:` origin, the value of [sourceOrigin] is `null`.
  ///
  ///- [message] represents the message from JavaScript.
  ///- [sourceOrigin] represents the origin of the frame that the message is from.
  ///- [isMainFrame] is `true` if the message is from the main frame.
  ///- [replyProxy] is used to reply back to the JavaScript object.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageListenerCreationParams.onPostMessage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewCompat.AqutterWebMessageListener.onPostMessage',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/WebViewCompat.AqutterWebMessageListener#onPostMessage(android.webkit.WebView,%20androidx.webkit.WebMessageCompat,%20android.net.Uri,%20boolean,%20androidx.webkit.AqutterJavaScriptReplyProxy)',
      ),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
      WindowsPlatform(),
    ],
  )
  final AqutterOnPostMessageCallback? onPostMessage;

  ///{@template aqutter_core.AqutterPlatformWebMessageListenerCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebMessageListenerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformWebMessageListenerCreationParams.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformWebMessageListenerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) =>
      _AqutterPlatformWebMessageListenerCreationParamsPropertySupported.isPropertySupported(
        property,
        platform: platform,
      );

  @override
  String toString() {
    return 'AqutterPlatformWebMessageListenerCreationParams{jsObjectName: $jsObjectName, allowedOriginRules: $allowedOriginRules, onPostMessage: $onPostMessage}';
  }
}

///{@template aqutter_core.AqutterPlatformWebMessageListener}
///This listener receives messages sent on the JavaScript object which was injected by [AqutterPlatformWebViewController.addWebMessageListener].
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebMessageListener.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    LinuxPlatform(),
    WindowsPlatform(),
  ],
)
abstract class AqutterPlatformWebMessageListener extends PlatformInterface
    implements AqutterDisposable {
  /// Creates a new [AqutterPlatformWebMessageListener]
  factory AqutterPlatformWebMessageListener(
    AqutterPlatformWebMessageListenerCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebMessageListener webMessageListener = AqutterWebViewPlatform
        .instance!
        .createPlatformWebMessageListener(params);
    PlatformInterface.verify(webMessageListener, _token);
    return webMessageListener;
  }

  /// Creates a new [AqutterPlatformWebMessageListener] to access static methods.
  factory AqutterPlatformWebMessageListener.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebMessageListener webMessageListenerStatic =
        AqutterWebViewPlatform.instance!.createPlatformWebMessageListenerStatic();
    PlatformInterface.verify(webMessageListenerStatic, _token);
    return webMessageListenerStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformWebMessageListener].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformWebMessageListener.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformWebMessageListener].
  final AqutterPlatformWebMessageListenerCreationParams params;

  ///{@macro aqutter_core.AqutterPlatformWebMessageListenerCreationParams.jsObjectName}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageListenerCreationParams.jsObjectName.supported_platforms}
  String get jsObjectName => params.jsObjectName;

  ///{@macro aqutter_core.AqutterPlatformWebMessageListenerCreationParams.allowedOriginRules}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageListenerCreationParams.allowedOriginRules.supported_platforms}
  Set<String>? get allowedOriginRules => params.allowedOriginRules;

  ///{@macro aqutter_core.AqutterPlatformWebMessageListenerCreationParams.onPostMessage}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageListenerCreationParams.onPostMessage.supported_platforms}
  AqutterOnPostMessageCallback? get onPostMessage => params.onPostMessage;

  Map<String, dynamic> toMap() {
    throw UnimplementedError(
      'toMap is not implemented on the current platform.',
    );
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError(
      'toJson is not implemented on the current platform.',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebMessageListener.dispose}
  ///Disposes the channel.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageListener.dispose.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
      WindowsPlatform(),
    ],
  )
  @override
  void dispose() {
    throw UnimplementedError(
      'dispose is not implemented on the current platform.',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformWebMessageListenerCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebMessageListenerClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformWebMessageListener.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformWebMessageListenerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => params.isPropertySupported(property, platform: platform);

  ///{@template aqutter_core.AqutterPlatformWebMessageListener.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformWebMessageListenerMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformWebMessageListenerMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );

  @override
  String toString() {
    return 'AqutterPlatformWebMessageListener{jsObjectName: $jsObjectName, allowedOriginRules: $allowedOriginRules, onPostMessage: $onPostMessage}';
  }
}

/// Object specifying creation parameters for creating a [AqutterPlatformJavaScriptReplyProxy].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
@immutable
class AqutterPlatformJavaScriptReplyProxyCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformJavaScriptReplyProxy].
  const AqutterPlatformJavaScriptReplyProxyCreationParams({
    required this.webMessageListener,
  });

  final AqutterPlatformWebMessageListener webMessageListener;
}

///{@template aqutter_core.AqutterPlatformJavaScriptReplyProxy}
///This class represents the JavaScript object injected by [AqutterPlatformWebViewController.addWebMessageListener].
///An instance will be given by [AqutterPlatformWebMessageListener.onPostMessage].
///The app can use `postMessage(String)` to talk to the JavaScript context.
///
///There is a 1:1 relationship between this object and the JavaScript object in a frame.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformJavaScriptReplyProxy.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    LinuxPlatform(),
    WindowsPlatform(),
  ],
)
abstract class AqutterPlatformJavaScriptReplyProxy extends PlatformInterface {
  /// Creates a new [AqutterPlatformWebMessageListener]
  factory AqutterPlatformJavaScriptReplyProxy(
    AqutterPlatformJavaScriptReplyProxyCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformJavaScriptReplyProxy javaScriptReplyProxy =
        AqutterWebViewPlatform.instance!.createPlatformJavaScriptReplyProxy(
          params,
        );
    PlatformInterface.verify(javaScriptReplyProxy, _token);
    return javaScriptReplyProxy;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformJavaScriptReplyProxy].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformJavaScriptReplyProxy.implementation(this.params)
    : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformJavaScriptReplyProxy].
  final AqutterPlatformJavaScriptReplyProxyCreationParams params;

  ///{@template aqutter_core.AqutterPlatformJavaScriptReplyProxy.postMessage}
  ///Post a [message] to the injected JavaScript object which sent this [AqutterPlatformJavaScriptReplyProxy].
  ///
  ///If [message] is of type [AqutterWebMessageType.ARRAY_BUFFER], be aware that large byte buffers can lead to out-of-memory crashes on low-end devices.
  ///
  ///**Official Android API**: https://developer.android.com/reference/androidx/webkit/AqutterJavaScriptReplyProxy#postMessage(java.lang.String)
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformJavaScriptReplyProxy.postMessage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<void> postMessage(AqutterWebMessage message) {
    throw UnimplementedError(
      'postMessage is not implemented on the current platform.',
    );
  }

  @override
  String toString() {
    return 'AqutterJavaScriptReplyProxy{}';
  }
}
