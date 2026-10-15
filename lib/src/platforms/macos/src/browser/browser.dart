import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../find_interaction/find_interaction_controller.dart';
import '../webview/webview_controller.dart';

/// Object specifying creation parameters for creating a [AqutterMacOSBrowser].
///
/// When adding additional fields make sure they can be null or have a default
/// value to avoid breaking changes. See [AqutterPlatformBrowserCreationParams] for
/// more information.
class AqutterMacOSBrowserCreationParams
    extends AqutterPlatformBrowserCreationParams {
  /// Creates a new [AqutterMacOSBrowserCreationParams] instance.
  AqutterMacOSBrowserCreationParams({
    super.contextMenu,
    super.pullToRefreshController,
    this.findInteractionController,
    super.initialUserScripts,
    super.windowId,
  });

  /// Creates a [AqutterMacOSBrowserCreationParams] instance based on [AqutterPlatformBrowserCreationParams].
  factory AqutterMacOSBrowserCreationParams.fromPlatformBrowserCreationParams(
    // Recommended placeholder to prevent being broken by platform interface.
    // ignore: avoid_unused_constructor_parameters
    AqutterPlatformBrowserCreationParams params,
  ) {
    return AqutterMacOSBrowserCreationParams(
      contextMenu: params.contextMenu,
      pullToRefreshController: params.pullToRefreshController,
      findInteractionController:
          params.findInteractionController as MacOSFindInteractionController?,
      initialUserScripts: params.initialUserScripts,
      windowId: params.windowId,
    );
  }

  @override
  final MacOSFindInteractionController? findInteractionController;
}

///{@macro aqutter_core.AqutterPlatformBrowser}
class AqutterMacOSBrowser extends AqutterPlatformBrowser with ChannelController {
  @override
  final String id = IdGenerator.generate();

  /// Constructs a [AqutterMacOSBrowser].
  AqutterMacOSBrowser(AqutterPlatformBrowserCreationParams params)
    : super.implementation(
        params is AqutterMacOSBrowserCreationParams
            ? params
            : AqutterMacOSBrowserCreationParams.fromPlatformBrowserCreationParams(
                params,
              ),
      ) {
    _contextMenu = params.contextMenu;
  }

  static final AqutterMacOSBrowser _staticValue = AqutterMacOSBrowser(
    AqutterMacOSBrowserCreationParams(),
  );

  /// Provide static access.
  factory AqutterMacOSBrowser.static() {
    return _staticValue;
  }

  AqutterMacOSBrowserCreationParams get _macosParams =>
      params as AqutterMacOSBrowserCreationParams;

  static const MethodChannel _staticChannel = const MethodChannel(
    'com.github.aqutter/browser',
  );

  AqutterContextMenu? _contextMenu;

  @override
  AqutterContextMenu? get contextMenu => _contextMenu;

  Map<int, AqutterBrowserMenuItem> _menuItems = HashMap();
  bool _isOpened = false;
  AqutterMacOSWebViewController? _webViewController;

  @override
  AqutterMacOSWebViewController? get webViewController {
    return _isOpened ? _webViewController : null;
  }

  _init() {
    channel = MethodChannel('com.github.aqutter/browser_$id');
    handler = _handleMethod;
    initMethodCallHandler();

    _webViewController = AqutterMacOSWebViewController.fromBrowser(
      AqutterMacOSWebViewControllerCreationParams(id: id),
      channel!,
      this,
      this.initialUserScripts,
    );
    _macosParams.findInteractionController?.init(id);
  }

