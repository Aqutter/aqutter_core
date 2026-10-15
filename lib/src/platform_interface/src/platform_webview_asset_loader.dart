import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'webview_platform.dart';
import 'types/web_resource_response.dart';

part 'platform_webview_asset_loader.g.dart';

///{@template aqutter_core.AqutterWebViewAssetLoader}
///Helper class to load local files including application's static assets and resources using http(s):// URLs inside a `WebView` class.
///Loading local files using web-like URLs instead of `file://` is desirable as it is compatible with the Same-Origin policy.
///
///For more context about application's assets and resources and how to normally access them please refer to
///[Android Developer Docs: App resources overview](https://developer.android.com/guide/topics/resources/providing-resources).
///
///Using http(s):// URLs to access local resources may conflict with a real website.
///This means that local files should only be hosted on domains your organization owns
///(at paths reserved for this purpose) or the default domain reserved for this: `appassets.androidplatform.net`.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterWebViewAssetLoader.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
@ExchangeableObject(copyMethod: true)
class AqutterWebViewAssetLoader_ {
  ///An unused domain reserved for Android applications to intercept requests for app assets.
  ///
  ///It is used by default unless the user specified a different domain.
  static final String DEFAULT_DOMAIN = "appassets.androidplatform.net";

  ///Set the domain under which app assets can be accessed. The default domain is `appassets.androidplatform.net`.
  String? domain;

  ///Allow using the HTTP scheme in addition to HTTPS. The default is to not allow HTTP.
  bool? httpAllowed;

  ///List of registered path handlers.
  ///
  ///[AqutterWebViewAssetLoader] will try Path Handlers in the order they're registered,
  ///and will use whichever is the first to return a non-null.
  List<AqutterPlatformPathHandler>? pathHandlers;

  AqutterWebViewAssetLoader_({this.domain, this.httpAllowed, this.pathHandlers});
}

///{@template aqutter_core.AqutterPlatformPathHandlerCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformPathHandler].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformPathHandlerCreationParams.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
@immutable
class AqutterPlatformPathHandlerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformPathHandler].
  const AqutterPlatformPathHandlerCreationParams({required this.path});

  ///{@template aqutter_core.AqutterPlatformPathHandlerCreationParams.path}
  ///{@macro aqutter_core.AqutterPlatformPathHandler.path}
  ///{@endtemplate}
  final String path;

  ///{@template aqutter_core.AqutterPlatformPathHandlerCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformPathHandlerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformPathHandler}
///A handler that produces responses for a registered path.
///
///Implement this interface to handle other use-cases according to your app's needs.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformPathHandler.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
abstract class AqutterPlatformPathHandler {
  /// Event handler object that handles the [AqutterPlatformPathHandler] events.
  late final AqutterPlatformPathHandlerEvents? eventHandler;

  ///{@template aqutter_core.AqutterPlatformPathHandler.type}
  ///The path handler type.
  ///{@endtemplate}
  String get type {
    throw UnimplementedError('type is not implemented on the current platform');
  }

  ///{@template aqutter_core.AqutterPlatformPathHandler.path}
  ///The suffix path to be handled.
  ///
  ///The path should start and end with a `"/"` and it shouldn't collide with a real web path.
  ///{@endtemplate}
  String get path {
    throw UnimplementedError('path is not implemented on the current platform');
  }

  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    throw UnimplementedError(
      'toMap is not implemented on the current platform',
    );
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError(
      'toJson is not implemented on the current platform',
    );
  }
}

///{@template aqutter_core.AqutterPlatformPathHandlerEvents}
///Interface path handler events.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformPathHandlerEvents.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
abstract class AqutterPlatformPathHandlerEvents {
  ///{@template aqutter_core.AqutterPlatformPathHandler.handle}
  ///Handles the requested URL by returning the appropriate response.
  ///
  ///Returning a `null` value means that the handler decided not to handle this path.
  ///In this case, [AqutterWebViewAssetLoader] will try the next handler registered on this path or pass to `WebView` that will fall back to network to try to resolve the URL.
  ///
  ///However, if the handler wants to save unnecessary processing either by another handler or by falling back to network,
  ///in cases like a file cannot be found, it may return a `AqutterWebResourceResponse(data: null)`
  ///which is received as an HTTP response with status code `404` and no body.
  ///{@endtemplate}
  Future<AqutterWebResourceResponse?> handle(String path) {
    throw UnimplementedError(
      'handle is not implemented on the current platform',
    );
  }
}

