// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_menu_settings.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents available settings used by [AqutterContextMenu].
class AqutterContextMenuSettings {
  ///Whether all the default system context menu items should be hidden or not. The default value is `false`.
  bool hideDefaultSystemContextMenuItems;
  AqutterContextMenuSettings({this.hideDefaultSystemContextMenuItems = false});

  ///Gets a possible [AqutterContextMenuSettings] instance from a [Map] value.
  static AqutterContextMenuSettings? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterContextMenuSettings();
    if (map['hideDefaultSystemContextMenuItems'] != null) {
      instance.hideDefaultSystemContextMenuItems =
          map['hideDefaultSystemContextMenuItems'];
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "hideDefaultSystemContextMenuItems": hideDefaultSystemContextMenuItems,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  ///Returns a copy of AqutterContextMenuSettings.
  AqutterContextMenuSettings copy() {
    return AqutterContextMenuSettings.fromMap(toMap()) ??
        AqutterContextMenuSettings();
  }

  @override
  String toString() {
    return 'AqutterContextMenuSettings{hideDefaultSystemContextMenuItems: $hideDefaultSystemContextMenuItems}';
  }
}

///Use [AqutterContextMenuSettings] instead.
@Deprecated('Use AqutterContextMenuSettings instead')
class AqutterContextMenuOptions {
  ///Whether all the default system context menu items should be hidden or not. The default value is `false`.
  bool hideDefaultSystemContextMenuItems;
  AqutterContextMenuOptions({this.hideDefaultSystemContextMenuItems = false});

  ///Gets a possible [AqutterContextMenuOptions] instance from a [Map] value.
  static AqutterContextMenuOptions? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterContextMenuOptions();
    if (map['hideDefaultSystemContextMenuItems'] != null) {
      instance.hideDefaultSystemContextMenuItems =
          map['hideDefaultSystemContextMenuItems'];
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "hideDefaultSystemContextMenuItems": hideDefaultSystemContextMenuItems,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  ///Returns a copy of AqutterContextMenuOptions.
  AqutterContextMenuOptions copy() {
    return AqutterContextMenuOptions.fromMap(toMap()) ??
        AqutterContextMenuOptions();
  }

  @override
  String toString() {
    return 'AqutterContextMenuOptions{hideDefaultSystemContextMenuItems: $hideDefaultSystemContextMenuItems}';
  }
}
