import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

part 'platform_localhost_server.g.dart';

///{@template aqutter_core.AqutterPlatformLocalhostServerCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformLocalhostServer].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformLocalhostServerCreationParams.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WindowsPlatform(),
    LinuxPlatform(),
  ],
)
@immutable
class AqutterPlatformLocalhostServerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformLocalhostServer].
  const AqutterPlatformLocalhostServerCreationParams({
    this.port = 8080,
    this.directoryIndex = 'index.html',
    this.documentRoot = './',
    this.shared = false,
    this.onData = null,
  });

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.port}
  final int port;

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.directoryIndex}
  final String directoryIndex;

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.documentRoot}
  final String documentRoot;

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.shared}
  final bool shared;

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.onData}
  final Future<bool> Function(HttpRequest request)? onData;

  ///{@template aqutter_core.AqutterPlatformLocalhostServerCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformLocalhostServerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformLocalhostServer}
///This class allows you to create a simple server on `http://localhost:[port]/`
///in order to be able to load your assets file on a local server.
///The default `port` value is `8080`.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformLocalhostServer.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WindowsPlatform(),
    LinuxPlatform(),
  ],
)
abstract class AqutterPlatformLocalhostServer extends PlatformInterface {
  /// Creates a new [AqutterPlatformLocalhostServer]
  factory AqutterPlatformLocalhostServer(
    AqutterPlatformLocalhostServerCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformLocalhostServer localhostServer =
        AqutterWebViewPlatform.instance!.createPlatformLocalhostServer(
          params,
        );
    PlatformInterface.verify(localhostServer, _token);
    return localhostServer;
  }

  /// Creates a new empty [AqutterPlatformLocalhostServer] to access static methods.
  factory AqutterPlatformLocalhostServer.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformLocalhostServer localhostServerStatic =
        AqutterWebViewPlatform.instance!
            .createPlatformLocalhostServerStatic();
    PlatformInterface.verify(localhostServerStatic, _token);
    return localhostServerStatic;
  }

  /// Used by the platform implementation to create a new
  /// [AqutterPlatformLocalhostServer].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformLocalhostServer.implementation(this.params)
    : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformLocalhostServer].
  final AqutterPlatformLocalhostServerCreationParams params;

  ///{@template aqutter_core.AqutterPlatformLocalhostServer.port}
  ///Represents the port of the server. The default value is `8080`.
  ///{@endtemplate}
  int get port => params.port;

  ///{@template aqutter_core.AqutterPlatformLocalhostServer.directoryIndex}
  ///represents the index file to use. The default value is `index.html`.
  ///{@endtemplate}
  String get directoryIndex => params.directoryIndex;

  ///{@template aqutter_core.AqutterPlatformLocalhostServer.documentRoot}
  ///Represents the document root path to serve. The default value is `./`.
  ///{@endtemplate}
  String get documentRoot => params.documentRoot;

  ///{@template aqutter_core.AqutterPlatformLocalhostServer.shared}
  ///Specifies whether additional `HttpServer`
  /// objects can bind to the same combination of `address`, `port` and `v6Only`.
  /// If `shared` is `true` and more `HttpServer`s from this isolate or other
  /// isolates are bound to the port, then the incoming connections will be
  /// distributed among all the bound `HttpServer`s. Connections can be
  /// distributed over multiple isolates this way.
  ///{@endtemplate}
  bool get shared => params.shared;

  ///{@template aqutter_core.AqutterPlatformLocalhostServer.onData}
  ///A custom callback that is called when a new request is received by the server
  ///that can be used to send or modify the response, for example adding custom headers.
  ///If this callback returns `true`, it means that the request has been handled by this callback.
  ///Otherwise, if this callback returns `false`, the server will continue to process the request using the default implementation.
  ///{@endtemplate}
  Future<bool> Function(HttpRequest request)? get onData => params.onData;

  ///{@template aqutter_core.AqutterPlatformLocalhostServer.start}
  ///Starts the server on `http://localhost:[port]/`.
  ///
  ///**NOTE for iOS**: For the iOS Platform, you need to add the `NSAllowsLocalNetworking` key with `true` in the `Info.plist` file
  ///(See [ATS Configuration Basics](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW35)):
  ///```xml
  ///<key>NSAppTransportSecurity</key>
  ///<dict>
  ///    <key>NSAllowsLocalNetworking</key>
  ///    <true/>
  ///</dict>
  ///```
  ///The `NSAllowsLocalNetworking` key is available since **iOS 10**.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.start.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> start() {
    throw UnimplementedError(
      'start is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformLocalhostServer.close}
  ///Closes the server.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.close.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> close() {
    throw UnimplementedError(
      'close is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformLocalhostServer.isRunning}
  ///Indicates if the server is running or not.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.isRunning.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  bool isRunning() {
    throw UnimplementedError(
      'isRunning is not implemented on the current platform',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformLocalhostServerCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);

  ///{@template aqutter_core.AqutterPlatformLocalhostServer.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformLocalhostServerMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformLocalhostServerMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}
