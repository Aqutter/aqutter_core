// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_tracing_controller.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///{@template aqutter_core.AqutterTracingSettings}
///Class that represents the settings used to configure the [AqutterPlatformTracingController].
///{@endtemplate}
///
///{@macro aqutter_core.AqutterTracingSettings.supported_platforms}
///
///**Officially Supported Platforms/Implementations**:
///- Android WebView ([Official API - TracingConfig](https://developer.android.com/reference/androidx/webkit/TracingConfig))
class AqutterTracingSettings {
  ///Adds predefined [AqutterTracingCategory] and/or custom [String] sets of categories to be included in the trace output.
  ///
  ///Note that the categories are defined by the currently-in-use version of WebView.
  ///They live in chromium code and are not part of the Android API.
  ///See [chromium documentation on tracing](https://www.chromium.org/developers/how-tos/trace-event-profiling-tool)
  ///for more details.
  ///
  ///A category pattern can contain wildcards, e.g. `"blink*"` or full category name e.g. `"renderer.scheduler"`.
  List<dynamic> categories;

  ///The tracing mode for this configuration.
  ///When tracingMode is not set explicitly, the default is [AqutterTracingMode.RECORD_CONTINUOUSLY].
  ///
  ///{@macro aqutter_core.AqutterTracingSettings.tracingMode.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  AqutterTracingMode? tracingMode;

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - TracingConfig](https://developer.android.com/reference/androidx/webkit/TracingConfig))
  AqutterTracingSettings({this.categories = const [], this.tracingMode}) {
    assert(
      this.categories
          .map(
            (e) =>
                e.runtimeType is String ||
                e.runtimeType is AqutterTracingCategory,
          )
          .contains(false),
      "categories must contain only String or AqutterTracingCategory items",
    );
  }

  ///Gets a possible [AqutterTracingSettings] instance from a [Map] value.
  static AqutterTracingSettings? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterTracingSettings(
      tracingMode: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterTracingMode.fromNativeValue(
          map['tracingMode'],
        ),
        AqutterEnumMethod.value => AqutterTracingMode.fromValue(
          map['tracingMode'],
        ),
        AqutterEnumMethod.name => AqutterTracingMode.byName(map['tracingMode']),
      },
    );
    if (map['categories'] != null) {
      instance.categories = _deserializeCategories(
        map['categories'],
        enumMethod: enumMethod,
      );
    }
    return instance;
  }

  ///{@template aqutter_core.AqutterTracingSettings.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterTracingSettingsClassSupported.isClassSupported(
        platform: platform,
      );

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

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "categories": _serializeCategories(categories, enumMethod: enumMethod),
      "tracingMode": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => tracingMode?.toNativeValue(),
        AqutterEnumMethod.value => tracingMode?.toValue(),
        AqutterEnumMethod.name => tracingMode?.name(),
      },
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  ///Returns a copy of AqutterTracingSettings.
  AqutterTracingSettings copy() {
    return AqutterTracingSettings.fromMap(toMap()) ?? AqutterTracingSettings();
  }

  @override
  String toString() {
    return 'AqutterTracingSettings{categories: $categories, tracingMode: $tracingMode}';
  }
}

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformTracingControllerCreationParamsClassSupported
    on AqutterPlatformTracingControllerCreationParams {
  ///{@template aqutter_core.AqutterPlatformTracingControllerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformTracingControllerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformTracingControllerClassSupported
    on AqutterPlatformTracingController {
  ///{@template aqutter_core.AqutterPlatformTracingController.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterTracingController](https://developer.android.com/reference/androidx/webkit/AqutterTracingController))
  ///
  ///Use the [AqutterPlatformTracingController.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformTracingController]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformTracingControllerMethod {
  ///Can be used to check if the [AqutterPlatformTracingController.isTracing] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformTracingController.isTracing.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterTracingController.isTracing](https://developer.android.com/reference/android/webkit/AqutterTracingController#isTracing()))
  ///
  ///Use the [AqutterPlatformTracingController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isTracing,

  ///Can be used to check if the [AqutterPlatformTracingController.start] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformTracingController.start.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterTracingController.start](https://developer.android.com/reference/android/webkit/AqutterTracingController#start(android.webkit.TracingConfig)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [settings]: all platforms
  ///
  ///Use the [AqutterPlatformTracingController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  start,

  ///Can be used to check if the [AqutterPlatformTracingController.stop] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformTracingController.stop.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterTracingController.stop](https://developer.android.com/reference/android/webkit/AqutterTracingController#stop(java.io.OutputStream,%20java.util.concurrent.Executor)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [filePath]: all platforms
  ///
  ///Use the [AqutterPlatformTracingController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  stop,
}

extension _AqutterPlatformTracingControllerMethodSupported
    on AqutterPlatformTracingController {
  static bool isMethodSupported(
    AqutterPlatformTracingControllerMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformTracingControllerMethod.isTracing:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformTracingControllerMethod.start:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformTracingControllerMethod.stop:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

extension _AqutterTracingSettingsClassSupported on AqutterTracingSettings {
  ///{@template aqutter_core.AqutterTracingSettings.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - TracingConfig](https://developer.android.com/reference/androidx/webkit/TracingConfig))
  ///
  ///Use the [AqutterTracingSettings.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [TargetPlatform.android].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterTracingSettings]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterTracingSettingsProperty {
  ///Can be used to check if the [AqutterTracingSettings.tracingMode] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterTracingSettings.tracingMode.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterTracingSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  tracingMode,
}

extension _AqutterTracingSettingsPropertySupported on AqutterTracingSettings {
  static bool isPropertySupported(
    AqutterTracingSettingsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterTracingSettingsProperty.tracingMode:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
