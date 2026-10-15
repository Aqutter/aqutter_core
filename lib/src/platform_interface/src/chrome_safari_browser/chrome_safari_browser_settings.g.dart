// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chrome_safari_browser_settings.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///{@template aqutter_core.AqutterChromeSafariBrowserSettings}
///Class that represents the settings that can be used for an [AqutterChromeSafariBrowser] window.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterChromeSafariBrowserSettings.supported_platforms}
///
///**Officially Supported Platforms/Implementations**:
///- Android Chrome Custom Tabs
///- iOS SFSafariViewController
class AqutterChromeSafariBrowserSettings
    implements AqutterChromeSafariBrowserOptions {
  ///An additional button to be shown in `SFSafariViewController`'s toolbar.
  ///This allows the user to access powerful functionality from your extension without needing to first show the `UIActivityViewController`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController 15.0+
  AqutterActivityButton? activityButton;

  ///Sets a list of additional trusted origins that the user may navigate or be redirected to from the starting uri.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  List<String>? additionalTrustedOrigins;

  ///Adds the necessary flags and extras to signal any browser supporting custom tabs to use the browser UI
  ///at all times and avoid showing custom tab like UI.
  ///Calling this with an intent will override any custom tabs related customizations.
  ///The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  bool? alwaysUseBrowserUI;

  ///Set to `true` to enable bar collapsing. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController
  bool? barCollapsingEnabled;

  ///Set the custom style for the dismiss button. The default value is [AqutterDismissButtonStyle.DONE].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController 11.0+
  AqutterDismissButtonStyle? dismissButtonStyle;

  ///Sets a display mode of a Trusted Web Activity.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  AqutterTrustedWebActivityDisplayMode? displayMode;

  ///Set to `true` to enable the url bar to hide as the user scrolls down on the page. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  bool? enableUrlBarHiding;

  ///Set to `true` if Reader mode should be entered automatically when it is available for the webpage. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController
  bool? entersReaderIfAvailable;

  ///An event attribution associated with a click that caused this `SFSafariViewController` to be opened.
  ///This attribute is ignored if the `SFSafariViewController` url has a scheme of 'http'.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController 15.2+
  AqutterUIEventAttribution? eventAttribution;

  ///Sets the exit animations.
  ///It must contain 2 [AqutterAndroidResource], where the first one represents the "enter" animation for the application
  ///and the second one represents the "exit" animation for the browser.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  List<AqutterAndroidResource>? exitAnimations;

  ///Set to `true` to enable Instant Apps. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  bool? instantAppsEnabled;

  ///Set to `true` to launch the Android activity in `singleInstance` mode. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  bool? isSingleInstance;

  ///Set to `true` to launch the Custom Tab as a Trusted Web Activity. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  bool? isTrustedWebActivity;

  ///Set to `true` to enable Keep Alive. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  bool? keepAliveEnabled;

  ///Sets the navigation bar color. Has no effect on Android API versions below L.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  Color? navigationBarColor;

  ///Sets the navigation bar divider color. Has no effect on Android API versions below P.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  Color? navigationBarDividerColor;

  ///Set to `true` to launch the Android intent with the flag `FLAG_ACTIVITY_NO_HISTORY`. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  bool? noHistory;

  ///Set an explicit application package name that limits
  ///the components this Intent will resolve to.  If left to the default
  ///value of null, all components in all applications will considered.
  ///If non-null, the Intent can only match the components in the given
  ///application package.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  String? packageName;

  ///Set the custom background color of the navigation bar and the toolbar.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController 10.0+
  Color? preferredBarTintColor;

  ///Set the custom color of the control buttons on the navigation bar and the toolbar.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController 10.0+
  Color? preferredControlTintColor;

  ///Set the custom modal presentation style when presenting the WebView. The default value is [AqutterModalPresentationStyle.FULL_SCREEN].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController
  AqutterModalPresentationStyle? presentationStyle;

  ///Sets a screen orientation. This can be used e.g. to enable the locking of an orientation lock type.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  AqutterTrustedWebActivityScreenOrientation? screenOrientation;

  ///Sets the color of the secondary toolbar.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  Color? secondaryToolbarColor;

  ///The share state that should be applied to the custom tab. The default value is [AqutterCustomTabsShareState.SHARE_STATE_DEFAULT].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  AqutterCustomTabsShareState? shareState;

  ///Set to `false` if the title shouldn't be shown in the custom tab. The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  bool? showTitle;

  ///Sets the start animations.
  ///It must contain 2 [AqutterAndroidResource], where the first one represents the "enter" animation for the browser
  ///and the second one represents the "exit" animation for the application.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  List<AqutterAndroidResource>? startAnimations;

  ///Set the custom background color of the toolbar.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  Color? toolbarBackgroundColor;

  ///Set to the custom transition style when presenting the WebView. The default value is [AqutterModalTransitionStyle.COVER_VERTICAL].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController
  AqutterModalTransitionStyle? transitionStyle;

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///- iOS SFSafariViewController
  AqutterChromeSafariBrowserSettings({
    this.shareState = AqutterCustomTabsShareState.SHARE_STATE_DEFAULT,
    this.showTitle = true,
    this.toolbarBackgroundColor,
    this.navigationBarColor,
    this.navigationBarDividerColor,
    this.secondaryToolbarColor,
    this.enableUrlBarHiding = false,
    this.instantAppsEnabled = false,
    this.packageName,
    this.keepAliveEnabled = false,
    this.isSingleInstance = false,
    this.noHistory = false,
    this.isTrustedWebActivity = false,
    this.additionalTrustedOrigins = const [],
    this.displayMode,
    this.screenOrientation = AqutterTrustedWebActivityScreenOrientation.DEFAULT,
    this.startAnimations,
    this.exitAnimations,
    this.alwaysUseBrowserUI = false,
    this.entersReaderIfAvailable = false,
    this.barCollapsingEnabled = false,
    this.dismissButtonStyle = AqutterDismissButtonStyle.DONE,
    this.preferredBarTintColor,
    this.preferredControlTintColor,
    this.presentationStyle = AqutterModalPresentationStyle.FULL_SCREEN,
    this.transitionStyle = AqutterModalTransitionStyle.COVER_VERTICAL,
    this.activityButton,
    this.eventAttribution,
  }) {
    if (startAnimations != null) {
      assert(
        startAnimations!.length == 2,
        "start animations must be have 2 android resources",
      );
    }
    if (exitAnimations != null) {
      assert(
        exitAnimations!.length == 2,
        "exit animations must be have 2 android resources",
      );
    }
  }

  ///Gets a possible [AqutterChromeSafariBrowserSettings] instance from a [Map] value.
  static AqutterChromeSafariBrowserSettings? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterChromeSafariBrowserSettings(
      activityButton: AqutterActivityButton.fromMap(
        map['activityButton']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      displayMode: _deserializeDisplayMode(
        map['displayMode'],
        enumMethod: enumMethod,
      ),
      eventAttribution: AqutterUIEventAttribution.fromMap(
        map['eventAttribution']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      exitAnimations: map['exitAnimations'] != null
          ? List<AqutterAndroidResource>.from(
              map['exitAnimations'].map(
                (e) => AqutterAndroidResource.fromMap(
                  e?.cast<String, dynamic>(),
                  enumMethod: enumMethod,
                )!,
              ),
            )
          : null,
      navigationBarColor: map['navigationBarColor'] != null
          ? UtilColor.fromStringRepresentation(map['navigationBarColor'])
          : null,
      navigationBarDividerColor: map['navigationBarDividerColor'] != null
          ? UtilColor.fromStringRepresentation(map['navigationBarDividerColor'])
          : null,
      packageName: map['packageName'],
      preferredBarTintColor: map['preferredBarTintColor'] != null
          ? UtilColor.fromStringRepresentation(map['preferredBarTintColor'])
          : null,
      preferredControlTintColor: map['preferredControlTintColor'] != null
          ? UtilColor.fromStringRepresentation(map['preferredControlTintColor'])
          : null,
      secondaryToolbarColor: map['secondaryToolbarColor'] != null
          ? UtilColor.fromStringRepresentation(map['secondaryToolbarColor'])
          : null,
      startAnimations: map['startAnimations'] != null
          ? List<AqutterAndroidResource>.from(
              map['startAnimations'].map(
                (e) => AqutterAndroidResource.fromMap(
                  e?.cast<String, dynamic>(),
                  enumMethod: enumMethod,
                )!,
              ),
            )
          : null,
      toolbarBackgroundColor: map['toolbarBackgroundColor'] != null
          ? UtilColor.fromStringRepresentation(map['toolbarBackgroundColor'])
          : null,
    );
    instance.additionalTrustedOrigins = map['additionalTrustedOrigins'] != null
        ? List<String>.from(map['additionalTrustedOrigins']!.cast<String>())
        : null;
    instance.alwaysUseBrowserUI = map['alwaysUseBrowserUI'];
    instance.barCollapsingEnabled = map['barCollapsingEnabled'];
    instance.dismissButtonStyle = switch (enumMethod ??
        AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterDismissButtonStyle.fromNativeValue(map['dismissButtonStyle']),
      AqutterEnumMethod.value => AqutterDismissButtonStyle.fromValue(
        map['dismissButtonStyle'],
      ),
      AqutterEnumMethod.name => AqutterDismissButtonStyle.byName(
        map['dismissButtonStyle'],
      ),
    };
    instance.enableUrlBarHiding = map['enableUrlBarHiding'];
    instance.entersReaderIfAvailable = map['entersReaderIfAvailable'];
    instance.instantAppsEnabled = map['instantAppsEnabled'];
    instance.isSingleInstance = map['isSingleInstance'];
    instance.isTrustedWebActivity = map['isTrustedWebActivity'];
    instance.keepAliveEnabled = map['keepAliveEnabled'];
    instance.noHistory = map['noHistory'];
    instance.presentationStyle = switch (enumMethod ??
        AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterModalPresentationStyle.fromNativeValue(map['presentationStyle']),
      AqutterEnumMethod.value => AqutterModalPresentationStyle.fromValue(
        map['presentationStyle'],
      ),
      AqutterEnumMethod.name => AqutterModalPresentationStyle.byName(
        map['presentationStyle'],
      ),
    };
    instance.screenOrientation = switch (enumMethod ??
        AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterTrustedWebActivityScreenOrientation.fromNativeValue(
          map['screenOrientation'],
        ),
      AqutterEnumMethod.value =>
        AqutterTrustedWebActivityScreenOrientation.fromValue(
          map['screenOrientation'],
        ),
      AqutterEnumMethod.name =>
        AqutterTrustedWebActivityScreenOrientation.byName(
          map['screenOrientation'],
        ),
    };
    instance.shareState = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterCustomTabsShareState.fromNativeValue(map['shareState']),
      AqutterEnumMethod.value => AqutterCustomTabsShareState.fromValue(
        map['shareState'],
      ),
      AqutterEnumMethod.name => AqutterCustomTabsShareState.byName(
        map['shareState'],
      ),
    };
    instance.showTitle = map['showTitle'];
    instance.transitionStyle = switch (enumMethod ??
        AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterModalTransitionStyle.fromNativeValue(map['transitionStyle']),
      AqutterEnumMethod.value => AqutterModalTransitionStyle.fromValue(
        map['transitionStyle'],
      ),
      AqutterEnumMethod.name => AqutterModalTransitionStyle.byName(
        map['transitionStyle'],
      ),
    };
    return instance;
  }

  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isPropertySupported(
    AqutterChromeSafariBrowserSettingsProperty property, {
    TargetPlatform? platform,
  }) =>
      _AqutterChromeSafariBrowserSettingsPropertySupported.isPropertySupported(
        property,
        platform: platform,
      );

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "activityButton": activityButton?.toMap(enumMethod: enumMethod),
      "additionalTrustedOrigins": additionalTrustedOrigins,
      "alwaysUseBrowserUI": alwaysUseBrowserUI,
      "barCollapsingEnabled": barCollapsingEnabled,
      "dismissButtonStyle": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => dismissButtonStyle?.toNativeValue(),
        AqutterEnumMethod.value => dismissButtonStyle?.toValue(),
        AqutterEnumMethod.name => dismissButtonStyle?.name(),
      },
      "displayMode": displayMode?.toMap(enumMethod: enumMethod),
      "enableUrlBarHiding": enableUrlBarHiding,
      "entersReaderIfAvailable": entersReaderIfAvailable,
      "eventAttribution": eventAttribution?.toMap(enumMethod: enumMethod),
      "exitAnimations": exitAnimations
          ?.map((e) => e.toMap(enumMethod: enumMethod))
          .toList(),
      "instantAppsEnabled": instantAppsEnabled,
      "isSingleInstance": isSingleInstance,
      "isTrustedWebActivity": isTrustedWebActivity,
      "keepAliveEnabled": keepAliveEnabled,
      "navigationBarColor": navigationBarColor?.toHex(),
      "navigationBarDividerColor": navigationBarDividerColor?.toHex(),
      "noHistory": noHistory,
      "packageName": packageName,
      "preferredBarTintColor": preferredBarTintColor?.toHex(),
      "preferredControlTintColor": preferredControlTintColor?.toHex(),
      "presentationStyle": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => presentationStyle?.toNativeValue(),
        AqutterEnumMethod.value => presentationStyle?.toValue(),
        AqutterEnumMethod.name => presentationStyle?.name(),
      },
      "screenOrientation": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => screenOrientation?.toNativeValue(),
        AqutterEnumMethod.value => screenOrientation?.toValue(),
        AqutterEnumMethod.name => screenOrientation?.name(),
      },
      "secondaryToolbarColor": secondaryToolbarColor?.toHex(),
      "shareState": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => shareState?.toNativeValue(),
        AqutterEnumMethod.value => shareState?.toValue(),
        AqutterEnumMethod.name => shareState?.name(),
      },
      "showTitle": showTitle,
      "startAnimations": startAnimations
          ?.map((e) => e.toMap(enumMethod: enumMethod))
          .toList(),
      "toolbarBackgroundColor": toolbarBackgroundColor?.toHex(),
      "transitionStyle": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => transitionStyle?.toNativeValue(),
        AqutterEnumMethod.value => transitionStyle?.toValue(),
        AqutterEnumMethod.name => transitionStyle?.name(),
      },
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  ///Returns a copy of AqutterChromeSafariBrowserSettings.
  AqutterChromeSafariBrowserSettings copy() {
    return AqutterChromeSafariBrowserSettings.fromMap(toMap()) ??
        AqutterChromeSafariBrowserSettings();
  }

  @override
  String toString() {
    return 'AqutterChromeSafariBrowserSettings{activityButton: $activityButton, additionalTrustedOrigins: $additionalTrustedOrigins, alwaysUseBrowserUI: $alwaysUseBrowserUI, barCollapsingEnabled: $barCollapsingEnabled, dismissButtonStyle: $dismissButtonStyle, displayMode: $displayMode, enableUrlBarHiding: $enableUrlBarHiding, entersReaderIfAvailable: $entersReaderIfAvailable, eventAttribution: $eventAttribution, exitAnimations: $exitAnimations, instantAppsEnabled: $instantAppsEnabled, isSingleInstance: $isSingleInstance, isTrustedWebActivity: $isTrustedWebActivity, keepAliveEnabled: $keepAliveEnabled, navigationBarColor: $navigationBarColor, navigationBarDividerColor: $navigationBarDividerColor, noHistory: $noHistory, packageName: $packageName, preferredBarTintColor: $preferredBarTintColor, preferredControlTintColor: $preferredControlTintColor, presentationStyle: $presentationStyle, screenOrientation: $screenOrientation, secondaryToolbarColor: $secondaryToolbarColor, shareState: $shareState, showTitle: $showTitle, startAnimations: $startAnimations, toolbarBackgroundColor: $toolbarBackgroundColor, transitionStyle: $transitionStyle}';
  }
}

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

