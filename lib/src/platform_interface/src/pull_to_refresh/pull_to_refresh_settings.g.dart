// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pull_to_refresh_settings.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Pull-To-Refresh Settings for [AqutterPlatformPullToRefreshController].
///
///**Officially Supported Platforms/Implementations**:
///- Android WebView
///- iOS WKWebView
class AqutterPullToRefreshSettings {
  ///The title text to display in the refresh control.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  AqutterAttributedString? attributedTitle;

  ///The background color of the refresh control.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  Color? backgroundColor;

  ///The color of the refresh control.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  Color? color;

  ///The distance to trigger a sync in dips.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  int? distanceToTriggerSync;

  ///Sets whether the pull-to-refresh feature is enabled or not.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  bool? enabled;

  ///The size of the refresh indicator.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  AqutterPullToRefreshSize? size;

  ///The distance in pixels that the refresh indicator can be pulled beyond its resting position.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  int? slingshotDistance;

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  AqutterPullToRefreshSettings({
    this.attributedTitle,
    this.backgroundColor,
    this.color,
    this.distanceToTriggerSync,
    this.enabled = true,
    this.size,
    this.slingshotDistance,
  });

  ///Gets a possible [AqutterPullToRefreshSettings] instance from a [Map] value.
  static AqutterPullToRefreshSettings? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterPullToRefreshSettings(
      attributedTitle: AqutterAttributedString.fromMap(
        map['attributedTitle']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      backgroundColor: map['backgroundColor'] != null
          ? UtilColor.fromStringRepresentation(map['backgroundColor'])
          : null,
      color: map['color'] != null
          ? UtilColor.fromStringRepresentation(map['color'])
          : null,
      distanceToTriggerSync: map['distanceToTriggerSync'],
      size: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterPullToRefreshSize.fromNativeValue(map['size']),
        AqutterEnumMethod.value => AqutterPullToRefreshSize.fromValue(
          map['size'],
        ),
        AqutterEnumMethod.name => AqutterPullToRefreshSize.byName(map['size']),
      },
      slingshotDistance: map['slingshotDistance'],
    );
    instance.enabled = map['enabled'];
    return instance;
  }

  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isPropertySupported(
    AqutterPullToRefreshSettingsProperty property, {
    TargetPlatform? platform,
  }) => _AqutterPullToRefreshSettingsPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "attributedTitle": attributedTitle?.toMap(enumMethod: enumMethod),
      "backgroundColor": backgroundColor?.toHex(),
      "color": color?.toHex(),
      "distanceToTriggerSync": distanceToTriggerSync,
      "enabled": enabled,
      "size": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => size?.toNativeValue(),
        AqutterEnumMethod.value => size?.toValue(),
        AqutterEnumMethod.name => size?.name(),
      },
      "slingshotDistance": slingshotDistance,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  ///Returns a copy of AqutterPullToRefreshSettings.
  AqutterPullToRefreshSettings copy() {
    return AqutterPullToRefreshSettings.fromMap(toMap()) ??
        AqutterPullToRefreshSettings();
  }

  @override
  String toString() {
    return 'AqutterPullToRefreshSettings{attributedTitle: $attributedTitle, backgroundColor: $backgroundColor, color: $color, distanceToTriggerSync: $distanceToTriggerSync, enabled: $enabled, size: $size, slingshotDistance: $slingshotDistance}';
  }
}

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

///List of [AqutterPullToRefreshSettings]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPullToRefreshSettingsProperty {
  ///Can be used to check if the [AqutterPullToRefreshSettings.attributedTitle] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPullToRefreshSettings.attributedTitle.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPullToRefreshSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  attributedTitle,

  ///Can be used to check if the [AqutterPullToRefreshSettings.backgroundColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPullToRefreshSettings.backgroundColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPullToRefreshSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  backgroundColor,

  ///Can be used to check if the [AqutterPullToRefreshSettings.color] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPullToRefreshSettings.color.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPullToRefreshSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  color,

  ///Can be used to check if the [AqutterPullToRefreshSettings.distanceToTriggerSync] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPullToRefreshSettings.distanceToTriggerSync.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPullToRefreshSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  distanceToTriggerSync,

  ///Can be used to check if the [AqutterPullToRefreshSettings.enabled] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPullToRefreshSettings.enabled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPullToRefreshSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  enabled,

  ///Can be used to check if the [AqutterPullToRefreshSettings.size] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPullToRefreshSettings.size.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPullToRefreshSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  size,

  ///Can be used to check if the [AqutterPullToRefreshSettings.slingshotDistance] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPullToRefreshSettings.slingshotDistance.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPullToRefreshSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  slingshotDistance,
}

extension _AqutterPullToRefreshSettingsPropertySupported
    on AqutterPullToRefreshSettings {
  static bool isPropertySupported(
    AqutterPullToRefreshSettingsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPullToRefreshSettingsProperty.attributedTitle:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPullToRefreshSettingsProperty.backgroundColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPullToRefreshSettingsProperty.color:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPullToRefreshSettingsProperty.distanceToTriggerSync:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPullToRefreshSettingsProperty.enabled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPullToRefreshSettingsProperty.size:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPullToRefreshSettingsProperty.slingshotDistance:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
