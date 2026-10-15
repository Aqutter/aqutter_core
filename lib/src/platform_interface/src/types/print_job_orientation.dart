import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../print_job/main.dart';

part 'print_job_orientation.g.dart';

///Class representing the orientation of a [AqutterPlatformPrintJobController].
@ExchangeableEnum()
class AqutterPrintJobOrientation_ {
  // ignore: unused_field
  final int _value;
  const AqutterPrintJobOrientation_._internal(this._value);

  ///Pages are printed in portrait orientation.
  @EnumSupportedPlatforms(
    platforms: [
      EnumAndroidPlatform(value: 0),
      EnumIOSPlatform(value: 0),
      EnumMacOSPlatform(value: 0),
      EnumWindowsPlatform(value: 0),
    ],
  )
  static const PORTRAIT = const AqutterPrintJobOrientation_._internal(0);

  ///Pages are printed in landscape orientation.
  @EnumSupportedPlatforms(
    platforms: [
      EnumAndroidPlatform(value: 1),
      EnumIOSPlatform(value: 1),
      EnumMacOSPlatform(value: 1),
      EnumWindowsPlatform(value: 1),
    ],
  )
  static const LANDSCAPE = const AqutterPrintJobOrientation_._internal(1);
}
