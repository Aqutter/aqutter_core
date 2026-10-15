import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'website_data_type.dart';
import 'enum_method.dart';

part 'website_data_record.g.dart';

///Class that represents website data, grouped by domain name using the public suffix list.
@ExchangeableObject()
class AqutterWebsiteDataRecord_ {
  ///The display name for the data record. This is usually the domain name.
  String? displayName;

  ///The various types of website data that exist for this data record.
  Set<AqutterWebsiteDataType_>? dataTypes;

  AqutterWebsiteDataRecord_({this.displayName, this.dataTypes});
}

///Class that represents website data, grouped by domain name using the public suffix list.
///
///**NOTE**: available on iOS 9.0+.
///
///Use [AqutterWebsiteDataRecord] instead.
@Deprecated("Use AqutterWebsiteDataRecord instead")
@ExchangeableObject()
class AqutterIOSWKWebsiteDataRecord_ {
  ///The display name for the data record. This is usually the domain name.
  String? displayName;

  ///The various types of website data that exist for this data record.
  Set<AqutterIOSWKWebsiteDataType_>? dataTypes;

  AqutterIOSWKWebsiteDataRecord_({this.displayName, this.dataTypes});
}
