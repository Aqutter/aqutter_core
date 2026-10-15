import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import 'enum_method.dart';
import 'physical_key_status.dart';

part 'accelerator_key_pressed_detail.g.dart';

///Class that represents details of the [AqutterPlatformWebViewCreationParams.onAcceleratorKeyPressed] event.
@ExchangeableObject()
class AqutterAcceleratorKeyPressedDetail_ {
  int? keyEventKind;
  AqutterPhysicalKeyStatus_? physicalKeyStatus;
  int? virtualKey;

  @ExchangeableObjectConstructor()
  AqutterAcceleratorKeyPressedDetail_({
    this.keyEventKind,
    this.physicalKeyStatus,
    this.virtualKey,
  });
}
