import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'download_start_response.dart';

part 'download_start_response_action.g.dart';

///Class representing the action of a [AqutterDownloadStartResponse].
@ExchangeableEnum()
class AqutterDownloadStartResponseAction_ {
  // ignore: unused_field
  final int _value;
  const AqutterDownloadStartResponseAction_._internal(this._value);

  ///Cancel the download.
  @EnumSupportedPlatforms(
    platforms: [EnumWindowsPlatform(value: 0), EnumLinuxPlatform(value: 0)],
  )
  static const CANCEL = const AqutterDownloadStartResponseAction_._internal(0);
}
