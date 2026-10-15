import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../print_job/main.dart';

part 'print_job_pagination_mode.g.dart';

///Class representing the constants that specify the different ways in which an image is divided into pages of a [AqutterPlatformPrintJobController].
@ExchangeableEnum()
class AqutterPrintJobPaginationMode_ {
  // ignore: unused_field
  final String _value;
  // ignore: unused_field
  final int? _nativeValue = null;
  const AqutterPrintJobPaginationMode_._internal(this._value);

  ///
  @EnumSupportedPlatforms(platforms: [EnumMacOSPlatform(value: 0)])
  static const AUTOMATIC = const AqutterPrintJobPaginationMode_._internal('AUTOMATIC');

  ///
  @EnumSupportedPlatforms(platforms: [EnumMacOSPlatform(value: 1)])
  static const FIT = const AqutterPrintJobPaginationMode_._internal("FIT");

  ///
  @EnumSupportedPlatforms(platforms: [EnumMacOSPlatform(value: 2)])
  static const CLIP = const AqutterPrintJobPaginationMode_._internal("CLIP");
}
