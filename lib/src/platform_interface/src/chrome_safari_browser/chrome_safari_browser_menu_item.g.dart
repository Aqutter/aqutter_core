// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chrome_safari_browser_menu_item.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents a custom menu item for a [AqutterPlatformChromeSafariBrowser] instance.
///
///**Officially Supported Platforms/Implementations**:
///- Android WebView:
///    - Not available in an Android Trusted Web Activity.
///- iOS WKWebView
class AqutterChromeSafariBrowserMenuItem {
  ///Use onClick instead.
  @Deprecated('Use onClick instead')
  void Function(String, String)? action;

  ///The menu item id. It should be different from [AqutterChromeSafariBrowserActionButton.id].
  int id;

  ///Item image.
  AqutterUIImage? image;

  ///The label of the menu item.
  String label;

  ///Callback function to be invoked when the menu item is clicked
  void Function(AqutterWebUri?, String)? onClick;

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView:
  ///    - Not available in an Android Trusted Web Activity.
  ///- iOS WKWebView
  AqutterChromeSafariBrowserMenuItem({
    required this.id,
    required this.label,
    this.image,
    @Deprecated("Use onClick instead") this.action,
    this.onClick,
  });

  ///Gets a possible [AqutterChromeSafariBrowserMenuItem] instance from a [Map] value.
  static AqutterChromeSafariBrowserMenuItem? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterChromeSafariBrowserMenuItem(
      id: map['id'],
      image: AqutterUIImage.fromMap(
        map['image']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      label: map['label'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "id": id,
      "image": image?.toMap(enumMethod: enumMethod),
      "label": label,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterChromeSafariBrowserMenuItem{id: $id, image: $image, label: $label}';
  }
}
