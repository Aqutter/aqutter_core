import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'webview_platform.dart';
import 'types/tracing_mode.dart';
import 'types/main.dart';

part 'platform_tracing_controller.g.dart';

///{@template aqutter_core.AqutterPlatformTracingControllerCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformTracingController].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformTracingControllerCreationParams.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
@immutable
class AqutterPlatformTracingControllerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformTracingController].
  const AqutterPlatformTracingControllerCreationParams();

  ///{@template aqutter_core.AqutterPlatformTracingControllerCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformTracingControllerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformTracingController}
///Manages tracing of `WebView`s.
///In particular provides functionality for the app to enable/disable tracing of parts of code and to collect tracing data.
///This is useful for profiling performance issues, debugging and memory usage analysis in production and real life scenarios.
///
///The resulting trace data is sent back as a byte sequence in json format.
///This file can be loaded in "chrome://tracing" for further analysis.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformTracingController.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(
      apiName: 'AqutterTracingController',
      apiUrl:
          'https://developer.android.com/reference/androidx/webkit/AqutterTracingController',
    ),
  ],
)
abstract class AqutterPlatformTracingController extends PlatformInterface {
  /// Creates a new [AqutterPlatformTracingController]
  factory AqutterPlatformTracingController(
    AqutterPlatformTracingControllerCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformTracingController tracingController = AqutterWebViewPlatform
        .instance!
        .createPlatformTracingController(params);
    PlatformInterface.verify(tracingController, _token);
    return tracingController;
  }

  /// Creates a new [AqutterPlatformTracingController]
  factory AqutterPlatformTracingController.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformTracingController tracingControllerStatic =
        AqutterWebViewPlatform.instance!.createPlatformTracingControllerStatic();
    PlatformInterface.verify(tracingControllerStatic, _token);
    return tracingControllerStatic;
  }

  /// Used by the platform implementation to create a new
  /// [AqutterPlatformTracingController].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformTracingController.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformTracingController].
  final AqutterPlatformTracingControllerCreationParams params;

  ///{@template aqutter_core.AqutterPlatformTracingController.start}
  ///Starts tracing all `WebView`s.
  ///Depending on the trace mode in trace config specifies how the trace events are recorded.
  ///For tracing modes [AqutterTracingMode.RECORD_UNTIL_FULL] and [AqutterTracingMode.RECORD_CONTINUOUSLY]
  ///the events are recorded using an internal buffer and flushed to the outputStream
  ///when [stop] is called.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformTracingController.start.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'AqutterTracingController.start',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/AqutterTracingController#start(android.webkit.TracingConfig)',
      ),
    ],
  )
  Future<void> start({required AqutterTracingSettings settings}) {
    throw UnimplementedError(
      'start is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformTracingController.stop}
  ///Stops tracing and flushes tracing data to the specified output stream.
  ///The data is sent to the specified output stream in json format typically in
  ///chunks.
  ///
  ///Returns `false` if the WebView framework was not tracing at the time of the call,
  ///`true` otherwise.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformTracingController.stop.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'AqutterTracingController.stop',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/AqutterTracingController#stop(java.io.OutputStream,%20java.util.concurrent.Executor)',
      ),
    ],
  )
  Future<bool> stop({String? filePath}) {
    throw UnimplementedError('stop is not implemented on the current platform');
  }

  ///{@template aqutter_core.AqutterPlatformTracingController.isTracing}
  ///Returns whether the WebView framework is tracing.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformTracingController.isTracing.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'AqutterTracingController.isTracing',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/AqutterTracingController#isTracing()',
      ),
    ],
  )
  Future<bool> isTracing() {
    throw UnimplementedError(
      'isTracing is not implemented on the current platform',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformTracingControllerCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);

  ///{@template aqutter_core.AqutterPlatformTracingController.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformTracingControllerMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformTracingControllerMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}

List<dynamic> _deserializeCategories(
  List<dynamic> categories, {
  AqutterEnumMethod? enumMethod,
}) {
  List<dynamic> deserializedCategories = [];
  for (dynamic category in categories) {
    if (category is String) {
      deserializedCategories.add(category);
    } else if (category is int) {
      final mode = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterTracingCategory.fromNativeValue(category),
        AqutterEnumMethod.value => AqutterTracingCategory.fromValue(category),
        AqutterEnumMethod.name => null,
      };
      if (mode != null) {
        deserializedCategories.add(mode);
      }
    }
  }
  return deserializedCategories;
}

List<dynamic> _serializeCategories(
  List<dynamic> categories, {
  AqutterEnumMethod? enumMethod,
}) {
  List<dynamic> serializedCategories = [];
  for (dynamic category in categories) {
    if (category is String) {
      serializedCategories.add(category);
    } else if (category is AqutterTracingCategory) {
      serializedCategories.add(switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => category.toNativeValue(),
        AqutterEnumMethod.value => category.toValue(),
        AqutterEnumMethod.name => null,
      });
    }
  }
  return serializedCategories;
}

///{@template aqutter_core.AqutterTracingSettings}
///Class that represents the settings used to configure the [AqutterPlatformTracingController].
///{@endtemplate}
///
///{@macro aqutter_core.AqutterTracingSettings.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(
      apiName: 'TracingConfig',
      apiUrl:
          'https://developer.android.com/reference/androidx/webkit/TracingConfig',
    ),
  ],
)
@ExchangeableObject(copyMethod: true)
class AqutterTracingSettings_ {
  ///Adds predefined [AqutterTracingCategory] and/or custom [String] sets of categories to be included in the trace output.
  ///
  ///Note that the categories are defined by the currently-in-use version of WebView.
  ///They live in chromium code and are not part of the Android API.
  ///See [chromium documentation on tracing](https://www.chromium.org/developers/how-tos/trace-event-profiling-tool)
  ///for more details.
  ///
  ///A category pattern can contain wildcards, e.g. `"blink*"` or full category name e.g. `"renderer.scheduler"`.
  @ExchangeableObjectProperty(
    deserializer: _deserializeCategories,
    serializer: _serializeCategories,
  )
  List<dynamic> categories;

  ///The tracing mode for this configuration.
  ///When tracingMode is not set explicitly, the default is [AqutterTracingMode.RECORD_CONTINUOUSLY].
  ///
  ///{@macro aqutter_core.AqutterTracingSettings.tracingMode.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  AqutterTracingMode_? tracingMode;

  @ExchangeableObjectConstructor()
  AqutterTracingSettings_({this.categories = const [], this.tracingMode}) {
    assert(
      this.categories
          .map(
            (e) => e.runtimeType is String || e.runtimeType is AqutterTracingCategory,
          )
          .contains(false),
      "categories must contain only String or AqutterTracingCategory items",
    );
  }

  ///{@template aqutter_core.AqutterTracingSettings.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterTracingSettingsClassSupported.isClassSupported(platform: platform);

  ///{@template aqutter_core.AqutterTracingSettings.isPropertySupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  static bool isPropertySupported(
    AqutterTracingSettingsProperty property, {
    TargetPlatform? platform,
  }) => _AqutterTracingSettingsPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );
}
