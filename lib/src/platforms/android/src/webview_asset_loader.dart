import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [AndroidPathHandler].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformPathHandlerCreationParams] for
/// more information.
@immutable
class AndroidPathHandlerCreationParams
    extends AqutterPlatformPathHandlerCreationParams {
  /// Creates a new [AndroidPathHandlerCreationParams] instance.
  AndroidPathHandlerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformPathHandlerCreationParams params,
  ) : super(path: params.path);

  /// Creates a [AndroidPathHandlerCreationParams] instance based on [AqutterPlatformPathHandlerCreationParams].
  factory AndroidPathHandlerCreationParams.fromPlatformPathHandlerCreationParams(
    AqutterPlatformPathHandlerCreationParams params,
  ) {
    return AndroidPathHandlerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformPathHandler}
abstract mixin class AndroidPathHandler
    implements ChannelController, AqutterPlatformPathHandler {
  final String _id = IdGenerator.generate();

  @override
  late final AqutterPlatformPathHandlerEvents? eventHandler;

  @override
  late final String path;

  void _init(AqutterPlatformPathHandlerCreationParams params) {
    this.path = params.path;
    channel = MethodChannel(
      'com.github.aqutter/webview_custompathhandler_${_id}',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "handle":
        String path = call.arguments["path"];
        return (await eventHandler?.handle(path))?.toMap();
      default:
        throw UnimplementedError("Unimplemented ${call.method} method");
    }
  }

  @override
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"path": path, "type": type, "id": _id};
  }

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AndroidPathHandler{path: $path, type: $type}';
  }

  @override
  void dispose() {
    disposeChannel();
    eventHandler = null;
  }
}

/// Object specifying creation parameters for creating a [AndroidAssetsPathHandler].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformAssetsPathHandlerCreationParams] for
/// more information.
@immutable
class AndroidAssetsPathHandlerCreationParams
    extends AqutterPlatformAssetsPathHandlerCreationParams {
  /// Creates a new [AndroidAssetsPathHandlerCreationParams] instance.
  AndroidAssetsPathHandlerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformAssetsPathHandlerCreationParams params,
  ) : super(params);

  /// Creates a [AndroidAssetsPathHandlerCreationParams] instance based on [AqutterPlatformAssetsPathHandlerCreationParams].
  factory AndroidAssetsPathHandlerCreationParams.fromPlatformAssetsPathHandlerCreationParams(
    AqutterPlatformAssetsPathHandlerCreationParams params,
  ) {
    return AndroidAssetsPathHandlerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformAssetsPathHandler}
class AndroidAssetsPathHandler extends AqutterPlatformAssetsPathHandler
    with AndroidPathHandler, ChannelController {
  /// Constructs a [AndroidAssetsPathHandler].
  AndroidAssetsPathHandler(AqutterPlatformAssetsPathHandlerCreationParams params)
    : super.implementation(
        params is AndroidAssetsPathHandlerCreationParams
            ? params
            : AndroidAssetsPathHandlerCreationParams.fromPlatformAssetsPathHandlerCreationParams(
                params,
              ),
      ) {
    _init(params);
  }

  static final AndroidAssetsPathHandler _staticValue = AndroidAssetsPathHandler(
    AndroidAssetsPathHandlerCreationParams(
      AqutterPlatformAssetsPathHandlerCreationParams(
        AqutterPlatformPathHandlerCreationParams(path: ''),
      ),
    ),
  );

  /// Creates a new empty [AndroidAssetsPathHandler] to access static methods.
  factory AndroidAssetsPathHandler.static() => _staticValue;
}

/// Object specifying creation parameters for creating a [AndroidResourcesPathHandler].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformResourcesPathHandlerCreationParams] for
/// more information.
@immutable
class AndroidResourcesPathHandlerCreationParams
    extends AqutterPlatformResourcesPathHandlerCreationParams {
  /// Creates a new [AndroidResourcesPathHandlerCreationParams] instance.
  AndroidResourcesPathHandlerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformResourcesPathHandlerCreationParams params,
  ) : super(params);

  /// Creates a [AndroidResourcesPathHandlerCreationParams] instance based on [AqutterPlatformResourcesPathHandlerCreationParams].
  factory AndroidResourcesPathHandlerCreationParams.fromPlatformResourcesPathHandlerCreationParams(
    AqutterPlatformResourcesPathHandlerCreationParams params,
  ) {
    return AndroidResourcesPathHandlerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformResourcesPathHandler}
