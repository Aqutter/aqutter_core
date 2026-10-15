import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'enum_method.dart';

part 'save_file_security_check_starting_response.g.dart';

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onSaveFileSecurityCheckStarting] event.
@ExchangeableObject()
class AqutterSaveFileSecurityCheckStartingResponse_ {
  ///Whether to cancel the save operation.
  bool? cancelSave;

  ///Whether to suppress the default policy check.
  bool? suppressDefaultPolicy;

  AqutterSaveFileSecurityCheckStartingResponse_({
    this.cancelSave,
    this.suppressDefaultPolicy,
  });
}
