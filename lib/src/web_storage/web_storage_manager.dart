import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import 'android/web_storage_manager.dart';
import 'ios/web_storage_manager.dart';

///{@macro aqutter_core.AqutterPlatformWebStorageManager}
///
///{@macro aqutter_core.AqutterPlatformWebStorageManager.supported_platforms}
class AqutterWebStorageManager {
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager}
  AqutterWebStorageManager()
    : this.fromPlatformCreationParams(
        const AqutterPlatformWebStorageManagerCreationParams(),
      );

  /// Constructs a [AqutterWebStorageManager] from creation params for a specific
  /// platform.
  AqutterWebStorageManager.fromPlatformCreationParams(
    AqutterPlatformWebStorageManagerCreationParams params,
  ) : this.fromPlatform(AqutterPlatformWebStorageManager(params));

  /// Constructs a [AqutterWebStorageManager] from a specific platform
  /// implementation.
  AqutterWebStorageManager.fromPlatform(this.platform);

  /// Implementation of [AqutterPlatformCookieManager] for the current platform.
  final AqutterPlatformWebStorageManager platform;

  static AqutterWebStorageManager? _instance;

  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformWebStorageManager.static().isClassSupported(platform: platform);

  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isMethodSupported(
    AqutterPlatformWebStorageManagerMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebStorageManager.static().isMethodSupported(
    method,
    platform: platform,
  );

  ///Use [AqutterWebStorageManager] instead.
  @Deprecated("Use AqutterWebStorageManager instead")
  AqutterAndroidWebStorageManager android = AqutterAndroidWebStorageManager();

  ///Use [AqutterWebStorageManager] instead.
  @Deprecated("Use AqutterWebStorageManager instead")
  AqutterIOSWebStorageManager ios = AqutterIOSWebStorageManager();

  ///Gets the [AqutterWebStorageManager] shared instance.
  static AqutterWebStorageManager instance() {
    if (_instance == null) {
      _instance = AqutterWebStorageManager();
    }
    return _instance!;
  }

  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.getOrigins}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.getOrigins.supported_platforms}
  Future<List<AqutterWebStorageOrigin>> getOrigins() => platform.getOrigins();

  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.deleteAllData}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.deleteAllData.supported_platforms}
  Future<void> deleteAllData() => platform.deleteAllData();

  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.deleteOrigin}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.deleteOrigin.supported_platforms}
  Future<void> deleteOrigin({required String origin}) =>
      platform.deleteOrigin(origin: origin);

  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.getQuotaForOrigin}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.getQuotaForOrigin.supported_platforms}
  Future<int> getQuotaForOrigin({required String origin}) =>
      platform.getQuotaForOrigin(origin: origin);

  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.getUsageForOrigin}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.getUsageForOrigin.supported_platforms}
  Future<int> getUsageForOrigin({required String origin}) =>
      platform.getUsageForOrigin(origin: origin);

  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.fetchDataRecords}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.fetchDataRecords.supported_platforms}
  Future<List<AqutterWebsiteDataRecord>> fetchDataRecords({
    required Set<AqutterWebsiteDataType> dataTypes,
  }) => platform.fetchDataRecords(dataTypes: dataTypes);

  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.removeDataFor}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.removeDataFor.supported_platforms}
  Future<void> removeDataFor({
    required Set<AqutterWebsiteDataType> dataTypes,
    required List<AqutterWebsiteDataRecord> dataRecords,
  }) => platform.removeDataFor(dataTypes: dataTypes, dataRecords: dataRecords);

  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.removeDataModifiedSince}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.removeDataModifiedSince.supported_platforms}
  Future<void> removeDataModifiedSince({
    required Set<AqutterWebsiteDataType> dataTypes,
    required DateTime date,
  }) => platform.removeDataModifiedSince(dataTypes: dataTypes, date: date);
}
