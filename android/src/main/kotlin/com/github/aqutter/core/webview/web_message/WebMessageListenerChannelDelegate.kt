package com.github.aqutter.core.webview.web_message

import com.github.aqutter.core.types.ChannelDelegateImpl
import com.github.aqutter.core.types.WebMessageCompatExt
import com.github.aqutter.core.webview.webview.AqutterWebView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.HashMap

class WebMessageListenerChannelDelegate(
  webMessageListener: WebMessageListener,
  channel: MethodChannel
) : ChannelDelegateImpl(channel) {
  private var webMessageListener: WebMessageListener? = webMessageListener

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "postMessage" -> {
        if (webMessageListener != null && webMessageListener!!.webView is AqutterWebView) {
          val message = WebMessageCompatExt.fromMap(call.argument<Map<String, Any?>>("message"))
          webMessageListener!!.postMessageForAqutterWebView(message, result)
        } else {
          result.success(false)
        }
      }
      else -> result.notImplemented()
    }
  }

  fun onPostMessage(message: WebMessageCompatExt?, sourceOrigin: String?, isMainFrame: Boolean) {
    val channel = getChannel() ?: return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["message"] = if (message != null) message.toMap() else null
    obj["sourceOrigin"] = sourceOrigin
    obj["isMainFrame"] = isMainFrame
    channel.invokeMethod("onPostMessage", obj)
  }

  override fun dispose() {
    super.dispose()
    webMessageListener = null
  }
}
