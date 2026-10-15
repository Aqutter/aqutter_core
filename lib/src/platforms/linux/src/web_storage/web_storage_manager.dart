import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [LinuxWebStorageManager].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebStorageManagerCreationParams] for
/// more information.
class LinuxWebStorageManagerCreationParams
    extends AqutterPlatformWebStorageManagerCreationParams {
  /// Creates a new [LinuxWebStorageManagerCreationParams] instance.
  const LinuxWebStorageManagerCreationParams();

  /// Creates a [LinuxWebStorageManagerCreationParams] instance based on [AqutterPlatformWebStorageManagerCreationParams].
  factory LinuxWebStorageManagerCreationParams.fromPlatformWebStorageManagerCreationParams(
    AqutterPlatformWebStorageManagerCreationParams params,
  ) {
    return const LinuxWebStorageManagerCreationParams();
  }
}

/// Implementation of [AqutterPlatformWebStorageManager] for Linux using WPE WebKit.
///
/// Uses [WebKitWebsiteDataManager](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.WebsiteDataManager.html)
/// to manage website data.
class LinuxWebStorageManager extends AqutterPlatformWebStorageManager {
  static const MethodChannel _channel = MethodChannel(
    'com.github.aqutter/webview_webstoragemanager',
  );

  /// Constructs a [LinuxWebStorageManager].
  LinuxWebStorageManager(AqutterPlatformWebStorageManagerCreationParams params)
    : super.implementation(
        params is LinuxWebStorageManagerCreationParams
            ? params
            : LinuxWebStorageManagerCreationParams.fromPlatformWebStorageManagerCreationParams(
                params,
              ),
      );

  static final LinuxWebStorageManager _instance = LinuxWebStorageManager(
    const LinuxWebStorageManagerCreationParams(),
  );

  /// The [LinuxWebStorageManager] singleton instance.
  static LinuxWebStorageManager instance() => _instance;

  /// Creates and returns a new [LinuxWebStorageManager] for static methods.
  factory LinuxWebStorageManager.static() => _instance;

  /// Maps AqutterWebsiteDataType to WPE WebKit data type strings.
  static String _toWpeDataType(AqutterWebsiteDataType type) {
    if (type == AqutterWebsiteDataType.WKWebsiteDataTypeDiskCache) {
      return 'WEBKIT_WEBSITE_DATA_DISK_CACHE';
    } else if (type == AqutterWebsiteDataType.WKWebsiteDataTypeMemoryCache) {
      return 'WEBKIT_WEBSITE_DATA_MEMORY_CACHE';
    } else if (type ==
        AqutterWebsiteDataType.WKWebsiteDataTypeOfflineWebApplicationCache) {
      return 'WEBKIT_WEBSITE_DATA_OFFLINE_APPLICATION_CACHE';
    } else if (type == AqutterWebsiteDataType.WKWebsiteDataTypeCookies) {
      return 'WEBKIT_WEBSITE_DATA_COOKIES';
    } else if (type == AqutterWebsiteDataType.WKWebsiteDataTypeSessionStorage) {
      return 'WEBKIT_WEBSITE_DATA_SESSION_STORAGE';
    } else if (type == AqutterWebsiteDataType.WKWebsiteDataTypeLocalStorage) {
      return 'WEBKIT_WEBSITE_DATA_LOCAL_STORAGE';
    } else if (type == AqutterWebsiteDataType.WKWebsiteDataTypeIndexedDBDatabases) {
      return 'WEBKIT_WEBSITE_DATA_INDEXEDDB_DATABASES';
    } else if (type ==
        AqutterWebsiteDataType.WKWebsiteDataTypeServiceWorkerRegistrations) {
      return 'WEBKIT_WEBSITE_DATA_SERVICE_WORKER_REGISTRATIONS';
    } else if (type == AqutterWebsiteDataType.WKWebsiteDataTypeFetchCache) {
      // WPE uses same as disk cache for fetch cache
      return 'WEBKIT_WEBSITE_DATA_DISK_CACHE';
    } else if (type == AqutterWebsiteDataType.WKWebsiteDataTypeWebSQLDatabases) {
      // WebSQL is deprecated, map to local storage
      return 'WEBKIT_WEBSITE_DATA_LOCAL_STORAGE';
    }
    // Default fallback
    return 'WEBKIT_WEBSITE_DATA_LOCAL_STORAGE';
  }

