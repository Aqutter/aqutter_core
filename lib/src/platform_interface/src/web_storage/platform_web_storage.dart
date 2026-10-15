import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:aqutter_core/src/platform_interface/src/types/disposable.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../webview/platform_webview_controller.dart';
import '../webview_platform.dart';
import '../types/main.dart';
import 'web_storage_item.dart';

part 'platform_web_storage.g.dart';

/// Object specifying creation parameters for creating a [AqutterPlatformWebStorage].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@template aqutter_core.AqutterPlatformWebStorageCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformWebStorage].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebStorageCreationParams.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WebPlatform(),
    WindowsPlatform(),
    LinuxPlatform(),
  ],
)
@immutable
class AqutterPlatformWebStorageCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformWebStorage].
  const AqutterPlatformWebStorageCreationParams({
    required this.localStorage,
    required this.sessionStorage,
  });

  ///{@macro aqutter_core.AqutterPlatformWebStorage.localStorage}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorage.localStorage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  final AqutterPlatformLocalStorage localStorage;

  ///{@macro aqutter_core.AqutterPlatformWebStorage.sessionStorage}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorage.sessionStorage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  final AqutterPlatformSessionStorage sessionStorage;

  ///{@template aqutter_core.AqutterPlatformWebStorageCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebStorageCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformWebStorageCreationParams.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformWebStorageCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => _AqutterPlatformWebStorageCreationParamsPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );
}

///{@template aqutter_core.AqutterPlatformWebStorage}
///Class that provides access to the JavaScript [Web AqutterStorage API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Storage_API): `window.sessionStorage` and `window.localStorage`.
///It used by [AqutterPlatformWebViewController.webStorage].
///{@endtemplate}
///{@macro aqutter_core.AqutterPlatformWebStorage.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WebPlatform(),
    WindowsPlatform(),
    LinuxPlatform(),
  ],
)
abstract class AqutterPlatformWebStorage extends PlatformInterface
    implements AqutterDisposable {
  /// Creates a new [AqutterPlatformWebStorage]
  factory AqutterPlatformWebStorage(AqutterPlatformWebStorageCreationParams params) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebStorage webStorage = AqutterWebViewPlatform.instance!
        .createPlatformWebStorage(params);
    PlatformInterface.verify(webStorage, _token);
    return webStorage;
  }

  /// Creates a new empty [AqutterPlatformWebStorage] to access static methods.
  factory AqutterPlatformWebStorage.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebStorage webStorageStatic = AqutterWebViewPlatform.instance!
        .createPlatformWebStorageStatic();
    PlatformInterface.verify(webStorageStatic, _token);
    return webStorageStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformWebStorage].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformWebStorage.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformWebStorage].
  final AqutterPlatformWebStorageCreationParams params;

  ///{@template aqutter_core.AqutterPlatformWebStorage.localStorage}
  ///Represents `window.localStorage`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorage.localStorage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  AqutterPlatformLocalStorage get localStorage => params.localStorage;

  ///{@template aqutter_core.AqutterPlatformWebStorage.sessionStorage}
  ///Represents `window.sessionStorage`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorage.sessionStorage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  AqutterPlatformSessionStorage get sessionStorage => params.sessionStorage;

  ///{@template aqutter_core.AqutterPlatformWebStorage.dispose}
  ///Disposes the web storage.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorage.dispose.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  void dispose() {
    throw UnimplementedError(
      'dispose is not implemented on the current platform',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformWebStorageCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebStorageClassSupported.isClassSupported(platform: platform);

  ///{@template aqutter_core.AqutterPlatformWebStorage.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(dynamic property, {TargetPlatform? platform}) =>
      property is AqutterPlatformWebStorageCreationParamsProperty
      ? params.isPropertySupported(property, platform: platform)
      : _AqutterPlatformWebStoragePropertySupported.isPropertySupported(
          property,
          platform: platform,
        );

  ///{@template aqutter_core.AqutterPlatformWebStorage.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformWebStorageMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformWebStorageMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}

/// Object specifying creation parameters for creating a [AqutterPlatformStorage].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@template aqutter_core.AqutterPlatformStorageCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformStorage].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformStorageCreationParams.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WebPlatform(),
    WindowsPlatform(),
    LinuxPlatform(),
  ],
)
@immutable
class AqutterPlatformStorageCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformStorage].
  const AqutterPlatformStorageCreationParams({
    required this.controller,
    required this.webStorageType,
  });

  ///{@macro aqutter_core.AqutterPlatformStorage.controller}
  ///
  ///{@macro aqutter_core.AqutterPlatformStorage.controller.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  final AqutterPlatformWebViewController? controller;

  ///{@macro aqutter_core.AqutterPlatformStorage.webStorageType}
  ///
  ///{@macro aqutter_core.AqutterPlatformStorage.webStorageType.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  final AqutterWebStorageType webStorageType;

  ///{@template aqutter_core.AqutterPlatformStorageCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformStorageCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformStorageCreationParams.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformStorageCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => _AqutterPlatformStorageCreationParamsPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );
}

