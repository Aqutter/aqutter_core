import 'dart:ui';

import '../../util.dart';
import '../../types/main.dart';

import '../chrome_safari_browser_settings.dart';
import '../platform_chrome_safari_browser.dart';

import '../../webview/apple/webview_options.dart';

///This class represents all the iOS-only [AqutterPlatformChromeSafariBrowser] options available.
///Use [AqutterChromeSafariBrowserSettings] instead.
@Deprecated('Use AqutterChromeSafariBrowserSettings instead')
class AqutterIOSSafariOptions implements AqutterChromeSafariBrowserOptions, AqutterIosOptions {
  ///Set to `true` if Reader mode should be entered automatically when it is available for the webpage. The default value is `false`.
  bool entersReaderIfAvailable;

  ///Set to `true` to enable bar collapsing. The default value is `false`.
  bool barCollapsingEnabled;

  ///Set the custom style for the dismiss button. The default value is [AqutterIOSSafariDismissButtonStyle.DONE].
  ///
  ///**NOTE**: available on iOS 11.0+.
  AqutterIOSSafariDismissButtonStyle dismissButtonStyle;

  ///Set the custom background color of the navigation bar and the toolbar.
  ///
  ///**NOTE**: available on iOS 10.0+.
  Color? preferredBarTintColor;

  ///Set the custom color of the control buttons on the navigation bar and the toolbar.
  ///
  ///**NOTE**: available on iOS 10.0+.
  Color? preferredControlTintColor;

  ///Set the custom modal presentation style when presenting the WebView. The default value is [AqutterIOSUIModalPresentationStyle.FULL_SCREEN].
  AqutterIOSUIModalPresentationStyle presentationStyle;

  ///Set to the custom transition style when presenting the WebView. The default value is [AqutterIOSUIModalTransitionStyle.COVER_VERTICAL].
  AqutterIOSUIModalTransitionStyle transitionStyle;

  AqutterIOSSafariOptions({
    this.entersReaderIfAvailable = false,
    this.barCollapsingEnabled = false,
    this.dismissButtonStyle = AqutterIOSSafariDismissButtonStyle.DONE,
    this.preferredBarTintColor,
    this.preferredControlTintColor,
    this.presentationStyle = AqutterIOSUIModalPresentationStyle.FULL_SCREEN,
    this.transitionStyle = AqutterIOSUIModalTransitionStyle.COVER_VERTICAL,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      "entersReaderIfAvailable": entersReaderIfAvailable,
      "barCollapsingEnabled": barCollapsingEnabled,
      "dismissButtonStyle": dismissButtonStyle.toNativeValue(),
      "preferredBarTintColor": preferredBarTintColor?.toHex(),
      "preferredControlTintColor": preferredControlTintColor?.toHex(),
      "presentationStyle": presentationStyle.toNativeValue(),
      "transitionStyle": transitionStyle.toNativeValue(),
    };
  }

  static AqutterIOSSafariOptions fromMap(Map<String, dynamic> map) {
    AqutterIOSSafariOptions options = AqutterIOSSafariOptions();
    options.entersReaderIfAvailable = map["entersReaderIfAvailable"];
    options.barCollapsingEnabled = map["barCollapsingEnabled"];
    options.dismissButtonStyle = AqutterIOSSafariDismissButtonStyle.fromNativeValue(
      map["dismissButtonStyle"],
    )!;
    options.preferredBarTintColor = UtilColor.fromHex(
      map["preferredBarTintColor"],
    );
    options.preferredControlTintColor = UtilColor.fromHex(
      map["preferredControlTintColor"],
    );
    options.presentationStyle = AqutterIOSUIModalPresentationStyle.fromNativeValue(
      map["presentationStyle"],
    )!;
    options.transitionStyle = AqutterIOSUIModalTransitionStyle.fromNativeValue(
      map["transitionStyle"],
    )!;
    return options;
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
  AqutterIOSSafariOptions copy() {
    return AqutterIOSSafariOptions.fromMap(this.toMap());
  }
}
