import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [IOSWebStorageManager].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebStorageManagerCreationParams] for
/// more information.
@immutable
class IOSWebStorageManagerCreationParams
    extends AqutterPlatformWebStorageManagerCreationParams {
  /// Creates a new [IOSWebStorageManagerCreationParams] instance.
  const IOSWebStorageManagerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebStorageManagerCreationParams params,
  ) : super();

  /// Creates a [IOSWebStorageManagerCreationParams] instance based on [AqutterPlatformWebStorageManagerCreationParams].
  factory IOSWebStorageManagerCreationParams.fromPlatformWebStorageManagerCreationParams(
    AqutterPlatformWebStorageManagerCreationParams params,
  ) {
    return IOSWebStorageManagerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformWebStorageManager}
class IOSWebStorageManager extends AqutterPlatformWebStorageManager
    with ChannelController {
  /// Creates a new [IOSWebStorageManager].
  IOSWebStorageManager(AqutterPlatformWebStorageManagerCreationParams params)
    : super.implementation(
        params is IOSWebStorageManagerCreationParams
            ? params
            : IOSWebStorageManagerCreationParams.fromPlatformWebStorageManagerCreationParams(
                params,
              ),
      ) {
    channel = const MethodChannel(
      'com.github.aqutter/webview_webstoragemanager',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }

  static IOSWebStorageManager? _instance;

  ///Gets the AqutterWebStorage manager shared instance.
  static IOSWebStorageManager instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static IOSWebStorageManager _init() {
    _instance = IOSWebStorageManager(
      IOSWebStorageManagerCreationParams(
        const AqutterPlatformWebStorageManagerCreationParams(),
      ),
    );
    return _instance!;
  }

  static IOSWebStorageManager? _static;

  /// Provide static access.
  factory IOSWebStorageManager.static() {
    _static ??= IOSWebStorageManager(
      IOSWebStorageManagerCreationParams(
        const AqutterPlatformWebStorageManagerCreationParams(),
      ),
    );
    return _static!;
  }

  Future<dynamic> _handleMethod(MethodCall call) async {}

  @override
  Future<List<AqutterWebsiteDataRecord>> fetchDataRecords({
    required Set<AqutterWebsiteDataType> dataTypes,
  }) async {
    List<AqutterWebsiteDataRecord> recordList = [];
    List<String> dataTypesList = [];
    for (var dataType in dataTypes) {
      if (dataType.isSupported()) {
        dataTypesList.add(dataType.toNativeValue()!);
      }
    }
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("dataTypes", () => dataTypesList);
    List<Map<dynamic, dynamic>> records =
        (await channel?.invokeMethod<List>(
          'fetchDataRecords',
          args,
        ))?.cast<Map<dynamic, dynamic>>() ??
        [];
    for (var record in records) {
      List<String> dataTypesString = record["dataTypes"].cast<String>();
      Set<AqutterWebsiteDataType> dataTypes = Set();
      for (var dataTypeValue in dataTypesString) {
        var dataType = AqutterWebsiteDataType.fromNativeValue(dataTypeValue);
        if (dataType != null) {
          dataTypes.add(dataType);
        }
      }
      recordList.add(
        AqutterWebsiteDataRecord(
          displayName: record["displayName"],
          dataTypes: dataTypes,
        ),
      );
    }
    return recordList;
  }

  @override
  Future<void> removeDataFor({
    required Set<AqutterWebsiteDataType> dataTypes,
    required List<AqutterWebsiteDataRecord> dataRecords,
  }) async {
    List<String> dataTypesList = [];
    for (var dataType in dataTypes) {
      if (dataType.isSupported()) {
        dataTypesList.add(dataType.toNativeValue()!);
      }
    }

    List<Map<String, dynamic>> recordList = [];
    for (var record in dataRecords) {
      recordList.add(record.toMap());
    }

    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("dataTypes", () => dataTypesList);
    args.putIfAbsent("recordList", () => recordList);
    await channel?.invokeMethod('removeDataFor', args);
  }

  @override
  Future<void> removeDataModifiedSince({
    required Set<AqutterWebsiteDataType> dataTypes,
    required DateTime date,
  }) async {
    List<String> dataTypesList = [];
    for (var dataType in dataTypes) {
      if (dataType.isSupported()) {
        dataTypesList.add(dataType.toNativeValue()!);
      }
    }

    var timestamp = date.millisecondsSinceEpoch;

    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("dataTypes", () => dataTypesList);
    args.putIfAbsent("timestamp", () => timestamp);
    await channel?.invokeMethod('removeDataModifiedSince', args);
  }

  @override
  void dispose() {
    // empty
  }
}
