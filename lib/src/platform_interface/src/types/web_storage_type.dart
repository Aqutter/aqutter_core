import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../web_storage/platform_web_storage.dart';

part 'web_storage_type.g.dart';

///Class that represents the type of Web AqutterStorage: `localStorage` or `sessionStorage`.
///Used by the [AqutterPlatformStorage] class.
@ExchangeableEnum()
class AqutterWebStorageType_ {
  // ignore: unused_field
  final String _value;
  const AqutterWebStorageType_._internal(this._value);

  ///`window.localStorage`: same as [SESSION_STORAGE], but persists even when the browser is closed and reopened.
  static const LOCAL_STORAGE = const AqutterWebStorageType_._internal("localStorage");

  ///`window.sessionStorage`: maintains a separate storage area for each given origin that's available for the duration
  ///of the page session (as long as the browser is open, including page reloads and restores).
  static const SESSION_STORAGE = const AqutterWebStorageType_._internal(
    "sessionStorage",
  );
}
