// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_chrome_safari_browser.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformChromeSafariBrowserClassSupported
    on AqutterPlatformChromeSafariBrowser {
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - This class uses native [Chrome Custom Tabs](https://developer.android.com/reference/android/support/customtabs/package-summary). If you want to use the `AqutterChromeSafariBrowser` class on Android 11+ you need to specify your app querying for `android.support.customtabs.action.CustomTabsService` in your `AndroidManifest.xml` (you can read more about it here: https://developers.google.com/web/android/custom-tabs/best-practices#applications_targeting_android_11_api_level_30_or_above).
  ///- iOS SFSafariViewController:
  ///    - This class uses native [SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller)
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformChromeSafariBrowser]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformChromeSafariBrowserMethod {
  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.addMenuItem] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.addMenuItem.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  ///- iOS SFSafariViewController
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [menuItem]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  addMenuItem,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.addMenuItems] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.addMenuItems.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs:
  ///    - Not available in a Trusted Web Activity.
  ///- iOS SFSafariViewController
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [menuItems]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  addMenuItems,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.clearWebsiteData] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.clearWebsiteData.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController 16.0+ ([Official API - SFSafariViewController.DataStore.clearWebsiteData](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller/datastore/3981117-clearwebsitedata))
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  clearWebsiteData,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.close] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.close.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///- iOS SFSafariViewController
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  close,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.dispose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.dispose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///- iOS SFSafariViewController
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dispose,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.getMaxToolbarItems] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.getMaxToolbarItems.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getMaxToolbarItems,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.getPackageName] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.getPackageName.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs ([Official API - CustomTabsClient.getPackageName](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsClient#getPackageName(android.content.Context,java.util.List%3Cjava.lang.String%3E,boolean)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [packages]: all platforms
  ///- [ignoreDefault]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getPackageName,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.invalidatePrewarmingToken] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.invalidatePrewarmingToken.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController 15.0+ ([Official API - SFSafariViewController.AqutterPrewarmingToken.invalidate](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller/prewarmingtoken/invalidate()))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [prewarmingToken]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  invalidatePrewarmingToken,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.isAvailable] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.isAvailable.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///- iOS SFSafariViewController
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isAvailable,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.isEngagementSignalsApiAvailable] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.isEngagementSignalsApiAvailable.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs ([Official API - CustomTabsSession.isEngagementSignalsApiAvailable](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsSession#isEngagementSignalsApiAvailable(android.os.Bundle)))
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isEngagementSignalsApiAvailable,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.isOpened] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.isOpened.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///- iOS SFSafariViewController
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isOpened,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.launchUrl] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.launchUrl.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [headers]: all platforms
  ///- [otherLikelyURLs]: all platforms
  ///- [referrer]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  launchUrl,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.mayLaunchUrl] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.mayLaunchUrl.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs ([Official API - CustomTabsSession.mayLaunchUrl](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsSession#mayLaunchUrl(android.net.Uri,android.os.Bundle,java.util.List%3Candroid.os.Bundle%3E)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [otherLikelyURLs]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  mayLaunchUrl,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.open] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.open.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs
  ///- iOS SFSafariViewController
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///- [headers]:
  ///    - Android Chrome Custom Tabs
  ///- [otherLikelyURLs]:
  ///    - Android Chrome Custom Tabs
  ///- [referrer]:
  ///    - Android Chrome Custom Tabs
  ///- [settings]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  open,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.postMessage] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.postMessage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs ([Official API - CustomTabsSession.postMessage](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsSession#postMessage(java.lang.String,android.os.Bundle)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [message]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  postMessage,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.prewarmConnections] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.prewarmConnections.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS SFSafariViewController 15.0+ ([Official API - SFSafariViewController.prewarmConnections](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller/3752133-prewarmconnections))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [URLs]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  prewarmConnections,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.requestPostMessageChannel] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.requestPostMessageChannel.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs ([Official API - CustomTabsSession.requestPostMessageChannel](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsSession#requestPostMessageChannel(android.net.Uri,android.net.Uri,android.os.Bundle)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [sourceOrigin]: all platforms
  ///- [targetOrigin]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  requestPostMessageChannel,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.setActionButton] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.setActionButton.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs ([Official API - CustomTabsSession.setActionButton](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsIntent.Builder#setActionButton(android.graphics.Bitmap,%20java.lang.String,%20android.app.PendingIntent,%20boolean))):
  ///    - Not available in a Trusted Web Activity.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [actionButton]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setActionButton,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.setSecondaryToolbar] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.setSecondaryToolbar.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs ([Official API - CustomTabsIntent.Builder.setSecondaryToolbarViews](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsIntent.Builder#setSecondaryToolbarViews(android.widget.RemoteViews,int[],android.app.PendingIntent))):
  ///    - Not available in a Trusted Web Activity.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [secondaryToolbar]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setSecondaryToolbar,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.updateActionButton] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.updateActionButton.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs ([Official API - CustomTabsSession.setActionButton](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsIntent.Builder#setActionButton(android.graphics.Bitmap,%20java.lang.String,%20android.app.PendingIntent,%20boolean))):
  ///    - Not available in a Trusted Web Activity.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [icon]: all platforms
  ///- [description]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  updateActionButton,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.updateSecondaryToolbar] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.updateSecondaryToolbar.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs ([Official API - CustomTabsIntent.Builder.setSecondaryToolbarViews](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsIntent.Builder#setSecondaryToolbarViews(android.widget.RemoteViews,int[],android.app.PendingIntent))):
  ///    - Not available in a Trusted Web Activity.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [secondaryToolbar]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  updateSecondaryToolbar,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowser.validateRelationship] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.validateRelationship.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android Chrome Custom Tabs ([Official API - CustomTabsSession.validateRelationship](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsSession#validateRelationship(int,android.net.Uri,android.os.Bundle)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [relation]: all platforms
  ///- [origin]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowser.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  validateRelationship,
}

