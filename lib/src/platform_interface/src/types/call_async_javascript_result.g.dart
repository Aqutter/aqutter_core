// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_async_javascript_result.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents either a success or a failure, including an associated value in each case for [AqutterPlatformWebViewController.callAsyncJavaScript].
class AqutterCallAsyncJavaScriptResult {
  ///It contains the failure value.
  String? error;

  ///It contains the success value.
  dynamic value;
  AqutterCallAsyncJavaScriptResult({this.error, this.value});

  ///Gets a possible [AqutterCallAsyncJavaScriptResult] instance from a [Map] value.
  static AqutterCallAsyncJavaScriptResult? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterCallAsyncJavaScriptResult(
      error: map['error'],
      value: map['value'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"error": error, "value": value};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterCallAsyncJavaScriptResult{error: $error, value: $value}';
  }
}
