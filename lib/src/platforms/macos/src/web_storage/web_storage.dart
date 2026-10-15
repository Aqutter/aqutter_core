import 'dart:convert';

import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../webview/webview_controller.dart';

/// Object specifying creation parameters for creating a [MacOSWebStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebStorageCreationParams] for
/// more information.
class MacOSWebStorageCreationParams extends AqutterPlatformWebStorageCreationParams {
  /// Creates a new [MacOSWebStorageCreationParams] instance.
  MacOSWebStorageCreationParams({
    required super.localStorage,
    required super.sessionStorage,
  });

  /// Creates a [MacOSWebStorageCreationParams] instance based on [AqutterPlatformWebStorageCreationParams].
  factory MacOSWebStorageCreationParams.fromPlatformWebStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebStorageCreationParams params,
  ) {
    return MacOSWebStorageCreationParams(
      localStorage: params.localStorage,
      sessionStorage: params.sessionStorage,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformWebStorage}
class MacOSWebStorage extends AqutterPlatformWebStorage {
  /// Constructs a [MacOSWebStorage].
  MacOSWebStorage(AqutterPlatformWebStorageCreationParams params)
    : super.implementation(
        params is MacOSWebStorageCreationParams
            ? params
            : MacOSWebStorageCreationParams.fromPlatformWebStorageCreationParams(
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

/// Object specifying creation parameters for creating a [MacOSStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformStorageCreationParams] for
/// more information.
class MacOSStorageCreationParams extends AqutterPlatformStorageCreationParams {
  /// Creates a new [MacOSStorageCreationParams] instance.
  MacOSStorageCreationParams({
    required super.controller,
    required super.webStorageType,
  });

  /// Creates a [MacOSStorageCreationParams] instance based on [AqutterPlatformStorageCreationParams].
  factory MacOSStorageCreationParams.fromPlatformStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformStorageCreationParams params,
  ) {
    return MacOSStorageCreationParams(
      controller: params.controller,
      webStorageType: params.webStorageType,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformStorage}
abstract mixin class MacOSStorage implements AqutterPlatformStorage {
  @override
  AqutterMacOSWebViewController? controller;

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

/// Object specifying creation parameters for creating a [MacOSLocalStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformLocalStorageCreationParams] for
/// more information.
class MacOSLocalStorageCreationParams
    extends AqutterPlatformLocalStorageCreationParams {
  /// Creates a new [MacOSLocalStorageCreationParams] instance.
  MacOSLocalStorageCreationParams(super.params);

  /// Creates a [MacOSLocalStorageCreationParams] instance based on [AqutterPlatformLocalStorageCreationParams].
  factory MacOSLocalStorageCreationParams.fromPlatformLocalStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    return MacOSLocalStorageCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformLocalStorage}
class MacOSLocalStorage extends AqutterPlatformLocalStorage with MacOSStorage {
  /// Constructs a [MacOSLocalStorage].
  MacOSLocalStorage(AqutterPlatformLocalStorageCreationParams params)
    : super.implementation(
        params is MacOSLocalStorageCreationParams
            ? params
            : MacOSLocalStorageCreationParams.fromPlatformLocalStorageCreationParams(
                params,
              ),
      );

  /// Default storage
  factory MacOSLocalStorage.defaultStorage({
    required AqutterPlatformWebViewController? controller,
  }) {
    return MacOSLocalStorage(
      MacOSLocalStorageCreationParams(
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
  AqutterMacOSWebViewController? get controller =>
      params.controller as AqutterMacOSWebViewController?;
}

/// Object specifying creation parameters for creating a [MacOSSessionStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformSessionStorageCreationParams] for
/// more information.
class MacOSSessionStorageCreationParams
    extends AqutterPlatformSessionStorageCreationParams {
  /// Creates a new [MacOSSessionStorageCreationParams] instance.
  MacOSSessionStorageCreationParams(super.params);

  /// Creates a [MacOSSessionStorageCreationParams] instance based on [AqutterPlatformSessionStorageCreationParams].
  factory MacOSSessionStorageCreationParams.fromPlatformSessionStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    return MacOSSessionStorageCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformSessionStorage}
class MacOSSessionStorage extends AqutterPlatformSessionStorage with MacOSStorage {
  /// Constructs a [MacOSSessionStorage].
  MacOSSessionStorage(AqutterPlatformSessionStorageCreationParams params)
    : super.implementation(
        params is MacOSSessionStorageCreationParams
            ? params
            : MacOSSessionStorageCreationParams.fromPlatformSessionStorageCreationParams(
                params,
              ),
      );

  /// Default storage
  factory MacOSSessionStorage.defaultStorage({
    required AqutterPlatformWebViewController? controller,
  }) {
    return MacOSSessionStorage(
      MacOSSessionStorageCreationParams(
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
  AqutterMacOSWebViewController? get controller =>
      params.controller as AqutterMacOSWebViewController?;
}
