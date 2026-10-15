import 'dart:async';
import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';
import 'package:web/web.dart';

class AqutterWebViewManager extends ChannelController {
  static final Map<dynamic, dynamic> webViews = {};
  static final Map<int, AqutterCreateWindowAction?> windowActions = {};
  static int windowAutoincrementId = 0;
  static String javaScriptBridgeName = "aqutter";
  late BinaryMessenger _messenger;

  AqutterWebViewManager({required BinaryMessenger messenger}) {
    this._messenger = messenger;
    channel = MethodChannel(
      'com.github.aqutter/webview_manager',
      const StandardMethodCodec(),
      _messenger,
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "getDefaultUserAgent":
        return getDefaultUserAgent();
      case "setJavaScriptBridgeName":
        javaScriptBridgeName = call.arguments["bridgeName"];
        break;
      case "getJavaScriptBridgeName":
        return javaScriptBridgeName;
      default:
        throw UnimplementedError("Unimplemented ${call.method} method");
    }
    return null;
  }

  String getDefaultUserAgent() {
    return window.navigator.userAgent;
  }

  @override
  void dispose() {
    disposeChannel();
  }
}
