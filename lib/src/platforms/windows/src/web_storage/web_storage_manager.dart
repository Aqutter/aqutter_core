import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [WindowsWebStorageManager].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebStorageManagerCreationParams] for
/// more information.
@immutable
class WindowsWebStorageManagerCreationParams
    extends AqutterPlatformWebStorageManagerCreationParams {
  /// Creates a new [WindowsWebStorageManagerCreationParams] instance.
  const WindowsWebStorageManagerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebStorageManagerCreationParams params,
  ) : super();

  /// Creates a [WindowsWebStorageManagerCreationParams] instance based on [AqutterPlatformWebStorageManagerCreationParams].
  factory WindowsWebStorageManagerCreationParams.fromPlatformWebStorageManagerCreationParams(
    AqutterPlatformWebStorageManagerCreationParams params,
  ) {
    return WindowsWebStorageManagerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformWebStorageManager}
class WindowsWebStorageManager extends AqutterPlatformWebStorageManager
    with ChannelController {
  /// Creates a new [WindowsWebStorageManager].
  WindowsWebStorageManager(AqutterPlatformWebStorageManagerCreationParams params)
    : super.implementation(
        params is WindowsWebStorageManagerCreationParams
            ? params
            : WindowsWebStorageManagerCreationParams.fromPlatformWebStorageManagerCreationParams(
                params,
              ),
      ) {
    channel = const MethodChannel(
      'com.github.aqutter/webview_webstoragemanager',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }

  static WindowsWebStorageManager? _instance;

  ///Gets the AqutterWebStorage manager shared instance.
  static WindowsWebStorageManager instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static WindowsWebStorageManager _init() {
    _instance = WindowsWebStorageManager(
      WindowsWebStorageManagerCreationParams(
        const AqutterPlatformWebStorageManagerCreationParams(),
      ),
    );
    return _instance!;
  }

  static WindowsWebStorageManager? _static;

  /// Provide static access.
  factory WindowsWebStorageManager.static() {
    _static ??= WindowsWebStorageManager(
      WindowsWebStorageManagerCreationParams(
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