class AndroidResourcesPathHandler extends AqutterPlatformResourcesPathHandler
    with AndroidPathHandler, ChannelController {
  /// Constructs a [AndroidResourcesPathHandler].
  AndroidResourcesPathHandler(AqutterPlatformResourcesPathHandlerCreationParams params)
    : super.implementation(
        params is AndroidResourcesPathHandlerCreationParams
            ? params
            : AndroidResourcesPathHandlerCreationParams.fromPlatformResourcesPathHandlerCreationParams(
                params,
              ),
      ) {
    _init(params);
  }

  static final AndroidResourcesPathHandler _staticValue =
      AndroidResourcesPathHandler(
        AndroidResourcesPathHandlerCreationParams(
          AqutterPlatformResourcesPathHandlerCreationParams(
            AqutterPlatformPathHandlerCreationParams(path: ''),
          ),
        ),
      );

  /// Creates a new empty [AndroidResourcesPathHandler] to access static methods.
  factory AndroidResourcesPathHandler.static() => _staticValue;
}

/// Object specifying creation parameters for creating a [AndroidInternalStoragePathHandler].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformInternalStoragePathHandlerCreationParams] for
/// more information.
@immutable
class AndroidInternalStoragePathHandlerCreationParams
    extends AqutterPlatformInternalStoragePathHandlerCreationParams {
  /// Creates a new [AndroidInternalStoragePathHandlerCreationParams] instance.
  AndroidInternalStoragePathHandlerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformInternalStoragePathHandlerCreationParams params,
  ) : super(params, directory: params.directory);

  /// Creates a [AndroidInternalStoragePathHandlerCreationParams] instance based on [AqutterPlatformInternalStoragePathHandlerCreationParams].
  factory AndroidInternalStoragePathHandlerCreationParams.fromPlatformInternalStoragePathHandlerCreationParams(
    AqutterPlatformInternalStoragePathHandlerCreationParams params,
  ) {
    return AndroidInternalStoragePathHandlerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformInternalStoragePathHandler}
class AndroidInternalStoragePathHandler
    extends AqutterPlatformInternalStoragePathHandler
    with AndroidPathHandler, ChannelController {
  /// Constructs a [AndroidInternalStoragePathHandler].
  AndroidInternalStoragePathHandler(
    AqutterPlatformInternalStoragePathHandlerCreationParams params,
  ) : super.implementation(
        params is AndroidInternalStoragePathHandlerCreationParams
            ? params
            : AndroidInternalStoragePathHandlerCreationParams.fromPlatformInternalStoragePathHandlerCreationParams(
                params,
              ),
      ) {
    _init(params);
  }

  static final AndroidInternalStoragePathHandler _staticValue =
      AndroidInternalStoragePathHandler(
        AndroidInternalStoragePathHandlerCreationParams(
          AqutterPlatformInternalStoragePathHandlerCreationParams(
            AqutterPlatformPathHandlerCreationParams(path: ''),
            directory: '',
          ),
        ),
      );

  /// Creates a new empty [AndroidInternalStoragePathHandler] to access static methods.
  factory AndroidInternalStoragePathHandler.static() => _staticValue;

  AndroidInternalStoragePathHandlerCreationParams get _internalParams =>
      params as AndroidInternalStoragePathHandlerCreationParams;

  @override
  String get directory => _internalParams.directory;

  @override
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {...super.toMap(), 'directory': directory};
  }
}

/// Object specifying creation parameters for creating a [AndroidCustomPathHandler].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformCustomPathHandlerCreationParams] for
/// more information.
@immutable
class AndroidCustomPathHandlerCreationParams
    extends AqutterPlatformCustomPathHandlerCreationParams {
  /// Creates a new [AndroidCustomPathHandlerCreationParams] instance.
  AndroidCustomPathHandlerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformCustomPathHandlerCreationParams params,
  ) : super(params);

  /// Creates a [AndroidCustomPathHandlerCreationParams] instance based on [AqutterPlatformCustomPathHandlerCreationParams].
  factory AndroidCustomPathHandlerCreationParams.fromPlatformCustomPathHandlerCreationParams(
    AqutterPlatformCustomPathHandlerCreationParams params,
  ) {
    return AndroidCustomPathHandlerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformCustomPathHandler}
class AndroidCustomPathHandler extends AqutterPlatformCustomPathHandler
    with AndroidPathHandler, ChannelController {
  /// Constructs a [AndroidCustomPathHandler].
  AndroidCustomPathHandler(AqutterPlatformCustomPathHandlerCreationParams params)
    : super.implementation(
        params is AndroidCustomPathHandlerCreationParams
            ? params
            : AndroidCustomPathHandlerCreationParams.fromPlatformCustomPathHandlerCreationParams(
                params,
              ),
      ) {
    _init(params);
  }

  static final AndroidCustomPathHandler _staticValue = AndroidCustomPathHandler(
    AndroidCustomPathHandlerCreationParams(
      AqutterPlatformCustomPathHandlerCreationParams(
        AqutterPlatformPathHandlerCreationParams(path: ''),
      ),
    ),
  );

  /// Creates a new empty [AndroidCustomPathHandler] to access static methods.
  factory AndroidCustomPathHandler.static() => _staticValue;
}
