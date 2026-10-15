import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../types/webview_rect.dart';
import '../types/modal_presentation_style.dart';
import '../types/modal_transition_style.dart';
import '../types/window_style_mask.dart';
import '../types/window_titlebar_separator_style.dart';
import '../types/window_type.dart';
import '../util.dart';

import '../webview/webview_settings.dart';

import 'android/browser_options.dart';
import '../webview/android/webview_options.dart';

import 'apple/browser_options.dart';
import '../webview/apple/webview_options.dart';
import '../types/enum_method.dart';

part 'browser_settings.g.dart';

///Class that represents the settings that can be used for an [AqutterBrowser] instance.
class AqutterBrowserClassSettings {
  ///Browser settings.
  late AqutterBrowserSettings browserSettings;

  ///WebView settings.
  late AqutterWebViewSettings webViewSettings;

  AqutterBrowserClassSettings({
    AqutterBrowserSettings? browserSettings,
    AqutterWebViewSettings? webViewSettings,
  }) {
    this.browserSettings = browserSettings ?? AqutterBrowserSettings();
    this.webViewSettings = webViewSettings ?? AqutterWebViewSettings();
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> options = {};

    options.addAll(browserSettings.toMap());
    options.addAll(webViewSettings.toMap());

    return options;
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }

  String toString() {
    return toMap().toString();
  }

  factory AqutterBrowserClassSettings.fromMap(
    Map<String, dynamic> options, {
    AqutterBrowserClassSettings? instance,
    AqutterEnumMethod? enumMethod,
  }) {
    if (instance == null) {
      instance = AqutterBrowserClassSettings();
    }
    instance.browserSettings =
        AqutterBrowserSettings.fromMap(options, enumMethod: enumMethod) ??
        AqutterBrowserSettings();
    instance.webViewSettings =
        AqutterWebViewSettings.fromMap(options, enumMethod: enumMethod) ??
        AqutterWebViewSettings();
    return instance;
  }

  AqutterBrowserClassSettings copy() {
    return AqutterBrowserClassSettings.fromMap(toMap());
  }
}

class AqutterBrowserOptions {
  Map<String, dynamic> toMap() {
    return {};
  }

  static AqutterBrowserOptions fromMap(Map<String, dynamic> map) {
    return AqutterBrowserOptions();
  }

  AqutterBrowserOptions copy() {
    return AqutterBrowserOptions.fromMap(this.toMap());
  }