///{@template aqutter_core.AqutterPlatformAssetsPathHandlerCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformAssetsPathHandler].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformAssetsPathHandlerCreationParams.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
@immutable
class AqutterPlatformAssetsPathHandlerCreationParams
    extends AqutterPlatformPathHandlerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformAssetsPathHandler].
  AqutterPlatformAssetsPathHandlerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformPathHandlerCreationParams params,
  ) : super(path: params.path);

  /// Creates a [AqutterPlatformAssetsPathHandlerCreationParams] instance based on [AqutterPlatformPathHandlerCreationParams].
  factory AqutterPlatformAssetsPathHandlerCreationParams.fromPlatformPathHandlerCreationParams(
    AqutterPlatformPathHandlerCreationParams params,
  ) {
    return AqutterPlatformAssetsPathHandlerCreationParams(params);
  }

  ///{@template aqutter_core.AqutterPlatformAssetsPathHandlerCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  @override
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformAssetsPathHandlerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformAssetsPathHandler}
///Handler class to open a file from assets directory in the application APK.
///
///Opens the requested file from the application's assets directory.
///
///The matched prefix path used shouldn't be a prefix of a real web path.
///Thus, if the requested file cannot be found a [AqutterWebResourceResponse] object with a `null` data will be returned instead of `null`.
///This saves the time of falling back to network and trying to resolve a path that doesn't exist.
///A [AqutterWebResourceResponse] with `null` data will be received as an HTTP response with status code `404` and no body.
///
///The MIME type for the file will be determined from the file's extension using
///[guessContentTypeFromName](https://developer.android.com/reference/java/net/URLConnection.html#guessContentTypeFromName-java.lang.String-).
///Developers should ensure that asset files are named using standard file extensions.
///If the file does not have a recognised extension, `text/plain` will be used by default.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformAssetsPathHandler.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
abstract class AqutterPlatformAssetsPathHandler extends PlatformInterface
    implements AqutterPlatformPathHandler {
  /// Creates a new [AqutterPlatformAssetsPathHandler]
  factory AqutterPlatformAssetsPathHandler(
    AqutterPlatformAssetsPathHandlerCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformAssetsPathHandler assetsPathHandler = AqutterWebViewPlatform
        .instance!
        .createPlatformAssetsPathHandler(params);
    PlatformInterface.verify(assetsPathHandler, _token);
    return assetsPathHandler;
  }

  /// Creates a new empty [AqutterPlatformAssetsPathHandler] to access static methods.
  factory AqutterPlatformAssetsPathHandler.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformAssetsPathHandler assetsPathHandlerStatic =
        AqutterWebViewPlatform.instance!.createPlatformAssetsPathHandlerStatic();
    PlatformInterface.verify(assetsPathHandlerStatic, _token);
    return assetsPathHandlerStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformAssetsPathHandler].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformAssetsPathHandler.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformAssetsPathHandler].
  final AqutterPlatformAssetsPathHandlerCreationParams params;

  @override
  String get type => 'AqutterAssetsPathHandler';

  @override
  String get path => params.path;

  ///{@macro aqutter_core.AqutterPlatformAssetsPathHandlerCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);
}

