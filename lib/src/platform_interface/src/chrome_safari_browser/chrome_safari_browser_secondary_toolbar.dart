import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../types/android_resource.dart';
import '../web_uri.dart';
import 'platform_chrome_safari_browser.dart';
import '../types/enum_method.dart';

part 'chrome_safari_browser_secondary_toolbar.g.dart';

///Class that represents the [RemoteViews](https://developer.android.com/reference/android/widget/RemoteViews.html)
///that will be shown on the secondary toolbar of a custom tab.
///
///This class describes a view hierarchy that can be displayed in another process.
///The hierarchy is inflated from an Android layout resource file.
///
///RemoteViews has limited to support to Android layouts.
///Check the [RemoteViews Official API](https://developer.android.com/reference/android/widget/RemoteViews.html) for more details.
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(note: 'Not available in an Android Trusted Web Activity.'),
  ],
)
@ExchangeableObject()
class AqutterChromeSafariBrowserSecondaryToolbar_ {
  ///The android layout resource.
  AqutterAndroidResource_ layout;

  ///The IDs of clickable views. The `onClick` event of these views will be handled by custom tabs.
  List<AqutterChromeSafariBrowserSecondaryToolbarClickableID_> clickableIDs;

  AqutterChromeSafariBrowserSecondaryToolbar_({
    required this.layout,
    this.clickableIDs = const [],
  });
}

///Class that represents a clickable ID item of the secondary toolbar for a [AqutterPlatformChromeSafariBrowser] instance.
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(note: 'Not available in an Android Trusted Web Activity.'),
  ],
)
@ExchangeableObject()
class AqutterChromeSafariBrowserSecondaryToolbarClickableID_ {
  ///The android id resource
  AqutterAndroidResource_ id;

  ///Callback function to be invoked when the item is clicked
  void Function(AqutterWebUri? url)? onClick;

  AqutterChromeSafariBrowserSecondaryToolbarClickableID_({
    required this.id,
    this.onClick,
  });
}
