import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [LinuxHttpAuthCredentialDatabase].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformHttpAuthCredentialDatabaseCreationParams] for
/// more information.
@immutable
class LinuxHttpAuthCredentialDatabaseCreationParams
    extends AqutterPlatformHttpAuthCredentialDatabaseCreationParams {
  /// Creates a new [LinuxHttpAuthCredentialDatabaseCreationParams] instance.
  const LinuxHttpAuthCredentialDatabaseCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) : super();

  /// Creates a [LinuxHttpAuthCredentialDatabaseCreationParams] instance based on [AqutterPlatformHttpAuthCredentialDatabaseCreationParams].
  factory LinuxHttpAuthCredentialDatabaseCreationParams.fromPlatformHttpAuthCredentialDatabaseCreationParams(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) {
    return LinuxHttpAuthCredentialDatabaseCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase}
///
/// This implementation delegates to native C++ code which uses libsecret for secure storage.
/// Passwords are stored in the system keyring (gnome-keyring, KDE Wallet, etc.).
/// A JSON index file at ~/.local/share/flutter_inappwebview/<appId>/credential_index.json
/// is used to enumerate stored credentials (contains only usernames, not passwords).
///
/// The native `appId` is resolved from `GApplication.application_id` when available.
/// If it is null/empty, it falls back to the executable filename (from `/proc/self/exe`), sanitized.
class LinuxHttpAuthCredentialDatabase
    extends AqutterPlatformHttpAuthCredentialDatabase {
  static const MethodChannel _channel = MethodChannel(
    'com.github.aqutter/webview_credential_database',
  );

  /// Creates a new [LinuxHttpAuthCredentialDatabase].
  LinuxHttpAuthCredentialDatabase(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) : super.implementation(
        params is LinuxHttpAuthCredentialDatabaseCreationParams
            ? params
            : LinuxHttpAuthCredentialDatabaseCreationParams.fromPlatformHttpAuthCredentialDatabaseCreationParams(
                params,
              ),
      );

  static LinuxHttpAuthCredentialDatabase? _instance;

  /// Gets the database shared instance.
  static LinuxHttpAuthCredentialDatabase instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static LinuxHttpAuthCredentialDatabase _init() {
    _instance = LinuxHttpAuthCredentialDatabase(
      LinuxHttpAuthCredentialDatabaseCreationParams(
        const AqutterPlatformHttpAuthCredentialDatabaseCreationParams(),
      ),
    );
    return _instance!;
  }

  static final LinuxHttpAuthCredentialDatabase _staticValue =
      LinuxHttpAuthCredentialDatabase(
        LinuxHttpAuthCredentialDatabaseCreationParams(
          const AqutterPlatformHttpAuthCredentialDatabaseCreationParams(),
        ),
      );

  factory LinuxHttpAuthCredentialDatabase.static() {
    return _staticValue;
  }

  @override
  Future<List<AqutterURLProtectionSpaceHttpAuthCredentials>>
  getAllAuthCredentials() async {
    final List<dynamic> allCredentials =
        await _channel.invokeMethod<List>('getAllAuthCredentials', {}) ?? [];

    List<AqutterURLProtectionSpaceHttpAuthCredentials> result = [];

    for (final Map<dynamic, dynamic> map in allCredentials) {
      final element = AqutterURLProtectionSpaceHttpAuthCredentials.fromMap(
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
    final Map<String, dynamic> args = {
      'host': protectionSpace.host,
      'protocol': protectionSpace.protocol,
      'realm': protectionSpace.realm,
      'port': protectionSpace.port,
    };

    final List<dynamic> credentialList =
        await _channel.invokeMethod<List>('getHttpAuthCredentials', args) ?? [];

    List<AqutterURLCredential> credentials = [];
    for (final Map<dynamic, dynamic> map in credentialList) {
      final credential = AqutterURLCredential.fromMap(map.cast<String, dynamic>());
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
    final Map<String, dynamic> args = {
      'host': protectionSpace.host,
      'protocol': protectionSpace.protocol,
      'realm': protectionSpace.realm,
      'port': protectionSpace.port,
      'username': credential.username,
      'password': credential.password,
    };
    await _channel.invokeMethod('setHttpAuthCredential', args);
  }

  @override
  Future<void> removeHttpAuthCredential({
    required AqutterURLProtectionSpace protectionSpace,
    required AqutterURLCredential credential,
  }) async {
    final Map<String, dynamic> args = {
      'host': protectionSpace.host,
      'protocol': protectionSpace.protocol,
      'realm': protectionSpace.realm,
      'port': protectionSpace.port,
      'username': credential.username,
      'password': credential.password,
    };
    await _channel.invokeMethod('removeHttpAuthCredential', args);
  }

  @override
  Future<void> removeHttpAuthCredentials({
    required AqutterURLProtectionSpace protectionSpace,
  }) async {
    final Map<String, dynamic> args = {
      'host': protectionSpace.host,
      'protocol': protectionSpace.protocol,
      'realm': protectionSpace.realm,
      'port': protectionSpace.port,
    };
    await _channel.invokeMethod('removeHttpAuthCredentials', args);
  }

  @override
  Future<void> clearAllAuthCredentials() async {
    await _channel.invokeMethod('clearAllAuthCredentials', {});
  }

  /// Disposes of any resources used by this database.
  /// Nothing to dispose - native side manages its own lifecycle.
  void dispose() {
    // Nothing to dispose
  }
}
