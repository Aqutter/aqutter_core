import 'dart:convert';

import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../webview/webview_controller.dart';

/// Object specifying creation parameters for creating a [AndroidWebStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebStorageCreationParams] for
/// more information.
class AndroidWebStorageCreationParams extends AqutterPlatformWebStorageCreationParams {
  /// Creates a new [AndroidWebStorageCreationParams] instance.
  AndroidWebStorageCreationParams({
    required super.localStorage,
    required super.sessionStorage,
  });

  /// Creates a [AndroidWebStorageCreationParams] instance based on [AqutterPlatformWebStorageCreationParams].
  factory AndroidWebStorageCreationParams.fromPlatformWebStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebStorageCreationParams params,
  ) {
    return AndroidWebStorageCreationParams(
      localStorage: params.localStorage,
      sessionStorage: params.sessionStorage,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformWebStorage}
class AndroidWebStorage extends AqutterPlatformWebStorage {
  /// Constructs a [AndroidWebStorage].
  AndroidWebStorage(AqutterPlatformWebStorageCreationParams params)
    : super.implementation(
        params is AndroidWebStorageCreationParams
            ? params
            : AndroidWebStorageCreationParams.fromPlatformWebStorageCreationParams(
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

/// Object specifying creation parameters for creating a [AndroidStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformStorageCreationParams] for
/// more information.
class AndroidStorageCreationParams extends AqutterPlatformStorageCreationParams {
  /// Creates a new [AndroidStorageCreationParams] instance.
  AndroidStorageCreationParams({
    required super.controller,
    required super.webStorageType,
  });

  /// Creates a [AndroidStorageCreationParams] instance based on [AqutterPlatformStorageCreationParams].
  factory AndroidStorageCreationParams.fromPlatformStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformStorageCreationParams params,
  ) {
    return AndroidStorageCreationParams(
      controller: params.controller,
      webStorageType: params.webStorageType,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformStorage}
abstract mixin class AndroidStorage implements AqutterPlatformStorage {
  @override
  AqutterAndroidWebViewControllerImpl? controller;

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

/// Object specifying creation parameters for creating a [AndroidLocalStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformLocalStorageCreationParams] for
/// more information.
class AndroidLocalStorageCreationParams
    extends AqutterPlatformLocalStorageCreationParams {
  /// Creates a new [AndroidLocalStorageCreationParams] instance.
  AndroidLocalStorageCreationParams(super.params);

  /// Creates a [AndroidLocalStorageCreationParams] instance based on [AqutterPlatformLocalStorageCreationParams].
  factory AndroidLocalStorageCreationParams.fromPlatformLocalStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    return AndroidLocalStorageCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformLocalStorage}
class AndroidLocalStorage extends AqutterPlatformLocalStorage with AndroidStorage {
  /// Constructs a [AndroidLocalStorage].
  AndroidLocalStorage(AqutterPlatformLocalStorageCreationParams params)
    : super.implementation(
        params is AndroidLocalStorageCreationParams
            ? params
            : AndroidLocalStorageCreationParams.fromPlatformLocalStorageCreationParams(
                params,
              ),
      );

  /// Default storage
  factory AndroidLocalStorage.defaultStorage({
    required AqutterPlatformWebViewController? controller,
  }) {
    return AndroidLocalStorage(
      AndroidLocalStorageCreationParams(
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
  AqutterAndroidWebViewControllerImpl? get controller =>
      params.controller as AqutterAndroidWebViewControllerImpl?;
}

/// Object specifying creation parameters for creating a [AndroidSessionStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformSessionStorageCreationParams] for
/// more information.
class AndroidSessionStorageCreationParams
    extends AqutterPlatformSessionStorageCreationParams {
  /// Creates a new [AndroidSessionStorageCreationParams] instance.
  AndroidSessionStorageCreationParams(super.params);

  /// Creates a [AndroidSessionStorageCreationParams] instance based on [AqutterPlatformSessionStorageCreationParams].
  factory AndroidSessionStorageCreationParams.fromPlatformSessionStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    return AndroidSessionStorageCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformSessionStorage}
class AndroidSessionStorage extends AqutterPlatformSessionStorage with AndroidStorage {
  /// Constructs a [AndroidSessionStorage].
  AndroidSessionStorage(AqutterPlatformSessionStorageCreationParams params)
    : super.implementation(
        params is AndroidSessionStorageCreationParams
            ? params
            : AndroidSessionStorageCreationParams.fromPlatformSessionStorageCreationParams(
                params,
              ),
      );

  /// Default storage
  factory AndroidSessionStorage.defaultStorage({
    required AqutterPlatformWebViewController? controller,
  }) {
    return AndroidSessionStorage(
      AndroidSessionStorageCreationParams(
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
  AqutterAndroidWebViewControllerImpl? get controller =>
      params.controller as AqutterAndroidWebViewControllerImpl?;
}
