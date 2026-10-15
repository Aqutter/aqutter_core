import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [AndroidHttpAuthCredentialDatabase].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformHttpAuthCredentialDatabaseCreationParams] for
/// more information.
@immutable
class AndroidHttpAuthCredentialDatabaseCreationParams
    extends AqutterPlatformHttpAuthCredentialDatabaseCreationParams {
  /// Creates a new [AndroidHttpAuthCredentialDatabaseCreationParams] instance.
  const AndroidHttpAuthCredentialDatabaseCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) : super();

  /// Creates a [AndroidHttpAuthCredentialDatabaseCreationParams] instance based on [AqutterPlatformHttpAuthCredentialDatabaseCreationParams].
  factory AndroidHttpAuthCredentialDatabaseCreationParams.fromPlatformHttpAuthCredentialDatabaseCreationParams(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) {
    return AndroidHttpAuthCredentialDatabaseCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase}
class AndroidHttpAuthCredentialDatabase
    extends AqutterPlatformHttpAuthCredentialDatabase
    with ChannelController {
  /// Creates a new [AndroidHttpAuthCredentialDatabase].
  AndroidHttpAuthCredentialDatabase(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) : super.implementation(
        params is AndroidHttpAuthCredentialDatabaseCreationParams
            ? params
            : AndroidHttpAuthCredentialDatabaseCreationParams.fromPlatformHttpAuthCredentialDatabaseCreationParams(
                params,
              ),
      ) {
    channel = const MethodChannel(
      'com.github.aqutter/webview_credential_database',
    );
    handler = handleMethod;
    initMethodCallHandler();
  }

  static AndroidHttpAuthCredentialDatabase? _instance;

  ///Gets the database shared instance.
  static AndroidHttpAuthCredentialDatabase instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static AndroidHttpAuthCredentialDatabase _init() {
    _instance = AndroidHttpAuthCredentialDatabase(
      AndroidHttpAuthCredentialDatabaseCreationParams(
        const AqutterPlatformHttpAuthCredentialDatabaseCreationParams(),
      ),
    );
    return _instance!;
  }

  static final AndroidHttpAuthCredentialDatabase _staticValue =
      AndroidHttpAuthCredentialDatabase(
        AndroidHttpAuthCredentialDatabaseCreationParams(
          const AqutterPlatformHttpAuthCredentialDatabaseCreationParams(),
        ),
      );

  factory AndroidHttpAuthCredentialDatabase.static() {
    return _staticValue;
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
    on AndroidHttpAuthCredentialDatabase {
  get handleMethod => _handleMethod;
}
