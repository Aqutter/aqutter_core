import 'dart:convert';

import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../webview/webview_controller.dart';

/// Object specifying creation parameters for creating a [WindowsWebStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebStorageCreationParams] for
/// more information.
class WindowsWebStorageCreationParams extends AqutterPlatformWebStorageCreationParams {
  /// Creates a new [WindowsWebStorageCreationParams] instance.
  WindowsWebStorageCreationParams({
    required super.localStorage,
    required super.sessionStorage,
  });

  /// Creates a [WindowsWebStorageCreationParams] instance based on [AqutterPlatformWebStorageCreationParams].
  factory WindowsWebStorageCreationParams.fromPlatformWebStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebStorageCreationParams params,
  ) {
    return WindowsWebStorageCreationParams(
      localStorage: params.localStorage,
      sessionStorage: params.sessionStorage,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformWebStorage}
class WindowsWebStorage extends AqutterPlatformWebStorage {
  /// Constructs a [WindowsWebStorage].
  WindowsWebStorage(AqutterPlatformWebStorageCreationParams params)
    : super.implementation(
        params is WindowsWebStorageCreationParams
            ? params
            : WindowsWebStorageCreationParams.fromPlatformWebStorageCreationParams(
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

/// Object specifying creation parameters for creating a [WindowsStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformStorageCreationParams] for
/// more information.
class WindowsStorageCreationParams extends AqutterPlatformStorageCreationParams {
  /// Creates a new [WindowsStorageCreationParams] instance.
  WindowsStorageCreationParams({
    required super.controller,
    required super.webStorageType,
  });

  /// Creates a [WindowsStorageCreationParams] instance based on [AqutterPlatformStorageCreationParams].
  factory WindowsStorageCreationParams.fromPlatformStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformStorageCreationParams params,
  ) {
    return WindowsStorageCreationParams(
      controller: params.controller,
      webStorageType: params.webStorageType,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformStorage}
abstract mixin class WindowsStorage implements AqutterPlatformStorage {
  @override
  AqutterWindowsWebViewController? controller;

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

/// Object specifying creation parameters for creating a [WindowsLocalStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformLocalStorageCreationParams] for
/// more information.
class WindowsLocalStorageCreationParams
    extends AqutterPlatformLocalStorageCreationParams {
  /// Creates a new [WindowsLocalStorageCreationParams] instance.
  WindowsLocalStorageCreationParams(super.params);

  /// Creates a [WindowsLocalStorageCreationParams] instance based on [AqutterPlatformLocalStorageCreationParams].
  factory WindowsLocalStorageCreationParams.fromPlatformLocalStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    return WindowsLocalStorageCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformLocalStorage}
class WindowsLocalStorage extends AqutterPlatformLocalStorage with WindowsStorage {
  /// Constructs a [WindowsLocalStorage].
  WindowsLocalStorage(AqutterPlatformLocalStorageCreationParams params)
    : super.implementation(
        params is WindowsLocalStorageCreationParams
            ? params
            : WindowsLocalStorageCreationParams.fromPlatformLocalStorageCreationParams(
                params,
              ),
      );

  /// Default storage
  factory WindowsLocalStorage.defaultStorage({
    required AqutterPlatformWebViewController? controller,
  }) {
    return WindowsLocalStorage(
      WindowsLocalStorageCreationParams(
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
  AqutterWindowsWebViewController? get controller =>
      params.controller as AqutterWindowsWebViewController?;
}

/// Object specifying creation parameters for creating a [WindowsSessionStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformSessionStorageCreationParams] for
/// more information.
class WindowsSessionStorageCreationParams
    extends AqutterPlatformSessionStorageCreationParams {
  /// Creates a new [WindowsSessionStorageCreationParams] instance.
  WindowsSessionStorageCreationParams(super.params);

  /// Creates a [WindowsSessionStorageCreationParams] instance based on [AqutterPlatformSessionStorageCreationParams].
  factory WindowsSessionStorageCreationParams.fromPlatformSessionStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    return WindowsSessionStorageCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformSessionStorage}
class WindowsSessionStorage extends AqutterPlatformSessionStorage with WindowsStorage {
  /// Constructs a [WindowsSessionStorage].
  WindowsSessionStorage(AqutterPlatformSessionStorageCreationParams params)
    : super.implementation(
        params is WindowsSessionStorageCreationParams
            ? params
            : WindowsSessionStorageCreationParams.fromPlatformSessionStorageCreationParams(
                params,
              ),
      );

  /// Default storage
  factory WindowsSessionStorage.defaultStorage({
    required AqutterPlatformWebViewController? controller,
  }) {
    return WindowsSessionStorage(
      WindowsSessionStorageCreationParams(
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
  AqutterWindowsWebViewController? get controller =>
      params.controller as AqutterWindowsWebViewController?;
}
