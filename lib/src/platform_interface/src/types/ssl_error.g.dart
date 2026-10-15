// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ssl_error.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents an SSL Error.
class AqutterSslError {
  ///Use [code] instead.
  @Deprecated('Use code instead')
  AqutterAndroidSslError? androidError;

  ///Primary code error associated to the server SSL certificate.
  ///It represents the most severe SSL error.
  AqutterSslErrorType? code;

  ///Use [code] instead.
  @Deprecated('Use code instead')
  AqutterIOSSslError? iosError;

  ///The message associated to the [code].
  String? message;
  AqutterSslError({
    @Deprecated('Use code instead') this.androidError,
    this.code,
    @Deprecated('Use code instead') this.iosError,
    this.message,
  }) {
    code =
        code ??
        AqutterSslErrorType.fromNativeValue(androidError?.toNativeValue());
    code =
        code ?? AqutterSslErrorType.fromNativeValue(iosError?.toNativeValue());
  }

  ///Gets a possible [AqutterSslError] instance from a [Map] value.
  static AqutterSslError? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterSslError(
      androidError: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterAndroidSslError.fromNativeValue(
          map['code'],
        ),
        AqutterEnumMethod.value => AqutterAndroidSslError.fromValue(
          map['code'],
        ),
        AqutterEnumMethod.name => AqutterAndroidSslError.byName(map['code']),
      },
      code: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterSslErrorType.fromNativeValue(
          map['code'],
        ),
        AqutterEnumMethod.value => AqutterSslErrorType.fromValue(map['code']),
        AqutterEnumMethod.name => AqutterSslErrorType.byName(map['code']),
      },
      iosError: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterIOSSslError.fromNativeValue(
          map['code'],
        ),
        AqutterEnumMethod.value => AqutterIOSSslError.fromValue(map['code']),
        AqutterEnumMethod.name => AqutterIOSSslError.byName(map['code']),
      },
      message: map['message'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "code": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => code?.toNativeValue(),
        AqutterEnumMethod.value => code?.toValue(),
        AqutterEnumMethod.name => code?.name(),
      },
      "message": message,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterSslError{code: $code, message: $message}';
  }
}
