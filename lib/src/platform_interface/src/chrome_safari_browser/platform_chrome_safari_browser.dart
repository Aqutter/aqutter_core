import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

part 'platform_chrome_safari_browser.g.dart';

/// Object specifying creation parameters for creating a [AqutterPlatformChromeSafariBrowser].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
@immutable
class AqutterPlatformChromeSafariBrowserCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformChromeSafariBrowser].
  const AqutterPlatformChromeSafariBrowserCreationParams();
}

///{@template aqutter_core.AqutterPlatformChromeSafariBrowser}
///Class that provides a visible standard interface for browsing the web.
///It presents a self-contained web interface inside your app.
///
///If you need to customize or interact with the web content, use the `AqutterWebView` widget.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(
      note:
          """This class uses native [Chrome Custom Tabs](https://developer.android.com/reference/android/support/customtabs/package-summary).
If you want to use the `AqutterChromeSafariBrowser` class on Android 11+ you need to specify your app querying for
`android.support.customtabs.action.CustomTabsService` in your `AndroidManifest.xml`
(you can read more about it here: https://developers.google.com/web/android/custom-tabs/best-practices#applications_targeting_android_11_api_level_30_or_above).""",
      name: 'Android Chrome Custom Tabs',
    ),
    IOSPlatform(
      note:
          'This class uses native [SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller)',
      name: 'iOS SFSafariViewController',
    ),
  ],
)
abstract class AqutterPlatformChromeSafariBrowser extends PlatformInterface
    implements AqutterDisposable {
  ///Debug settings.
  static AqutterDebugLoggingSettings debugLoggingSettings = AqutterDebugLoggingSettings();

  /// Event handler object that handles the [AqutterPlatformChromeSafariBrowser] events.
  AqutterPlatformChromeSafariBrowserEvents? eventHandler;

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.id}
  ///View ID used internally.
  ///{@endtemplate}
  String get id {
    throw UnimplementedError('id is not implemented on the current platform');
  }

  /// Creates a new [AqutterPlatformChromeSafariBrowser]
  factory AqutterPlatformChromeSafariBrowser(
    AqutterPlatformChromeSafariBrowserCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformChromeSafariBrowser chromeSafariBrowser = AqutterWebViewPlatform
        .instance!
        .createPlatformChromeSafariBrowser(params);
    PlatformInterface.verify(chromeSafariBrowser, _token);
    return chromeSafariBrowser;
  }

  /// Creates a new [AqutterPlatformChromeSafariBrowser] to access static methods.
  factory AqutterPlatformChromeSafariBrowser.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformChromeSafariBrowser chromeSafariBrowserStatic =
        AqutterWebViewPlatform.instance!
            .createPlatformChromeSafariBrowserStatic();
    PlatformInterface.verify(chromeSafariBrowserStatic, _token);
    return chromeSafariBrowserStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformChromeSafariBrowser].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformChromeSafariBrowser.implementation(this.params)
    : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformChromeSafariBrowser].
  final AqutterPlatformChromeSafariBrowserCreationParams params;

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.open}
  ///Opens the [AqutterPlatformChromeSafariBrowser] instance with an [url].
  ///
  ///[url] - The [url] to load. On iOS, the [url] is required and must use the `http` or `https` scheme.
  ///
  ///[headers] - [whitelisted](https://fetch.spec.whatwg.org/#cors-safelisted-request-header) cross-origin request headers.
  ///It is possible to attach non-whitelisted headers to cross-origin requests, when the server and client are related using a
  ///[digital asset link](https://developers.google.com/digital-asset-links/v1/getting-started).
  ///
  ///[otherLikelyURLs] - Other likely destinations, sorted in decreasing likelihood order.
  ///
  ///[referrer] - referrer header.
  ///
  ///[options] - Deprecated. Use `settings` instead.
  ///
  ///[settings] - Settings for the [AqutterPlatformChromeSafariBrowser].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.open.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  Future<void> open({
    AqutterWebUri? url,
    @SupportedPlatforms(platforms: [AndroidPlatform()])
    Map<String, String>? headers,
    @SupportedPlatforms(platforms: [AndroidPlatform()])
    List<AqutterWebUri>? otherLikelyURLs,
    @SupportedPlatforms(platforms: [AndroidPlatform()]) AqutterWebUri? referrer,
    @Deprecated('Use settings instead')
    // ignore: deprecated_member_use_from_same_package
    AqutterChromeSafariBrowserClassOptions? options,
    AqutterChromeSafariBrowserSettings? settings,
  }) {
    throw UnimplementedError('open is not implemented on the current platform');
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.launchUrl}
  ///Tells the browser to launch with [url].
  ///
  ///[url] - initial url.
  ///
  ///[headers] - [whitelisted](https://fetch.spec.whatwg.org/#cors-safelisted-request-header) cross-origin request headers.
  ///It is possible to attach non-whitelisted headers to cross-origin requests, when the server and client are related using a
  ///[digital asset link](https://developers.google.com/digital-asset-links/v1/getting-started).
  ///
  ///[otherLikelyURLs] - Other likely destinations, sorted in decreasing likelihood order.
  ///
  ///[referrer] - referrer header.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.launchUrl.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  Future<void> launchUrl({
    required AqutterWebUri url,
    Map<String, String>? headers,
    List<AqutterWebUri>? otherLikelyURLs,
    AqutterWebUri? referrer,
  }) {
    throw UnimplementedError(
      'launchUrl is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.mayLaunchUrl}
  ///Tells the browser of a likely future navigation to a URL.
  ///The most likely URL has to be specified first.
  ///Optionally, a list of other likely URLs can be provided.
  ///They are treated as less likely than the first one, and have to be sorted in decreasing priority order.
  ///These additional URLs may be ignored. All previous calls to this method will be deprioritized.
  ///
  ///[url] - Most likely URL, may be null if otherLikelyBundles is provided.
  ///
  ///[otherLikelyURLs] - Other likely destinations, sorted in decreasing likelihood order.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.mayLaunchUrl.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsSession.mayLaunchUrl',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsSession#mayLaunchUrl(android.net.Uri,android.os.Bundle,java.util.List%3Candroid.os.Bundle%3E)',
      ),
    ],
  )
  Future<bool> mayLaunchUrl({AqutterWebUri? url, List<AqutterWebUri>? otherLikelyURLs}) {
    throw UnimplementedError(
      'mayLaunchUrl is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.validateRelationship}
  ///Requests to validate a relationship between the application and an origin.
  ///
  ///See [here](https://developers.google.com/digital-asset-links/v1/getting-started) for documentation about Digital Asset Links.
  ///This methods requests the browser to verify a relation with the calling application, to grant the associated rights.
  ///
  ///If this method returns `true`, the validation result will be provided through [AqutterPlatformChromeSafariBrowserEvents.onRelationshipValidationResult].
  ///Otherwise the request didn't succeed.
  ///
  ///[relation] – Relation to check, must be one of the [AqutterCustomTabsRelationType] constants.
  ///
  ///[origin] – Origin.
  ///
  ///[extras] – Reserved for future use.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.validateRelationship.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsSession.validateRelationship',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsSession#validateRelationship(int,android.net.Uri,android.os.Bundle)',
      ),
    ],
  )
  Future<bool> validateRelationship({
    required AqutterCustomTabsRelationType relation,
    required AqutterWebUri origin,
  }) {
    throw UnimplementedError(
      'validateRelationship is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.close}
  ///Closes the [AqutterPlatformChromeSafariBrowser] instance.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.close.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  Future<void> close() {
    throw UnimplementedError(
      'close is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.setActionButton}
  ///Set a custom action button.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.setActionButton.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsSession.setActionButton',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsIntent.Builder#setActionButton(android.graphics.Bitmap,%20java.lang.String,%20android.app.PendingIntent,%20boolean)',
        note: 'Not available in a Trusted Web Activity.',
      ),
    ],
  )
  void setActionButton(AqutterChromeSafariBrowserActionButton actionButton) {
    throw UnimplementedError(
      'setActionButton is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.updateActionButton}
  ///Updates the [AqutterChromeSafariBrowserActionButton.icon] and [AqutterChromeSafariBrowserActionButton.description].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.updateActionButton.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsSession.setActionButton',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsIntent.Builder#setActionButton(android.graphics.Bitmap,%20java.lang.String,%20android.app.PendingIntent,%20boolean)',
        note: 'Not available in a Trusted Web Activity.',
      ),
    ],
  )
  Future<void> updateActionButton({
    required Uint8List icon,
    required String description,
  }) {
    throw UnimplementedError(
      'updateActionButton is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.setSecondaryToolbar}
  ///Sets the remote views displayed in the secondary toolbar in a custom tab.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.setSecondaryToolbar.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsIntent.Builder.setSecondaryToolbarViews',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsIntent.Builder#setSecondaryToolbarViews(android.widget.RemoteViews,int[],android.app.PendingIntent)',
        note: 'Not available in a Trusted Web Activity.',
      ),
    ],
  )
  void setSecondaryToolbar(
    AqutterChromeSafariBrowserSecondaryToolbar secondaryToolbar,
  ) {
    throw UnimplementedError(
      'setSecondaryToolbar is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.updateSecondaryToolbar}
  ///Sets or updates (if already present) the Remote Views of the secondary toolbar in an existing custom tab session.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.updateSecondaryToolbar.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsIntent.Builder.setSecondaryToolbarViews',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsIntent.Builder#setSecondaryToolbarViews(android.widget.RemoteViews,int[],android.app.PendingIntent)',
        note: 'Not available in a Trusted Web Activity.',
      ),
    ],
  )
  Future<void> updateSecondaryToolbar(
    AqutterChromeSafariBrowserSecondaryToolbar secondaryToolbar,
  ) {
    throw UnimplementedError(
      'updateSecondaryToolbar is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.addMenuItem}
  ///Adds a [AqutterChromeSafariBrowserMenuItem] to the menu.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.addMenuItem.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(note: 'Not available in a Trusted Web Activity.'),
      IOSPlatform(),
    ],
  )
  void addMenuItem(AqutterChromeSafariBrowserMenuItem menuItem) {
    throw UnimplementedError(
      'addMenuItem is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.addMenuItems}
  ///Adds a list of [AqutterChromeSafariBrowserMenuItem] to the menu.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.addMenuItems.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(note: 'Not available in a Trusted Web Activity.'),
      IOSPlatform(),
    ],
  )
  void addMenuItems(List<AqutterChromeSafariBrowserMenuItem> menuItems) {
    throw UnimplementedError(
      'addMenuItems is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.requestPostMessageChannel}
  ///Sends a request to create a two way postMessage channel between the client
  ///and the browser.
  ///If you want to specifying the target origin to communicate with, set the [targetOrigin].
  ///
  ///[sourceOrigin] - A origin that the client is requesting to be
  ///identified as during the postMessage communication.
  ///It has to either start with http or https.
  ///
  ///[targetOrigin] - The target Origin to establish the postMessage communication with.
  ///This can be the app's package name, it has to either start with http or https.
  ///
  ///Returns whether the implementation accepted the request.
  ///Note that returning true here doesn't mean an origin has already been
  ///assigned as the validation is asynchronous.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.requestPostMessageChannel.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsSession.requestPostMessageChannel',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsSession#requestPostMessageChannel(android.net.Uri,android.net.Uri,android.os.Bundle)',
      ),
    ],
  )
  Future<bool> requestPostMessageChannel({
    required AqutterWebUri sourceOrigin,
    AqutterWebUri? targetOrigin,
  }) {
    throw UnimplementedError(
      'requestPostMessageChannel is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.postMessage}
  ///Sends a postMessage request using the origin communicated via [requestPostMessageChannel].
  ///Fails when called before [AqutterPlatformChromeSafariBrowserEvents.onMessageChannelReady] event.
  ///
  ///[message] – The message that is being sent.
  ///
  ///Returns an integer constant about the postMessage request result.
  ///Will return [AqutterCustomTabsPostMessageResultType.SUCCESS] if successful.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.postMessage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsSession.postMessage',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsSession#postMessage(java.lang.String,android.os.Bundle)',
      ),
    ],
  )
  Future<AqutterCustomTabsPostMessageResultType> postMessage(String message) {
    throw UnimplementedError(
      'postMessage is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.isEngagementSignalsApiAvailable}
  ///Returns whether the Engagement Signals API is available.
  ///The availability of the Engagement Signals API may change at runtime.
  ///If an EngagementSignalsCallback has been set, an [AqutterPlatformChromeSafariBrowserEvents.onSessionEnded]
  ///signal will be sent if the API becomes unavailable later.
  ///
  ///Returns whether the Engagement Signals API is available.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.isEngagementSignalsApiAvailable.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsSession.isEngagementSignalsApiAvailable',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsSession#isEngagementSignalsApiAvailable(android.os.Bundle)',
      ),
    ],
  )
  Future<bool> isEngagementSignalsApiAvailable() {
    throw UnimplementedError(
      'isEngagementSignalsApiAvailable is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.isOpened}
  ///Returns `true` if the [AqutterPlatformChromeSafariBrowser] instance is opened, otherwise `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.isOpened.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  bool isOpened() {
    throw UnimplementedError(
      'isOpened is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.isAvailable}
  ///On Android, returns `true` if Chrome Custom Tabs is available.
  ///On iOS, returns `true` if SFSafariViewController is available.
  ///Otherwise returns `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.isAvailable.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  Future<bool> isAvailable() {
    throw UnimplementedError(
      'isAvailable is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.getMaxToolbarItems}
  ///The maximum number of allowed secondary toolbar items.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.getMaxToolbarItems.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  Future<int> getMaxToolbarItems() {
    throw UnimplementedError(
      'getMaxToolbarItems is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.getPackageName}
  ///Returns the preferred package to use for Custom Tabs.
  ///The preferred package name is the default VIEW intent handler as long as it supports Custom Tabs.
  ///To modify this preferred behavior, set [ignoreDefault] to `true` and give a
  ///non empty list of package names in packages.
  ///This method queries the `PackageManager` to determine which packages support the Custom Tabs API.
  ///On apps that target Android 11 and above, this requires adding the following
  ///package visibility elements to your manifest.
  ///
  ///[packages] – Ordered list of packages to test for Custom Tabs support, in decreasing order of priority.
  ///
  ///[ignoreDefault] – If set, the default VIEW handler won't get priority over other browsers.
  ///
  ///Returns the preferred package name for handling Custom Tabs, or `null`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.getPackageName.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsClient.getPackageName',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsClient#getPackageName(android.content.Context,java.util.List%3Cjava.lang.String%3E,boolean)',
      ),
    ],
  )
  Future<String?> getPackageName({
    List<String>? packages,
    bool ignoreDefault = false,
  }) {
    throw UnimplementedError(
      'getPackageName is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.clearWebsiteData}
  ///Clear associated website data accrued from browsing activity within your app.
  ///This includes all local storage, cached resources, and cookies.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.clearWebsiteData.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'SFSafariViewController.DataStore.clearWebsiteData',
        apiUrl:
            'https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller/datastore/3981117-clearwebsitedata',
        available: '16.0',
      ),
    ],
  )
  Future<void> clearWebsiteData() {
    throw UnimplementedError(
      'clearWebsiteData is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.prewarmConnections}
  ///Prewarms a connection to each URL. SFSafariViewController will automatically use a
  ///prewarmed connection if possible when loading its initial URL.
  ///
  ///Returns a token object that corresponds to the requested URLs. You must keep a strong
  ///reference to this token as long as you expect the prewarmed connections to remain open. If the same
  ///server is requested in multiple calls to this method, all of the corresponding tokens must be
  ///invalidated or released to end the prewarmed connection to that server.
  ///
  ///This method uses a best-effort approach to prewarming connections, but may delay
  ///or drop requests based on the volume of requests made by your app. Use this method when you expect
  ///to present the browser soon. Many HTTP servers time out connections after a few minutes.
  ///After a timeout, prewarming delivers less performance benefit.
  ///
  ///[URLs] - the URLs of servers that the browser should prewarm connections to.
  ///Only supports URLs with `http://` or `https://` schemes.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.prewarmConnections.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'SFSafariViewController.prewarmConnections',
        apiUrl:
            'https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller/3752133-prewarmconnections',
        available: '15.0',
      ),
    ],
  )
  Future<AqutterPrewarmingToken?> prewarmConnections(List<AqutterWebUri> URLs) {
    throw UnimplementedError(
      'prewarmConnections is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.invalidatePrewarmingToken}
  ///Ends all prewarmed connections associated with the token, except for connections that are also kept alive by other tokens.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.invalidatePrewarmingToken.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'SFSafariViewController.AqutterPrewarmingToken.invalidate',
        apiUrl:
            'https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller/prewarmingtoken/invalidate()',
        available: '15.0',
      ),
    ],
  )
  Future<void> invalidatePrewarmingToken(AqutterPrewarmingToken prewarmingToken) {
    throw UnimplementedError(
      'invalidatePrewarmingToken is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.dispose}
  ///Disposes the channel and event handler.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.dispose.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  @override
  @mustCallSuper
  void dispose() {
    eventHandler = null;
  }

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformChromeSafariBrowserClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowser.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformChromeSafariBrowserMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformChromeSafariBrowserMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.isMethodSupported}
  bool isEventMethodSupported(
    AqutterPlatformChromeSafariBrowserEventsMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformChromeSafariBrowserEvents.isMethodSupported(
    method,
    platform: platform,
  );
}

@SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
abstract class AqutterPlatformChromeSafariBrowserEvents {
  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onServiceConnected}
  ///Event fired when the when connecting from Android Custom Tabs Service.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onServiceConnected.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  void onServiceConnected() {}

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onOpened}
  ///Event fired when the [AqutterPlatformChromeSafariBrowser] is opened.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onOpened.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  void onOpened() {}

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onCompletedInitialLoad}
  ///Event fired when the initial URL load is complete.
  ///
  ///[didLoadSuccessfully] - `true` if loading completed successfully; otherwise, `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onCompletedInitialLoad.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(
        apiName: 'SFSafariViewControllerDelegate.safariViewController',
        apiUrl:
            'https://developer.apple.com/documentation/safariservices/sfsafariviewcontrollerdelegate/1621215-safariviewcontroller',
      ),
    ],
  )
  void onCompletedInitialLoad(
    @SupportedPlatforms(platforms: [IOSPlatform()]) bool? didLoadSuccessfully,
  ) {}

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onInitialLoadDidRedirect}
  ///Event fired when the initial URL load is complete.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onInitialLoadDidRedirect.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'SFSafariViewControllerDelegate.safariViewController',
        apiUrl:
            'https://developer.apple.com/documentation/safariservices/sfsafariviewcontrollerdelegate/2923545-safariviewcontroller',
      ),
    ],
  )
  void onInitialLoadDidRedirect(AqutterWebUri? url) {}

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onNavigationEvent}
  ///Event fired when a navigation event happens.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onNavigationEvent.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsCallback.onNavigationEvent',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsCallback#onNavigationEvent(int,android.os.Bundle)',
      ),
    ],
  )
  void onNavigationEvent(AqutterCustomTabsNavigationEventType? navigationEvent) {}

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onRelationshipValidationResult}
  ///Event fired when a relationship validation result is available.
  ///
  ///[relation] - Relation for which the result is available. Value previously passed to [AqutterPlatformChromeSafariBrowser.validateRelationship].
  ///
  ///[requestedOrigin] - Origin requested. Value previously passed to [AqutterPlatformChromeSafariBrowser.validateRelationship].
  ///
  ///[result] - Whether the relation was validated.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onRelationshipValidationResult.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsCallback.onRelationshipValidationResult',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsCallback#onRelationshipValidationResult(int,android.net.Uri,boolean,android.os.Bundle)',
      ),
    ],
  )
  void onRelationshipValidationResult(
    AqutterCustomTabsRelationType? relation,
    AqutterWebUri? requestedOrigin,
    bool result,
  ) {}

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onWillOpenInBrowser}
  ///Event fired when the user opens the current page in the default browser by tapping the toolbar button.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onWillOpenInBrowser.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName:
            'SFSafariViewControllerDelegate.safariViewControllerWillOpenInBrowser',
        apiUrl:
            'https://developer.apple.com/documentation/safariservices/sfsafariviewcontrollerdelegate/3650426-safariviewcontrollerwillopeninbr',
        available: '14.0',
      ),
    ],
  )
  void onWillOpenInBrowser() {}

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onMessageChannelReady}
  ///Called when the [AqutterPlatformChromeSafariBrowser] has requested a postMessage channel through
  ///[AqutterPlatformChromeSafariBrowser.requestPostMessageChannel] and the channel is ready for sending and receiving messages on both ends.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onMessageChannelReady.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsCallback.onMessageChannelReady',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsCallback#onMessageChannelReady(android.os.Bundle)',
      ),
    ],
  )
  void onMessageChannelReady() {}

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onPostMessage}
  ///Called when a tab controlled by this [AqutterPlatformChromeSafariBrowser] has sent a postMessage.
  ///If [AqutterPlatformChromeSafariBrowser.postMessage] is called from a single thread, then the messages will be posted in the same order.
  ///When received on the client side, it is the client's responsibility to preserve the ordering further.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onPostMessage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'CustomTabsCallback.onPostMessage',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/CustomTabsCallback#onPostMessage(java.lang.String,android.os.Bundle)',
      ),
    ],
  )
  void onPostMessage(String message) {}

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onVerticalScrollEvent}
  ///Called when a user scrolls the tab.
  ///
  ///[isDirectionUp] - `false` when the user scrolls farther down the page,
  ///and `true` when the user scrolls back up toward the top of the page.
  ///
  ///**NOTE**: available only if [AqutterPlatformChromeSafariBrowser.isEngagementSignalsApiAvailable] returns `true`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onVerticalScrollEvent.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'EngagementSignalsCallback.onVerticalScrollEvent',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/EngagementSignalsCallback#onVerticalScrollEvent(boolean,android.os.Bundle)',
      ),
    ],
  )
  void onVerticalScrollEvent(bool isDirectionUp) {}

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onGreatestScrollPercentageIncreased}
  ///Called when a user has reached a greater scroll percentage on the page. The greatest scroll
  ///percentage is reset if the user navigates to a different page. If the current page's total
  ///height changes, this method will be called again only if the scroll progress reaches a
  ///higher percentage based on the new and current height of the page.
  ///
  ///[scrollPercentage] - An integer indicating the percent of scrollable progress
  ///the user hasmade down the current page.
  ///
  ///**NOTE**: available only if [AqutterPlatformChromeSafariBrowser.isEngagementSignalsApiAvailable] returns `true`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onGreatestScrollPercentageIncreased.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName:
            'EngagementSignalsCallback.onGreatestScrollPercentageIncreased',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/EngagementSignalsCallback#onGreatestScrollPercentageIncreased(int,android.os.Bundle)',
      ),
    ],
  )
  void onGreatestScrollPercentageIncreased(int scrollPercentage) {}

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onSessionEnded}
  ///Called when a `CustomTabsSession` is ending or when no further Engagement Signals
  ///callbacks are expected to report whether any user action has occurred during the session.
  ///
  ///[didUserInteract] - Whether the user has interacted with the page in any way, e.g. scrolling.
  ///
  ///**NOTE**: available only if [AqutterPlatformChromeSafariBrowser.isEngagementSignalsApiAvailable] returns `true`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onSessionEnded.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'EngagementSignalsCallback.onSessionEnded',
        apiUrl:
            'https://developer.android.com/reference/androidx/browser/customtabs/EngagementSignalsCallback#onSessionEnded(boolean,android.os.Bundle)',
      ),
    ],
  )
  void onSessionEnded(bool didUserInteract) {}

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onClosed}
  ///Event fired when the [AqutterPlatformChromeSafariBrowser] is closed.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.onClosed.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  void onClosed() {}

  ///{@template aqutter_core.AqutterPlatformChromeSafariBrowserEvents.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  static bool isMethodSupported(
    AqutterPlatformChromeSafariBrowserEventsMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformChromeSafariBrowserEventsMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}