///{@template aqutter_core.AqutterPlatformResourcesPathHandlerCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformResourcesPathHandler].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformResourcesPathHandlerCreationParams.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
@immutable
class AqutterPlatformResourcesPathHandlerCreationParams
    extends AqutterPlatformPathHandlerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformResourcesPathHandler].
  AqutterPlatformResourcesPathHandlerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformPathHandlerCreationParams params,
  ) : super(path: params.path);

  /// Creates a [AqutterPlatformResourcesPathHandlerCreationParams] instance based on [AqutterPlatformPathHandlerCreationParams].
  factory AqutterPlatformResourcesPathHandlerCreationParams.fromPlatformPathHandlerCreationParams(
    AqutterPlatformPathHandlerCreationParams params,
  ) {
    return AqutterPlatformResourcesPathHandlerCreationParams(params);
  }

  ///{@template aqutter_core.AqutterPlatformResourcesPathHandlerCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  @override
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformResourcesPathHandlerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformResourcesPathHandler}
///Handler class to open a file from resources directory in the application APK.
///
///Opens the requested file from application's resources directory.
///
///The matched prefix path used shouldn't be a prefix of a real web path.
///Thus, if the requested file cannot be found a [AqutterWebResourceResponse] object with a `null` data will be returned instead of `null`.
///This saves the time of falling back to network and trying to resolve a path that doesn't exist.
///A [AqutterWebResourceResponse] with `null` data will be received as an HTTP response with status code `404` and no body.
///
///The MIME type for the file will be determined from the file's extension using
///[guessContentTypeFromName](https://developer.android.com/reference/java/net/URLConnection.html#guessContentTypeFromName-java.lang.String-).
///Developers should ensure that asset files are named using standard file extensions.
///If the file does not have a recognised extension, `text/plain` will be used by default.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformResourcesPathHandler.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
abstract class AqutterPlatformResourcesPathHandler extends PlatformInterface
    implements AqutterPlatformPathHandler {
  /// Creates a new [AqutterPlatformResourcesPathHandler]
  factory AqutterPlatformResourcesPathHandler(
    AqutterPlatformResourcesPathHandlerCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformResourcesPathHandler resourcesPathHandler =
        AqutterWebViewPlatform.instance!.createPlatformResourcesPathHandler(
          params,
        );
    PlatformInterface.verify(resourcesPathHandler, _token);
    return resourcesPathHandler;
  }

  /// Creates a new empty [AqutterPlatformResourcesPathHandler] to access static methods.
  factory AqutterPlatformResourcesPathHandler.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformResourcesPathHandler resourcesPathHandlerStatic =
        AqutterWebViewPlatform.instance!
            .createPlatformResourcesPathHandlerStatic();
    PlatformInterface.verify(resourcesPathHandlerStatic, _token);
    return resourcesPathHandlerStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformResourcesPathHandler].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformResourcesPathHandler.implementation(this.params)
    : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformResourcesPathHandler].
  final AqutterPlatformResourcesPathHandlerCreationParams params;

  @override
  String get type => 'AqutterResourcesPathHandler';

  @override
  String get path => params.path;

  ///{@macro aqutter_core.AqutterPlatformResourcesPathHandlerCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);
}

///{@template aqutter_core.AqutterPlatformInternalStoragePathHandlerCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformInternalStoragePathHandler].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformInternalStoragePathHandlerCreationParams.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
@immutable
class AqutterPlatformInternalStoragePathHandlerCreationParams
    extends AqutterPlatformPathHandlerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformInternalStoragePathHandler].
  AqutterPlatformInternalStoragePathHandlerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformPathHandlerCreationParams params, {
    required this.directory,
  }) : super(path: params.path);

  /// Creates a [AqutterPlatformInternalStoragePathHandlerCreationParams] instance based on [AqutterPlatformPathHandlerCreationParams].
  factory AqutterPlatformInternalStoragePathHandlerCreationParams.fromPlatformPathHandlerCreationParams(
    AqutterPlatformPathHandlerCreationParams params, {
    required String directory,
  }) {
    return AqutterPlatformInternalStoragePathHandlerCreationParams(
      params,
      directory: directory,
    );
  }

  ///{@template aqutter_core.AqutterPlatformInternalStoragePathHandlerCreationParams.directory}
  ///The directory for which files should be served.
  ///{@endtemplate}
  final String directory;

  ///{@template aqutter_core.AqutterPlatformInternalStoragePathHandlerCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  @override
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformInternalStoragePathHandlerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformInternalStoragePathHandler}
///Handler class to open files from application internal storage.
///For more information about android storage please refer to
///[Android Developers Docs: Data and file storage overview](https://developer.android.com/guide/topics/data/data-storage).
///
///To avoid leaking user or app data to the web, make sure to choose [directory] carefully,
///and assume any file under this directory could be accessed by any web page subject to same-origin rules.
///
///Opens the requested file from the exposed data directory.
///
///The matched prefix path used shouldn't be a prefix of a real web path.
///Thus, if the requested file cannot be found a [AqutterWebResourceResponse] object with a `null` data will be returned instead of `null`.
///This saves the time of falling back to network and trying to resolve a path that doesn't exist.
///A [AqutterWebResourceResponse] with `null` data will be received as an HTTP response with status code `404` and no body.
///
///The MIME type for the file will be determined from the file's extension using
///[guessContentTypeFromName](https://developer.android.com/reference/java/net/URLConnection.html#guessContentTypeFromName-java.lang.String-).
///Developers should ensure that asset files are named using standard file extensions.
///If the file does not have a recognised extension, `text/plain` will be used by default.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformInternalStoragePathHandler.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
abstract class AqutterPlatformInternalStoragePathHandler extends PlatformInterface
    implements AqutterPlatformPathHandler {
  /// Creates a new [AqutterPlatformInternalStoragePathHandler]
  factory AqutterPlatformInternalStoragePathHandler(
    AqutterPlatformInternalStoragePathHandlerCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformInternalStoragePathHandler internalStoragePathHandler =
        AqutterWebViewPlatform.instance!.createPlatformInternalStoragePathHandler(
          params,
        );
    PlatformInterface.verify(internalStoragePathHandler, _token);
    return internalStoragePathHandler;
  }

  /// Creates a new empty [AqutterPlatformInternalStoragePathHandler] to access static methods.
  factory AqutterPlatformInternalStoragePathHandler.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformInternalStoragePathHandler internalStoragePathHandlerStatic =
        AqutterWebViewPlatform.instance!
            .createPlatformInternalStoragePathHandlerStatic();
    PlatformInterface.verify(internalStoragePathHandlerStatic, _token);
    return internalStoragePathHandlerStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformInternalStoragePathHandler].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformInternalStoragePathHandler.implementation(this.params)
    : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformInternalStoragePathHandler].
  final AqutterPlatformInternalStoragePathHandlerCreationParams params;

  @override
  String get type => 'AqutterInternalStoragePathHandler';

  @override
  String get path => params.path;

  ///{@macro aqutter_core.AqutterPlatformInternalStoragePathHandlerCreationParams.directory}
  String get directory => params.directory;

  ///{@macro aqutter_core.AqutterPlatformInternalStoragePathHandlerCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);
}

