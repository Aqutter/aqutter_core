import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase}
///
///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.supported_platforms}
class AqutterHttpAuthCredentialDatabase {
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.supported_platforms}
  AqutterHttpAuthCredentialDatabase()
    : this.fromPlatformCreationParams(
        const AqutterPlatformHttpAuthCredentialDatabaseCreationParams(),
      );

  /// Constructs a [AqutterHttpAuthCredentialDatabase] from creation params for a specific
  /// platform.
  AqutterHttpAuthCredentialDatabase.fromPlatformCreationParams(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) : this.fromPlatform(AqutterPlatformHttpAuthCredentialDatabase(params));

  /// Constructs a [AqutterHttpAuthCredentialDatabase] from a specific platform
  /// implementation.
  AqutterHttpAuthCredentialDatabase.fromPlatform(this.platform);

  /// Implementation of [AqutterPlatformHttpAuthCredentialDatabase] for the current platform.
  final AqutterPlatformHttpAuthCredentialDatabase platform;

  static AqutterHttpAuthCredentialDatabase? _instance;

  ///Gets the [AqutterHttpAuthCredentialDatabase] shared instance.
  static AqutterHttpAuthCredentialDatabase instance() {
    if (_instance == null) {
      _instance = AqutterHttpAuthCredentialDatabase();
    }
    return _instance!;
  }

  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.getAllAuthCredentials}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.getAllAuthCredentials.supported_platforms}
  Future<List<AqutterURLProtectionSpaceHttpAuthCredentials>> getAllAuthCredentials() =>
      platform.getAllAuthCredentials();

  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.getHttpAuthCredentials}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.getHttpAuthCredentials.supported_platforms}
  Future<List<AqutterURLCredential>> getHttpAuthCredentials({
    required AqutterURLProtectionSpace protectionSpace,
  }) => platform.getHttpAuthCredentials(protectionSpace: protectionSpace);

  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.setHttpAuthCredential}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.setHttpAuthCredential.supported_platforms}
  Future<void> setHttpAuthCredential({
    required AqutterURLProtectionSpace protectionSpace,
    required AqutterURLCredential credential,
  }) => platform.setHttpAuthCredential(
    protectionSpace: protectionSpace,
    credential: credential,
  );

  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.removeHttpAuthCredential}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.removeHttpAuthCredential.supported_platforms}
  Future<void> removeHttpAuthCredential({
    required AqutterURLProtectionSpace protectionSpace,
    required AqutterURLCredential credential,
  }) => platform.removeHttpAuthCredential(
    protectionSpace: protectionSpace,
    credential: credential,
  );

  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.removeHttpAuthCredentials}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.removeHttpAuthCredentials.supported_platforms}
  Future<void> removeHttpAuthCredentials({
    required AqutterURLProtectionSpace protectionSpace,
  }) => platform.removeHttpAuthCredentials(protectionSpace: protectionSpace);

  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.clearAllAuthCredentials}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.clearAllAuthCredentials.supported_platforms}
  Future<void> clearAllAuthCredentials() => platform.clearAllAuthCredentials();

  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabaseCreationParams.isClassSupported}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabaseCreationParams.isClassSupported.supported_platforms}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformHttpAuthCredentialDatabase.static().isClassSupported(
        platform: platform,
      );

  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.isMethodSupported}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.isMethodSupported.supported_platforms}
  static bool isMethodSupported(
    AqutterPlatformHttpAuthCredentialDatabaseMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformHttpAuthCredentialDatabase.static().isMethodSupported(
    method,
    platform: platform,
  );
}
