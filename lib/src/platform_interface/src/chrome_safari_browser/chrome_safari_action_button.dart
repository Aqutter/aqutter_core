import 'dart:typed_data';

import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'platform_chrome_safari_browser.dart';
import 'chrome_safari_browser_menu_item.dart';
import '../web_uri.dart';
import '../types/enum_method.dart';

part 'chrome_safari_action_button.g.dart';

///Class that represents a custom action button for a [AqutterPlatformChromeSafariBrowser] instance.
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(note: 'Not available in an Android Trusted Web Activity.'),
  ],
)
@ExchangeableObject()
class AqutterChromeSafariBrowserActionButton_ {
  ///The action button id. It should be different from the [AqutterChromeSafariBrowserMenuItem.id].
  int id;

  ///The icon byte data.
  Uint8List icon;

  ///The description for the button. To be used for accessibility.
  String description;

  ///Whether the action button should be tinted.
  bool shouldTint;

  ///Use onClick instead.
  @Deprecated("Use onClick instead")
  void Function(String url, String title)? action;

  ///Callback function to be invoked when the action button is clicked
  void Function(AqutterWebUri? url, String title)? onClick;

  @ExchangeableObjectConstructor()
  AqutterChromeSafariBrowserActionButton_({
    required this.id,
    required this.icon,
    required this.description,
    @Deprecated("Use onClick instead") this.action,
    this.onClick,
    this.shouldTint = false,
  });
}
