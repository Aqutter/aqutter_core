import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'trusted_web_activity_display_mode.dart';
import 'layout_in_display_cutout_mode.dart';
import 'enum_method.dart';

part 'trusted_web_activity_immersive_display_mode.g.dart';

///Class that represents the default display mode of a Trusted Web Activity.
///The system UI (status bar, navigation bar) is shown, and the browser toolbar is hidden while the user is on a verified origin.
@ExchangeableObject()
class AqutterTrustedWebActivityImmersiveDisplayMode_
    implements AqutterTrustedWebActivityDisplayMode_ {
  ///Whether the Trusted Web Activity should be in sticky immersive mode.
  bool isSticky;

  ///Use [displayCutoutMode] instead.
  @Deprecated("Use displayCutoutMode instead")
  AqutterAndroidLayoutInDisplayCutoutMode_? layoutInDisplayCutoutMode;

  ///The constant defining how to deal with display cutouts.
  AqutterLayoutInDisplayCutoutMode_ displayCutoutMode;

  static final _type = "IMMERSIVE_MODE";

  @ExchangeableObjectConstructor()
  AqutterTrustedWebActivityImmersiveDisplayMode_({
    required this.isSticky,
    this.displayCutoutMode = AqutterLayoutInDisplayCutoutMode_.DEFAULT,
    this.layoutInDisplayCutoutMode,
  }) {
    this.displayCutoutMode = this.layoutInDisplayCutoutMode != null
        ? AqutterLayoutInDisplayCutoutMode_.fromNativeValue(
            layoutInDisplayCutoutMode?.toNativeValue(),
          )!
        : this.displayCutoutMode;
  }

  @ExchangeableObjectMethod(toMapMergeWith: true)
  // ignore: unused_element
  Map<String, dynamic> _toMapMergeWith({AqutterEnumMethod? enumMethod}) {
    return {"type": _type};
  }

  @override
  @ExchangeableObjectMethod(ignore: true)
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
