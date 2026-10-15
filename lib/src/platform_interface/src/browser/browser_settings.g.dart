// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_settings.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///{@template aqutter_core.AqutterWebViewSettings}
///This class represents all [AqutterBrowser] settings available.
///{@endtemplate}
///
///**Officially Supported Platforms/Implementations**:
///- Android WebView
///- iOS WKWebView
///- macOS WKWebView
///- Windows WebView2
///- Linux WPE WebKit ([Official API - GtkWindow](https://docs.gtk.org/gtk3/class.Window.html))
class AqutterBrowserSettings
    implements AqutterBrowserOptions, AqutterAndroidOptions, AqutterIosOptions {
  ///Set to `false` to block the AqutterBrowser WebView going back when the user click on the Android back button. The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  bool? allowGoBackWithBackButton;

  ///Set the custom text for the close button.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  String? closeButtonCaption;

  ///Set the custom color for the close button.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  Color? closeButtonColor;

  ///Set to `false` to not close the AqutterBrowser when the user click on the Android back button and the WebView cannot go back to the history. The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  bool? closeOnCannotGoBack;

  ///Set to `true` to create the browser and load the page, but not show it. Omit or set to `false` to have the browser open and load normally.
  ///The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  bool? hidden;

  ///Set to `true` to hide the close button. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  bool? hideCloseButton;

  ///Set to `true` to hide the default menu items. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  bool? hideDefaultMenuItems;

  ///Set to `true` to hide the progress bar when the WebView is loading a page. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  bool? hideProgressBar;

  ///Set to `true` if you want the title should be displayed. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  bool? hideTitleBar;

  ///Set to `true` to hide the toolbar at the bottom of the WebView. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  bool? hideToolbarBottom;

  ///Set to `true` to hide the toolbar at the top of the WebView. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  bool? hideToolbarTop;

  ///Set to `true` to hide the url bar on the toolbar at the top. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  bool? hideUrlBar;

  ///Set the custom color for the menu button.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  Color? menuButtonColor;

  ///Set the custom modal presentation style when presenting the WebView. The default value is [AqutterModalPresentationStyle.FULL_SCREEN].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  AqutterModalPresentationStyle? presentationStyle;

  ///Set to `true` to close the AqutterBrowser when the user click on the Android back button. The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  bool? shouldCloseOnBackButtonPressed;

  ///Set the custom background color of the toolbar at the bottom.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  Color? toolbarBottomBackgroundColor;

  ///Set the tint color to apply to the bar button items.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  Color? toolbarBottomTintColor;

  ///Set to `true` to set the toolbar at the bottom translucent. The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  bool? toolbarBottomTranslucent;

  ///Set the custom background color of the toolbar at the top.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  Color? toolbarTopBackgroundColor;

  ///Set the tint color to apply to the navigation bar background.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  Color? toolbarTopBarTintColor;

  ///Set the action bar's title.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  String? toolbarTopFixedTitle;

  ///Set the tint color to apply to the navigation items and bar button items.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  Color? toolbarTopTintColor;

  ///Set to `true` to set the toolbar at the top translucent. The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  bool? toolbarTopTranslucent;

  ///Set to the custom transition style when presenting the WebView. The default value is [AqutterModalTransitionStyle.COVER_VERTICAL].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  AqutterModalTransitionStyle? transitionStyle;

  ///The window’s alpha value.
  ///The default value is `1.0`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  double? windowAlphaValue;

  ///Sets the origin and size of the window’s frame rectangle according to a given frame rectangle,
  ///thereby setting its position and size onscreen.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  AqutterWebViewRect? windowFrame;

  ///Flags that describe the window’s current style, such as if it’s resizable or in full-screen mode.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  AqutterWindowStyleMask? windowStyleMask;

  ///The type of separator that the app displays between the title bar and content of a window.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView 11.0+
  AqutterWindowTitlebarSeparatorStyle? windowTitlebarSeparatorStyle;

  ///How the browser window should be added to the main window.
  ///The default value is [AqutterWindowType.WINDOW].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  AqutterWindowType? windowType;

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit ([Official API - GtkWindow](https://docs.gtk.org/gtk3/class.Window.html))
  AqutterBrowserSettings({
    this.allowGoBackWithBackButton = true,
    this.closeButtonCaption,
    this.closeButtonColor,
    this.closeOnCannotGoBack = true,
    this.hidden = false,
    this.hideCloseButton = false,
    this.hideDefaultMenuItems = false,
    this.hideProgressBar = false,
    this.hideTitleBar = false,
    this.hideToolbarBottom = false,
    this.hideToolbarTop = false,
    this.hideUrlBar = false,
    this.menuButtonColor,
    AqutterModalPresentationStyle? presentationStyle,
    this.shouldCloseOnBackButtonPressed = false,
    this.toolbarBottomBackgroundColor,
    this.toolbarBottomTintColor,
    this.toolbarBottomTranslucent = true,
    this.toolbarTopBackgroundColor,
    this.toolbarTopFixedTitle,
    this.toolbarTopTintColor,
    this.toolbarTopTranslucent = true,
    AqutterModalTransitionStyle? transitionStyle,
    this.windowAlphaValue = 1.0,
    this.windowFrame,
    this.windowStyleMask,
    this.windowTitlebarSeparatorStyle,
    this.windowType,
  }) : presentationStyle =
           presentationStyle ?? AqutterModalPresentationStyle.FULL_SCREEN,
       transitionStyle =
           transitionStyle ?? AqutterModalTransitionStyle.COVER_VERTICAL;

  ///Gets a possible [AqutterBrowserSettings] instance from a [Map] value.
  static AqutterBrowserSettings? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterBrowserSettings(
      closeButtonCaption: map['closeButtonCaption'],
      closeButtonColor: map['closeButtonColor'] != null
          ? UtilColor.fromStringRepresentation(map['closeButtonColor'])
          : null,
      menuButtonColor: map['menuButtonColor'] != null
          ? UtilColor.fromStringRepresentation(map['menuButtonColor'])
          : null,
      toolbarBottomBackgroundColor: map['toolbarBottomBackgroundColor'] != null
          ? UtilColor.fromStringRepresentation(
              map['toolbarBottomBackgroundColor'],
            )
          : null,
      toolbarBottomTintColor: map['toolbarBottomTintColor'] != null
          ? UtilColor.fromStringRepresentation(map['toolbarBottomTintColor'])
          : null,
      toolbarTopBackgroundColor: map['toolbarTopBackgroundColor'] != null
          ? UtilColor.fromStringRepresentation(map['toolbarTopBackgroundColor'])
          : null,
      toolbarTopFixedTitle: map['toolbarTopFixedTitle'],
      toolbarTopTintColor: map['toolbarTopTintColor'] != null
          ? UtilColor.fromStringRepresentation(map['toolbarTopTintColor'])
          : null,
      windowFrame: AqutterWebViewRect.fromMap(
        map['windowFrame']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      windowStyleMask: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterWindowStyleMask.fromNativeValue(
          map['windowStyleMask'],
        ),
        AqutterEnumMethod.value => AqutterWindowStyleMask.fromValue(
          map['windowStyleMask'],
        ),
        AqutterEnumMethod.name => AqutterWindowStyleMask.byName(
          map['windowStyleMask'],
        ),
      },
      windowTitlebarSeparatorStyle: switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterWindowTitlebarSeparatorStyle.fromNativeValue(
            map['windowTitlebarSeparatorStyle'],
          ),
        AqutterEnumMethod.value =>
          AqutterWindowTitlebarSeparatorStyle.fromValue(
            map['windowTitlebarSeparatorStyle'],
          ),
        AqutterEnumMethod.name => AqutterWindowTitlebarSeparatorStyle.byName(
          map['windowTitlebarSeparatorStyle'],
        ),
      },
      windowType: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterWindowType.fromNativeValue(
          map['windowType'],
        ),
        AqutterEnumMethod.value => AqutterWindowType.fromValue(
          map['windowType'],
        ),
        AqutterEnumMethod.name => AqutterWindowType.byName(map['windowType']),
      },
    );
    instance.allowGoBackWithBackButton = map['allowGoBackWithBackButton'];
    instance.closeOnCannotGoBack = map['closeOnCannotGoBack'];
    instance.hidden = map['hidden'];
    instance.hideCloseButton = map['hideCloseButton'];
    instance.hideDefaultMenuItems = map['hideDefaultMenuItems'];
    instance.hideProgressBar = map['hideProgressBar'];
    instance.hideTitleBar = map['hideTitleBar'];
    instance.hideToolbarBottom = map['hideToolbarBottom'];
    instance.hideToolbarTop = map['hideToolbarTop'];
    instance.hideUrlBar = map['hideUrlBar'];
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
    instance.shouldCloseOnBackButtonPressed =
        map['shouldCloseOnBackButtonPressed'];
    instance.toolbarBottomTranslucent = map['toolbarBottomTranslucent'];
    instance.toolbarTopBarTintColor = map['toolbarTopBarTintColor'] != null
        ? UtilColor.fromStringRepresentation(map['toolbarTopBarTintColor'])
        : null;
    instance.toolbarTopTranslucent = map['toolbarTopTranslucent'];
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
    instance.windowAlphaValue = map['windowAlphaValue'];
    return instance;
  }

  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isPropertySupported(
    AqutterBrowserSettingsProperty property, {
    TargetPlatform? platform,
  }) => _AqutterBrowserSettingsPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "allowGoBackWithBackButton": allowGoBackWithBackButton,
      "closeButtonCaption": closeButtonCaption,
      "closeButtonColor": closeButtonColor?.toHex(),
      "closeOnCannotGoBack": closeOnCannotGoBack,
      "hidden": hidden,
      "hideCloseButton": hideCloseButton,
      "hideDefaultMenuItems": hideDefaultMenuItems,
      "hideProgressBar": hideProgressBar,
      "hideTitleBar": hideTitleBar,
      "hideToolbarBottom": hideToolbarBottom,
      "hideToolbarTop": hideToolbarTop,
      "hideUrlBar": hideUrlBar,
      "menuButtonColor": menuButtonColor?.toHex(),
      "presentationStyle": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => presentationStyle?.toNativeValue(),
        AqutterEnumMethod.value => presentationStyle?.toValue(),
        AqutterEnumMethod.name => presentationStyle?.name(),
      },
      "shouldCloseOnBackButtonPressed": shouldCloseOnBackButtonPressed,
      "toolbarBottomBackgroundColor": toolbarBottomBackgroundColor?.toHex(),
      "toolbarBottomTintColor": toolbarBottomTintColor?.toHex(),
      "toolbarBottomTranslucent": toolbarBottomTranslucent,
      "toolbarTopBackgroundColor": toolbarTopBackgroundColor?.toHex(),
      "toolbarTopBarTintColor": toolbarTopBarTintColor?.toHex(),
      "toolbarTopFixedTitle": toolbarTopFixedTitle,
      "toolbarTopTintColor": toolbarTopTintColor?.toHex(),
      "toolbarTopTranslucent": toolbarTopTranslucent,
      "transitionStyle": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => transitionStyle?.toNativeValue(),
        AqutterEnumMethod.value => transitionStyle?.toValue(),
        AqutterEnumMethod.name => transitionStyle?.name(),
      },
      "windowAlphaValue": windowAlphaValue,
      "windowFrame": windowFrame?.toMap(enumMethod: enumMethod),
      "windowStyleMask": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => windowStyleMask?.toNativeValue(),
        AqutterEnumMethod.value => windowStyleMask?.toValue(),
        AqutterEnumMethod.name => windowStyleMask?.name(),
      },
      "windowTitlebarSeparatorStyle": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          windowTitlebarSeparatorStyle?.toNativeValue(),
        AqutterEnumMethod.value => windowTitlebarSeparatorStyle?.toValue(),
        AqutterEnumMethod.name => windowTitlebarSeparatorStyle?.name(),
      },
      "windowType": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => windowType?.toNativeValue(),
        AqutterEnumMethod.value => windowType?.toValue(),
        AqutterEnumMethod.name => windowType?.name(),
      },
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  ///Returns a copy of AqutterBrowserSettings.
  AqutterBrowserSettings copy() {
    return AqutterBrowserSettings.fromMap(toMap()) ?? AqutterBrowserSettings();
  }

  @override
  String toString() {
    return 'AqutterBrowserSettings{allowGoBackWithBackButton: $allowGoBackWithBackButton, closeButtonCaption: $closeButtonCaption, closeButtonColor: $closeButtonColor, closeOnCannotGoBack: $closeOnCannotGoBack, hidden: $hidden, hideCloseButton: $hideCloseButton, hideDefaultMenuItems: $hideDefaultMenuItems, hideProgressBar: $hideProgressBar, hideTitleBar: $hideTitleBar, hideToolbarBottom: $hideToolbarBottom, hideToolbarTop: $hideToolbarTop, hideUrlBar: $hideUrlBar, menuButtonColor: $menuButtonColor, presentationStyle: $presentationStyle, shouldCloseOnBackButtonPressed: $shouldCloseOnBackButtonPressed, toolbarBottomBackgroundColor: $toolbarBottomBackgroundColor, toolbarBottomTintColor: $toolbarBottomTintColor, toolbarBottomTranslucent: $toolbarBottomTranslucent, toolbarTopBackgroundColor: $toolbarTopBackgroundColor, toolbarTopBarTintColor: $toolbarTopBarTintColor, toolbarTopFixedTitle: $toolbarTopFixedTitle, toolbarTopTintColor: $toolbarTopTintColor, toolbarTopTranslucent: $toolbarTopTranslucent, transitionStyle: $transitionStyle, windowAlphaValue: $windowAlphaValue, windowFrame: $windowFrame, windowStyleMask: $windowStyleMask, windowTitlebarSeparatorStyle: $windowTitlebarSeparatorStyle, windowType: $windowType}';
  }
}

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

