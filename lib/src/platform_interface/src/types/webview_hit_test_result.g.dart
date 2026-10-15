// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webview_hit_test_result.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the hit result for hitting an HTML elements.
class AqutterWebViewHitTestResult {
  ///Additional type-dependant information about the result.
  String? extra;

  ///The type of the hit test result.
  AqutterWebViewHitTestResultType? type;
  AqutterWebViewHitTestResult({this.extra, this.type});

  ///Gets a possible [AqutterWebViewHitTestResult] instance from a [Map] value.
  static AqutterWebViewHitTestResult? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebViewHitTestResult(
      extra: map['extra'],
      type: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterWebViewHitTestResultType.fromNativeValue(map['type']),
        AqutterEnumMethod.value => AqutterWebViewHitTestResultType.fromValue(
          map['type'],
        ),
        AqutterEnumMethod.name => AqutterWebViewHitTestResultType.byName(
          map['type'],
        ),
      },
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "extra": extra,
      "type": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => type?.toNativeValue(),
        AqutterEnumMethod.value => type?.toValue(),
        AqutterEnumMethod.name => type?.name(),
      },
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterWebViewHitTestResult{extra: $extra, type: $type}';
  }
}