///{@template aqutter_core.AqutterPlatformStorage}
///Class that provides methods to manage the JavaScript [AqutterStorage](https://developer.mozilla.org/en-US/docs/Web/API/AqutterStorage) object.
///It is used by [AqutterPlatformLocalStorage] and [AqutterPlatformSessionStorage].
///{@endtemplate}
///{@macro aqutter_core.AqutterPlatformStorage.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WebPlatform(),
    WindowsPlatform(),
    LinuxPlatform(),
  ],
)
abstract mixin class AqutterPlatformStorage implements AqutterDisposable {
  ///{@template aqutter_core.AqutterPlatformStorage.controller}
  ///Controller used to interact with storage.
  ///{@endtemplate}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  AqutterPlatformWebViewController? get controller;

  ///{@template aqutter_core.AqutterPlatformStorage.webStorageType}
  ///The web storage type: `window.sessionStorage` or `window.localStorage`.
  ///{@endtemplate}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  AqutterWebStorageType get webStorageType {
    throw UnimplementedError(
      'webStorageType is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformStorage.length}
  ///Returns an integer representing the number of data items stored in the AqutterStorage object.
  ///{@endtemplate}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(
        note:
            'This method has an effect only if the iframe has the same origin.',
      ),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<int?> length() {
    throw UnimplementedError(
      'length is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformStorage.setItem}
  ///When passed a [key] name and [value], will add that key to the storage, or update that key's value if it already exists.
  ///{@endtemplate}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(
        note:
            'This method has an effect only if the iframe has the same origin.',
      ),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> setItem({required String key, required dynamic value}) {
    throw UnimplementedError(
      'setItem is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformStorage.getItem}
  ///When passed a [key] name, will return that key's value, or `null` if the key does not exist, in the given AqutterStorage object.
  ///{@endtemplate}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(
        note:
            'This method has an effect only if the iframe has the same origin.',
      ),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<dynamic> getItem({required String key}) {
    throw UnimplementedError(
      'getItem is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformStorage.removeItem}
  ///When passed a [key] name, will remove that key from the given AqutterStorage object if it exists.
  ///{@endtemplate}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(
        note:
            'This method has an effect only if the iframe has the same origin.',
      ),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> removeItem({required String key}) {
    throw UnimplementedError(
      'removeItem is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformStorage.getItems}
  ///Returns the list of all items from the given AqutterStorage object.
  ///{@endtemplate}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(
        note:
            'This method has an effect only if the iframe has the same origin.',
      ),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<List<AqutterWebStorageItem>> getItems() {
    throw UnimplementedError(
      'getItems is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformStorage.clear}
  ///Clears all keys stored in a given AqutterStorage object.
  ///{@endtemplate}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(
        note:
            'This method has an effect only if the iframe has the same origin.',
      ),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> clear() {
    throw UnimplementedError(
      'clear is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformStorage.key}
  ///When passed a number [index], returns the name of the nth key in a given AqutterStorage object.
  ///The order of keys is user-agent defined, so you should not rely on it.
  ///{@endtemplate}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(
        note:
            'This method has an effect only if the iframe has the same origin.',
      ),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<String> key({required int index}) {
    throw UnimplementedError('key is not implemented on the current platform');
  }

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  void dispose() {
    throw UnimplementedError(
      'dispose is not implemented on the current platform',
    );
  }
}

/// Object specifying creation parameters for creating a [AqutterPlatformLocalStorage].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
@immutable
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WebPlatform(),
    WindowsPlatform(),
    LinuxPlatform(),
  ],
)
class AqutterPlatformLocalStorageCreationParams extends AqutterPlatformStorageCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformLocalStorage].
  AqutterPlatformLocalStorageCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformStorageCreationParams params,
  ) : super(
        controller: params.controller,
        webStorageType: AqutterWebStorageType.LOCAL_STORAGE,
      );

  /// Creates a [AqutterPlatformLocalStorageCreationParams] instance based on [AqutterPlatformLocalStorageCreationParams].
  factory AqutterPlatformLocalStorageCreationParams.fromPlatformStorageCreationParams(
    AqutterPlatformStorageCreationParams params,
  ) {
    return AqutterPlatformLocalStorageCreationParams(params);
  }

  ///{@template aqutter_core.AqutterPlatformLocalStorageCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformLocalStorageCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformLocalStorage}
///Class that provides methods to manage the JavaScript `window.localStorage` object.
///It used by [AqutterPlatformWebStorage].
///{@endtemplate}
///{@macro aqutter_core.AqutterPlatformLocalStorage.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WebPlatform(),
    WindowsPlatform(),
    LinuxPlatform(),
  ],
)
abstract class AqutterPlatformLocalStorage extends PlatformInterface
    with AqutterPlatformStorage {
  /// Creates a new [AqutterPlatformLocalStorage]
  factory AqutterPlatformLocalStorage(AqutterPlatformLocalStorageCreationParams params) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformLocalStorage localStorage = AqutterWebViewPlatform.instance!
        .createPlatformLocalStorage(params);
    PlatformInterface.verify(localStorage, _token);
    return localStorage;
  }

  /// Creates a new empty [AqutterPlatformLocalStorage] to access static methods.
  factory AqutterPlatformLocalStorage.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformLocalStorage localStorageStatic = AqutterWebViewPlatform
        .instance!
        .createPlatformLocalStorageStatic();
    PlatformInterface.verify(localStorageStatic, _token);
    return localStorageStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformLocalStorage].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformLocalStorage.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformLocalStorage].
  final AqutterPlatformLocalStorageCreationParams params;

  @override
  AqutterWebStorageType get webStorageType => params.webStorageType;

  ///{@macro aqutter_core.AqutterPlatformLocalStorage.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformLocalStorageClassSupported.isClassSupported(platform: platform);

  ///{@template aqutter_core.AqutterPlatformLocalStorage.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformStorageCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => params.isPropertySupported(property, platform: platform);

  ///{@template aqutter_core.AqutterPlatformLocalStorage.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformLocalStorageMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformLocalStorageMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<int?> length() => super.length();

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> setItem({required String key, required dynamic value}) =>
      super.setItem(key: key, value: value);

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<dynamic> getItem({required String key}) => super.getItem(key: key);

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> removeItem({required String key}) => super.removeItem(key: key);

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<List<AqutterWebStorageItem>> getItems() => super.getItems();

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> clear() => super.clear();

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<String> key({required int index}) => super.key(index: index);

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  void dispose() => super.dispose();
}