///List of [AqutterBrowserSettings]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterBrowserSettingsProperty {
  ///Can be used to check if the [AqutterBrowserSettings.allowGoBackWithBackButton] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.allowGoBackWithBackButton.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  allowGoBackWithBackButton,

  ///Can be used to check if the [AqutterBrowserSettings.closeButtonCaption] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.closeButtonCaption.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  closeButtonCaption,

  ///Can be used to check if the [AqutterBrowserSettings.closeButtonColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.closeButtonColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  closeButtonColor,

  ///Can be used to check if the [AqutterBrowserSettings.closeOnCannotGoBack] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.closeOnCannotGoBack.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  closeOnCannotGoBack,

  ///Can be used to check if the [AqutterBrowserSettings.hidden] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.hidden.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  hidden,

  ///Can be used to check if the [AqutterBrowserSettings.hideCloseButton] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.hideCloseButton.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  hideCloseButton,

  ///Can be used to check if the [AqutterBrowserSettings.hideDefaultMenuItems] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.hideDefaultMenuItems.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  hideDefaultMenuItems,

  ///Can be used to check if the [AqutterBrowserSettings.hideProgressBar] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.hideProgressBar.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  hideProgressBar,

  ///Can be used to check if the [AqutterBrowserSettings.hideTitleBar] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.hideTitleBar.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  hideTitleBar,

  ///Can be used to check if the [AqutterBrowserSettings.hideToolbarBottom] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.hideToolbarBottom.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  hideToolbarBottom,

  ///Can be used to check if the [AqutterBrowserSettings.hideToolbarTop] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.hideToolbarTop.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  hideToolbarTop,

  ///Can be used to check if the [AqutterBrowserSettings.hideUrlBar] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.hideUrlBar.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  hideUrlBar,

  ///Can be used to check if the [AqutterBrowserSettings.menuButtonColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.menuButtonColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  menuButtonColor,

  ///Can be used to check if the [AqutterBrowserSettings.presentationStyle] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.presentationStyle.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  presentationStyle,

  ///Can be used to check if the [AqutterBrowserSettings.shouldCloseOnBackButtonPressed] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.shouldCloseOnBackButtonPressed.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  shouldCloseOnBackButtonPressed,

  ///Can be used to check if the [AqutterBrowserSettings.toolbarBottomBackgroundColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.toolbarBottomBackgroundColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  toolbarBottomBackgroundColor,

  ///Can be used to check if the [AqutterBrowserSettings.toolbarBottomTintColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.toolbarBottomTintColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  toolbarBottomTintColor,

  ///Can be used to check if the [AqutterBrowserSettings.toolbarBottomTranslucent] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.toolbarBottomTranslucent.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  toolbarBottomTranslucent,

  ///Can be used to check if the [AqutterBrowserSettings.toolbarTopBackgroundColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.toolbarTopBackgroundColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  toolbarTopBackgroundColor,

  ///Can be used to check if the [AqutterBrowserSettings.toolbarTopBarTintColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.toolbarTopBarTintColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  toolbarTopBarTintColor,

  ///Can be used to check if the [AqutterBrowserSettings.toolbarTopFixedTitle] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.toolbarTopFixedTitle.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  toolbarTopFixedTitle,

  ///Can be used to check if the [AqutterBrowserSettings.toolbarTopTintColor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.toolbarTopTintColor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  toolbarTopTintColor,

  ///Can be used to check if the [AqutterBrowserSettings.toolbarTopTranslucent] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.toolbarTopTranslucent.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  toolbarTopTranslucent,

  ///Can be used to check if the [AqutterBrowserSettings.transitionStyle] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.transitionStyle.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  transitionStyle,

  ///Can be used to check if the [AqutterBrowserSettings.windowAlphaValue] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.windowAlphaValue.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  windowAlphaValue,

  ///Can be used to check if the [AqutterBrowserSettings.windowFrame] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.windowFrame.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  windowFrame,

  ///Can be used to check if the [AqutterBrowserSettings.windowStyleMask] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.windowStyleMask.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  windowStyleMask,

  ///Can be used to check if the [AqutterBrowserSettings.windowTitlebarSeparatorStyle] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.windowTitlebarSeparatorStyle.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView 11.0+
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  windowTitlebarSeparatorStyle,

  ///Can be used to check if the [AqutterBrowserSettings.windowType] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterBrowserSettings.windowType.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterBrowserSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  windowType,
}

extension _AqutterBrowserSettingsPropertySupported on AqutterBrowserSettings {
  static bool isPropertySupported(
    AqutterBrowserSettingsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterBrowserSettingsProperty.allowGoBackWithBackButton:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.closeButtonCaption:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.closeButtonColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.closeOnCannotGoBack:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.hidden:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.hideCloseButton:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.hideDefaultMenuItems:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.hideProgressBar:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.hideTitleBar:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.hideToolbarBottom:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.hideToolbarTop:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.hideUrlBar:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.menuButtonColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.presentationStyle:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.shouldCloseOnBackButtonPressed:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.toolbarBottomBackgroundColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.toolbarBottomTintColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.toolbarBottomTranslucent:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.toolbarTopBackgroundColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.toolbarTopBarTintColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.toolbarTopFixedTitle:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.toolbarTopTintColor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.toolbarTopTranslucent:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.transitionStyle:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.windowAlphaValue:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.windowFrame:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.windowStyleMask:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.windowTitlebarSeparatorStyle:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterBrowserSettingsProperty.windowType:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.macOS,
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
