import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformLocalhostServer}
///
///{@macro aqutter_core.AqutterPlatformLocalhostServer.supported_platforms}
class AqutterLocalhostServer {
  ///{@macro aqutter_core.AqutterPlatformLocalhostServer}
  AqutterLocalhostServer({
    int port = 8080,
    String directoryIndex = 'index.html',
    String documentRoot = './',
    bool shared = false,
    Future<bool> Function(HttpRequest request)? onData,
  }) : this.fromPlatformCreationParams(
         AqutterPlatformLocalhostServerCreationParams(
           port: port,
           directoryIndex: directoryIndex,
           documentRoot: documentRoot,
           shared: shared,
           onData: onData,
         ),
       );

  /// Constructs a [AqutterLocalhostServer] from creation params for a specific
  /// platform.
  AqutterLocalhostServer.fromPlatformCreationParams(
    AqutterPlatformLocalhostServerCreationParams params,
  ) : this.fromPlatform(AqutterPlatformLocalhostServer(params));

  /// Constructs a [AqutterLocalhostServer] from a specific platform
  /// implementation.
  AqutterLocalhostServer.fromPlatform(this.platform);

  /// Implementation of [AqutterPlatformLocalhostServer] for the current platform.
  final AqutterPlatformLocalhostServer platform;

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.port}
  ///
  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.port.supported_platforms}
  int get port => platform.port;

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.directoryIndex}
  ///
  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.directoryIndex.supported_platforms}
  String get directoryIndex => platform.directoryIndex;

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.documentRoot}
  ///
  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.documentRoot.supported_platforms}
  String get documentRoot => platform.documentRoot;

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.shared}
  ///
  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.shared.supported_platforms}
  bool get shared => platform.shared;

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.onData}
  ///
  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.onData.supported_platforms}
  Future<bool> Function(HttpRequest request)? get onData => platform.onData;

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.start}
  ///
  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.start.supported_platforms}
  Future<void> start() => platform.start();

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.close}
  ///
  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.close.supported_platforms}
  Future<void> close() => platform.close();

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.isRunning}
  ///
  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.isRunning.supported_platforms}
  bool isRunning() => platform.isRunning();

  ///{@macro aqutter_core.AqutterPlatformLocalhostServerCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformLocalhostServer.static().isClassSupported(
        platform: platform,
      );

  ///{@macro aqutter_core.AqutterPlatformLocalhostServer.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformLocalhostServerMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformLocalhostServer.static().isMethodSupported(
    method,
    platform: platform,
  );
}
