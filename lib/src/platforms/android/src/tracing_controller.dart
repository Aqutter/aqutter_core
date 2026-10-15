import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [AndroidTracingController].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformTracingControllerCreationParams] for
/// more information.
@immutable
class AndroidTracingControllerCreationParams
    extends AqutterPlatformTracingControllerCreationParams {
  /// Creates a new [AndroidTracingControllerCreationParams] instance.
  const AndroidTracingControllerCreationParams(
    // This parameter prevents breaking changes later.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformTracingControllerCreationParams params,
  ) : super();

  /// Creates a [AndroidTracingControllerCreationParams] instance based on [AqutterPlatformTracingControllerCreationParams].
  factory AndroidTracingControllerCreationParams.fromPlatformTracingControllerCreationParams(
    AqutterPlatformTracingControllerCreationParams params,
  ) {
    return AndroidTracingControllerCreationParams(params);
  }
}

///{@macro aqutter_core.AqutterPlatformTracingController}
class AndroidTracingController extends AqutterPlatformTracingController
    with ChannelController {
  /// Creates a new [AndroidTracingController].
  AndroidTracingController(AqutterPlatformTracingControllerCreationParams params)
    : super.implementation(
        params is AndroidTracingControllerCreationParams
            ? params
            : AndroidTracingControllerCreationParams.fromPlatformTracingControllerCreationParams(
                params,
              ),
      ) {
    channel = const MethodChannel(
      'com.github.aqutter/webview_tracingcontroller',
    );
    handler = handleMethod;
    initMethodCallHandler();
  }

  static AndroidTracingController? _instance;

  ///Gets the [AndroidTracingController] shared instance.
  static AndroidTracingController instance() {
    return (_instance != null) ? _instance! : _init();
  }

  static AndroidTracingController _init() {
    _instance = AndroidTracingController(
      AndroidTracingControllerCreationParams(
        const AqutterPlatformTracingControllerCreationParams(),
      ),
    );
    return _instance!;
  }

  static final AndroidTracingController _staticValue = AndroidTracingController(
    AndroidTracingControllerCreationParams(
      const AqutterPlatformTracingControllerCreationParams(),
    ),
  );

  /// Provide static access.
  factory AndroidTracingController.static() {
    return _staticValue;
  }

  Future<dynamic> _handleMethod(MethodCall call) async {}

  @override
  Future<void> start({required AqutterTracingSettings settings}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("settings", () => settings.toMap());
    await channel?.invokeMethod('start', args);
  }

  @override
  Future<bool> stop({String? filePath}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("filePath", () => filePath);
    return await channel?.invokeMethod<bool>('stop', args) ?? false;
  }

  @override
  Future<bool> isTracing() async {
    Map<String, dynamic> args = <String, dynamic>{};
    return await channel?.invokeMethod<bool>('isTracing', args) ?? false;
  }

  @override
  void dispose() {
    // empty
  }
}

extension InternalTracingController on AndroidTracingController {
  get handleMethod => _handleMethod;
}
