import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformPathHandler}
///
///{@macro aqutter_core.AqutterPlatformPathHandler.supported_platforms}
abstract class AqutterPathHandler
    implements AqutterPlatformPathHandler, AqutterPlatformPathHandlerEvents {
  /// Constructs a [AqutterPathHandler] from a specific platform implementation.
  AqutterPathHandler.fromPlatform({required this.platform}) {
    this.platform.eventHandler = this;
  }

  /// Returns whether this class is supported on the current platform.
  ///
  /// Use [platform] to check support for a specific platform.
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformPathHandlerCreationParams(
        path: '',
      ).isClassSupported(platform: platform);

  @override
  late final AqutterPlatformPathHandlerEvents? eventHandler;

  /// Implementation of [AqutterPlatformPathHandler] for the current platform.
  final AqutterPlatformPathHandler platform;

  @override
  String get type => platform.type;

  @override
  String get path => platform.path;

  @override
  Future<AqutterWebResourceResponse?> handle(String path) async {
    return null;
  }

  @override
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) =>
      platform.toMap(enumMethod: enumMethod);

  @override
  Map<String, dynamic> toJson() => platform.toJson();
}

///{@macro aqutter_core.AqutterPlatformAssetsPathHandler}
///
///{@macro aqutter_core.AqutterPlatformAssetsPathHandler.supported_platforms}
class AqutterAssetsPathHandler extends AqutterPathHandler {
  ///{@macro aqutter_core.AqutterPlatformAssetsPathHandler}
  ///
  ///{@macro aqutter_core.AqutterPlatformAssetsPathHandler.supported_platforms}
  AqutterAssetsPathHandler({required String path})
    : this.fromPlatformCreationParams(
        params: AqutterPlatformAssetsPathHandlerCreationParams(
          AqutterPlatformPathHandlerCreationParams(path: path),
        ),
      );

  /// Constructs a [AqutterAssetsPathHandler].
  ///
  /// See [AqutterAssetsPathHandler.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterAssetsPathHandler.fromPlatformCreationParams({
    required AqutterPlatformAssetsPathHandlerCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformAssetsPathHandler(params));

  /// Constructs a [AqutterAssetsPathHandler] from a specific platform implementation.
  AqutterAssetsPathHandler.fromPlatform({required this.platform})
    : super.fromPlatform(platform: platform);

  /// Implementation of [AqutterPlatformAssetsPathHandler] for the current platform.
  final AqutterPlatformAssetsPathHandler platform;

  /// Returns whether this class is supported on the current platform.
  ///
  /// Use [platform] to check support for a specific platform.
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformPathHandlerCreationParams(
        path: '',
      ).isClassSupported(platform: platform);
}

///{@macro aqutter_core.AqutterPlatformResourcesPathHandler}
///
///{@macro aqutter_core.AqutterPlatformResourcesPathHandler.supported_platforms}
class AqutterResourcesPathHandler extends AqutterPathHandler {
  ///{@macro aqutter_core.AqutterPlatformResourcesPathHandler}
  ///
  ///{@macro aqutter_core.AqutterPlatformResourcesPathHandler.supported_platforms}
  AqutterResourcesPathHandler({required String path})
    : this.fromPlatformCreationParams(
        params: AqutterPlatformResourcesPathHandlerCreationParams(
          AqutterPlatformPathHandlerCreationParams(path: path),
        ),
      );

  /// Constructs a [AqutterResourcesPathHandler].
  ///
  /// See [AqutterResourcesPathHandler.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterResourcesPathHandler.fromPlatformCreationParams({
    required AqutterPlatformResourcesPathHandlerCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformResourcesPathHandler(params));

  /// Constructs a [AqutterResourcesPathHandler] from a specific platform implementation.
  AqutterResourcesPathHandler.fromPlatform({required this.platform})
    : super.fromPlatform(platform: platform);

  /// Implementation of [AqutterPlatformResourcesPathHandler] for the current platform.
  final AqutterPlatformResourcesPathHandler platform;

  /// Returns whether this class is supported on the current platform.
  ///
  /// Use [platform] to check support for a specific platform.
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformPathHandlerCreationParams(
        path: '',
      ).isClassSupported(platform: platform);
}

///{@macro aqutter_core.AqutterPlatformInternalStoragePathHandler}
///
///{@macro aqutter_core.AqutterPlatformInternalStoragePathHandler.supported_platforms}
class AqutterInternalStoragePathHandler extends AqutterPathHandler {
  ///{@macro aqutter_core.AqutterPlatformInternalStoragePathHandler}
  ///
  ///{@macro aqutter_core.AqutterPlatformInternalStoragePathHandler.supported_platforms}
  AqutterInternalStoragePathHandler({required String path, required String directory})
    : this.fromPlatformCreationParams(
        params: AqutterPlatformInternalStoragePathHandlerCreationParams(
          AqutterPlatformPathHandlerCreationParams(path: path),
          directory: directory,
        ),
      );

  /// Constructs a [AqutterInternalStoragePathHandler].
  ///
  /// See [AqutterInternalStoragePathHandler.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterInternalStoragePathHandler.fromPlatformCreationParams({
    required AqutterPlatformInternalStoragePathHandlerCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformInternalStoragePathHandler(params));

  /// Constructs a [AqutterInternalStoragePathHandler] from a specific platform implementation.
  AqutterInternalStoragePathHandler.fromPlatform({required this.platform})
    : super.fromPlatform(platform: platform);

  /// Implementation of [AqutterPlatformInternalStoragePathHandler] for the current platform.
  final AqutterPlatformInternalStoragePathHandler platform;

  String get directory => platform.directory;

  /// Returns whether this class is supported on the current platform.
  ///
  /// Use [platform] to check support for a specific platform.
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformPathHandlerCreationParams(
        path: '',
      ).isClassSupported(platform: platform);
}

///{@macro aqutter_core.AqutterPlatformCustomPathHandler}
///
///{@macro aqutter_core.AqutterPlatformCustomPathHandler.supported_platforms}
abstract class AqutterCustomPathHandler extends AqutterPathHandler {
  ///{@macro aqutter_core.AqutterPlatformCustomPathHandler}
  ///
  ///{@macro aqutter_core.AqutterPlatformCustomPathHandler.supported_platforms}
  AqutterCustomPathHandler({required String path})
    : this.fromPlatformCreationParams(
        params: AqutterPlatformCustomPathHandlerCreationParams(
          AqutterPlatformPathHandlerCreationParams(path: path),
        ),
      );

  /// Constructs a [AqutterCustomPathHandler].
  ///
  /// See [AqutterCustomPathHandler.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterCustomPathHandler.fromPlatformCreationParams({
    required AqutterPlatformCustomPathHandlerCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformCustomPathHandler(params));

  /// Constructs a [AqutterCustomPathHandler] from a specific platform implementation.
  AqutterCustomPathHandler.fromPlatform({required this.platform})
    : super.fromPlatform(platform: platform);

  /// Implementation of [AqutterPlatformCustomPathHandler] for the current platform.
  final AqutterPlatformCustomPathHandler platform;

  /// Returns whether this class is supported on the current platform.
  ///
  /// Use [platform] to check support for a specific platform.
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformPathHandlerCreationParams(
        path: '',
      ).isClassSupported(platform: platform);
}
