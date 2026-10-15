import 'dart:convert';

import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../webview/webview_controller.dart';

/// Object specifying creation parameters for creating a [WebPlatformWebStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformWebStorageCreationParams] for
/// more information.
class WebPlatformWebStorageCreationParams
    extends AqutterPlatformWebStorageCreationParams {
  /// Creates a new [WebPlatformWebStorageCreationParams] instance.
  WebPlatformWebStorageCreationParams({
    required super.localStorage,
    required super.sessionStorage,
  });

  /// Creates a [WebPlatformWebStorageCreationParams] instance based on [AqutterPlatformWebStorageCreationParams].
  factory WebPlatformWebStorageCreationParams.fromPlatformWebStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformWebStorageCreationParams params,
  ) {
    return WebPlatformWebStorageCreationParams(
      localStorage: params.localStorage,
      sessionStorage: params.sessionStorage,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformWebStorage}
class WebPlatformWebStorage extends AqutterPlatformWebStorage {
  /// Constructs a [WebPlatformWebStorage].
  WebPlatformWebStorage(AqutterPlatformWebStorageCreationParams params)
    : super.implementation(
        params is WebPlatformWebStorageCreationParams
            ? params
            : WebPlatformWebStorageCreationParams.fromPlatformWebStorageCreationParams(
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

/// Object specifying creation parameters for creating a [WebPlatformStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformStorageCreationParams] for
/// more information.
class WebPlatformStorageCreationParams extends AqutterPlatformStorageCreationParams {
  /// Creates a new [WebPlatformStorageCreationParams] instance.
  WebPlatformStorageCreationParams({
    required super.controller,
    required super.webStorageType,
  });

  /// Creates a [WebPlatformStorageCreationParams] instance based on [AqutterPlatformStorageCreationParams].
  factory WebPlatformStorageCreationParams.fromPlatformStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformStorageCreationParams params,
  ) {
    return WebPlatformStorageCreationParams(
      controller: params.controller,
      webStorageType: params.webStorageType,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformStorage}
abstract mixin class WebPlatformStorage implements AqutterPlatformStorage {
  @override
  AqutterWebPlatformWebViewController? controller;

  @override
  Future<int?> length() async {
    var result = await controller?.evaluateJavascript(
      source:
          """
    window.$webStorageType.length;
    """,
    );
    // evaluateJavascript already decodes the JSON, so result is already a num
    return result != null ? (result as num).toInt() : null;
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
    // evaluateJavascript already decodes the JSON, so result is already a String
    return result as String? ?? '';
  }

  @override
  void dispose() {
    controller = null;
  }
}

/// Object specifying creation parameters for creating a [WebPlatformLocalStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformLocalStorageCreationParams] for
/// more information.
class WebPlatformLocalStorageCreationParams
    extends AqutterPlatformLocalStorageCreationParams {
  /// Creates a new [WebPlatformLocalStorageCreationParams] instance.
  WebPlatformLocalStorageCreationParams(super.params);

  /// Creates a [WebPlatformLocalStorageCreationParams] instance based on [AqutterPlatformLocalStorageCreationParams].
  factory WebPlatformLocalStorageCreationParams.fromPlatformLocalStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformLocalStorageCreationParams params,
  ) {
    return WebPlatformLocalStorageCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformLocalStorage}
class WebPlatformLocalStorage extends AqutterPlatformLocalStorage
    with WebPlatformStorage {
  /// Constructs a [WebPlatformLocalStorage].
  WebPlatformLocalStorage(AqutterPlatformLocalStorageCreationParams params)
    : super.implementation(
        params is WebPlatformLocalStorageCreationParams
            ? params
            : WebPlatformLocalStorageCreationParams.fromPlatformLocalStorageCreationParams(
                params,
              ),
      );

  /// Default storage
  factory WebPlatformLocalStorage.defaultStorage({
    required AqutterPlatformWebViewController? controller,
  }) {
    return WebPlatformLocalStorage(
      WebPlatformLocalStorageCreationParams(
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
  AqutterWebPlatformWebViewController? get controller =>
      params.controller as AqutterWebPlatformWebViewController?;
}

/// Object specifying creation parameters for creating a [WebPlatformSessionStorage].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformSessionStorageCreationParams] for
/// more information.
class WebPlatformSessionStorageCreationParams
    extends AqutterPlatformSessionStorageCreationParams {
  /// Creates a new [WebPlatformSessionStorageCreationParams] instance.
  WebPlatformSessionStorageCreationParams(super.params);

  /// Creates a [WebPlatformSessionStorageCreationParams] instance based on [AqutterPlatformSessionStorageCreationParams].
  factory WebPlatformSessionStorageCreationParams.fromPlatformSessionStorageCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformSessionStorageCreationParams params,
  ) {
    return WebPlatformSessionStorageCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformSessionStorage}
class WebPlatformSessionStorage extends AqutterPlatformSessionStorage
    with WebPlatformStorage {
  /// Constructs a [WebPlatformSessionStorage].
  WebPlatformSessionStorage(AqutterPlatformSessionStorageCreationParams params)
    : super.implementation(
        params is WebPlatformSessionStorageCreationParams
            ? params
            : WebPlatformSessionStorageCreationParams.fromPlatformSessionStorageCreationParams(
                params,
              ),
      );

  /// Default storage
  factory WebPlatformSessionStorage.defaultStorage({
    required AqutterPlatformWebViewController? controller,
  }) {
    return WebPlatformSessionStorage(
      WebPlatformSessionStorageCreationParams(
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
  AqutterWebPlatformWebViewController? get controller =>
      params.controller as AqutterWebPlatformWebViewController?;
}
