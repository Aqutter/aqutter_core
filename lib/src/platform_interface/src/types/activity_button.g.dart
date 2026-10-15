// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_button.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents a custom button to show in `SFSafariViewController`'s toolbar.
///When tapped, it will invoke a Share or Action Extension bundled with your app.
///The default VoiceOver description of this button is the `CFBundleDisplayName` set in the extension's `Info.plist`.
///
///Check [Official Apple App Extensions](https://developer.apple.com/app-extensions/) for more details.
///
///**Officially Supported Platforms/Implementations**:
///- iOS
class AqutterActivityButton {
  ///The name of the App or Share Extension to be called.
  String extensionIdentifier;

  ///The name of the image asset or file.
  AqutterUIImage templateImage;
  AqutterActivityButton({
    required this.templateImage,
    required this.extensionIdentifier,
  });

  ///Gets a possible [AqutterActivityButton] instance from a [Map] value.
  static AqutterActivityButton? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterActivityButton(
      extensionIdentifier: map['extensionIdentifier'],
      templateImage: AqutterUIImage.fromMap(
        map['templateImage']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      )!,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "extensionIdentifier": extensionIdentifier,
      "templateImage": templateImage.toMap(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterActivityButton{extensionIdentifier: $extensionIdentifier, templateImage: $templateImage}';
  }
}
