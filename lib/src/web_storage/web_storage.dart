import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../webview/webview_controller.dart';

///{@macro aqutter_core.AqutterPlatformWebStorage}
///
///{@macro aqutter_core.AqutterPlatformWebStorage.supported_platforms}
class AqutterWebStorage {
  ///{@macro aqutter_core.AqutterPlatformWebStorage}
  AqutterWebStorage({
    required AqutterPlatformLocalStorage localStorage,
    required AqutterPlatformSessionStorage sessionStorage,
  }) : this.fromPlatformCreationParams(
         params: AqutterPlatformWebStorageCreationParams(
           localStorage: localStorage,
           sessionStorage: sessionStorage,
         ),
       );

  /// Constructs a [AqutterWebStorage].
  ///
  /// See [AqutterWebStorage.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterWebStorage.fromPlatformCreationParams({
    required AqutterPlatformWebStorageCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformWebStorage(params));

  /// Constructs a [AqutterWebStorage] from a specific platform implementation.
  AqutterWebStorage.fromPlatform({required this.platform});

  /// Implementation of [AqutterPlatformWebStorage] for the current platform.
  final AqutterPlatformWebStorage platform;

  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformWebStorage.static().isClassSupported(platform: platform);

  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isPropertySupported(
    dynamic property, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebStorage.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isMethodSupported(
    AqutterPlatformWebStorageMethod method, {
    TargetPlatform? platform,
  }) =>
      AqutterPlatformWebStorage.static().isMethodSupported(method, platform: platform);

  ///{@macro aqutter_core.AqutterPlatformWebStorage.localStorage}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorage.localStorage.supported_platforms}
  AqutterLocalStorage get localStorage =>
      AqutterLocalStorage.fromPlatform(platform: platform.localStorage);

  ///{@macro aqutter_core.AqutterPlatformWebStorage.sessionStorage}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorage.sessionStorage.supported_platforms}
  AqutterSessionStorage get sessionStorage =>
      AqutterSessionStorage.fromPlatform(platform: platform.sessionStorage);

  ///{@macro aqutter_core.AqutterPlatformWebStorage.dispose}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorage.dispose.supported_platforms}
  void dispose() => platform.dispose();
}

///{@macro aqutter_core.AqutterPlatformStorage}
///
///{@macro aqutter_core.AqutterPlatformStorage.supported_platforms}
abstract class AqutterStorage implements AqutterPlatformStorage {
  /// Constructs a [AqutterStorage] from a specific platform implementation.
  AqutterStorage.fromPlatform({required this.platform});

  /// Implementation of [AqutterPlatformStorage] for the current platform.
  final AqutterPlatformStorage platform;

  ///{@macro aqutter_core.AqutterPlatformStorage.controller}
  ///
  ///{@macro aqutter_core.AqutterPlatformStorage.controller.supported_platforms}
  AqutterPlatformWebViewController? get controller => platform.controller;

  ///{@macro aqutter_core.AqutterPlatformStorage.webStorageType}
  ///
  ///{@macro aqutter_core.AqutterPlatformStorage.webStorageType.supported_platforms}
  AqutterWebStorageType get webStorageType => platform.webStorageType;

  ///{@macro aqutter_core.AqutterPlatformStorage.length}
  ///
  ///{@macro aqutter_core.AqutterPlatformStorage.length.supported_platforms}
  Future<int?> length() => platform.length();

  ///{@macro aqutter_core.AqutterPlatformStorage.setItem}
  ///
  ///{@macro aqutter_core.AqutterPlatformStorage.setItem.supported_platforms}
  Future<void> setItem({required String key, required dynamic value}) =>
      platform.setItem(key: key, value: value);

  ///{@macro aqutter_core.AqutterPlatformStorage.getItem}
  ///
  ///{@macro aqutter_core.AqutterPlatformStorage.getItem.supported_platforms}
  Future<dynamic> getItem({required String key}) => platform.getItem(key: key);

  ///{@macro aqutter_core.AqutterPlatformStorage.removeItem}
  ///
  ///{@macro aqutter_core.AqutterPlatformStorage.removeItem.supported_platforms}
  Future<void> removeItem({required String key}) =>
      platform.removeItem(key: key);

