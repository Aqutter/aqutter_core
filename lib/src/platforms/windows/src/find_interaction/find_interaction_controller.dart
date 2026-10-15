import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [WindowsFindInteractionController].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformFindInteractionControllerCreationParams] for
/// more information.
@immutable
class WindowsFindInteractionControllerCreationParams
    extends AqutterPlatformFindInteractionControllerCreationParams {
  /// Creates a new [WindowsFindInteractionControllerCreationParams] instance.
  const WindowsFindInteractionControllerCreationParams({
    super.onFindResultReceived,
  });

  /// Creates a [WindowsFindInteractionControllerCreationParams] instance based on [AqutterPlatformFindInteractionControllerCreationParams].
  factory WindowsFindInteractionControllerCreationParams.fromPlatformFindInteractionControllerCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) {
    return WindowsFindInteractionControllerCreationParams(
      onFindResultReceived: params.onFindResultReceived,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformFindInteractionController}
class WindowsFindInteractionController extends AqutterPlatformFindInteractionController
    with ChannelController {
  /// Constructs a [WindowsFindInteractionController].
  WindowsFindInteractionController(
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) : super.implementation(
        params is WindowsFindInteractionControllerCreationParams
            ? params
            : WindowsFindInteractionControllerCreationParams.fromPlatformFindInteractionControllerCreationParams(
                params,
              ),
      );

  static final WindowsFindInteractionController _staticValue =
      WindowsFindInteractionController(
        const WindowsFindInteractionControllerCreationParams(),
      );

  /// Provide static access.
  factory WindowsFindInteractionController.static() {
    return _staticValue;
  }

  _debugLog(String method, dynamic args) {
    debugLog(
      className: this.runtimeType.toString(),
      debugLoggingSettings:
          AqutterPlatformFindInteractionController.debugLoggingSettings,
      method: method,
      args: args,
    );
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    _debugLog(call.method, call.arguments);

    switch (call.method) {
      case "onFindResultReceived":
        if (onFindResultReceived != null) {
          int activeMatchOrdinal = call.arguments["activeMatchOrdinal"];
          int numberOfMatches = call.arguments["numberOfMatches"];
          bool isDoneCounting = call.arguments["isDoneCounting"];
          onFindResultReceived!(
            this,
            activeMatchOrdinal,
            numberOfMatches,
            isDoneCounting,
          );
        }
        break;
      default:
        throw UnimplementedError("Unimplemented ${call.method} method");
    }
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.findAll}
  @override
  Future<void> findAll({String? find}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('find', () => find);
    await channel?.invokeMethod('findAll', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.findNext}
  @override
  Future<void> findNext({bool forward = true}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('forward', () => forward);
    await channel?.invokeMethod('findNext', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.clearMatches}
  @override
  Future<void> clearMatches() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('clearMatches', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.setSearchText}
  @override
  Future<void> setSearchText(String? searchText) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('searchText', () => searchText);
    await channel?.invokeMethod('setSearchText', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.setFindOptions}
  @override
  Future<void> setFindOptions({AqutterFindOptions? options}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('options', () => options?.toMap());
    await channel?.invokeMethod('setFindOptions', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.getSearchText}
  @override
  Future<String?> getSearchText() async {
    Map<String, dynamic> args = <String, dynamic>{};
    return await channel?.invokeMethod<String?>('getSearchText', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.getActiveFindSession}
  @override
  Future<AqutterFindSession?> getActiveFindSession() async {
    Map<String, dynamic> args = <String, dynamic>{};
    Map<String, dynamic>? result = (await channel?.invokeMethod(
      'getActiveFindSession',
      args,
    ))?.cast<String, dynamic>();
    return AqutterFindSession.fromMap(result);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.dispose}
  @override
  void dispose({bool isKeepAlive = false}) {
    disposeChannel(removeMethodCallHandler: !isKeepAlive);
  }
}

extension InternalFindInteractionController
    on WindowsFindInteractionController {
  void init(dynamic id) {
    channel = MethodChannel(
      'com.github.aqutter/webview_find_interaction_$id',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }
}