extension _AqutterPlatformChromeSafariBrowserMethodSupported
    on AqutterPlatformChromeSafariBrowser {
  static bool isMethodSupported(
    AqutterPlatformChromeSafariBrowserMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformChromeSafariBrowserMethod.addMenuItem:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.addMenuItems:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.clearWebsiteData:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.close:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.dispose:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.getMaxToolbarItems:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.getPackageName:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.invalidatePrewarmingToken:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.isAvailable:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod
          .isEngagementSignalsApiAvailable:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.isOpened:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.launchUrl:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.mayLaunchUrl:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.open:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.postMessage:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.prewarmConnections:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.requestPostMessageChannel:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.setActionButton:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.setSecondaryToolbar:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.updateActionButton:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.updateSecondaryToolbar:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserMethod.validateRelationship:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

///List of [AqutterPlatformChromeSafariBrowserEvents]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformChromeSafariBrowserEventsMethod {
  ///Can be used to check if the [AqutterPlatformChromeSafariBrowserEvents.onClosed] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onClosed.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformChromeSafariBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onClosed,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowserEvents.onCompletedInitialLoad] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onCompletedInitialLoad.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView ([Official API - SFSafariViewControllerDelegate.safariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontrollerdelegate/1621215-safariviewcontroller))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [didLoadSuccessfully]:
  ///    - iOS WKWebView
  ///
  ///Use the [AqutterPlatformChromeSafariBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onCompletedInitialLoad,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowserEvents.onGreatestScrollPercentageIncreased] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onGreatestScrollPercentageIncreased.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - EngagementSignalsCallback.onGreatestScrollPercentageIncreased](https://developer.android.com/reference/androidx/browser/customtabs/EngagementSignalsCallback#onGreatestScrollPercentageIncreased(int,android.os.Bundle)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [scrollPercentage]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onGreatestScrollPercentageIncreased,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowserEvents.onInitialLoadDidRedirect] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onInitialLoadDidRedirect.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - SFSafariViewControllerDelegate.safariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontrollerdelegate/2923545-safariviewcontroller))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [url]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onInitialLoadDidRedirect,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowserEvents.onMessageChannelReady] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onMessageChannelReady.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - CustomTabsCallback.onMessageChannelReady](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsCallback#onMessageChannelReady(android.os.Bundle)))
  ///
  ///Use the [AqutterPlatformChromeSafariBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onMessageChannelReady,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowserEvents.onNavigationEvent] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onNavigationEvent.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - CustomTabsCallback.onNavigationEvent](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsCallback#onNavigationEvent(int,android.os.Bundle)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [navigationEvent]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onNavigationEvent,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowserEvents.onOpened] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onOpened.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPlatformChromeSafariBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onOpened,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowserEvents.onPostMessage] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onPostMessage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - CustomTabsCallback.onPostMessage](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsCallback#onPostMessage(java.lang.String,android.os.Bundle)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [message]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onPostMessage,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowserEvents.onRelationshipValidationResult] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onRelationshipValidationResult.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - CustomTabsCallback.onRelationshipValidationResult](https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsCallback#onRelationshipValidationResult(int,android.net.Uri,boolean,android.os.Bundle)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [relation]: all platforms
  ///- [requestedOrigin]: all platforms
  ///- [result]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onRelationshipValidationResult,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowserEvents.onServiceConnected] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onServiceConnected.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPlatformChromeSafariBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onServiceConnected,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowserEvents.onSessionEnded] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onSessionEnded.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - EngagementSignalsCallback.onSessionEnded](https://developer.android.com/reference/androidx/browser/customtabs/EngagementSignalsCallback#onSessionEnded(boolean,android.os.Bundle)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [didUserInteract]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onSessionEnded,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowserEvents.onVerticalScrollEvent] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onVerticalScrollEvent.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - EngagementSignalsCallback.onVerticalScrollEvent](https://developer.android.com/reference/androidx/browser/customtabs/EngagementSignalsCallback#onVerticalScrollEvent(boolean,android.os.Bundle)))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [isDirectionUp]: all platforms
  ///
  ///Use the [AqutterPlatformChromeSafariBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onVerticalScrollEvent,

  ///Can be used to check if the [AqutterPlatformChromeSafariBrowserEvents.onWillOpenInBrowser] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onWillOpenInBrowser.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 14.0+ ([Official API - SFSafariViewControllerDelegate.safariViewControllerWillOpenInBrowser](https://developer.apple.com/documentation/safariservices/sfsafariviewcontrollerdelegate/3650426-safariviewcontrollerwillopeninbr))
  ///
  ///Use the [AqutterPlatformChromeSafariBrowserEvents.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  onWillOpenInBrowser,
}

extension _AqutterPlatformChromeSafariBrowserEventsMethodSupported
    on AqutterPlatformChromeSafariBrowserEvents {
  static bool isMethodSupported(
    AqutterPlatformChromeSafariBrowserEventsMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformChromeSafariBrowserEventsMethod.onClosed:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserEventsMethod
          .onCompletedInitialLoad:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserEventsMethod
          .onGreatestScrollPercentageIncreased:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserEventsMethod
          .onInitialLoadDidRedirect:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserEventsMethod.onMessageChannelReady:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserEventsMethod.onNavigationEvent:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserEventsMethod.onOpened:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserEventsMethod.onPostMessage:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserEventsMethod
          .onRelationshipValidationResult:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserEventsMethod.onServiceConnected:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserEventsMethod.onSessionEnded:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserEventsMethod.onVerticalScrollEvent:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformChromeSafariBrowserEventsMethod.onWillOpenInBrowser:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
    }
  }
}
