import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'meta_tag.dart';
import 'enum_method.dart';

part 'meta_tag_attribute.g.dart';

///Class that represents an attribute of a `<meta>` HTML tag. It is used by the [AqutterMetaTag] class.
@ExchangeableObject()
class AqutterMetaTagAttribute_ {
  ///The attribute name.
  String? name;

  ///The attribute value.
  String? value;

  AqutterMetaTagAttribute_({this.name, this.value});
}
