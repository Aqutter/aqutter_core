import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../print_job/main.dart';
import 'enum_method.dart';

part 'printer.g.dart';

///Class representing the printer used by a [AqutterPlatformPrintJobController].
@ExchangeableObject()
class AqutterPrinter_ {
  ///The unique id of the printer.
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  String? id;

  ///A description of the printer’s make and model.
  @SupportedPlatforms(platforms: [MacOSPlatform()])
  String? type;

  ///The PostScript language level recognized by the printer.
  @SupportedPlatforms(platforms: [MacOSPlatform()])
  int? languageLevel;

  ///The printer’s name.
  @SupportedPlatforms(platforms: [MacOSPlatform()])
  String? name;

  AqutterPrinter_({this.id, this.type, this.languageLevel, this.name});
}