///{@template aqutter_core.AqutterPlatformCustomPathHandlerCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformCustomPathHandler].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformCustomPathHandlerCreationParams.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
@immutable
class AqutterPlatformCustomPathHandlerCreationParams
    extends AqutterPlatformPathHandlerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformCustomPathHandler].
  AqutterPlatformCustomPathHandlerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformPathHandlerCreationParams params,
  ) : super(path: params.path);

  /// Creates a [AqutterPlatformCustomPathHandlerCreationParams] instance based on [AqutterPlatformPathHandlerCreationParams].
  factory AqutterPlatformCustomPathHandlerCreationParams.fromPlatformPathHandlerCreationParams(
    AqutterPlatformPathHandlerCreationParams params,
  ) {
    return AqutterPlatformCustomPathHandlerCreationParams(params);
  }

  ///{@template aqutter_core.AqutterPlatformCustomPathHandlerCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  @override
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformCustomPathHandlerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformCustomPathHandler}
///Custom handler class used to implement a custom logic to open a file.
///
///The matched prefix path used shouldn't be a prefix of a real web path.
///Thus, if the requested file cannot be found a [AqutterWebResourceResponse] object with a `null` data will be returned instead of `null`.
///This saves the time of falling back to network and trying to resolve a path that doesn't exist.
///A [AqutterWebResourceResponse] with `null` data will be received as an HTTP response with status code `404` and no body.
///
///The MIME type for the file will be determined from the file's extension using
///[guessContentTypeFromName](https://developer.android.com/reference/java/net/URLConnection.html#guessContentTypeFromName-java.lang.String-).
///Developers should ensure that asset files are named using standard file extensions.
///If the file does not have a recognised extension, `text/plain` will be used by default.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformCustomPathHandler.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
abstract class AqutterPlatformCustomPathHandler extends PlatformInterface
    implements AqutterPlatformPathHandler {
  /// Creates a new [AqutterPlatformCustomPathHandler]
  factory AqutterPlatformCustomPathHandler(
    AqutterPlatformCustomPathHandlerCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformCustomPathHandler customPathHandler = AqutterWebViewPlatform
        .instance!
        .createPlatformCustomPathHandler(params);
    PlatformInterface.verify(customPathHandler, _token);
    return customPathHandler;
  }

  /// Creates a new empty [AqutterPlatformCustomPathHandler] to access static methods.
  factory AqutterPlatformCustomPathHandler.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformCustomPathHandler customPathHandlerStatic =
        AqutterWebViewPlatform.instance!.createPlatformCustomPathHandlerStatic();
    PlatformInterface.verify(customPathHandlerStatic, _token);
    return customPathHandlerStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformCustomPathHandler].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformCustomPathHandler.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformCustomPathHandler].
  final AqutterPlatformCustomPathHandlerCreationParams params;

  @override
  String get type => 'AqutterCustomPathHandler';

  @override
  String get path => params.path;

  ///{@macro aqutter_core.AqutterPlatformCustomPathHandlerCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);
}