  ///{@macro aqutter_core.AqutterPlatformStorage.getItems}
  ///
  ///{@macro aqutter_core.AqutterPlatformStorage.getItems.supported_platforms}
  Future<List<AqutterWebStorageItem>> getItems() => platform.getItems();

  ///{@macro aqutter_core.AqutterPlatformStorage.clear}
  ///
  ///{@macro aqutter_core.AqutterPlatformStorage.clear.supported_platforms}
  Future<void> clear() => platform.clear();

  ///{@macro aqutter_core.AqutterPlatformStorage.key}
  ///
  ///{@macro aqutter_core.AqutterPlatformStorage.key.supported_platforms}
  Future<String> key({required int index}) => platform.key(index: index);

  ///{@macro aqutter_core.AqutterPlatformStorage.dispose}
  ///
  ///{@macro aqutter_core.AqutterPlatformStorage.dispose.supported_platforms}
  void dispose() => platform.dispose();
}

///{@macro aqutter_core.AqutterPlatformLocalStorage}
///
///{@macro aqutter_core.AqutterPlatformLocalStorage.supported_platforms}
class AqutterLocalStorage extends AqutterStorage {
  ///{@macro aqutter_core.AqutterPlatformLocalStorage}
  AqutterLocalStorage({required AqutterWebViewController? controller})
    : this.fromPlatformCreationParams(
        params: AqutterPlatformLocalStorageCreationParams(
          AqutterPlatformStorageCreationParams(
            controller: controller?.platform,
            webStorageType: AqutterWebStorageType.LOCAL_STORAGE,
          ),
        ),
      );

  /// Constructs a [AqutterLocalStorage].
  ///
  /// See [AqutterLocalStorage.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterLocalStorage.fromPlatformCreationParams({
    required AqutterPlatformLocalStorageCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformLocalStorage(params));

  /// Constructs a [AqutterLocalStorage] from a specific platform implementation.
  AqutterLocalStorage.fromPlatform({required this.platform})
    : super.fromPlatform(platform: platform);

  /// Implementation of [AqutterPlatformLocalStorage] for the current platform.
  final AqutterPlatformLocalStorage platform;

  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformLocalStorage.static().isClassSupported(platform: platform);

  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isPropertySupported(
    AqutterPlatformStorageCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => AqutterPlatformLocalStorage.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isMethodSupported(
    AqutterPlatformLocalStorageMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformLocalStorage.static().isMethodSupported(
    method,
    platform: platform,
  );
}

///{@macro aqutter_core.AqutterPlatformSessionStorage}
///
///{@macro aqutter_core.AqutterPlatformSessionStorage.supported_platforms}
class AqutterSessionStorage extends AqutterStorage {
  ///{@macro aqutter_core.AqutterPlatformSessionStorage}
  AqutterSessionStorage({required AqutterWebViewController? controller})
    : this.fromPlatformCreationParams(
        params: AqutterPlatformSessionStorageCreationParams(
          AqutterPlatformStorageCreationParams(
            controller: controller?.platform,
            webStorageType: AqutterWebStorageType.SESSION_STORAGE,
          ),
        ),
      );

  /// Constructs a [AqutterSessionStorage].
  ///
  /// See [AqutterSessionStorage.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterSessionStorage.fromPlatformCreationParams({
    required AqutterPlatformSessionStorageCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformSessionStorage(params));

  /// Constructs a [AqutterSessionStorage] from a specific platform implementation.
  AqutterSessionStorage.fromPlatform({required this.platform})
    : super.fromPlatform(platform: platform);

  /// Implementation of [AqutterPlatformSessionStorage] for the current platform.
  final AqutterPlatformSessionStorage platform;

  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformSessionStorage.static().isClassSupported(platform: platform);

  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isPropertySupported(
    AqutterPlatformStorageCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => AqutterPlatformSessionStorage.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isMethodSupported(
    AqutterPlatformSessionStorageMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformSessionStorage.static().isMethodSupported(
    method,
    platform: platform,
  );
}
