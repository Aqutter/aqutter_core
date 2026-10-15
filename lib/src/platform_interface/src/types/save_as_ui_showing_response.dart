import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'save_as_kind.dart';
import 'enum_method.dart';

part 'save_as_ui_showing_response.g.dart';

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onSaveAsUIShowing] event.
@ExchangeableObject()
class AqutterSaveAsUIShowingResponse_ {
  ///Whether to cancel the Save As action.
  bool? cancel;

  ///Whether to suppress the default dialog.
  bool? suppressDefaultDialog;

  ///The save file path to use.
  String? saveAsFilePath;

  ///Whether the save operation may replace an existing file.
  bool? allowReplace;

  ///The save-as kind for the operation.
  AqutterSaveAsKind_? kind;

  AqutterSaveAsUIShowingResponse_({
    this.cancel,
    this.suppressDefaultDialog,
    this.saveAsFilePath,
    this.allowReplace,
    this.kind,
  });
}
