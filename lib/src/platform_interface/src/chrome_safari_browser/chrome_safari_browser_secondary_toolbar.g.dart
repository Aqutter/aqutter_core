// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chrome_safari_browser_secondary_toolbar.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the [RemoteViews](https://developer.android.com/reference/android/widget/RemoteViews.html)
///that will be shown on the secondary toolbar of a custom tab.
///
///This class describes a view hierarchy that can be displayed in another process.
///The hierarchy is inflated from an Android layout resource file.
///
///RemoteViews has limited to support to Android layouts.
///Check the [RemoteViews Official API](https://developer.android.com/reference/android/widget/RemoteViews.html) for more details.
///
///**Officially Supported Platforms/Implementations**:
///- Android WebView:
///    - Not available in an Android Trusted Web Activity.
class AqutterChromeSafariBrowserSecondaryToolbar {
  ///The IDs of clickable views. The `onClick` event of these views will be handled by custom tabs.
  List<AqutterChromeSafariBrowserSecondaryToolbarClickableID> clickableIDs;

  ///The android layout resource.
  AqutterAndroidResource layout;

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - Not available in an Android Trusted Web Activity.
  AqutterChromeSafariBrowserSecondaryToolbar({
    this.clickableIDs = const [],
    required this.layout,
  });

  ///Gets a possible [AqutterChromeSafariBrowserSecondaryToolbar] instance from a [Map] value.
  static AqutterChromeSafariBrowserSecondaryToolbar? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterChromeSafariBrowserSecondaryToolbar(
      layout: AqutterAndroidResource.fromMap(
        map['layout']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      )!,
    );
    if (map['clickableIDs'] != null) {
      instance.clickableIDs =
          List<AqutterChromeSafariBrowserSecondaryToolbarClickableID>.from(
            map['clickableIDs'].map(
              (e) =>
                  AqutterChromeSafariBrowserSecondaryToolbarClickableID.fromMap(
                    e?.cast<String, dynamic>(),
                    enumMethod: enumMethod,
                  )!,
            ),
          );
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "clickableIDs": clickableIDs
          .map((e) => e.toMap(enumMethod: enumMethod))
          .toList(),
      "layout": layout.toMap(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterChromeSafariBrowserSecondaryToolbar{clickableIDs: $clickableIDs, layout: $layout}';
  }
}

///Class that represents a clickable ID item of the secondary toolbar for a [AqutterPlatformChromeSafariBrowser] instance.
///
///**Officially Supported Platforms/Implementations**:
///- Android WebView:
///    - Not available in an Android Trusted Web Activity.
class AqutterChromeSafariBrowserSecondaryToolbarClickableID {
  ///The android id resource
  AqutterAndroidResource id;

  ///Callback function to be invoked when the item is clicked
  void Function(AqutterWebUri?)? onClick;

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - Not available in an Android Trusted Web Activity.
  AqutterChromeSafariBrowserSecondaryToolbarClickableID({
    required this.id,
    this.onClick,
  });

  ///Gets a possible [AqutterChromeSafariBrowserSecondaryToolbarClickableID] instance from a [Map] value.
  static AqutterChromeSafariBrowserSecondaryToolbarClickableID? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterChromeSafariBrowserSecondaryToolbarClickableID(
      id: AqutterAndroidResource.fromMap(
        map['id']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      )!,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"id": id.toMap(enumMethod: enumMethod)};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterChromeSafariBrowserSecondaryToolbarClickableID{id: $id}';
  }
}