/// Object specifying creation parameters for creating a [AqutterPlatformSessionStorage].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
@immutable
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WebPlatform(),
    WindowsPlatform(),
    LinuxPlatform(),
  ],
)
class AqutterPlatformSessionStorageCreationParams
    extends AqutterPlatformStorageCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformSessionStorage].
  AqutterPlatformSessionStorageCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformStorageCreationParams params,
  ) : super(
        controller: params.controller,
        webStorageType: AqutterWebStorageType.SESSION_STORAGE,
      );

  /// Creates a [AqutterPlatformSessionStorageCreationParams] instance based on [AqutterPlatformStorageCreationParams].
  factory AqutterPlatformSessionStorageCreationParams.fromPlatformStorageCreationParams(
    AqutterPlatformStorageCreationParams params,
  ) {
    return AqutterPlatformSessionStorageCreationParams(params);
  }

  ///{@template aqutter_core.AqutterPlatformSessionStorageCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformSessionStorageCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformSessionStorage}
///Class that provides methods to manage the JavaScript `window.sessionStorage` object.
///It used by [AqutterPlatformWebStorage].
///{@endtemplate}
///{@macro aqutter_core.AqutterPlatformSessionStorage.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WebPlatform(),
    WindowsPlatform(),
    LinuxPlatform(),
  ],
)
abstract class AqutterPlatformSessionStorage extends PlatformInterface
    with AqutterPlatformStorage {
  /// Creates a new [AqutterPlatformSessionStorage]
  factory AqutterPlatformSessionStorage(AqutterPlatformSessionStorageCreationParams params) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformSessionStorage sessionStorage = AqutterWebViewPlatform.instance!
        .createPlatformSessionStorage(params);
    PlatformInterface.verify(sessionStorage, _token);
    return sessionStorage;
  }

  /// Creates a new empty [AqutterPlatformSessionStorage] to access static methods.
  factory AqutterPlatformSessionStorage.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformSessionStorage sessionStorageStatic = AqutterWebViewPlatform
        .instance!
        .createPlatformSessionStorageStatic();
    PlatformInterface.verify(sessionStorageStatic, _token);
    return sessionStorageStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformSessionStorage].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformSessionStorage.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformSessionStorage].
  final AqutterPlatformSessionStorageCreationParams params;

  @override
  AqutterWebStorageType get webStorageType => params.webStorageType;

  ///{@macro aqutter_core.AqutterPlatformSessionStorage.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformSessionStorageClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformSessionStorage.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformStorageCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => params.isPropertySupported(property, platform: platform);

  ///{@template aqutter_core.AqutterPlatformSessionStorage.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformSessionStorageMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformSessionStorageMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<int?> length() => super.length();

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> setItem({required String key, required dynamic value}) =>
      super.setItem(key: key, value: value);

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<dynamic> getItem({required String key}) => super.getItem(key: key);

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> removeItem({required String key}) => super.removeItem(key: key);

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<List<AqutterWebStorageItem>> getItems() => super.getItems();

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> clear() => super.clear();

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<String> key({required int index}) => super.key(index: index);

  @override
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WebPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  void dispose() => super.dispose();
}
