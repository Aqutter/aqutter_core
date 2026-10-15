// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_menu.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the WebView context menu. It used by [AqutterPlatformWebViewCreationParams.contextMenu].
///
///**Officially Supported Platforms/Implementations**:
///- Android WebView:
///    - To make it work properly on Android, JavaScript should be enabled!
///- iOS WKWebView
class AqutterContextMenu {
  ///List of the custom [AqutterContextMenuItem].
  final List<AqutterContextMenuItem> menuItems;

  ///Event fired when a context menu item has been clicked.
  ///
  ///[contextMenuItemClicked] represents the [AqutterContextMenuItem] clicked.
  final void Function(AqutterContextMenuItem)? onContextMenuActionItemClicked;

  ///Event fired when the context menu for this WebView is being built.
  ///
  ///[hitTestResult] represents the hit result for hitting an HTML elements.
  final void Function(AqutterWebViewHitTestResult)? onCreateContextMenu;

  ///Event fired when the context menu for this WebView is being hidden.
  final void Function()? onHideContextMenu;

  ///Use [settings] instead
  @Deprecated('Use settings instead')
  final AqutterContextMenuOptions? options;

  ///Context menu settings.
  final AqutterContextMenuSettings? settings;

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - To make it work properly on Android, JavaScript should be enabled!
  ///- iOS WKWebView
  AqutterContextMenu({
    this.menuItems = const [],
    this.onCreateContextMenu,
    this.onHideContextMenu,
    @Deprecated("Use settings instead") this.options,
    this.settings,
    this.onContextMenuActionItemClicked,
  });

  ///Gets a possible [AqutterContextMenu] instance from a [Map] value.
  static AqutterContextMenu? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterContextMenu(
      menuItems: List<AqutterContextMenuItem>.from(
        map['menuItems'].map(
          (e) => AqutterContextMenuItem.fromMap(
            e?.cast<String, dynamic>(),
            enumMethod: enumMethod,
          )!,
        ),
      ),
      options: AqutterContextMenuOptions.fromMap(
        map['settings']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      settings: AqutterContextMenuSettings.fromMap(
        map['settings']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
    );
    return instance;
  }

  @ExchangeableObjectMethod(toMapMergeWith: true)
  Map<String, dynamic> _toMapMergeWith({AqutterEnumMethod? enumMethod}) {
    return {
      "settings":
          (settings as AqutterContextMenuSettings?)?.toMap(
            enumMethod: enumMethod,
          ) ??
          (options as AqutterContextMenuOptions?)?.toMap(
            enumMethod: enumMethod,
          ),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "menuItems": menuItems
          .map((e) => e.toMap(enumMethod: enumMethod))
          .toList(),
      "settings": settings?.toMap(enumMethod: enumMethod),
      ..._toMapMergeWith(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterContextMenu{menuItems: $menuItems, settings: $settings}';
  }
}
