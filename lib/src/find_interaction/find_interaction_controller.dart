import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformFindInteractionController}
///
///{@macro aqutter_core.AqutterPlatformFindInteractionController.supported_platforms}
class AqutterFindInteractionController {
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController}
  ///
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.supported_platforms}
  AqutterFindInteractionController({
    void Function(
      AqutterPlatformFindInteractionController controller,
      int activeMatchOrdinal,
      int numberOfMatches,
      bool isDoneCounting,
    )?
    onFindResultReceived,
  }) : this.fromPlatformCreationParams(
         params: AqutterPlatformFindInteractionControllerCreationParams(
           onFindResultReceived: onFindResultReceived,
         ),
       );

  /// Constructs a [AqutterFindInteractionController].
  ///
  /// See [AqutterFindInteractionController.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterFindInteractionController.fromPlatformCreationParams({
    required AqutterPlatformFindInteractionControllerCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformFindInteractionController(params));

  /// Constructs a [AqutterFindInteractionController] from a specific platform implementation.
  AqutterFindInteractionController.fromPlatform({required this.platform});

  /// Implementation of [AqutterPlatformFindInteractionController] for the current platform.
  final AqutterPlatformFindInteractionController platform;

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.onFindResultReceived}
  ///
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.onFindResultReceived.supported_platforms}
  void Function(
    AqutterPlatformFindInteractionController controller,
    int activeMatchOrdinal,
    int numberOfMatches,
    bool isDoneCounting,
  )?
  get onFindResultReceived => platform.onFindResultReceived;

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.findAll}
  ///
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.findAll.supported_platforms}
  Future<void> findAll({String? find}) => platform.findAll(find: find);

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.findNext}
  ///
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.findNext.supported_platforms}
  Future<void> findNext({bool forward = true}) =>
      platform.findNext(forward: forward);

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.clearMatches}
  ///
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.clearMatches.supported_platforms}
  Future<void> clearMatches() => platform.clearMatches();

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.setSearchText}
  ///
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.setSearchText.supported_platforms}
  Future<void> setSearchText(String? searchText) =>
      platform.setSearchText(searchText);

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.getSearchText}
  ///
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.getSearchText.supported_platforms}
  Future<String?> getSearchText() => platform.getSearchText();

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.isFindNavigatorVisible}
  ///
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.isFindNavigatorVisible.supported_platforms}
  Future<bool?> isFindNavigatorVisible() => platform.isFindNavigatorVisible();

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.updateResultCount}
  ///
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.updateResultCount.supported_platforms}
  Future<void> updateResultCount() => platform.updateResultCount();

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.presentFindNavigator}
  ///
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.presentFindNavigator.supported_platforms}
  Future<void> presentFindNavigator() => platform.presentFindNavigator();

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.dismissFindNavigator}
  ///
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.dismissFindNavigator.supported_platforms}
  Future<void> dismissFindNavigator() => platform.dismissFindNavigator();

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.getActiveFindSession}
  ///
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.getActiveFindSession.supported_platforms}
  Future<AqutterFindSession?> getActiveFindSession() =>
      platform.getActiveFindSession();

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.dispose}
  ///
  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.dispose.supported_platforms}
  void dispose({bool isKeepAlive = false}) => platform.dispose();

  ///{@macro aqutter_core.AqutterPlatformFindInteractionControllerCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformFindInteractionController.static().isClassSupported(
        platform: platform,
      );

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.isPropertySupported}
  static bool isPropertySupported(
    AqutterPlatformFindInteractionControllerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) => AqutterPlatformFindInteractionController.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformFindInteractionController.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformFindInteractionControllerMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformFindInteractionController.static().isMethodSupported(
    method,
    platform: platform,
  );
}
