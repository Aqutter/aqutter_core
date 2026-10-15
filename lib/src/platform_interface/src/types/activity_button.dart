import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'enum_method.dart';
import 'ui_image.dart';

part 'activity_button.g.dart';

///Class that represents a custom button to show in `SFSafariViewController`'s toolbar.
///When tapped, it will invoke a Share or Action Extension bundled with your app.
///The default VoiceOver description of this button is the `CFBundleDisplayName` set in the extension's `Info.plist`.
///
///Check [Official Apple App Extensions](https://developer.apple.com/app-extensions/) for more details.
///
///**Officially Supported Platforms/Implementations**:
///- iOS
@ExchangeableObject()
class AqutterActivityButton_ {
  ///The name of the image asset or file.
  AqutterUIImage_ templateImage;

  ///The name of the App or Share Extension to be called.
  String extensionIdentifier;

  @ExchangeableObjectConstructor()
  AqutterActivityButton_({
    required this.templateImage,
    required this.extensionIdentifier,
  });
}
