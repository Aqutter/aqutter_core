import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../types/enum_method.dart';

part 'web_storage_item.g.dart';

///Class that represents a single web storage item of the JavaScript `window.sessionStorage` and `window.localStorage` objects.
@ExchangeableObject()
class AqutterWebStorageItem_ {
  ///Item key.
  String? key;

  ///Item value.
  dynamic value;

  AqutterWebStorageItem_({this.key, this.value});
}
