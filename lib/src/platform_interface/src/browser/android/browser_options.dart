import '../../webview/android/webview_options.dart';

import '../browser_settings.dart';
import '../platform_browser.dart';

///This class represents all the Android-only [AqutterPlatformBrowser] options available.
///Use [AqutterBrowserSettings] instead.
@Deprecated('Use AqutterBrowserSettings instead')
class AqutterAndroidBrowserOptions implements AqutterBrowserOptions, AqutterAndroidOptions {
  ///Set to `true` if you want the title should be displayed. The default value is `false`.
  bool hideTitleBar;

  ///Set the action bar's title.
  String? toolbarTopFixedTitle;

  ///Set to `false` to not close the AqutterBrowser when the user click on the Android back button and the WebView cannot go back to the history. The default value is `true`.
  bool closeOnCannotGoBack;

  ///Set to `false` to block the AqutterBrowser WebView going back when the user click on the Android back button. The default value is `true`.
  bool allowGoBackWithBackButton;

  ///Set to `true` to close the AqutterBrowser when the user click on the Android back button. The default value is `false`.
  bool shouldCloseOnBackButtonPressed;

  AqutterAndroidBrowserOptions({
    this.hideTitleBar = false,
    this.toolbarTopFixedTitle,
    this.closeOnCannotGoBack = true,
    this.allowGoBackWithBackButton = true,
    this.shouldCloseOnBackButtonPressed = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      "hideTitleBar": hideTitleBar,
      "toolbarTopFixedTitle": toolbarTopFixedTitle,
      "closeOnCannotGoBack": closeOnCannotGoBack,
      "allowGoBackWithBackButton": allowGoBackWithBackButton,
      "shouldCloseOnBackButtonPressed": shouldCloseOnBackButtonPressed,
    };
  }

  static AqutterAndroidBrowserOptions fromMap(Map<String, dynamic> map) {
    var instance = AqutterAndroidBrowserOptions();
    instance.hideTitleBar = map["hideTitleBar"];
    instance.toolbarTopFixedTitle = map["toolbarTopFixedTitle"];
    instance.closeOnCannotGoBack = map["closeOnCannotGoBack"];
    instance.allowGoBackWithBackButton = map["allowGoBackWithBackButton"];
    instance.shouldCloseOnBackButtonPressed =
        map["shouldCloseOnBackButtonPressed"];
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
  AqutterAndroidBrowserOptions copy() {
    return AqutterAndroidBrowserOptions.fromMap(this.toMap());
  }
}
