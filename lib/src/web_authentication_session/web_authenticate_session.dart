import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession}
///
///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.supported_platforms}
class AqutterWebAuthenticationSession {
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.supported_platforms}
  AqutterWebAuthenticationSession()
    : this.fromPlatformCreationParams(
        params: AqutterPlatformWebAuthenticationSessionCreationParams(),
      );

  /// Constructs a [AqutterWebAuthenticationSession].
  ///
  /// See [AqutterWebAuthenticationSession.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterWebAuthenticationSession.fromPlatformCreationParams({
    required AqutterPlatformWebAuthenticationSessionCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformWebAuthenticationSession(params));

  /// Constructs a [AqutterWebAuthenticationSession] from a specific platform implementation.
  AqutterWebAuthenticationSession.fromPlatform({required this.platform});

  /// Implementation of [AqutterPlatformWebAuthenticationSession] for the current platform.
  final AqutterPlatformWebAuthenticationSession platform;

  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.id}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.id.supported_platforms}
  String get id => platform.id;

  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.url}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.url.supported_platforms}
  AqutterWebUri get url => platform.url;

  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.callbackURLScheme}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.callbackURLScheme.supported_platforms}
  String? get callbackURLScheme => platform.callbackURLScheme;

  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.initialSettings}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.initialSettings.supported_platforms}
  AqutterWebAuthenticationSessionSettings? get initialSettings =>
      platform.initialSettings;

  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.onComplete}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.onComplete.supported_platforms}
  AqutterWebAuthenticationSessionCompletionHandler get onComplete =>
      platform.onComplete;

  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.create}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.create.supported_platforms}
  static Future<AqutterWebAuthenticationSession> create({
    required AqutterWebUri url,
    String? callbackURLScheme,
    AqutterWebAuthenticationSessionCompletionHandler onComplete,
    AqutterWebAuthenticationSessionSettings? initialSettings,
  }) async {
    return AqutterWebAuthenticationSession.fromPlatform(
      platform: await AqutterPlatformWebAuthenticationSession.static().create(
        url: url,
        callbackURLScheme: callbackURLScheme,
        onComplete: onComplete,
        initialSettings: initialSettings,
      ),
    );
  }

  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.canStart}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.canStart.supported_platforms}
  Future<bool> canStart() => platform.canStart();

  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.start}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.start.supported_platforms}
  Future<bool> start() => platform.start();

  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.cancel}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.cancel.supported_platforms}
  Future<void> cancel() => platform.cancel();

  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.dispose}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.dispose.supported_platforms}
  Future<void> dispose() => platform.dispose();

  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.isAvailable}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.isAvailable.supported_platforms}
  static Future<bool> isAvailable() =>
      AqutterPlatformWebAuthenticationSession.static().isAvailable();

  ///{@template aqutter_core.AqutterWebAuthenticationSession.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformWebAuthenticationSession.static().isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterWebAuthenticationSession.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///The property should be one of the [AqutterPlatformWebAuthenticationSessionProperty] or [PlatformWebAuthenticationSessionCreationParamsProperty] values.
  ///{@endtemplate}
  static bool isPropertySupported(
    dynamic property, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebAuthenticationSession.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@template aqutter_core.AqutterWebAuthenticationSession.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  static bool isMethodSupported(
    AqutterPlatformWebAuthenticationSessionMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebAuthenticationSession.static().isMethodSupported(
    method,
    platform: platform,
  );
}
