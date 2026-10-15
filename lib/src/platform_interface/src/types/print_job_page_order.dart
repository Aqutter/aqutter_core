import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../print_job/main.dart';

part 'print_job_page_order.g.dart';

///Class representing the page order that will be used to generate the pages of a [AqutterPlatformPrintJobController].
@ExchangeableEnum()
class AqutterPrintJobPageOrder_ {
  // ignore: unused_field
  final int _value;
  const AqutterPrintJobPageOrder_._internal(this._value);

  ///Descending (front to back) page order.
  @EnumSupportedPlatforms(platforms: [EnumMacOSPlatform(value: -1)])
  static const DESCENDING = const AqutterPrintJobPageOrder_._internal(-1);

  ///The spooler does not rearrange pages—they are printed in the order received by the spooler.
  @EnumSupportedPlatforms(platforms: [EnumMacOSPlatform(value: 0)])
  static const SPECIAL = const AqutterPrintJobPageOrder_._internal(0);

  ///Ascending (back to front) page order.
  @EnumSupportedPlatforms(platforms: [EnumMacOSPlatform(value: 1)])
  static const ASCENDING = const AqutterPrintJobPageOrder_._internal(1);

  ///No page order specified.
  @EnumSupportedPlatforms(platforms: [EnumMacOSPlatform(value: 2)])
  static const UNKNOWN = const AqutterPrintJobPageOrder_._internal(2);
}
