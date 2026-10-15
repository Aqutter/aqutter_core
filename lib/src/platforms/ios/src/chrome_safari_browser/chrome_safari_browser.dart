import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

/// Object specifying creation parameters for creating a [IOSChromeSafariBrowser].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformChromeSafariBrowserCreationParams] for
/// more information.
@immutable
class IOSChromeSafariBrowserCreationParams
    extends AqutterPlatformChromeSafariBrowserCreationParams {
  /// Creates a new [IOSChromeSafariBrowserCreationParams] instance.
  const IOSChromeSafariBrowserCreationParams();

  /// Creates a [IOSChromeSafariBrowserCreationParams] instance based on [AqutterPlatformChromeSafariBrowserCreationParams].
  factory IOSChromeSafariBrowserCreationParams.fromPlatformChromeSafariBrowserCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformChromeSafariBrowserCreationParams params,
  ) {
    return IOSChromeSafariBrowserCreationParams();
  }
}

///{@macro aqutter_core.AqutterPlatformChromeSafariBrowser}
class IOSChromeSafariBrowser extends AqutterPlatformChromeSafariBrowser
    with ChannelController {
  @override
  final String id = IdGenerator.generate();

  /// Constructs a [IOSChromeSafariBrowser].
  IOSChromeSafariBrowser(AqutterPlatformChromeSafariBrowserCreationParams params)
    : super.implementation(
        params is IOSChromeSafariBrowserCreationParams
            ? params
            : IOSChromeSafariBrowserCreationParams.fromPlatformChromeSafariBrowserCreationParams(
                params,
              ),
      );

  static final IOSChromeSafariBrowser _staticValue = IOSChromeSafariBrowser(
    IOSChromeSafariBrowserCreationParams(),
  );

  /// Provide static access.
  factory IOSChromeSafariBrowser.static() {
    return _staticValue;
  }

  Map<int, AqutterChromeSafariBrowserMenuItem> _menuItems = new HashMap();
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
      case "onOpened":
        eventHandler?.onOpened();
        break;
      case "onCompletedInitialLoad":
        final bool? didLoadSuccessfully = call.arguments["didLoadSuccessfully"];
        eventHandler?.onCompletedInitialLoad(didLoadSuccessfully);
        break;
      case "onInitialLoadDidRedirect":
        final String? url = call.arguments["url"];
        final AqutterWebUri? uri = url != null ? AqutterWebUri(url) : null;
        eventHandler?.onInitialLoadDidRedirect(uri);
        break;
      case "onWillOpenInBrowser":
        eventHandler?.onWillOpenInBrowser();
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
        if (this._menuItems[id] != null) {
          if (this._menuItems[id]?.action != null) {
            this._menuItems[id]?.action!(url, title);
          }
          if (this._menuItems[id]?.onClick != null) {
            this._menuItems[id]?.onClick!(AqutterWebUri(url), title);
          }
        }
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

    assert(url != null, 'The specified URL must not be null on iOS.');
    assert(
      ['http', 'https'].contains(url!.scheme),
      'The specified URL has an unsupported scheme. Only HTTP and HTTPS URLs are supported on iOS.',
    );
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
    args.putIfAbsent('menuItemList', () => menuItemList);
    await _staticChannel.invokeMethod('open', args);
  }

  @override
  Future<void> close() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod("close", args);
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
  Future<bool> isAvailable() async {
    Map<String, dynamic> args = <String, dynamic>{};
    return await _staticChannel.invokeMethod<bool>("isAvailable", args) ??
        false;
  }

  @override
  Future<void> clearWebsiteData() async {
    Map<String, dynamic> args = <String, dynamic>{};
    await _staticChannel.invokeMethod("clearWebsiteData", args);
  }

  @override
  Future<AqutterPrewarmingToken?> prewarmConnections(List<AqutterWebUri> URLs) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('URLs', () => URLs.map((e) => e.toString()).toList());
    Map<String, dynamic>? result = (await _staticChannel.invokeMethod(
      "prewarmConnections",
      args,
    ))?.cast<String, dynamic>();
    return AqutterPrewarmingToken.fromMap(result);
  }

  @override
  Future<void> invalidatePrewarmingToken(
    AqutterPrewarmingToken prewarmingToken,
  ) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('prewarmingToken', () => prewarmingToken.toMap());
    await _staticChannel.invokeMethod("invalidatePrewarmingToken", args);
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
