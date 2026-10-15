import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';

import 'headless_webview_manager.dart';
import 'web_view_web_element.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

class AqutterHeadlessWebViewWebElement extends ChannelController {
  String id;
  late BinaryMessenger _messenger;
  AqutterWebViewWebElement? webView;

  AqutterHeadlessWebViewWebElement({
    required this.id,
    required BinaryMessenger messenger,
    required this.webView,
  }) {
    this._messenger = messenger;

    channel = MethodChannel(
      'com.github.aqutter/headless_webview_${this.id}',
      const StandardMethodCodec(),
      _messenger,
    );
    handler = _handleMethod;
    initMethodCallHandler();
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "dispose":
        dispose();
        break;
      case "setSize":
        Size size = MapSize.fromMap(
          call.arguments['size'].cast<String, dynamic>(),
        )!;
        setSize(size);
        break;
      case "getSize":
        return webView?.getSize().toMap();
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'aqutter_core for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  void onWebViewCreated() async {
    await channel?.invokeMethod("onWebViewCreated");
  }

  void setSize(Size size) {
    webView?.iframeContainer.style.width = size.width.toString() + "px";
    webView?.iframeContainer.style.height = size.height.toString() + "px";
  }

  AqutterWebViewWebElement? disposeAndGetFlutterWebView() {
    AqutterWebViewWebElement? newFlutterWebView = webView;
    dispose();
    return newFlutterWebView;
  }

  @override
  void dispose() {
    disposeChannel();
    AqutterHeadlessWebViewManager.webViews.putIfAbsent(id, () => null);
    webView?.dispose();
    webView = null;
  }
}
