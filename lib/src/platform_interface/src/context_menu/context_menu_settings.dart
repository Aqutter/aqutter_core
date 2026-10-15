import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'context_menu.dart';
import '../types/enum_method.dart';

part 'context_menu_settings.g.dart';

///Class that represents available settings used by [AqutterContextMenu].
@ExchangeableObject(copyMethod: true)
class AqutterContextMenuSettings_ {
  ///Whether all the default system context menu items should be hidden or not. The default value is `false`.
  bool hideDefaultSystemContextMenuItems;

  AqutterContextMenuSettings_({this.hideDefaultSystemContextMenuItems = false});
}

///Use [AqutterContextMenuSettings] instead.
@Deprecated("Use AqutterContextMenuSettings instead")
@ExchangeableObject(copyMethod: true)
class AqutterContextMenuOptions_ {
  ///Whether all the default system context menu items should be hidden or not. The default value is `false`.
  bool hideDefaultSystemContextMenuItems;

  AqutterContextMenuOptions_({this.hideDefaultSystemContextMenuItems = false});
}
