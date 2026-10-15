import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../web_storage/platform_web_storage_manager.dart';
import 'enum_method.dart';

part 'web_storage_origin.g.dart';

///Class that encapsulates information about the amount of storage currently used by an origin for the JavaScript storage APIs.
///An origin comprises the host, scheme and port of a URI. See [AqutterPlatformWebStorageManager] for details.
@ExchangeableObject()
class AqutterWebStorageOrigin_ {
  ///The string representation of this origin.
  String? origin;

  ///The quota for this origin, for the Web SQL Database API, in bytes.
  int? quota;

  ///The total amount of storage currently being used by this origin, for all JavaScript storage APIs, in bytes.
  int? usage;

  AqutterWebStorageOrigin_({this.origin, this.quota, this.usage});
}

///Class that encapsulates information about the amount of storage currently used by an origin for the JavaScript storage APIs.
///An origin comprises the host, scheme and port of a URI. See `AqutterAndroidWebStorageManager` for details.
///Use [AqutterWebStorageOrigin] instead.
@Deprecated("Use AqutterWebStorageOrigin instead")
@ExchangeableObject()
class AqutterAndroidWebStorageOrigin_ {
  ///The string representation of this origin.
  String? origin;

  ///The quota for this origin, for the Web SQL Database API, in bytes.
  int? quota;

  ///The total amount of storage currently being used by this origin, for all JavaScript storage APIs, in bytes.
  int? usage;

  AqutterAndroidWebStorageOrigin_({this.origin, this.quota, this.usage});
}
