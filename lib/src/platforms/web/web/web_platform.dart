import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:ui_web' as ui_web;

import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../src/webview_platform.dart';
import 'headless_webview_manager.dart';
import 'web_view_web_element.dart';
import 'webview_manager.dart';
import 'js_bridge.dart';
import 'platform_util.dart';

/// Builds an iframe based WebView.
///
/// This is used as the default implementation for `WebView` on web.
class AqutterCorePlugin {
  /// Constructs a new instance of [AqutterCorePlugin].
  AqutterCorePlugin(Registrar registrar) {
    ui_web.platformViewRegistry.registerViewFactory(
      'com.github.aqutter/webview',
      (int viewId) {
        var webView = AqutterWebViewWebElement(
          viewId: viewId,
          messenger: registrar,
        );
        AqutterWebViewManager.webViews.putIfAbsent(viewId, () => webView);
        return webView.iframeContainer;
      },
    );
  }

  static void registerWith(Registrar registrar) {
    AqutterWebPlatformWebViewPlatform.registerWith();
    // ignore: unused_local_variable
    final pluginInstance = AqutterCorePlugin(registrar);
    // ignore: unused_local_variable
    final platformUtil = PlatformUtil(messenger: registrar);
    // ignore: unused_local_variable
    final webViewManager = AqutterWebViewManager(messenger: registrar);
    // ignore: unused_local_variable
    final headlessManager = AqutterHeadlessWebViewManager(messenger: registrar);
    if (aqutterWeb != null) {
      if (!Object_isFrozen(aqutterWeb!).toDart) {
        aqutterWeb!.nativeAsyncCommunication =
            ((JSString method, JSAny viewId, [JSArray? args]) {
              return _dartNativeAsyncCommunication(
                method.toDart,
                viewId,
                args?.toDart,
              ).then((value) => value?.toJS).toJS;
            }).toJS;
        aqutterWeb!.nativeSyncCommunication =
            ((JSString method, JSAny viewId, [JSArray? args]) =>
                    _dartNativeSyncCommunication(
                      method.toDart,
                      viewId,
                      args?.toDart,
                    )?.toJS)
                .toJS;
        Object_freeze(aqutterWeb!);
      }
    } else {
      if (kDebugMode) {
        print("Error: window.aqutterWeb is not available!");
      }
    }
  }
}

Future<String?> _dartNativeAsyncCommunication(
  String method,
  dynamic viewId, [
  List? args,
]) async {
  if (AqutterWebViewManager.webViews.containsKey(viewId)) {
    var webViewHtmlElement =
        AqutterWebViewManager.webViews[viewId] as AqutterWebViewWebElement;
    var result = null;
    try {
      switch (method) {
        case 'onCreateWindow':
          String url = args![0] ?? 'about:blank';
          String? target = args[1];
          String? windowFeatures = args[2];
          result = await webViewHtmlElement.onCreateWindow(
            url,
            target,
            windowFeatures,
          );
          break;
        case 'onCallJsHandler':
          String handlerName = args![0];
          Map<String, dynamic> data = jsonDecode(args[1]);
          result = await webViewHtmlElement.onCallJsHandler(handlerName, data);
          break;
        default:
          throw UnimplementedError("Method '$method' not implemented");
      }
      return result != null ? jsonEncode(result) : null;
    } catch (e, stacktrace) {
      if (!(e is UnimplementedError) && kDebugMode) {
        print("$e\n$stacktrace");
      }
      throw e;
    }
  }
  return null;
}

String? _dartNativeSyncCommunication(
  String method,
  dynamic viewId, [
  List? args,
]) {
  if (AqutterWebViewManager.webViews.containsKey(viewId)) {
    var webViewHtmlElement =
        AqutterWebViewManager.webViews[viewId] as AqutterWebViewWebElement;
    var result = null;

    try {
      switch (method) {
        case 'onLoadStart':
          String url = args![0];
          webViewHtmlElement.onLoadStart(url);
          break;
        case 'onLoadStop':
          String url = args![0];
          webViewHtmlElement.onLoadStop(url);
          break;
        case 'onUpdateVisitedHistory':
          String url = args![0];
          webViewHtmlElement.onUpdateVisitedHistory(url);
          break;
        case 'onScrollChanged':
          int x = (args![0] as double).toInt();
          int y = (args[1] as double).toInt();
          webViewHtmlElement.onScrollChanged(x, y);
          break;
        case 'onConsoleMessage':
          String type = args![0];
          String? message = args[1];
          webViewHtmlElement.onConsoleMessage(type, message);
          break;
        case 'onWindowFocus':
          webViewHtmlElement.onWindowFocus();
          break;
        case 'onWindowBlur':
          webViewHtmlElement.onWindowBlur();
          break;
        case 'onPrintRequest':
          String? url = args![0];
          webViewHtmlElement.onPrintRequest(url);
          break;
        case 'onEnterFullscreen':
          webViewHtmlElement.onEnterFullscreen();
          break;
        case 'onExitFullscreen':
          webViewHtmlElement.onExitFullscreen();
          break;
        case 'onTitleChanged':
          String? title = args![0];
          webViewHtmlElement.onTitleChanged(title);
          break;
        case 'onZoomScaleChanged':
          double oldScale = args![0];
          double newScale = args[1];
          webViewHtmlElement.onZoomScaleChanged(oldScale, newScale);
          break;
        case 'onInjectedScriptLoaded':
          String id = args![0];
          webViewHtmlElement.onInjectedScriptLoaded(id);
          break;
        case 'onInjectedScriptError':
          String id = args![0];
          webViewHtmlElement.onInjectedScriptError(id);
          break;
        case 'onCloseWindow':
          webViewHtmlElement.onCloseWindow();
          break;
        case 'getUserOnlyScriptsAt':
          final injectionTime = AqutterUserScriptInjectionTime.fromNativeValue(
            args![0],
          );
          result = webViewHtmlElement.userContentController
              .getUserOnlyScriptsAt(injectionTime!);
          break;
        case 'getJavaScriptBridgeName':
          result = AqutterWebViewManager.javaScriptBridgeName;
          break;
        default:
          throw UnimplementedError("Method '$method' not implemented");
      }
    } catch (e, stacktrace) {
      if (!(e is UnimplementedError) && kDebugMode) {
        print("$e\n$stacktrace");
      }
      throw e;
    }

    return result != null ? jsonEncode(result) : null;
  }
  return null;
}
