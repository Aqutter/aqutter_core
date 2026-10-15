import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [LinuxFindInteractionController].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformFindInteractionControllerCreationParams] for
/// more information.
@immutable
class LinuxFindInteractionControllerCreationParams
    extends AqutterPlatformFindInteractionControllerCreationParams {
  /// Creates a new [LinuxFindInteractionControllerCreationParams] instance.
  const LinuxFindInteractionControllerCreationParams({
    super.onFindResultReceived,
  });

  /// Creates a [LinuxFindInteractionControllerCreationParams] instance based on [AqutterPlatformFindInteractionControllerCreationParams].
  factory LinuxFindInteractionControllerCreationParams.fromPlatformFindInteractionControllerCreationParams(
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) {
    return LinuxFindInteractionControllerCreationParams(
      onFindResultReceived: params.onFindResultReceived,
    );
  }
}

/// Implementation of [AqutterPlatformFindInteractionController] for Linux.
class LinuxFindInteractionController extends AqutterPlatformFindInteractionController
    with ChannelController {
  /// Creates a new [LinuxFindInteractionController].
  LinuxFindInteractionController(
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) : super.implementation(
        params is LinuxFindInteractionControllerCreationParams
            ? params
            : LinuxFindInteractionControllerCreationParams.fromPlatformFindInteractionControllerCreationParams(
                params,
              ),
      );

  static final LinuxFindInteractionController _staticValue =
      LinuxFindInteractionController(
        LinuxFindInteractionControllerCreationParams(),
      );

  /// Provide static access.
  factory LinuxFindInteractionController.static() {
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

extension InternalFindInteractionController on LinuxFindInteractionController {
  void init(dynamic id) {
    channel = MethodChannel(
      'com.github.aqutter/webview_find_interaction_$id',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }
}
