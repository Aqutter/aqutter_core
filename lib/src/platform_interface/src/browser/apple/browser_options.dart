import 'dart:ui';

import '../../webview/apple/webview_options.dart';

import '../browser_settings.dart';
import '../platform_browser.dart';

import '../../types/main.dart';
import '../../util.dart';

///This class represents all the iOS-only [AqutterPlatformBrowser] options available.
///Use [AqutterBrowserSettings] instead.
@Deprecated('Use AqutterBrowserSettings instead')
class AqutterIOSBrowserOptions implements AqutterBrowserOptions, AqutterIosOptions {
  ///Set to `true` to set the toolbar at the top translucent. The default value is `true`.
  bool toolbarTopTranslucent;

  ///Set the tint color to apply to the navigation bar background.
  Color? toolbarTopBarTintColor;

  ///Set the tint color to apply to the navigation items and bar button items.
  Color? toolbarTopTintColor;

  ///Set to `true` to hide the toolbar at the bottom of the WebView. The default value is `false`.
  bool hideToolbarBottom;

  ///Set the custom background color of the toolbar at the bottom.
  Color? toolbarBottomBackgroundColor;

  ///Set the tint color to apply to the bar button items.
  Color? toolbarBottomTintColor;

  ///Set to `true` to set the toolbar at the bottom translucent. The default value is `true`.
  bool toolbarBottomTranslucent;

  ///Set the custom text for the close button.
  String? closeButtonCaption;

  ///Set the custom color for the close button.
  Color? closeButtonColor;

  ///Set the custom modal presentation style when presenting the WebView. The default value is [AqutterIOSUIModalPresentationStyle.FULL_SCREEN].
  AqutterIOSUIModalPresentationStyle presentationStyle;

  ///Set to the custom transition style when presenting the WebView. The default value is [AqutterIOSUIModalTransitionStyle.COVER_VERTICAL].
  AqutterIOSUIModalTransitionStyle transitionStyle;

  AqutterIOSBrowserOptions({
    this.toolbarTopTranslucent = true,
    this.toolbarTopTintColor,
    this.hideToolbarBottom = false,
    this.toolbarBottomBackgroundColor,
    this.toolbarBottomTintColor,
    this.toolbarBottomTranslucent = true,
    this.closeButtonCaption,
    this.closeButtonColor,
    this.presentationStyle = AqutterIOSUIModalPresentationStyle.FULL_SCREEN,
    this.transitionStyle = AqutterIOSUIModalTransitionStyle.COVER_VERTICAL,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      "toolbarTopTranslucent": toolbarTopTranslucent,
      "toolbarTopTintColor": toolbarTopTintColor?.toHex(),
      "hideToolbarBottom": hideToolbarBottom,
      "toolbarBottomBackgroundColor": toolbarBottomBackgroundColor?.toHex(),
      "toolbarBottomTintColor": toolbarBottomTintColor?.toHex(),
      "toolbarBottomTranslucent": toolbarBottomTranslucent,
      "closeButtonCaption": closeButtonCaption,
      "closeButtonColor": closeButtonColor?.toHex(),
      "presentationStyle": presentationStyle.toNativeValue(),
      "transitionStyle": transitionStyle.toNativeValue(),
    };
  }

  static AqutterIOSBrowserOptions fromMap(Map<String, dynamic> map) {
    var instance = AqutterIOSBrowserOptions();
    instance.toolbarTopTranslucent = map["toolbarTopTranslucent"];
    instance.toolbarTopTintColor = UtilColor.fromHex(
      map["toolbarTopTintColor"],
    );
    instance.hideToolbarBottom = map["hideToolbarBottom"];
    instance.toolbarBottomBackgroundColor = UtilColor.fromHex(
      map["toolbarBottomBackgroundColor"],
    );
    instance.toolbarBottomTintColor = UtilColor.fromHex(
      map["toolbarBottomTintColor"],
    );
    instance.toolbarBottomTranslucent = map["toolbarBottomTranslucent"];
    instance.closeButtonCaption = map["closeButtonCaption"];
    instance.closeButtonColor = UtilColor.fromHex(map["closeButtonColor"]);
    instance.presentationStyle = AqutterIOSUIModalPresentationStyle.fromNativeValue(
      map["presentationStyle"],
    )!;
    instance.transitionStyle = AqutterIOSUIModalTransitionStyle.fromNativeValue(
      map["transitionStyle"],
    )!;
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
  AqutterIOSBrowserOptions copy() {
    return AqutterIOSBrowserOptions.fromMap(this.toMap());
  }
}
