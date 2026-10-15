import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [WindowsHttpAuthCredentialDatabase].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformHttpAuthCredentialDatabaseCreationParams] for
/// more information.
@immutable
class WindowsHttpAuthCredentialDatabaseCreationParams
    extends AqutterPlatformHttpAuthCredentialDatabaseCreationParams {
  /// Creates a new [WindowsHttpAuthCredentialDatabaseCreationParams] instance.
  const WindowsHttpAuthCredentialDatabaseCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) : super();

  /// Creates a [WindowsHttpAuthCredentialDatabaseCreationParams] instance based on [AqutterPlatformHttpAuthCredentialDatabaseCreationParams].
  factory WindowsHttpAuthCredentialDatabaseCreationParams.fromPlatformHttpAuthCredentialDatabaseCreationParams(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) {
    return WindowsHttpAuthCredentialDatabaseCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase}
class WindowsHttpAuthCredentialDatabase
    extends AqutterPlatformHttpAuthCredentialDatabase
    with ChannelController {
  /// Creates a new [WindowsHttpAuthCredentialDatabase].
  WindowsHttpAuthCredentialDatabase(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) : super.implementation(
        params is WindowsHttpAuthCredentialDatabaseCreationParams
            ? params
            : WindowsHttpAuthCredentialDatabaseCreationParams.fromPlatformHttpAuthCredentialDatabaseCreationParams(
                params,
              ),
      ) {
    channel = const MethodChannel(
      'com.github.aqutter/webview_credential_database',
    );
    handler = handleMethod;
    initMethodCallHandler();
  }

  static WindowsHttpAuthCredentialDatabase? _instance;

  ///Gets the database shared instance.
  static WindowsHttpAuthCredentialDatabase instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static WindowsHttpAuthCredentialDatabase _init() {
    _instance = WindowsHttpAuthCredentialDatabase(
      WindowsHttpAuthCredentialDatabaseCreationParams(
        const AqutterPlatformHttpAuthCredentialDatabaseCreationParams(),
      ),
    );
    return _instance!;
  }

  Future<dynamic> _handleMethod(MethodCall call) async {}

  @override
  Future<List<AqutterURLProtectionSpaceHttpAuthCredentials>>
  getAllAuthCredentials() async {
    Map<String, dynamic> args = <String, dynamic>{};
    List<dynamic> allCredentials =
        await channel?.invokeMethod<List>('getAllAuthCredentials', args) ?? [];

    List<AqutterURLProtectionSpaceHttpAuthCredentials> result = [];

    for (Map<dynamic, dynamic> map in allCredentials) {
      var element = AqutterURLProtectionSpaceHttpAuthCredentials.fromMap(
        map.cast<String, dynamic>(),
      );
      if (element != null) {
        result.add(element);
      }
    }
    return result;
  }

  @override
  Future<List<AqutterURLCredential>> getHttpAuthCredentials({
    required AqutterURLProtectionSpace protectionSpace,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("host", () => protectionSpace.host);
    args.putIfAbsent("protocol", () => protectionSpace.protocol);
    args.putIfAbsent("realm", () => protectionSpace.realm);
    args.putIfAbsent("port", () => protectionSpace.port);
    List<dynamic> credentialList =
        await channel?.invokeMethod<List>('getHttpAuthCredentials', args) ?? [];
    List<AqutterURLCredential> credentials = [];
    for (Map<dynamic, dynamic> map in credentialList) {
      var credential = AqutterURLCredential.fromMap(map.cast<String, dynamic>());
      if (credential != null) {
        credentials.add(credential);
      }
    }
    return credentials;
  }

  @override
  Future<void> setHttpAuthCredential({
    required AqutterURLProtectionSpace protectionSpace,
    required AqutterURLCredential credential,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("host", () => protectionSpace.host);
    args.putIfAbsent("protocol", () => protectionSpace.protocol);
    args.putIfAbsent("realm", () => protectionSpace.realm);
    args.putIfAbsent("port", () => protectionSpace.port);
    args.putIfAbsent("username", () => credential.username);
    args.putIfAbsent("password", () => credential.password);
    await channel?.invokeMethod('setHttpAuthCredential', args);
  }

  @override
  Future<void> removeHttpAuthCredential({
    required AqutterURLProtectionSpace protectionSpace,
    required AqutterURLCredential credential,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("host", () => protectionSpace.host);
    args.putIfAbsent("protocol", () => protectionSpace.protocol);
    args.putIfAbsent("realm", () => protectionSpace.realm);
    args.putIfAbsent("port", () => protectionSpace.port);
    args.putIfAbsent("username", () => credential.username);
    args.putIfAbsent("password", () => credential.password);
    await channel?.invokeMethod('removeHttpAuthCredential', args);
  }

  @override
  Future<void> removeHttpAuthCredentials({
    required AqutterURLProtectionSpace protectionSpace,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("host", () => protectionSpace.host);
    args.putIfAbsent("protocol", () => protectionSpace.protocol);
    args.putIfAbsent("realm", () => protectionSpace.realm);
    args.putIfAbsent("port", () => protectionSpace.port);
    await channel?.invokeMethod('removeHttpAuthCredentials', args);
  }

  @override
  Future<void> clearAllAuthCredentials() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('clearAllAuthCredentials', args);
  }

  @override
  void dispose() {
    // empty
  }
}

extension InternalHttpAuthCredentialDatabase
    on WindowsHttpAuthCredentialDatabase {
  get handleMethod => _handleMethod;
}