  _debugLog(String method, dynamic args) {
    debugLog(
      className: this.runtimeType.toString(),
      id: id,
      debugLoggingSettings: AqutterPlatformBrowser.debugLoggingSettings,
      method: method,
      args: args,
    );
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "onBrowserCreated":
        _debugLog(call.method, call.arguments);
        eventHandler?.onBrowserCreated();
        break;
      case "onMenuItemClicked":
        _debugLog(call.method, call.arguments);
        int id = call.arguments["id"].toInt();
        if (this._menuItems[id] != null) {
          if (this._menuItems[id]?.onClick != null) {
            this._menuItems[id]?.onClick!();
          }
        }
        break;
      case "onMainWindowWillClose":
        _debugLog(call.method, call.arguments);
        eventHandler?.onMainWindowWillClose();
        break;
      case "onExit":
        _debugLog(call.method, call.arguments);
        _isOpened = false;
        final onExit = eventHandler?.onExit;
        dispose();
        onExit?.call();
        break;
      default:
        return _webViewController?.handleMethod(call);
    }
  }

  Map<String, dynamic> _prepareOpenRequest({
    @Deprecated('Use settings instead') AqutterBrowserClassOptions? options,
    AqutterBrowserClassSettings? settings,
  }) {
    assert(!_isOpened, 'The browser is already opened.');
    _isOpened = true;
    _init();

    var initialSettings =
        settings?.toMap() ??
        options?.toMap() ??
        AqutterBrowserClassSettings().toMap();

    Map<String, dynamic> pullToRefreshSettings =
        pullToRefreshController?.settings.toMap() ??
        pullToRefreshController?.options.toMap() ??
        AqutterPullToRefreshSettings(enabled: false).toMap();

    List<Map<String, dynamic>> menuItemList = [];
    _menuItems.forEach((key, value) {
      menuItemList.add(value.toMap());
    });

    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('id', () => id);
    args.putIfAbsent('settings', () => initialSettings);
    args.putIfAbsent('contextMenu', () => contextMenu?.toMap() ?? {});
    args.putIfAbsent('windowId', () => windowId);
    args.putIfAbsent(
      'initialUserScripts',
      () => initialUserScripts?.map((e) => e.toMap()).toList() ?? [],
    );
    args.putIfAbsent('pullToRefreshSettings', () => pullToRefreshSettings);
    args.putIfAbsent('menuItems', () => menuItemList);
    return args;
  }

  @override
  Future<void> openUrlRequest({
    required AqutterURLRequest urlRequest,
    // ignore: deprecated_member_use_from_same_package
    @Deprecated('Use settings instead') AqutterBrowserClassOptions? options,
    AqutterBrowserClassSettings? settings,
  }) async {
    assert(urlRequest.url != null && urlRequest.url.toString().isNotEmpty);

    Map<String, dynamic> args = _prepareOpenRequest(
      options: options,
      settings: settings,
    );
    args.putIfAbsent('urlRequest', () => urlRequest.toMap());
    await _staticChannel.invokeMethod('open', args);
  }

  @override
  Future<void> openFile({
    required String assetFilePath,
    // ignore: deprecated_member_use_from_same_package
    @Deprecated('Use settings instead') AqutterBrowserClassOptions? options,
    AqutterBrowserClassSettings? settings,
  }) async {
    assert(assetFilePath.isNotEmpty);

    Map<String, dynamic> args = _prepareOpenRequest(
      options: options,
      settings: settings,
    );
    args.putIfAbsent('assetFilePath', () => assetFilePath);
    await _staticChannel.invokeMethod('open', args);
  }

  @override
  Future<void> openData({
    required String data,
    String mimeType = "text/html",
    String encoding = "utf8",
    AqutterWebUri? baseUrl,
    @Deprecated("Use historyUrl instead") Uri? androidHistoryUrl,
    AqutterWebUri? historyUrl,
    // ignore: deprecated_member_use_from_same_package
    @Deprecated('Use settings instead') AqutterBrowserClassOptions? options,
    AqutterBrowserClassSettings? settings,
  }) async {
    Map<String, dynamic> args = _prepareOpenRequest(
      options: options,
      settings: settings,
    );
    args.putIfAbsent('data', () => data);
    args.putIfAbsent('mimeType', () => mimeType);
    args.putIfAbsent('encoding', () => encoding);
    args.putIfAbsent('baseUrl', () => baseUrl?.toString() ?? "about:blank");
    args.putIfAbsent(
      'historyUrl',
      () => (historyUrl ?? androidHistoryUrl)?.toString() ?? "about:blank",
    );
    await _staticChannel.invokeMethod('open', args);
  }

  @override
  Future<void> openWithSystemBrowser({required AqutterWebUri url}) async {
    assert(url.toString().isNotEmpty);

    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('url', () => url.toString());
    return await _staticChannel.invokeMethod('openWithSystemBrowser', args);
  }

  @override
  void addMenuItem(AqutterBrowserMenuItem menuItem) {
    _menuItems[menuItem.id] = menuItem;
  }

  @override
  void addMenuItems(List<AqutterBrowserMenuItem> menuItems) {
    menuItems.forEach((menuItem) {
      _menuItems[menuItem.id] = menuItem;
    });
  }

  @override
  bool removeMenuItem(AqutterBrowserMenuItem menuItem) {
    return _menuItems.remove(menuItem.id) != null;
  }

  @override
  void removeMenuItems(List<AqutterBrowserMenuItem> menuItems) {
    for (final menuItem in menuItems) {
      removeMenuItem(menuItem);
    }
  }

  @override
  void removeAllMenuItem() {
    _menuItems.clear();
  }

  @override
  bool hasMenuItem(AqutterBrowserMenuItem menuItem) {
    return _menuItems.containsKey(menuItem.id);
  }

  @override
  Future<void> show() async {
    assert(_isOpened, 'The browser is not opened.');

    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('show', args);
  }

  @override
  Future<void> hide() async {
    assert(_isOpened, 'The browser is not opened.');

    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('hide', args);
  }

  @override
  Future<void> close() async {
    assert(_isOpened, 'The browser is not opened.');

    Map<String, dynamic> args = <String, dynamic>{};
    await channel?.invokeMethod('close', args);
  }

  @override
  Future<bool> isHidden() async {
    assert(_isOpened, 'The browser is not opened.');

    Map<String, dynamic> args = <String, dynamic>{};
    return await channel?.invokeMethod<bool>('isHidden', args) ?? false;
  }

  @override
  @Deprecated('Use setSettings instead')
  Future<void> setOptions({required AqutterBrowserClassOptions options}) async {
    assert(_isOpened, 'The browser is not opened.');

    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('settings', () => options.toMap());
    await channel?.invokeMethod('setSettings', args);
  }

  @override
  @Deprecated('Use getSettings instead')
  Future<AqutterBrowserClassOptions?> getOptions() async {
    assert(_isOpened, 'The browser is not opened.');
    Map<String, dynamic> args = <String, dynamic>{};

    Map<dynamic, dynamic>? options = await channel?.invokeMethod(
      'getSettings',
      args,
    );
    if (options != null) {
      options = options.cast<String, dynamic>();
      return AqutterBrowserClassOptions.fromMap(options as Map<String, dynamic>);
    }

    return null;
  }

  @override
  Future<void> setSettings({
    required AqutterBrowserClassSettings settings,
  }) async {
    assert(_isOpened, 'The browser is not opened.');

    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('settings', () => settings.toMap());
    await channel?.invokeMethod('setSettings', args);
  }

  @override
  Future<AqutterBrowserClassSettings?> getSettings() async {
    assert(_isOpened, 'The browser is not opened.');

    Map<String, dynamic> args = <String, dynamic>{};

    Map<dynamic, dynamic>? settings = await channel?.invokeMethod(
      'getSettings',
      args,
    );
    if (settings != null) {
      settings = settings.cast<String, dynamic>();
      return AqutterBrowserClassSettings.fromMap(
        settings as Map<String, dynamic>,
      );
    }

    return null;
  }

  @override
  bool isOpened() {
    return this._isOpened;
  }

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
    disposeChannel();
    _webViewController?.dispose();
    _webViewController = null;
    pullToRefreshController?.dispose();
    findInteractionController?.dispose();
  }
}

extension AqutterInternalBrowser on AqutterMacOSBrowser {
  void setContextMenu(AqutterContextMenu? contextMenu) {
    _contextMenu = contextMenu;
  }
}
