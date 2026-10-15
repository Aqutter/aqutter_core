package com.github.aqutter.core.webview.web_message

import com.github.aqutter.core.types.ChannelDelegateImpl
import com.github.aqutter.core.types.WebMessageCompatExt
import com.github.aqutter.core.webview.webview.AqutterWebView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.HashMap

class WebMessageChannelChannelDelegate(
  webMessageChannel: WebMessageChannel,
  channel: MethodChannel
) : ChannelDelegateImpl(channel) {
  private var webMessageChannel: WebMessageChannel? = webMessageChannel

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "setWebMessageCallback" -> {
        if (webMessageChannel != null && webMessageChannel!!.webView is AqutterWebView) {
          val index = call.argument<Int>("index")
          webMessageChannel!!.setWebMessageCallbackForAqutterWebView(index!!, result)
        } else {
          result.success(false)
        }
      }
      "postMessage" -> {
        if (webMessageChannel != null && webMessageChannel!!.webView is AqutterWebView) {
          val index = call.argument<Int>("index")
          val message = WebMessageCompatExt.fromMap(call.argument<Map<String, Any?>>("message"))
          webMessageChannel!!.postMessageForAqutterWebView(index!!, message, result)
        } else {
          result.success(false)
        }
      }
      "close" -> {
        if (webMessageChannel != null && webMessageChannel!!.webView is AqutterWebView) {
          val index = call.argument<Int>("index")
          webMessageChannel!!.closeForAqutterWebView(index!!, result)
        } else {
          result.success(false)
        }
      }
      else -> result.notImplemented()
    }
  }

  fun onMessage(index: Int, message: WebMessageCompatExt?) {
    val channel = getChannel() ?: return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["index"] = index
    obj["message"] = if (message != null) message.toMap() else null
    channel.invokeMethod("onMessage", obj)
  }

  override fun dispose() {
    super.dispose()
    webMessageChannel = null
  }
}
