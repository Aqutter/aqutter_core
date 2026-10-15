// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'javascript_handler_callback.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///A class that represents the data passed to a [AqutterJavaScriptHandlerFunction] added with [AqutterPlatformWebViewController.addJavaScriptHandler].
class AqutterJavaScriptHandlerFunctionData {
  List<dynamic> args;
  bool isMainFrame;
  AqutterWebUri origin;
  AqutterWebUri requestUrl;
  AqutterJavaScriptHandlerFunctionData({
    this.args = const [],
    required this.isMainFrame,
    required this.origin,
    required this.requestUrl,
  });

  ///Gets a possible [AqutterJavaScriptHandlerFunctionData] instance from a [Map] value.
  static AqutterJavaScriptHandlerFunctionData? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterJavaScriptHandlerFunctionData(
      isMainFrame: map['isMainFrame'],
      origin: AqutterWebUri(map['origin']),
      requestUrl: AqutterWebUri(map['requestUrl']),
    );
    if (map['args'] != null) {
      instance.args = List<dynamic>.from(map['args']!.cast<dynamic>());
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "args": args,
      "isMainFrame": isMainFrame,
      "origin": origin.toString(),
      "requestUrl": requestUrl.toString(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterJavaScriptHandlerFunctionData{args: $args, isMainFrame: $isMainFrame, origin: $origin, requestUrl: $requestUrl}';
  }
}
