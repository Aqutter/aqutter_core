import 'dart:convert';

import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../webview/webview_controller.dart';

/// Object specifying creation parameters for creating a [LinuxWebStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebStorageCreationParams] for
/// more information.
class LinuxWebStorageCreationParams extends AqutterPlatformWebStorageCreationParams {
  /// Creates a new [LinuxWebStorageCreationParams] instance.
  LinuxWebStorageCreationParams({
    required super.localStorage,
    required super.sessionStorage,
  });

  /// Creates a [LinuxWebStorageCreationParams] instance based on [AqutterPlatformWebStorageCreationParams].
  factory LinuxWebStorageCreationParams.fromPlatformWebStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebStorageCreationParams params,
  ) {
    return LinuxWebStorageCreationParams(
      localStorage: params.localStorage,
      sessionStorage: params.sessionStorage,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformWebStorage}
class LinuxWebStorage extends AqutterPlatformWebStorage {
  /// Constructs a [LinuxWebStorage].
  LinuxWebStorage(AqutterPlatformWebStorageCreationParams params)
    : super.implementation(
        params is LinuxWebStorageCreationParams
            ? params
            : LinuxWebStorageCreationParams.fromPlatformWebStorageCreationParams(
                params,
              ),
      );

  @override
  AqutterPlatformLocalStorage get localStorage => params.localStorage;

  @override
  AqutterPlatformSessionStorage get sessionStorage => params.sessionStorage;

  @override
  void dispose() {
    localStorage.dispose();
    sessionStorage.dispose();
  }
}

/// Object specifying creation parameters for creating a [LinuxStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformStorageCreationParams] for
/// more information.
class LinuxStorageCreationParams extends AqutterPlatformStorageCreationParams {
  /// Creates a new [LinuxStorageCreationParams] instance.
  LinuxStorageCreationParams({
    required super.controller,
    required super.webStorageType,
  });

  /// Creates a [LinuxStorageCreationParams] instance based on [AqutterPlatformStorageCreationParams].
  factory LinuxStorageCreationParams.fromPlatformStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformStorageCreationParams params,
  ) {
    return LinuxStorageCreationParams(
      controller: params.controller,
      webStorageType: params.webStorageType,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformStorage}
abstract mixin class LinuxStorage implements AqutterPlatformStorage {
  @override
  AqutterLinuxWebViewController? controller;

  @override
  Future<int?> length() async {
    var result = await controller?.evaluateJavascript(
      source:
          """
    window.$webStorageType.length;
    """,
    );
    return result != null ? int.parse(json.decode(result)) : null;
  }

  @override
  Future<void> setItem({required String key, required dynamic value}) async {
    var encodedValue = json.encode(value);
    await controller?.evaluateJavascript(
      source:
          """
    window.$webStorageType.setItem("$key", ${value is String ? encodedValue : "JSON.stringify($encodedValue)"});
    """,
    );
  }

  @override
  Future<dynamic> getItem({required String key}) async {
    var itemValue = await controller?.evaluateJavascript(
      source:
          """
    window.$webStorageType.getItem("$key");
    """,
    );

    if (itemValue == null) {
      return null;
    }

    try {
      return json.decode(itemValue);
    } catch (e) {}

    return itemValue;
  }

  @override
  Future<void> removeItem({required String key}) async {
    await controller?.evaluateJavascript(
      source:
          """
    window.$webStorageType.removeItem("$key");
    """,
    );
  }

  @override
  Future<List<AqutterWebStorageItem>> getItems() async {
    var webStorageItems = <AqutterWebStorageItem>[];

    List<Map<dynamic, dynamic>>? items = (await controller?.evaluateJavascript(
      source:
          """
(function() {
  var webStorageItems = [];
  for(var i = 0; i < window.$webStorageType.length; i++){
    var key = window.$webStorageType.key(i);
    webStorageItems.push(
      {
        key: key,
        value: window.$webStorageType.getItem(key)
      }
    );
  }
  return webStorageItems;
})();
    """,
    ))?.cast<Map<dynamic, dynamic>>();

    if (items == null) {
      return webStorageItems;
    }

    for (var item in items) {
      webStorageItems.add(
        AqutterWebStorageItem(key: item["key"], value: item["value"]),
      );
    }

    return webStorageItems;
  }

  @override
  Future<void> clear() async {
    await controller?.evaluateJavascript(
      source:
          """
    window.$webStorageType.clear();
    """,
    );
  }

  @override
  Future<String> key({required int index}) async {
    var result = await controller?.evaluateJavascript(
      source:
          """
    window.$webStorageType.key($index);
    """,
    );
    return result != null ? json.decode(result) : null;
  }

  @override
  void dispose() {
    controller = null;
  }
}

/// Object specifying creation parameters for creating a [LinuxLocalStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformLocalStorageCreationParams] for
/// more information.
class LinuxLocalStorageCreationParams extends AqutterPlatformLocalStorageCreationParams {
  /// Creates a new [LinuxLocalStorageCreationParams] instance.
  LinuxLocalStorageCreationParams(super.params);

  /// Creates a [LinuxLocalStorageCreationParams] instance based on [AqutterPlatformLocalStorageCreationParams].
  factory LinuxLocalStorageCreationParams.fromPlatformLocalStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    return LinuxLocalStorageCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformLocalStorage}
class LinuxLocalStorage extends AqutterPlatformLocalStorage with LinuxStorage {
  /// Constructs a [LinuxLocalStorage].
  LinuxLocalStorage(AqutterPlatformLocalStorageCreationParams params)
    : super.implementation(
        params is LinuxLocalStorageCreationParams
            ? params
            : LinuxLocalStorageCreationParams.fromPlatformLocalStorageCreationParams(
                params,
              ),
      );

  /// Default storage
  factory LinuxLocalStorage.defaultStorage({
    required AqutterPlatformWebViewController? controller,
  }) {
    return LinuxLocalStorage(
      LinuxLocalStorageCreationParams(
        AqutterPlatformLocalStorageCreationParams(
          AqutterPlatformStorageCreationParams(
            controller: controller,
            webStorageType: AqutterWebStorageType.LOCAL_STORAGE,
          ),
        ),
      ),
    );
  }

  @override
  AqutterLinuxWebViewController? get controller =>
      params.controller as AqutterLinuxWebViewController?;
}

/// Object specifying creation parameters for creating a [LinuxSessionStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformSessionStorageCreationParams] for
/// more information.
class LinuxSessionStorageCreationParams
    extends AqutterPlatformSessionStorageCreationParams {
  /// Creates a new [LinuxSessionStorageCreationParams] instance.
  LinuxSessionStorageCreationParams(super.params);

  /// Creates a [LinuxSessionStorageCreationParams] instance based on [AqutterPlatformSessionStorageCreationParams].
  factory LinuxSessionStorageCreationParams.fromPlatformSessionStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    return LinuxSessionStorageCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformSessionStorage}
class LinuxSessionStorage extends AqutterPlatformSessionStorage with LinuxStorage {
  /// Constructs a [LinuxSessionStorage].
  LinuxSessionStorage(AqutterPlatformSessionStorageCreationParams params)
    : super.implementation(
        params is LinuxSessionStorageCreationParams
            ? params
            : LinuxSessionStorageCreationParams.fromPlatformSessionStorageCreationParams(
                params,
              ),
      );

  /// Default storage
  factory LinuxSessionStorage.defaultStorage({
    required AqutterPlatformWebViewController? controller,
  }) {
    return LinuxSessionStorage(
      LinuxSessionStorageCreationParams(
        AqutterPlatformSessionStorageCreationParams(
          AqutterPlatformStorageCreationParams(
            controller: controller,
            webStorageType: AqutterWebStorageType.SESSION_STORAGE,
          ),
        ),
      ),
    );
  }

  @override
  AqutterLinuxWebViewController? get controller =>
      params.controller as AqutterLinuxWebViewController?;
}