  Map<String, dynamic> toJson() {
    return this.toMap();
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

///{@template aqutter_core.AqutterWebViewSettings}
///This class represents all [AqutterBrowser] settings available.
///{@endtemplate}
@ExchangeableObject(copyMethod: true)
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WindowsPlatform(),
    LinuxPlatform(
      apiName: 'GtkWindow',
      apiUrl: 'https://docs.gtk.org/gtk3/class.Window.html',
    ),
  ],
)
class AqutterBrowserSettings_
    implements AqutterBrowserOptions, AqutterAndroidOptions, AqutterIosOptions {
  ///Set to `true` to create the browser and load the page, but not show it. Omit or set to `false` to have the browser open and load normally.
  ///The default value is `false`.
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  bool? hidden;

  ///Set to `true` to hide the toolbar at the top of the WebView. The default value is `false`.
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
    ],
  )
  bool? hideToolbarTop;

  ///Set the custom background color of the toolbar at the top.
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
    ],
  )
  Color_? toolbarTopBackgroundColor;

  ///Set to `true` to hide the url bar on the toolbar at the top. The default value is `false`.
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
    ],
  )
  bool? hideUrlBar;

  ///Set to `true` to hide the progress bar when the WebView is loading a page. The default value is `false`.
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
    ],
  )
  bool? hideProgressBar;

  ///Set to `true` to hide the default menu items. The default value is `false`.
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
    ],
  )
  bool? hideDefaultMenuItems;

  ///Set to `true` if you want the title should be displayed. The default value is `false`.
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  bool? hideTitleBar;

  ///Set the action bar's title.
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  String? toolbarTopFixedTitle;

  ///Set to `false` to not close the AqutterBrowser when the user click on the Android back button and the WebView cannot go back to the history. The default value is `true`.
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  bool? closeOnCannotGoBack;

  ///Set to `false` to block the AqutterBrowser WebView going back when the user click on the Android back button. The default value is `true`.
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  bool? allowGoBackWithBackButton;

  ///Set to `true` to close the AqutterBrowser when the user click on the Android back button. The default value is `false`.
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  bool? shouldCloseOnBackButtonPressed;

  ///Set to `true` to set the toolbar at the top translucent. The default value is `true`.
  @SupportedPlatforms(platforms: [IOSPlatform()])
  bool? toolbarTopTranslucent;

  ///Set the tint color to apply to the navigation bar background.
  @SupportedPlatforms(platforms: [IOSPlatform()])
  Color_? toolbarTopBarTintColor;

  ///Set the tint color to apply to the navigation items and bar button items.
  @SupportedPlatforms(platforms: [IOSPlatform()])
  Color_? toolbarTopTintColor;

  ///Set to `true` to hide the toolbar at the bottom of the WebView. The default value is `false`.
  @SupportedPlatforms(platforms: [IOSPlatform()])
  bool? hideToolbarBottom;

  ///Set the custom background color of the toolbar at the bottom.
  @SupportedPlatforms(platforms: [IOSPlatform()])
  Color_? toolbarBottomBackgroundColor;

  ///Set the tint color to apply to the bar button items.
  @SupportedPlatforms(platforms: [IOSPlatform()])
  Color_? toolbarBottomTintColor;

  ///Set to `true` to set the toolbar at the bottom translucent. The default value is `true`.
  @SupportedPlatforms(platforms: [IOSPlatform()])
  bool? toolbarBottomTranslucent;

  ///Set the custom text for the close button.
  @SupportedPlatforms(platforms: [IOSPlatform()])
  String? closeButtonCaption;

  ///Set the custom color for the close button.
  @SupportedPlatforms(platforms: [IOSPlatform()])
  Color_? closeButtonColor;

  ///Set to `true` to hide the close button. The default value is `false`.
  @SupportedPlatforms(platforms: [IOSPlatform()])
  bool? hideCloseButton;

  ///Set the custom color for the menu button.
  @SupportedPlatforms(platforms: [IOSPlatform()])
  Color_? menuButtonColor;

  ///Set the custom modal presentation style when presenting the WebView. The default value is [AqutterModalPresentationStyle.FULL_SCREEN].
  @SupportedPlatforms(platforms: [IOSPlatform()])
  AqutterModalPresentationStyle_? presentationStyle;

  ///Set to the custom transition style when presenting the WebView. The default value is [AqutterModalTransitionStyle.COVER_VERTICAL].
  @SupportedPlatforms(platforms: [IOSPlatform()])
  AqutterModalTransitionStyle_? transitionStyle;

  ///How the browser window should be added to the main window.
  ///The default value is [AqutterWindowType.WINDOW].
  @SupportedPlatforms(
    platforms: [MacOSPlatform(), WindowsPlatform(), LinuxPlatform()],
  )
  AqutterWindowType_? windowType;

  ///The window’s alpha value.
  ///The default value is `1.0`.
  @SupportedPlatforms(
    platforms: [MacOSPlatform(), WindowsPlatform(), LinuxPlatform()],
  )
  double? windowAlphaValue;

  ///Flags that describe the window’s current style, such as if it’s resizable or in full-screen mode.
  @SupportedPlatforms(platforms: [MacOSPlatform()])
  AqutterWindowStyleMask_? windowStyleMask;

  ///The type of separator that the app displays between the title bar and content of a window.
  @SupportedPlatforms(platforms: [MacOSPlatform(available: '11.0')])
  AqutterWindowTitlebarSeparatorStyle_? windowTitlebarSeparatorStyle;

  ///Sets the origin and size of the window’s frame rectangle according to a given frame rectangle,
  ///thereby setting its position and size onscreen.
  @SupportedPlatforms(
    platforms: [MacOSPlatform(), WindowsPlatform(), LinuxPlatform()],
  )
  AqutterWebViewRect_? windowFrame;

  AqutterBrowserSettings_({
    this.hidden = false,
    this.hideToolbarTop = false,
    this.toolbarTopBackgroundColor,
    this.hideUrlBar = false,
    this.hideProgressBar = false,
    this.hideDefaultMenuItems = false,
    this.toolbarTopTranslucent = true,
    this.toolbarTopTintColor,
    this.hideToolbarBottom = false,
    this.toolbarBottomBackgroundColor,
    this.toolbarBottomTintColor,
    this.toolbarBottomTranslucent = true,
    this.closeButtonCaption,
    this.closeButtonColor,
    this.hideCloseButton = false,
    this.menuButtonColor,
    this.presentationStyle = AqutterModalPresentationStyle_.FULL_SCREEN,
    this.transitionStyle = AqutterModalTransitionStyle_.COVER_VERTICAL,
    this.hideTitleBar = false,
    this.toolbarTopFixedTitle,
    this.closeOnCannotGoBack = true,
    this.allowGoBackWithBackButton = true,
    this.shouldCloseOnBackButtonPressed = false,
    this.windowType,
    this.windowAlphaValue = 1.0,
    this.windowStyleMask,
    this.windowTitlebarSeparatorStyle,
    this.windowFrame,
  });

  @override
  @ExchangeableObjectMethod(ignore: true)
  AqutterBrowserSettings_ copy() {
    throw UnimplementedError();
  }

  @override
  @ExchangeableObjectMethod(ignore: true)
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  @override
  @ExchangeableObjectMethod(ignore: true)
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }

  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isPropertySupported(
    AqutterBrowserSettingsProperty property, {
    TargetPlatform? platform,
  }) => _AqutterBrowserSettingsPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );
}

///Class that represents the options that can be used for an [AqutterBrowser] WebView.
///Use [AqutterBrowserClassSettings] instead.
@Deprecated('Use AqutterBrowserClassSettings instead')
class AqutterBrowserClassOptions {
  ///Cross-platform options.
  late AqutterInAppBrowserOptions crossPlatform;

