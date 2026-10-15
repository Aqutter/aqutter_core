import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [AndroidPrintJobController].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformPrintJobControllerCreationParams] for
/// more information.
@immutable
class AndroidPrintJobControllerCreationParams
    extends AqutterPlatformPrintJobControllerCreationParams {
  /// Creates a new [AndroidPrintJobControllerCreationParams] instance.
  const AndroidPrintJobControllerCreationParams({required super.id});

  /// Creates a [AndroidPrintJobControllerCreationParams] instance based on [AqutterPlatformPrintJobControllerCreationParams].
  factory AndroidPrintJobControllerCreationParams.fromPlatformPrintJobControllerCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformPrintJobControllerCreationParams params,
  ) {
    return AndroidPrintJobControllerCreationParams(id: params.id);
  }
}

///{@macro aqutter_core.AqutterPlatformPrintJobController}
class AndroidPrintJobController extends AqutterPlatformPrintJobController
    with ChannelController {
  /// Constructs a [AndroidPrintJobController].
  AndroidPrintJobController(AqutterPlatformPrintJobControllerCreationParams params)
    : super.implementation(
        params is AndroidPrintJobControllerCreationParams
            ? params
            : AndroidPrintJobControllerCreationParams.fromPlatformPrintJobControllerCreationParams(
                params,
              ),
      ) {
    channel = MethodChannel(
      'com.github.aqutter/webview_printjobcontroller_${params.id}',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }

  static final AndroidPrintJobController _staticValue =
      AndroidPrintJobController(
        AndroidPrintJobControllerCreationParams(id: ''),
      );

  /// Provide static access.
  factory AndroidPrintJobController.static() {
    return _staticValue;
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "onComplete":
        bool completed = call.arguments["completed"];
        String? error = call.arguments["error"];
        onComplete?.call(completed, error);
        break;
      default:
        throw UnimplementedError("Unimplemented ${call.method} method");
    }
  }

  @override
  Future<void> cancel() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('cancel', args);
  }

  @override
  Future<void> restart() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('restart', args);
  }

  @override
  Future<AqutterPrintJobInfo?> getInfo() async {
    Map<String, dynamic> args = <String, dynamic>{};
    Map<String, dynamic>? infoMap = (await channel?.invokeMethod(
      'getInfo',
      args,
    ))?.cast<String, dynamic>();
    return AqutterPrintJobInfo.fromMap(infoMap);
  }

  @override
  Future<void> dispose() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('dispose', args);
    disposeChannel();
  }
}
