import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:aqutter_core/src/platform_interface/src/types/disposable.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import '../webview_platform.dart';
import 'platform_web_message_port.dart';

// ignore: uri_has_not_been_generated
part 'platform_web_message_channel.g.dart';

///{@template aqutter_core.AqutterPlatformWebMessageChannelCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformWebMessageChannel].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebMessageChannelCreationParams.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    LinuxPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
    WindowsPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
  ],
)
@immutable
class AqutterPlatformWebMessageChannelCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformWebMessageChannel].
  const AqutterPlatformWebMessageChannelCreationParams({
    required this.id,
    required this.port1,
    required this.port2,
  });

  ///{@template aqutter_core.AqutterPlatformWebMessageChannelCreationParams.id}
  ///Message Channel ID used internally.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageChannelCreationParams.id.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
      WindowsPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
    ],
  )
  final String id;

  ///{@template aqutter_core.AqutterPlatformWebMessageChannelCreationParams.port1}
  ///The first [AqutterPlatformWebMessagePort] object of the channel.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageChannelCreationParams.port1.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
      WindowsPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
    ],
  )
  final AqutterPlatformWebMessagePort port1;

  ///{@template aqutter_core.AqutterPlatformWebMessageChannelCreationParams.port2}
  ///The second [AqutterPlatformWebMessagePort] object of the channel.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageChannelCreationParams.port2.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
      WindowsPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
    ],
  )
  final AqutterPlatformWebMessagePort port2;

  ///{@template aqutter_core.AqutterPlatformWebMessageChannelCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebMessageChannelCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformWebMessageChannelCreationParams.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformWebMessageChannelCreationParamsProperty property, {
    TargetPlatform? platform,
  }) =>
      _AqutterPlatformWebMessageChannelCreationParamsPropertySupported.isPropertySupported(
        property,
        platform: platform,
      );

  @override
  String toString() {
    return 'AqutterPlatformWebMessageChannelCreationParams{id: $id, port1: $port1, port2: $port2}';
  }
}

///{@template aqutter_core.AqutterPlatformWebMessageChannel}
///The representation of the [HTML5 message channels](https://html.spec.whatwg.org/multipage/web-messaging.html#message-channels).
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebMessageChannel.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    LinuxPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
    WindowsPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
  ],
)
abstract class AqutterPlatformWebMessageChannel extends PlatformInterface
    implements AqutterDisposable {
  /// Creates a new [AqutterPlatformWebMessageChannel]
  factory AqutterPlatformWebMessageChannel(
    AqutterPlatformWebMessageChannelCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebMessageChannel webMessageChannel = AqutterWebViewPlatform
        .instance!
        .createPlatformWebMessageChannel(params);
    PlatformInterface.verify(webMessageChannel, _token);
    return webMessageChannel;
  }

  /// Creates a new [AqutterPlatformWebMessageChannel] to access static methods.
  factory AqutterPlatformWebMessageChannel.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebMessageChannel webMessageChannelStatic =
        AqutterWebViewPlatform.instance!.createPlatformWebMessageChannelStatic();
    PlatformInterface.verify(webMessageChannelStatic, _token);
    return webMessageChannelStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformWebMessageChannel].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformWebMessageChannel.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformWebMessageChannel].
  final AqutterPlatformWebMessageChannelCreationParams params;

  ///{@macro aqutter_core.AqutterPlatformWebMessageChannelCreationParams.id}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageChannelCreationParams.id.supported_platforms}
  String get id => params.id;

  ///{@macro aqutter_core.AqutterPlatformWebMessageChannelCreationParams.port1}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageChannelCreationParams.port1.supported_platforms}
  AqutterPlatformWebMessagePort get port1 => params.port1;

  ///{@macro aqutter_core.AqutterPlatformWebMessageChannelCreationParams.port2}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageChannelCreationParams.port2.supported_platforms}
  AqutterPlatformWebMessagePort get port2 => params.port2;

  AqutterPlatformWebMessageChannel? fromMap(Map<String, dynamic>? map) {
    throw UnimplementedError(
      'fromMap is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebMessageChannel.dispose}
  ///Disposes the web message channel.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebMessageChannel.dispose.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
      WindowsPlatform(note: 'Implemented via JavaScript MessageChannel API.'),
    ],
  )
  @override
  void dispose() {
    throw UnimplementedError(
      'dispose is not implemented on the current platform',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformWebMessageChannelCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebMessageChannelClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformWebMessageChannel.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformWebMessageChannelCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => params.isPropertySupported(property, platform: platform);

  ///{@template aqutter_core.AqutterPlatformWebMessageChannel.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformWebMessageChannelMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformWebMessageChannelMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );

  @override
  String toString() {
    return 'AqutterPlatformWebMessageChannel{id: $id, port1: $port1, port2: $port2}';
  }
}
