import 'dart:async';

import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../web_storage_manager.dart';

///Class that represents various types of data that a website might make use of.
///This includes cookies, disk and memory caches, and persistent data such as WebSQL, IndexedDB databases, and local storage.
///
///**NOTE**: available on iOS 9.0+.
///
///Use [AqutterWebStorageManager] instead.
@Deprecated("Use AqutterWebStorageManager instead")
class AqutterIOSWebStorageManager {
  ///Fetches data records containing the given website data types.
  ///
  ///[dataTypes] represents the website data types to fetch records for.
  Future<List<AqutterIOSWKWebsiteDataRecord>> fetchDataRecords({
    required Set<AqutterIOSWKWebsiteDataType> dataTypes,
  }) async {
    List<AqutterIOSWKWebsiteDataRecord> recordList = [];
    Set<AqutterWebsiteDataType> dataTypesList = Set();
    for (var dataType in dataTypes) {
      dataTypesList.add(
        AqutterWebsiteDataType.fromNativeValue(dataType.toNativeValue())!,
      );
    }

    List<AqutterWebsiteDataRecord> records = await AqutterWebStorageManager.instance()
        .fetchDataRecords(dataTypes: dataTypesList);

    for (var record in records) {
      Set<AqutterWebsiteDataType> dataTypesString = record.dataTypes ?? Set();
      Set<AqutterIOSWKWebsiteDataType> dataTypes = Set();
      for (var dataTypeValue in dataTypesString) {
        var dataType = AqutterIOSWKWebsiteDataType.fromNativeValue(
          dataTypeValue.toNativeValue(),
        );
        if (dataType != null) {
          dataTypes.add(dataType);
        }
      }
      recordList.add(
        AqutterIOSWKWebsiteDataRecord(
          displayName: record.displayName,
          dataTypes: dataTypes,
        ),
      );
    }
    return recordList;
  }

  ///Removes website data of the given types for the given data records.
  ///
  ///[dataTypes] represents the website data types that should be removed.
  ///
  ///[dataRecords] represents the website data records to delete website data for.
  Future<void> removeDataFor({
    required Set<AqutterIOSWKWebsiteDataType> dataTypes,
    required List<AqutterIOSWKWebsiteDataRecord> dataRecords,
  }) async {
    Set<AqutterWebsiteDataType> dataTypesList = Set();
    for (var dataType in dataTypes) {
      dataTypesList.add(
        AqutterWebsiteDataType.fromNativeValue(dataType.toNativeValue())!,
      );
    }

    List<AqutterWebsiteDataRecord> recordList = [];
    for (var record in dataRecords) {
      recordList.add(AqutterWebsiteDataRecord.fromMap(record.toMap())!);
    }

    await AqutterWebStorageManager.instance().removeDataFor(
      dataRecords: recordList,
      dataTypes: dataTypesList,
    );
  }

  ///Removes all website data of the given types that has been modified since the given date.
  ///
  ///[dataTypes] represents the website data types that should be removed.
  ///
  ///[date] represents a date. All website data modified after this date will be removed.
  Future<void> removeDataModifiedSince({
    required Set<AqutterIOSWKWebsiteDataType> dataTypes,
    required DateTime date,
  }) async {
    Set<AqutterWebsiteDataType> dataTypesList = Set();
    for (var dataType in dataTypes) {
      dataTypesList.add(
        AqutterWebsiteDataType.fromNativeValue(dataType.toNativeValue())!,
      );
    }

    await AqutterWebStorageManager.instance().removeDataModifiedSince(
      dataTypes: dataTypesList,
      date: date,
    );
  }
}
