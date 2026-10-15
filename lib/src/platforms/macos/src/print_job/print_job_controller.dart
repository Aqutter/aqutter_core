import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [MacOSPrintJobController].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformPrintJobControllerCreationParams] for
/// more information.
@immutable
class MacOSPrintJobControllerCreationParams
    extends AqutterPlatformPrintJobControllerCreationParams {
  /// Creates a new [MacOSPrintJobControllerCreationParams] instance.
  const MacOSPrintJobControllerCreationParams({required super.id});

  /// Creates a [MacOSPrintJobControllerCreationParams] instance based on [AqutterPlatformPrintJobControllerCreationParams].
  factory MacOSPrintJobControllerCreationParams.fromPlatformPrintJobControllerCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformPrintJobControllerCreationParams params,
  ) {
    return MacOSPrintJobControllerCreationParams(id: params.id);
  }
}

///{@macro aqutter_core.AqutterPlatformPrintJobController}
class MacOSPrintJobController extends AqutterPlatformPrintJobController
    with ChannelController {
  /// Constructs a [MacOSPrintJobController].
  MacOSPrintJobController(AqutterPlatformPrintJobControllerCreationParams params)
    : super.implementation(
        params is MacOSPrintJobControllerCreationParams
            ? params
            : MacOSPrintJobControllerCreationParams.fromPlatformPrintJobControllerCreationParams(
                params,
              ),
      ) {
    channel = MethodChannel(
      'com.github.aqutter/webview_printjobcontroller_${params.id}',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }

  static final MacOSPrintJobController _staticValue = MacOSPrintJobController(
    MacOSPrintJobControllerCreationParams(id: ''),
  );

  /// Provide static access.
  factory MacOSPrintJobController.static() {
    return _staticValue;
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "onComplete":
        bool completed = call.arguments["completed"];
        String? error = call.arguments["error"];
        if (onComplete != null) {
          onComplete!(completed, error);
        }
        break;
      default:
        throw UnimplementedError("Unimplemented ${call.method} method");
    }
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