///List of [AqutterChromeSafariBrowserSettings]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterChromeSafariBrowserSettingsProperty {
  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.activityButton] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.activityButton.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController 15.0+
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  activityButton,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.additionalTrustedOrigins] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.additionalTrustedOrigins.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  additionalTrustedOrigins,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.alwaysUseBrowserUI] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.alwaysUseBrowserUI.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  alwaysUseBrowserUI,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.barCollapsingEnabled] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.barCollapsingEnabled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  barCollapsingEnabled,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.dismissButtonStyle] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.dismissButtonStyle.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController 11.0+
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  dismissButtonStyle,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.displayMode] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.displayMode.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  displayMode,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.enableUrlBarHiding] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.enableUrlBarHiding.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  enableUrlBarHiding,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.entersReaderIfAvailable] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.entersReaderIfAvailable.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  entersReaderIfAvailable,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.eventAttribution] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.eventAttribution.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController 15.2+
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  eventAttribution,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.exitAnimations] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.exitAnimations.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  exitAnimations,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.instantAppsEnabled] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.instantAppsEnabled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  instantAppsEnabled,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.isSingleInstance] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.isSingleInstance.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  isSingleInstance,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.isTrustedWebActivity] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.isTrustedWebActivity.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  isTrustedWebActivity,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.keepAliveEnabled] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.keepAliveEnabled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  keepAliveEnabled,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.navigationBarColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.navigationBarColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  navigationBarColor,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.navigationBarDividerColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.navigationBarDividerColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  navigationBarDividerColor,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.noHistory] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.noHistory.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  noHistory,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.packageName] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.packageName.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  packageName,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.preferredBarTintColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.preferredBarTintColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController 10.0+
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  preferredBarTintColor,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.preferredControlTintColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.preferredControlTintColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController 10.0+
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  preferredControlTintColor,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.presentationStyle] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.presentationStyle.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  presentationStyle,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.screenOrientation] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.screenOrientation.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  screenOrientation,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.secondaryToolbarColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.secondaryToolbarColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  secondaryToolbarColor,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.shareState] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.shareState.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  shareState,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.showTitle] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.showTitle.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  showTitle,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.startAnimations] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.startAnimations.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  startAnimations,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.toolbarBackgroundColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.toolbarBackgroundColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  toolbarBackgroundColor,

  ///Can be used to check if the [AqutterChromeSafariBrowserSettings.transitionStyle] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterChromeSafariBrowserSettings.transitionStyle.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController
  ///
  ///Use the [AqutterChromeSafariBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  transitionStyle,
}

extension _AqutterChromeSafariBrowserSettingsPropertySupported
    on AqutterChromeSafariBrowserSettings {
  static bool isPropertySupported(
    AqutterChromeSafariBrowserSettingsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterChromeSafariBrowserSettingsProperty.activityButton:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.additionalTrustedOrigins:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.alwaysUseBrowserUI:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.barCollapsingEnabled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.dismissButtonStyle:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.displayMode:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.enableUrlBarHiding:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.entersReaderIfAvailable:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.eventAttribution:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.exitAnimations:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.instantAppsEnabled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.isSingleInstance:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.isTrustedWebActivity:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.keepAliveEnabled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.navigationBarColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.navigationBarDividerColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.noHistory:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.packageName:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.preferredBarTintColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.preferredControlTintColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.presentationStyle:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.screenOrientation:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.secondaryToolbarColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.shareState:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.showTitle:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.startAnimations:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.toolbarBackgroundColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterChromeSafariBrowserSettingsProperty.transitionStyle:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
    }
  }
}