  ///Android-specific options.
  late AqutterAndroidBrowserOptions android;

  ///iOS-specific options.
  late AqutterIOSBrowserOptions ios;

  ///WebView options.
  late AqutterWebViewGroupOptions webViewGroupOptions;

  AqutterBrowserClassOptions({
    AqutterInAppBrowserOptions? crossPlatform,
    AqutterAndroidBrowserOptions? android,
    AqutterIOSBrowserOptions? ios,
    AqutterWebViewGroupOptions? webViewGroupOptions,
  }) {
    this.crossPlatform = crossPlatform ?? AqutterInAppBrowserOptions();
    this.android = android ?? AqutterAndroidBrowserOptions();
    this.ios = ios ?? AqutterIOSBrowserOptions();
    this.webViewGroupOptions =
        webViewGroupOptions ?? AqutterWebViewGroupOptions();
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> options = {};

    options.addAll(this.crossPlatform.toMap());
    options.addAll(this.webViewGroupOptions.crossPlatform.toMap());
    if (Util.isAndroid) {
      options.addAll(this.android.toMap());
      options.addAll(this.webViewGroupOptions.android.toMap());
    } else if (Util.isIOS) {
      options.addAll(this.ios.toMap());
      options.addAll(this.webViewGroupOptions.ios.toMap());
    }

    return options;
  }

  Map<String, dynamic> toJson() {
    return this.toMap();
  }

  @override
  String toString() {
    return toMap().toString();
  }

  static AqutterBrowserClassOptions fromMap(
    Map<String, dynamic> options, {
    AqutterEnumMethod? enumMethod,
  }) {
    AqutterBrowserClassOptions browserClassOptions =
        AqutterBrowserClassOptions();

    browserClassOptions.crossPlatform = AqutterInAppBrowserOptions.fromMap(
      options,
    );
    browserClassOptions.webViewGroupOptions =
        AqutterWebViewGroupOptions();
    browserClassOptions.webViewGroupOptions.crossPlatform =
        AqutterInAppWebViewOptions.fromMap(options);
    if (Util.isAndroid) {
      browserClassOptions.android = AqutterAndroidBrowserOptions.fromMap(
        options,
      );
      browserClassOptions.webViewGroupOptions.android =
          AqutterAndroidWebViewOptions.fromMap(options);
    } else if (Util.isIOS) {
      browserClassOptions.ios = AqutterIOSBrowserOptions.fromMap(options);
      browserClassOptions.webViewGroupOptions.ios =
          AqutterIOSWebViewOptions.fromMap(options);
    }

    return browserClassOptions;
  }

  AqutterBrowserClassOptions copy() {
    return AqutterBrowserClassOptions.fromMap(this.toMap());
  }
}

///This class represents all the cross-platform [AqutterBrowser] options available.
///Use [AqutterBrowserClassSettings] instead.
@Deprecated('Use AqutterBrowserClassSettings instead')
class AqutterInAppBrowserOptions
    implements AqutterBrowserOptions, AqutterAndroidOptions, AqutterIosOptions {
  ///Set to `true` to create the browser and load the page, but not show it. Omit or set to `false` to have the browser open and load normally.
  ///The default value is `false`.
  bool hidden;

  ///Set to `true` to hide the toolbar at the top of the WebView. The default value is `false`.
  bool hideToolbarTop;

  ///Set the custom background color of the toolbar at the top.
  Color? toolbarTopBackgroundColor;

  ///Set to `true` to hide the url bar on the toolbar at the top. The default value is `false`.
  bool hideUrlBar;

  ///Set to `true` to hide the progress bar when the WebView is loading a page. The default value is `false`.
  bool hideProgressBar;

  AqutterInAppBrowserOptions({
    this.hidden = false,
    this.hideToolbarTop = false,
    this.toolbarTopBackgroundColor,
    this.hideUrlBar = false,
    this.hideProgressBar = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      "hidden": hidden,
      "hideToolbarTop": hideToolbarTop,
      "toolbarTopBackgroundColor": toolbarTopBackgroundColor?.toHex(),
      "hideUrlBar": hideUrlBar,
      "hideProgressBar": hideProgressBar,
    };
  }

  static AqutterInAppBrowserOptions fromMap(Map<String, dynamic> map) {
    var instance = AqutterInAppBrowserOptions();
    instance.hidden = map["hidden"];
    instance.hideToolbarTop = map["hideToolbarTop"];
    instance.toolbarTopBackgroundColor = UtilColor.fromHex(
      map["toolbarTopBackgroundColor"],
    );
    instance.hideUrlBar = map["hideUrlBar"];
    instance.hideProgressBar = map["hideProgressBar"];
    return instance;
  }

  @override
  Map<String, dynamic> toJson() {
    return this.toMap();
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  AqutterInAppBrowserOptions copy() {
    return AqutterInAppBrowserOptions.fromMap(this.toMap());
  }
}
