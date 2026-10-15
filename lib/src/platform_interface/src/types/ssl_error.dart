import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'enum_method.dart';
import 'ssl_error_type.dart';

part 'ssl_error.g.dart';

///Class that represents an SSL Error.
@ExchangeableObject()
class AqutterSslError_ {
  ///Use [code] instead.
  @Deprecated('Use code instead')
  AqutterAndroidSslError_? androidError;

  ///Use [code] instead.
  @Deprecated('Use code instead')
  AqutterIOSSslError_? iosError;

  ///Primary code error associated to the server SSL certificate.
  ///It represents the most severe SSL error.
  AqutterSslErrorType_? code;

  ///The message associated to the [code].
  String? message;

  AqutterSslError_({
    @Deprecated('Use code instead') this.androidError,
    @Deprecated('Use code instead') this.iosError,
    this.code,
    this.message,
  }) {}
}
