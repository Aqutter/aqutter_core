import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [AndroidChromeSafariBrowser].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformChromeSafariBrowserCreationParams] for
/// more information.
@immutable
class AndroidChromeSafariBrowserCreationParams
    extends AqutterPlatformChromeSafariBrowserCreationParams {
  /// Creates a new [AndroidChromeSafariBrowserCreationParams] instance.
  const AndroidChromeSafariBrowserCreationParams();

  /// Creates a [AndroidChromeSafariBrowserCreationParams] instance based on [AqutterPlatformChromeSafariBrowserCreationParams].
  factory AndroidChromeSafariBrowserCreationParams.fromPlatformChromeSafariBrowserCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformChromeSafariBrowserCreationParams params,
  ) {
    return AndroidChromeSafariBrowserCreationParams();
  }
}

///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser}
class AndroidChromeSafariBrowser extends AqutterPlatformChromeSafariBrowser
    with ChannelController {
  @override
  final String id = IdGenerator.generate();

  /// Constructs a [AndroidChromeSafariBrowser].
  AndroidChromeSafariBrowser(AqutterPlatformChromeSafariBrowserCreationParams params)
    : super.implementation(
        params is AndroidChromeSafariBrowserCreationParams
            ? params
            : AndroidChromeSafariBrowserCreationParams.fromPlatformChromeSafariBrowserCreationParams(
                params,
              ),
      );

  static final AndroidChromeSafariBrowser _staticValue =
      AndroidChromeSafariBrowser(AndroidChromeSafariBrowserCreationParams());

  /// Provide static access.
  factory AndroidChromeSafariBrowser.static() {
    return _staticValue;
  }

  AqutterChromeSafariBrowserActionButton? _actionButton;
  Map<int, AqutterChromeSafariBrowserMenuItem> _menuItems = new HashMap();
  AqutterChromeSafariBrowserSecondaryToolbar? _secondaryToolbar;
  bool _isOpened = false;
  static const MethodChannel _staticChannel = const MethodChannel(
    'com.github.aqutter/chromesafaribrowser',
  );

  _init() {
    channel = MethodChannel(
      'com.github.aqutter/chromesafaribrowser_$id',
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }

  _debugLog(String method, dynamic args) {
    debugLog(
      className: this.runtimeType.toString(),
      id: id,
      debugLoggingSettings: AqutterPlatformChromeSafariBrowser.debugLoggingSettings,
      method: method,
      args: args,
    );
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    _debugLog(call.method, call.arguments);

    switch (call.method) {
      case "onServiceConnected":
        eventHandler?.onServiceConnected();
        break;
      case "onOpened":
        eventHandler?.onOpened();
        break;
      case "onCompletedInitialLoad":
        final bool? didLoadSuccessfully = call.arguments["didLoadSuccessfully"];
        eventHandler?.onCompletedInitialLoad(didLoadSuccessfully);
        break;
      case "onNavigationEvent":
        final navigationEvent = AqutterCustomTabsNavigationEventType.fromNativeValue(
          call.arguments["navigationEvent"],
        );
        eventHandler?.onNavigationEvent(navigationEvent);
        break;
      case "onRelationshipValidationResult":
        final relation = AqutterCustomTabsRelationType.fromNativeValue(
          call.arguments["relation"],
        );
        final requestedOrigin = call.arguments["requestedOrigin"] != null
            ? AqutterWebUri(call.arguments["requestedOrigin"])
            : null;
        final bool result = call.arguments["result"];
        eventHandler?.onRelationshipValidationResult(
          relation,
          requestedOrigin,
          result,
        );
        break;
      case "onClosed":
        _isOpened = false;
        final onClosed = eventHandler?.onClosed;
        dispose();
        onClosed?.call();
        break;
      case "onItemActionPerform":
        String url = call.arguments["url"];
        String title = call.arguments["title"];
        int id = call.arguments["id"].toInt();
        if (this._actionButton?.id == id) {
          if (this._actionButton?.action != null) {
            this._actionButton?.action!(url, title);
          }
          if (this._actionButton?.onClick != null) {
            this._actionButton?.onClick!(AqutterWebUri(url), title);
          }
        } else if (this._menuItems[id] != null) {
          if (this._menuItems[id]?.action != null) {
            this._menuItems[id]?.action!(url, title);
          }
          if (this._menuItems[id]?.onClick != null) {
            this._menuItems[id]?.onClick!(AqutterWebUri(url), title);
          }
        }
        break;
      case "onSecondaryItemActionPerform":
        final clickableIDs = this._secondaryToolbar?.clickableIDs;
        if (clickableIDs != null) {
          AqutterWebUri? url = call.arguments["url"] != null
              ? AqutterWebUri(call.arguments["url"])
              : null;
          String name = call.arguments["name"];
          for (final clickable in clickableIDs) {
            var clickableFullname = clickable.id.name;
            if (clickable.id.defType != null &&
                !clickableFullname.contains("/")) {
              clickableFullname = "${clickable.id.defType}/$clickableFullname";
            }
            if (clickable.id.defPackage != null &&
                !clickableFullname.contains(":")) {
              clickableFullname =
                  "${clickable.id.defPackage}:$clickableFullname";
            }
            if (clickableFullname == name) {
              if (clickable.onClick != null) {
                clickable.onClick!(url);
              }
              break;
            }
          }
        }
        break;
      case "onMessageChannelReady":
        eventHandler?.onMessageChannelReady();
        break;
      case "onPostMessage":
        final String message = call.arguments["message"];
        eventHandler?.onPostMessage(message);
        break;
      case "onVerticalScrollEvent":
        final bool isDirectionUp = call.arguments["isDirectionUp"];
        eventHandler?.onVerticalScrollEvent(isDirectionUp);
        break;
      case "onGreatestScrollPercentageIncreased":
        final int scrollPercentage = call.arguments["scrollPercentage"];
        eventHandler?.onGreatestScrollPercentageIncreased(scrollPercentage);
        break;
      case "onSessionEnded":
        final bool didUserInteract = call.arguments["didUserInteract"];
        eventHandler?.onSessionEnded(didUserInteract);
        break;
      default:
        throw UnimplementedError("Unimplemented ${call.method} method");
    }
  }

  @override
  Future<void> open({
    AqutterWebUri? url,
    Map<String, String>? headers,
    List<AqutterWebUri>? otherLikelyURLs,
    AqutterWebUri? referrer,
    @Deprecated('Use settings instead')
    // ignore: deprecated_member_use_from_same_package
    AqutterChromeSafariBrowserClassOptions? options,
    AqutterChromeSafariBrowserSettings? settings,
  }) async {
    assert(!_isOpened, 'The browser is already opened.');
    _isOpened = true;

    if (Util.isIOS) {
      assert(url != null, 'The specified URL must not be null on iOS.');
      assert(
        ['http', 'https'].contains(url!.scheme),
        'The specified URL has an unsupported scheme. Only HTTP and HTTPS URLs are supported on iOS.',
      );
    }
    if (url != null) {
      assert(url.toString().isNotEmpty, 'The specified URL must not be empty.');
    }

    _init();

    List<Map<String, dynamic>> menuItemList = [];
    _menuItems.forEach((key, value) {
      menuItemList.add(value.toMap());
    });

    var initialSettings =
        settings?.toMap() ??
        options?.toMap() ??
        AqutterChromeSafariBrowserSettings().toMap();

    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('id', () => id);
    args.putIfAbsent('url', () => url?.toString());
    args.putIfAbsent('headers', () => headers);
    args.putIfAbsent(
      'otherLikelyURLs',
      () => otherLikelyURLs?.map((e) => e.toString()).toList(),
    );
    args.putIfAbsent('referrer', () => referrer?.toString());
    args.putIfAbsent('settings', () => initialSettings);
    args.putIfAbsent('actionButton', () => _actionButton?.toMap());
    args.putIfAbsent('secondaryToolbar', () => _secondaryToolbar?.toMap());
    args.putIfAbsent('menuItemList', () => menuItemList);
    await _staticChannel.invokeMethod('open', args);
  }

  @override
  Future<void> launchUrl({
    required AqutterWebUri url,
    Map<String, String>? headers,
    List<AqutterWebUri>? otherLikelyURLs,
    AqutterWebUri? referrer,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('url', () => url.toString());
    args.putIfAbsent('headers', () => headers);
    args.putIfAbsent(
      'otherLikelyURLs',
      () => otherLikelyURLs?.map((e) => e.toString()).toList(),
    );
    args.putIfAbsent('referrer', () => referrer?.toString());
    await channel?.invokeMethod("launchUrl", args);
  }

  @override
  Future<bool> mayLaunchUrl({
    AqutterWebUri? url,
    List<AqutterWebUri>? otherLikelyURLs,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('url', () => url?.toString());
    args.putIfAbsent(
      'otherLikelyURLs',
      () => otherLikelyURLs?.map((e) => e.toString()).toList(),
    );
    return await channel?.invokeMethod<bool>("mayLaunchUrl", args) ?? false;
  }

  @override
  Future<bool> validateRelationship({
    required AqutterCustomTabsRelationType relation,
    required AqutterWebUri origin,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('relation', () => relation.toNativeValue());
    args.putIfAbsent('origin', () => origin.toString());
    return await channel?.invokeMethod<bool>("validateRelationship", args) ??
        false;
  }

  @override
  Future<void> close() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod("close", args);
  }

  @override
  void setActionButton(AqutterChromeSafariBrowserActionButton actionButton) {
    this._actionButton = actionButton;
  }

  @override
  Future<void> updateActionButton({
    required Uint8List icon,
    required String description,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('icon', () => icon);
    args.putIfAbsent('description', () => description);
    await channel?.invokeMethod("updateActionButton", args);
    _actionButton?.icon = icon;
    _actionButton?.description = description;
  }

  @override
  void setSecondaryToolbar(
    AqutterChromeSafariBrowserSecondaryToolbar secondaryToolbar,
  ) {
    this._secondaryToolbar = secondaryToolbar;
  }

  @override
  Future<void> updateSecondaryToolbar(
    AqutterChromeSafariBrowserSecondaryToolbar secondaryToolbar,
  ) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('secondaryToolbar', () => secondaryToolbar.toMap());
    await channel?.invokeMethod("updateSecondaryToolbar", args);
    this._secondaryToolbar = secondaryToolbar;
  }

  @override
  void addMenuItem(AqutterChromeSafariBrowserMenuItem menuItem) {
    this._menuItems[menuItem.id] = menuItem;
  }

  @override
  void addMenuItems(List<AqutterChromeSafariBrowserMenuItem> menuItems) {
    menuItems.forEach((menuItem) {
      this._menuItems[menuItem.id] = menuItem;
    });
  }

  @override
  Future<bool> requestPostMessageChannel({
    required AqutterWebUri sourceOrigin,
    AqutterWebUri? targetOrigin,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("sourceOrigin", () => sourceOrigin.toString());
    args.putIfAbsent("targetOrigin", () => targetOrigin.toString());
    return await channel?.invokeMethod<bool>(
          "requestPostMessageChannel",
          args,
        ) ??
        false;
  }

  @override
  Future<AqutterCustomTabsPostMessageResultType> postMessage(String message) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("message", () => message);
    return AqutterCustomTabsPostMessageResultType.fromNativeValue(
          await channel?.invokeMethod<int>("postMessage", args),
        ) ??
        AqutterCustomTabsPostMessageResultType.FAILURE_MESSAGING_ERROR;
  }

  @override
  Future<bool> isEngagementSignalsApiAvailable() async {
    Map<String, dynamic> args = <String, dynamic>{};
    return await channel?.invokeMethod<bool>(
          "isEngagementSignalsApiAvailable",
          args,
        ) ??
        false;
  }

  @override
  Future<bool> isAvailable() async {
    Map<String, dynamic> args = <String, dynamic>{};
    return await _staticChannel.invokeMethod<bool>("isAvailable", args) ??
        false;
  }

  @override
  Future<int> getMaxToolbarItems() async {
    Map<String, dynamic> args = <String, dynamic>{};
    return await _staticChannel.invokeMethod<int>("getMaxToolbarItems", args) ??
        0;
  }

  @override
  Future<String?> getPackageName({
    List<String>? packages,
    bool ignoreDefault = false,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("packages", () => packages);
    args.putIfAbsent("ignoreDefault", () => ignoreDefault);
    return await _staticChannel.invokeMethod<String?>("getPackageName", args);
  }

  @override
  bool isOpened() {
    return _isOpened;
  }

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
    disposeChannel();
  }
}
