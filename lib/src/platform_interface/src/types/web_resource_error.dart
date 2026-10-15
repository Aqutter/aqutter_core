import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'web_resource_error_type.dart';
import 'enum_method.dart';

part 'web_resource_error.g.dart';

///Encapsulates information about errors occurred during loading of web resources.
@ExchangeableObject()
class AqutterWebResourceError_ {
  ///The type of the error.
  AqutterWebResourceErrorType_ type;

  ///The string describing the error.
  String description;

  AqutterWebResourceError_({required this.type, required this.description});
}
