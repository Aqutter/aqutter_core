import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser}
///
///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.supported_platforms}
class AqutterChromeSafariBrowser implements AqutterPlatformChromeSafariBrowserEvents {
  ///Constructs a [AqutterChromeSafariBrowser].
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.supported_platforms}
  AqutterChromeSafariBrowser()
    : this.fromPlatformCreationParams(
        AqutterPlatformChromeSafariBrowserCreationParams(),
      );

  /// Constructs a [AqutterChromeSafariBrowser] from creation params for a specific
  /// platform.
  AqutterChromeSafariBrowser.fromPlatformCreationParams(
    AqutterPlatformChromeSafariBrowserCreationParams params,
  ) : this.fromPlatform(AqutterPlatformChromeSafariBrowser(params));

  /// Constructs a [AqutterChromeSafariBrowser] from a specific platform
  /// implementation.
  AqutterChromeSafariBrowser.fromPlatform(this.platform) {
    this.platform.eventHandler = this;
  }

  /// Implementation of [AqutterPlatformChromeSafariBrowser] for the current platform.
  final AqutterPlatformChromeSafariBrowser platform;

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.id}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.id.supported_platforms}
  String get id => platform.id;

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.open}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.open.supported_platforms}
  Future<void> open({
    AqutterWebUri? url,
    Map<String, String>? headers,
    List<AqutterWebUri>? otherLikelyURLs,
    AqutterWebUri? referrer,
    @Deprecated('Use settings instead')
    // ignore: deprecated_member_use_from_same_package
    AqutterChromeSafariBrowserClassOptions? options,
    AqutterChromeSafariBrowserSettings? settings,
  }) {
    this.platform.eventHandler = this;
    return platform.open(
      url: url,
      headers: headers,
      otherLikelyURLs: otherLikelyURLs,
      options: options,
      settings: settings,
    );
  }

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.launchUrl}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.launchUrl.supported_platforms}
  Future<void> launchUrl({
    required AqutterWebUri url,
    Map<String, String>? headers,
    List<AqutterWebUri>? otherLikelyURLs,
    AqutterWebUri? referrer,
  }) => platform.launchUrl(
    url: url,
    headers: headers,
    otherLikelyURLs: otherLikelyURLs,
    referrer: referrer,
  );

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.mayLaunchUrl}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.mayLaunchUrl.supported_platforms}
  Future<bool> mayLaunchUrl({AqutterWebUri? url, List<AqutterWebUri>? otherLikelyURLs}) =>
      platform.mayLaunchUrl(url: url, otherLikelyURLs: otherLikelyURLs);

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.validateRelationship}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.validateRelationship.supported_platforms}
  Future<bool> validateRelationship({
    required AqutterCustomTabsRelationType relation,
    required AqutterWebUri origin,
  }) => platform.validateRelationship(relation: relation, origin: origin);

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.close}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.close.supported_platforms}
  Future<void> close() => platform.close();

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.isOpened}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.isOpened.supported_platforms}
  bool isOpened() => platform.isOpened();

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.setActionButton}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.setActionButton.supported_platforms}
  void setActionButton(AqutterChromeSafariBrowserActionButton actionButton) =>
      platform.setActionButton(actionButton);

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.updateActionButton}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.updateActionButton.supported_platforms}
  Future<void> updateActionButton({
    required Uint8List icon,
    required String description,
  }) => platform.updateActionButton(icon: icon, description: description);

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.setSecondaryToolbar}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.setSecondaryToolbar.supported_platforms}
  void setSecondaryToolbar(
    AqutterChromeSafariBrowserSecondaryToolbar secondaryToolbar,
  ) => platform.setSecondaryToolbar(secondaryToolbar);

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.updateSecondaryToolbar}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.updateSecondaryToolbar.supported_platforms}
  Future<void> updateSecondaryToolbar(
    AqutterChromeSafariBrowserSecondaryToolbar secondaryToolbar,
  ) => platform.updateSecondaryToolbar(secondaryToolbar);

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.addMenuItem}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.addMenuItem.supported_platforms}
  void addMenuItem(AqutterChromeSafariBrowserMenuItem menuItem) =>
      platform.addMenuItem(menuItem);

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.addMenuItems}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.addMenuItems.supported_platforms}
  void addMenuItems(List<AqutterChromeSafariBrowserMenuItem> menuItems) =>
      platform.addMenuItems(menuItems);

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.requestPostMessageChannel}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.requestPostMessageChannel.supported_platforms}
  Future<bool> requestPostMessageChannel({
    required AqutterWebUri sourceOrigin,
    AqutterWebUri? targetOrigin,
  }) => platform.requestPostMessageChannel(
    sourceOrigin: sourceOrigin,
    targetOrigin: targetOrigin,
  );

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.postMessage}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.postMessage.supported_platforms}
  Future<AqutterCustomTabsPostMessageResultType> postMessage(String message) =>
      platform.postMessage(message);

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.isEngagementSignalsApiAvailable}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.isEngagementSignalsApiAvailable.supported_platforms}
  Future<bool> isEngagementSignalsApiAvailable() =>
      platform.isEngagementSignalsApiAvailable();

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.isAvailable}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.isAvailable.supported_platforms}
  static Future<bool> isAvailable() =>
      AqutterPlatformChromeSafariBrowser.static().isAvailable();

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.getMaxToolbarItems}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.getMaxToolbarItems.supported_platforms}
  static Future<int> getMaxToolbarItems() =>
      AqutterPlatformChromeSafariBrowser.static().getMaxToolbarItems();

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.getPackageName}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.getPackageName.supported_platforms}
  static Future<String?> getPackageName({
    List<String>? packages,
    bool ignoreDefault = false,
  }) => AqutterPlatformChromeSafariBrowser.static().getPackageName(
    packages: packages,
    ignoreDefault: ignoreDefault,
  );

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.clearWebsiteData}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.clearWebsiteData.supported_platforms}
  static Future<void> clearWebsiteData() =>
      AqutterPlatformChromeSafariBrowser.static().clearWebsiteData();

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.prewarmConnections}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.prewarmConnections.supported_platforms}
  static Future<AqutterPrewarmingToken?> prewarmConnections(List<AqutterWebUri> URLs) =>
      AqutterPlatformChromeSafariBrowser.static().prewarmConnections(URLs);

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.invalidatePrewarmingToken}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.invalidatePrewarmingToken.supported_platforms}
  static Future<void> invalidatePrewarmingToken(
    AqutterPrewarmingToken prewarmingToken,
  ) => AqutterPlatformChromeSafariBrowser.static().invalidatePrewarmingToken(
    prewarmingToken,
  );

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.dispose}
  ///
  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.dispose.supported_platforms}
  @mustCallSuper
  void dispose() => platform.dispose();

  @override
  void onClosed() {}

  @override
  void onCompletedInitialLoad(bool? didLoadSuccessfully) {}

  @override
  void onGreatestScrollPercentageIncreased(int scrollPercentage) {}

  @override
  void onInitialLoadDidRedirect(AqutterWebUri? url) {}

  @override
  void onMessageChannelReady() {}

  @override
  void onNavigationEvent(AqutterCustomTabsNavigationEventType? navigationEvent) {}

  @override
  void onOpened() {}

  @override
  void onPostMessage(String message) {}

  @override
  void onRelationshipValidationResult(
    AqutterCustomTabsRelationType? relation,
    AqutterWebUri? requestedOrigin,
    bool result,
  ) {}

  @override
  void onServiceConnected() {}

  @override
  void onSessionEnded(bool didUserInteract) {}

  @override
  void onVerticalScrollEvent(bool isDirectionUp) {}

  @override
  void onWillOpenInBrowser() {}

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformChromeSafariBrowser.static().isClassSupported(platform: platform);

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformChromeSafariBrowserMethod property, {
    TargetPlatform? platform,
  }) => AqutterPlatformChromeSafariBrowser.static().isMethodSupported(
    property,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformChromeSafariBrowserEvents.isMethodSupported}
  static bool isEventMethodSupported(
    AqutterPlatformChromeSafariBrowserEventsMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformChromeSafariBrowserEvents.isMethodSupported(
    method,
    platform: platform,
  );
}
