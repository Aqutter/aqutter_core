import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [IOSFindInteractionController].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformFindInteractionControllerCreationParams] for
/// more information.
@immutable
class IOSFindInteractionControllerCreationParams
    extends AqutterPlatformFindInteractionControllerCreationParams {
  /// Creates a new [IOSFindInteractionControllerCreationParams] instance.
  const IOSFindInteractionControllerCreationParams({
    super.onFindResultReceived,
  });

  /// Creates a [IOSFindInteractionControllerCreationParams] instance based on [AqutterPlatformFindInteractionControllerCreationParams].
  factory IOSFindInteractionControllerCreationParams.fromPlatformFindInteractionControllerCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) {
    return IOSFindInteractionControllerCreationParams(
      onFindResultReceived: params.onFindResultReceived,
    );
  }
}

///{@macro aqutter_core.AqutterPlatformFindInteractionController}
class IOSFindInteractionController extends AqutterPlatformFindInteractionController
    with ChannelController {
  /// Constructs a [IOSFindInteractionController].
  IOSFindInteractionController(
    AqutterPlatformFindInteractionControllerCreationParams params,
  ) : super.implementation(
        params is IOSFindInteractionControllerCreationParams
            ? params
            : IOSFindInteractionControllerCreationParams.fromPlatformFindInteractionControllerCreationParams(
                params,
              ),
      );

  static final IOSFindInteractionController _staticValue =
      IOSFindInteractionController(
        IOSFindInteractionControllerCreationParams(),
      );

  /// Provide static access.
  factory IOSFindInteractionController.static() {
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
  Future<void> findAll({String? find}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('find', () => find);
    await channel?.invokeMethod('findAll', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.findNext}
  Future<void> findNext({bool forward = true}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('forward', () => forward);
    await channel?.invokeMethod('findNext', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.clearMatches}
  Future<void> clearMatches() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('clearMatches', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.setSearchText}
  Future<void> setSearchText(String? searchText) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('searchText', () => searchText);
    await channel?.invokeMethod('setSearchText', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.getSearchText}
  Future<String?> getSearchText() async {
    Map<String, dynamic> args = <String, dynamic>{};
    return await channel?.invokeMethod<String?>('getSearchText', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.isFindNavigatorVisible}
  Future<bool?> isFindNavigatorVisible() async {
    Map<String, dynamic> args = <String, dynamic>{};
    return await channel?.invokeMethod<bool?>('isFindNavigatorVisible', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.updateResultCount}
  Future<void> updateResultCount() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('updateResultCount', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.presentFindNavigator}
  Future<void> presentFindNavigator() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('presentFindNavigator', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.dismissFindNavigator}
  Future<void> dismissFindNavigator() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('dismissFindNavigator', args);
  }

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.getActiveFindSession}
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

extension InternalFindInteractionController on IOSFindInteractionController {
  void init(dynamic id) {
    channel = MethodChannel(
      'com.github.aqutter/webview_find_interaction_$id',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }
}