  /// Maps WPE WebKit data type string to AqutterWebsiteDataType.
  static AqutterWebsiteDataType? _fromWpeDataType(String wpeType) {
    if (wpeType == 'WEBKIT_WEBSITE_DATA_DISK_CACHE') {
      return AqutterWebsiteDataType.WKWebsiteDataTypeDiskCache;
    } else if (wpeType == 'WEBKIT_WEBSITE_DATA_MEMORY_CACHE') {
      return AqutterWebsiteDataType.WKWebsiteDataTypeMemoryCache;
    } else if (wpeType == 'WEBKIT_WEBSITE_DATA_OFFLINE_APPLICATION_CACHE') {
      return AqutterWebsiteDataType.WKWebsiteDataTypeOfflineWebApplicationCache;
    } else if (wpeType == 'WEBKIT_WEBSITE_DATA_COOKIES') {
      return AqutterWebsiteDataType.WKWebsiteDataTypeCookies;
    } else if (wpeType == 'WEBKIT_WEBSITE_DATA_SESSION_STORAGE') {
      return AqutterWebsiteDataType.WKWebsiteDataTypeSessionStorage;
    } else if (wpeType == 'WEBKIT_WEBSITE_DATA_LOCAL_STORAGE') {
      return AqutterWebsiteDataType.WKWebsiteDataTypeLocalStorage;
    } else if (wpeType == 'WEBKIT_WEBSITE_DATA_INDEXEDDB_DATABASES') {
      return AqutterWebsiteDataType.WKWebsiteDataTypeIndexedDBDatabases;
    } else if (wpeType == 'WEBKIT_WEBSITE_DATA_SERVICE_WORKER_REGISTRATIONS') {
      return AqutterWebsiteDataType.WKWebsiteDataTypeServiceWorkerRegistrations;
    }
    return null;
  }

  @override
  Future<List<AqutterWebsiteDataRecord>> fetchDataRecords({
    required Set<AqutterWebsiteDataType> dataTypes,
  }) async {
    final List<String> wpeDataTypes = dataTypes
        .map((type) => _toWpeDataType(type))
        .toList();

    final result = await _channel.invokeMethod<List<dynamic>>(
      'fetchDataRecords',
      {'dataTypes': wpeDataTypes},
    );

    if (result == null) {
      return [];
    }

    return result.cast<Map<dynamic, dynamic>>().map((recordMap) {
      final String? displayName = recordMap['displayName'] as String?;
      final List<dynamic>? dataTypesRaw =
          recordMap['dataTypes'] as List<dynamic>?;

      Set<AqutterWebsiteDataType>? dataTypesSet;
      if (dataTypesRaw != null) {
        dataTypesSet = dataTypesRaw
            .cast<String>()
            .map((typeStr) => _fromWpeDataType(typeStr))
            .whereType<AqutterWebsiteDataType>()
            .toSet();
      }

      return AqutterWebsiteDataRecord(
        displayName: displayName,
        dataTypes: dataTypesSet,
      );
    }).toList();
  }

  @override
  Future<void> removeDataFor({
    required Set<AqutterWebsiteDataType> dataTypes,
    required List<AqutterWebsiteDataRecord> dataRecords,
  }) async {
    final List<String> wpeDataTypes = dataTypes
        .map((type) => _toWpeDataType(type))
        .toList();

    final List<Map<String, dynamic>> recordList = dataRecords.map((record) {
      return {
        'displayName': record.displayName,
        'dataTypes': record.dataTypes
            ?.map((type) => _toWpeDataType(type))
            .toList(),
      };
    }).toList();

    await _channel.invokeMethod('removeDataFor', {
      'dataTypes': wpeDataTypes,
      'recordList': recordList,
    });
  }

  @override
  Future<void> removeDataModifiedSince({
    required Set<AqutterWebsiteDataType> dataTypes,
    required DateTime date,
  }) async {
    final List<String> wpeDataTypes = dataTypes
        .map((type) => _toWpeDataType(type))
        .toList();

    // Convert DateTime to Unix timestamp (seconds since epoch)
    final int timestamp = date.millisecondsSinceEpoch ~/ 1000;

    await _channel.invokeMethod('removeDataModifiedSince', {
      'dataTypes': wpeDataTypes,
      'timestamp': timestamp,
    });
  }
}
