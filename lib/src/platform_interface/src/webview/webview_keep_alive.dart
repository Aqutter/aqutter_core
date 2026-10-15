import '../types/main.dart';
import '../util.dart';
import '../web_message/platform_web_message_channel.dart';
import '../web_message/platform_web_message_listener.dart';
import 'platform_webview_widget.dart';
import 'platform_webview_controller.dart';

///Class used to keep alive a [AqutterPlatformWebViewWidget].
class AqutterWebViewKeepAlive {
  String _id = IdGenerator.generate();
}

///Used internally
extension AqutterInternalWebViewKeepAlive on AqutterWebViewKeepAlive {
  String get id => _id;

  set id(String id) {
    _id = id;
  }
}

///Used internally to save and restore [AqutterPlatformWebViewController] properties
///for the keep alive feature.
class AqutterWebViewControllerKeepAliveProps {
  Map<String, Function> javaScriptHandlersMap;
  Map<AqutterUserScriptInjectionTime, List<AqutterUserScript>> userScripts;
  Set<String> webMessageListenerObjNames;
  Map<String, AqutterScriptHtmlTagAttributes> injectedScriptsFromURL;
  Set<AqutterPlatformWebMessageChannel> webMessageChannels = Set();
  Set<AqutterPlatformWebMessageListener> webMessageListeners = Set();
  Map<String, Function(dynamic data)> devToolsProtocolEventListenerMap;

  AqutterWebViewControllerKeepAliveProps({
    this.javaScriptHandlersMap = const {},
    this.userScripts = const {},
    this.webMessageListenerObjNames = const {},
    this.injectedScriptsFromURL = const {},
    this.webMessageChannels = const {},
    this.webMessageListeners = const {},
    this.devToolsProtocolEventListenerMap = const {},
  });
}
