import 'dart:convert';

import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../webview/webview_controller.dart';

/// Object specifying creation parameters for creating a [IOSWebStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebStorageCreationParams] for
/// more information.
class IOSWebStorageCreationParams extends AqutterPlatformWebStorageCreationParams {
  /// Creates a new [IOSWebStorageCreationParams] instance.
  IOSWebStorageCreationParams({
    required super.localStorage,
    required super.sessionStorage,
  });

  /// Creates a [IOSWebStorageCreationParams] instance based on [AqutterPlatformWebStorageCreationParams].
  factory IOSWebStorageCreationParams.fromPlatformWebStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebStorageCreationParams params,
  ) {
    return IOSWebStorageCreationParams(
      localStorage: params.localStorage,
      sessionStorage: params.sessionStorage,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformWebStorage}
class IOSWebStorage extends AqutterPlatformWebStorage {
  /// Constructs a [IOSWebStorage].
  IOSWebStorage(AqutterPlatformWebStorageCreationParams params)
    : super.implementation(
        params is IOSWebStorageCreationParams
            ? params
            : IOSWebStorageCreationParams.fromPlatformWebStorageCreationParams(
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

/// Object specifying creation parameters for creating a [IOSStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformStorageCreationParams] for
/// more information.
class IOSStorageCreationParams extends AqutterPlatformStorageCreationParams {
  /// Creates a new [IOSStorageCreationParams] instance.
  IOSStorageCreationParams({
    required super.controller,
    required super.webStorageType,
  });

  /// Creates a [IOSStorageCreationParams] instance based on [AqutterPlatformStorageCreationParams].
  factory IOSStorageCreationParams.fromPlatformStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformStorageCreationParams params,
  ) {
    return IOSStorageCreationParams(
      controller: params.controller,
      webStorageType: params.webStorageType,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformStorage}
abstract mixin class IOSStorage implements AqutterPlatformStorage {
  @override
  AqutterIOSWebViewControllerImpl? controller;

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

/// Object specifying creation parameters for creating a [IOSLocalStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformLocalStorageCreationParams] for
/// more information.
class IOSLocalStorageCreationParams extends AqutterPlatformLocalStorageCreationParams {
  /// Creates a new [IOSLocalStorageCreationParams] instance.
  IOSLocalStorageCreationParams(super.params);

  /// Creates a [IOSLocalStorageCreationParams] instance based on [AqutterPlatformLocalStorageCreationParams].
  factory IOSLocalStorageCreationParams.fromPlatformLocalStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    return IOSLocalStorageCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformLocalStorage}
class IOSLocalStorage extends AqutterPlatformLocalStorage with IOSStorage {
  /// Constructs a [IOSLocalStorage].
  IOSLocalStorage(AqutterPlatformLocalStorageCreationParams params)
    : super.implementation(
        params is IOSLocalStorageCreationParams
            ? params
            : IOSLocalStorageCreationParams.fromPlatformLocalStorageCreationParams(
                params,
              ),
      );

  /// Default storage
  factory IOSLocalStorage.defaultStorage({
    required AqutterPlatformWebViewController? controller,
  }) {
    return IOSLocalStorage(
      IOSLocalStorageCreationParams(
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
  AqutterIOSWebViewControllerImpl? get controller =>
      params.controller as AqutterIOSWebViewControllerImpl?;
}

/// Object specifying creation parameters for creating a [IOSSessionStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformSessionStorageCreationParams] for
/// more information.
class IOSSessionStorageCreationParams
    extends AqutterPlatformSessionStorageCreationParams {
  /// Creates a new [IOSSessionStorageCreationParams] instance.
  IOSSessionStorageCreationParams(super.params);

  /// Creates a [IOSSessionStorageCreationParams] instance based on [AqutterPlatformSessionStorageCreationParams].
  factory IOSSessionStorageCreationParams.fromPlatformSessionStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    return IOSSessionStorageCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformSessionStorage}
class IOSSessionStorage extends AqutterPlatformSessionStorage with IOSStorage {
  /// Constructs a [IOSSessionStorage].
  IOSSessionStorage(AqutterPlatformSessionStorageCreationParams params)
    : super.implementation(
        params is IOSSessionStorageCreationParams
            ? params
            : IOSSessionStorageCreationParams.fromPlatformSessionStorageCreationParams(
                params,
              ),
      );

  /// Default storage
  factory IOSSessionStorage.defaultStorage({
    required AqutterPlatformWebViewController? controller,
  }) {
    return IOSSessionStorage(
      IOSSessionStorageCreationParams(
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
  AqutterIOSWebViewControllerImpl? get controller =>
      params.controller as AqutterIOSWebViewControllerImpl?;
}
