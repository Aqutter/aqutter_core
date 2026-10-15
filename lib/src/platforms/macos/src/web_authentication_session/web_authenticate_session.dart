import 'dart:async';

import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [MacOSWebAuthenticationSession].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebAuthenticationSessionCreationParams] for
/// more information.
class MacOSWebAuthenticationSessionCreationParams
    extends AqutterPlatformWebAuthenticationSessionCreationParams {
  /// Creates a new [MacOSWebAuthenticationSessionCreationParams] instance.
  const MacOSWebAuthenticationSessionCreationParams();

  /// Creates a [MacOSWebAuthenticationSessionCreationParams] instance based on [AqutterPlatformWebAuthenticationSessionCreationParams].
  factory MacOSWebAuthenticationSessionCreationParams.fromPlatformWebAuthenticationSessionCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebAuthenticationSessionCreationParams params,
  ) {
    return MacOSWebAuthenticationSessionCreationParams();
  }
}

///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession}
class MacOSWebAuthenticationSession extends AqutterPlatformWebAuthenticationSession
    with ChannelController {
  /// Constructs a [MacOSWebAuthenticationSession].
  MacOSWebAuthenticationSession(
    AqutterPlatformWebAuthenticationSessionCreationParams params,
  ) : super.implementation(
        params is MacOSWebAuthenticationSessionCreationParams
            ? params
            : MacOSWebAuthenticationSessionCreationParams.fromPlatformWebAuthenticationSessionCreationParams(
                params,
              ),
      );

  static final MacOSWebAuthenticationSession _staticValue =
      MacOSWebAuthenticationSession(
        MacOSWebAuthenticationSessionCreationParams(),
      );

  /// Provide static access.
  factory MacOSWebAuthenticationSession.static() {
    return _staticValue;
  }

  @override
  final String id = IdGenerator.generate();

  @override
  late final AqutterWebUri url;

  @override
  late final String? callbackURLScheme;

  @override
  late final AqutterWebAuthenticationSessionSettings? initialSettings;

  @override
  late final AqutterWebAuthenticationSessionCompletionHandler onComplete;

  static const MethodChannel _staticChannel = const MethodChannel(
    'com.github.aqutter/webauthenticationsession',
  );

  @override
  Future<MacOSWebAuthenticationSession> create({
    required AqutterWebUri url,
    String? callbackURLScheme,
    AqutterWebAuthenticationSessionCompletionHandler onComplete,
    AqutterWebAuthenticationSessionSettings? initialSettings,
  }) async {
    var session = MacOSWebAuthenticationSession._create(
      url: url,
      callbackURLScheme: callbackURLScheme,
      onComplete: onComplete,
      initialSettings: initialSettings,
    );
    initialSettings =
        session.initialSettings ?? AqutterWebAuthenticationSessionSettings();
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("id", () => session.id);
    args.putIfAbsent("url", () => session.url.toString());
    args.putIfAbsent("callbackURLScheme", () => session.callbackURLScheme);
    args.putIfAbsent("initialSettings", () => initialSettings?.toMap());
    await _staticChannel.invokeMethod('create', args);
    return session;
  }

  MacOSWebAuthenticationSession._create({
    required this.url,
    this.callbackURLScheme,
    this.onComplete,
    AqutterWebAuthenticationSessionSettings? initialSettings,
  }) : super.implementation(MacOSWebAuthenticationSessionCreationParams()) {
    assert(url.toString().isNotEmpty);
    assert(
      ['http', 'https'].contains(url.scheme),
      'The specified URL has an unsupported scheme. Only HTTP and HTTPS URLs are supported on iOS.',
    );

    this.initialSettings =
        initialSettings ?? AqutterWebAuthenticationSessionSettings();
    channel = MethodChannel(
      'com.github.aqutter/webauthenticationsession_$id',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }

  _debugLog(String method, dynamic args) {
    debugLog(
      className: this.runtimeType.toString(),
      debugLoggingSettings:
          AqutterPlatformWebAuthenticationSession.debugLoggingSettings,
      id: id,
      method: method,
      args: args,
    );
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    _debugLog(call.method, call.arguments);

    switch (call.method) {
      case "onComplete":
        String? url = call.arguments["url"];
        AqutterWebUri? uri = url != null ? AqutterWebUri(url) : null;
        var error = AqutterWebAuthenticationSessionError.fromNativeValue(
          call.arguments["errorCode"],
        );
        if (onComplete != null) {
          onComplete!(uri, error);
        }
        break;
      default:
        throw UnimplementedError("Unimplemented ${call.method} method");
    }
  }

  @override
  Future<bool> canStart() async {
    Map<String, dynamic> args = <String, dynamic>{};
    return await channel?.invokeMethod<bool>('canStart', args) ?? false;
  }

  @override
  Future<bool> start() async {
    Map<String, dynamic> args = <String, dynamic>{};
    return await channel?.invokeMethod<bool>('start', args) ?? false;
  }

  @override
  Future<void> cancel() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod("cancel", args);
  }

  @override
  Future<void> dispose() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod("dispose", args);
    disposeChannel();
  }

  @override
  Future<bool> isAvailable() async {
    Map<String, dynamic> args = <String, dynamic>{};
    return await _staticChannel.invokeMethod<bool>("isAvailable", args) ??
        false;
  }
}
