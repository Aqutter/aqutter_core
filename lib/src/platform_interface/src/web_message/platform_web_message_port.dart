import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../webview_platform.dart';
import '../types/enum_method.dart';
import '../types/web_message_callback.dart';
import 'web_message.dart';

/// Object specifying creation parameters for creating a [AqutterPlatformWebMessagePort].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
@immutable
class AqutterPlatformWebMessagePortCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformWebMessagePort].
  const AqutterPlatformWebMessagePortCreationParams({required this.index});

  ///Port index.
  final int index;

  @override
  String toString() {
    return 'AqutterPlatformWebMessagePortCreationParams{index: $index}';
  }
}

///{@template aqutter_core.AqutterPlatformWebMessagePort}
///The representation of the [HTML5 message ports](https://html.spec.whatwg.org/multipage/comms.html#messageport).
///
///A Message port represents one endpoint of a Message Channel. In Android webview, there is no separate Message Channel object.
///When a message channel is created, both ports are tangled to each other and started.
///See [AqutterWebViewController.createWebMessageChannel] for creating a message channel.
///
///When a message port is first created or received via transfer, it does not have a [AqutterWebMessageCallback] to receive web messages.
///On Android, the messages are queued until a [AqutterWebMessageCallback] is set.
///
///A message port should be closed when it is not used by the embedder application anymore.
///A closed port cannot be transferred or cannot be reopened to send messages.
///Close can be called multiple times.
///
///When a port is transferred to JavaScript, it cannot be used to send or receive messages at the Dart side anymore.
///Different from HTML5 Spec, a port cannot be transferred if one of these has ever happened: i. a message callback was set, ii. a message was posted on it.
///A transferred port cannot be closed by the application, since the ownership is also transferred.
///
///It is possible to transfer both ports of a channel to JavaScript, for example for communication between subframes.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebMessagePort.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    LinuxPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
    WindowsPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
  ],
)
abstract class AqutterPlatformWebMessagePort extends PlatformInterface
    implements AqutterIWebMessagePort {
  /// Creates a new [AqutterPlatformWebMessagePort]
  factory AqutterPlatformWebMessagePort(AqutterPlatformWebMessagePortCreationParams params) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebMessagePort webMessagePort = AqutterWebViewPlatform.instance!
        .createPlatformWebMessagePort(params);
    PlatformInterface.verify(webMessagePort, _token);
    return webMessagePort;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformWebMessagePort].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformWebMessagePort.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformWebMessagePort].
  final AqutterPlatformWebMessagePortCreationParams params;

  @override
  String toString() {
    return 'AqutterPlatformWebMessagePort{index: ${params.index}}';
  }
}

abstract class AqutterIWebMessagePort {
  ///{@template aqutter_core.AqutterPlatformWebMessagePort.setWebMessageCallback}
  ///Sets a callback to receive message events on the main thread.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessagePort.setWebMessageCallback.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
      WindowsPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
    ],
  )
  Future<void> setWebMessageCallback(AqutterWebMessageCallback? onMessage) {
    throw UnimplementedError(
      'setWebMessageCallback is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebMessagePort.postMessage}
  ///Post a AqutterWebMessage to the entangled port.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessagePort.postMessage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
      WindowsPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
    ],
  )
  Future<void> postMessage(AqutterWebMessage message) {
    throw UnimplementedError(
      'postMessage is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebMessagePort.close}
  ///Close the message port and free any resources associated with it.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessagePort.close.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
      WindowsPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
    ],
  )
  Future<void> close() {
    throw UnimplementedError(
      'close is not implemented on the current platform',
    );
  }

  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    throw UnimplementedError(
      'toMap is not implemented on the current platform',
    );
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError(
      'toJson is not implemented on the current platform',
    );
  }
}
