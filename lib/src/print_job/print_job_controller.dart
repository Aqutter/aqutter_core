import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformPrintJobController}
///
///{@macro aqutter_core.AqutterPlatformPrintJobController.supported_platforms}
class AqutterPrintJobController {
  ///{@macro aqutter_core.AqutterPlatformPrintJobController}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.supported_platforms}
  AqutterPrintJobController({required String id})
    : this.fromPlatformCreationParams(
        params: AqutterPlatformPrintJobControllerCreationParams(id: id),
      );

  /// Constructs a [AqutterPrintJobController].
  ///
  /// See [AqutterPrintJobController.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterPrintJobController.fromPlatformCreationParams({
    required AqutterPlatformPrintJobControllerCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformPrintJobController(params));

  /// Constructs a [AqutterPrintJobController] from a specific platform implementation.
  AqutterPrintJobController.fromPlatform({required this.platform});

  /// Implementation of [AqutterPlatformPrintJobController] for the current platform.
  final AqutterPlatformPrintJobController platform;

  ///{@macro aqutter_core.AqutterPlatformPrintJobController.id}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.id.supported_platforms}
  String get id => platform.id;

  ///{@macro aqutter_core.AqutterPlatformPrintJobController.onComplete}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.onComplete.supported_platforms}
  AqutterPrintJobCompletionHandler? get onComplete => platform.onComplete;

  void set onComplete(AqutterPrintJobCompletionHandler? handler) {
    platform.onComplete = handler;
  }

  ///{@macro aqutter_core.AqutterPlatformPrintJobController.cancel}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.cancel.supported_platforms}
  Future<void> cancel() => platform.cancel();

  ///{@macro aqutter_core.AqutterPlatformPrintJobController.restart}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.restart.supported_platforms}
  Future<void> restart() => platform.restart();

  ///{@macro aqutter_core.AqutterPlatformPrintJobController.dismiss}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.dismiss.supported_platforms}
  Future<void> dismiss({bool animated = true}) =>
      platform.dismiss(animated: animated);

  ///{@macro aqutter_core.AqutterPlatformPrintJobController.getInfo}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.getInfo.supported_platforms}
  Future<AqutterPrintJobInfo?> getInfo() => platform.getInfo();

  ///{@macro aqutter_core.AqutterPlatformPrintJobController.dispose}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.dispose.supported_platforms}
  void dispose() => platform.dispose();

  ///{@macro aqutter_core.AqutterPlatformPrintJobControllerCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformPrintJobController.static().isClassSupported(platform: platform);

  ///{@macro aqutter_core.AqutterPlatformPrintJobController.isPropertySupported}
  static bool isPropertySupported(
    dynamic property, {
    TargetPlatform? platform,
  }) => AqutterPlatformPrintJobController.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformPrintJobController.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformPrintJobControllerMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformPrintJobController.static().isMethodSupported(
    method,
    platform: platform,
  );
}
