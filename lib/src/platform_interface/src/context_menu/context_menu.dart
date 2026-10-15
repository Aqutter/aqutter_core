import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import '../types/webview_hit_test_result.dart';
import 'context_menu_item.dart';
import 'context_menu_settings.dart';
import '../types/enum_method.dart';

part 'context_menu.g.dart';

///Class that represents the WebView context menu. It used by [AqutterPlatformWebViewCreationParams.contextMenu].
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(
      note:
          'To make it work properly on Android, JavaScript should be enabled!',
    ),
    IOSPlatform(),
  ],
)
@ExchangeableObject()
class AqutterContextMenu_ {
  ///Event fired when the context menu for this WebView is being built.
  ///
  ///[hitTestResult] represents the hit result for hitting an HTML elements.
  final void Function(AqutterWebViewHitTestResult_ hitTestResult)?
  onCreateContextMenu;

  ///Event fired when the context menu for this WebView is being hidden.
  final void Function()? onHideContextMenu;

  ///Event fired when a context menu item has been clicked.
  ///
  ///[contextMenuItemClicked] represents the [AqutterContextMenuItem] clicked.
  final void Function(AqutterContextMenuItem_ contextMenuItemClicked)?
  onContextMenuActionItemClicked;

  ///Use [settings] instead
  @Deprecated("Use settings instead")
  final AqutterContextMenuOptions_? options;

  ///Context menu settings.
  final AqutterContextMenuSettings_? settings;

  ///List of the custom [AqutterContextMenuItem].
  final List<AqutterContextMenuItem_> menuItems;

  @ExchangeableObjectConstructor()
  AqutterContextMenu_({
    this.menuItems = const [],
    this.onCreateContextMenu,
    this.onHideContextMenu,
    @Deprecated("Use settings instead") this.options,
    this.settings,
    this.onContextMenuActionItemClicked,
  });

  @ExchangeableObjectMethod(toMapMergeWith: true)
  // ignore: unused_element
  Map<String, dynamic> _toMapMergeWith({AqutterEnumMethod? enumMethod}) {
    return {
      "settings":
          (settings as AqutterContextMenuSettings?)?.toMap(enumMethod: enumMethod) ??
          (options as AqutterContextMenuOptions?)?.toMap(enumMethod: enumMethod),
    };
  }
}
