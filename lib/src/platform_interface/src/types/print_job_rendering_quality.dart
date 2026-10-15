import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../print_job/main.dart';

part 'print_job_rendering_quality.g.dart';

///Class representing the rendering quality of a [AqutterPlatformPrintJobController].
@ExchangeableEnum()
class AqutterPrintJobRenderingQuality_ {
  // ignore: unused_field
  final int _value;
  const AqutterPrintJobRenderingQuality_._internal(this._value);

  ///Renders the printing at the best possible quality, regardless of speed.
  @EnumSupportedPlatforms(
    platforms: [EnumIOSPlatform(value: 0), EnumMacOSPlatform(value: 0)],
  )
  static const BEST = const AqutterPrintJobRenderingQuality_._internal(0);

  ///Sacrifices the least possible amount of rendering quality for speed to maintain a responsive user interface.
  ///This option should be used only after establishing that best quality rendering does indeed make the user interface unresponsive.
  @EnumSupportedPlatforms(
    platforms: [EnumIOSPlatform(value: 1), EnumMacOSPlatform(value: 1)],
  )
  static const RESPONSIVE = const AqutterPrintJobRenderingQuality_._internal(1);
}
