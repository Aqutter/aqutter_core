package com.github.aqutter.core.types

import android.text.TextUtils
import android.webkit.ValueCallback
import com.github.aqutter.core.Util
import com.github.aqutter.core.plugin_scripts_js.JavaScriptBridgeJS
import com.github.aqutter.core.webview.AqutterWebViewInterface
import com.github.aqutter.core.webview.web_message.WebMessageChannel
import java.util.ArrayList

class WebMessagePort(
  @JvmField var name: String,
  @JvmField var webMessageChannel: WebMessageChannel?
) {
  @JvmField
  var isClosed = false

  @JvmField
  var isTransferred = false

  @JvmField
  var isStarted = false

  @Throws(Exception::class)
  fun setWebMessageCallback(callback: ValueCallback<Void>?) {
    if (isClosed || isTransferred) {
      throw Exception("Port is already closed or transferred")
    }
    this.isStarted = true
    val webView: AqutterWebViewInterface? = if (webMessageChannel != null && webMessageChannel!!.webView != null) webMessageChannel!!.webView else null
    if (webView != null) {
      val index = if (name == "port1") 0 else 1
      webView.evaluateJavascript("(function() {" +
        "  var webMessageChannel = " + JavaScriptBridgeJS.WEB_MESSAGE_CHANNELS_VARIABLE_NAME() + "['" + webMessageChannel!!.id + "'];" +
        "  if (webMessageChannel != null) {" +
        "      webMessageChannel." + this.name + ".onmessage = function (event) {" +
        "          window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + ".callHandler('onWebMessagePortMessageReceived', {" +
        "              'webMessageChannelId': '" + webMessageChannel!!.id + "'," +
        "              'index': " + index + "," +
        "              'message': event.data" +
        "          });" +
        "      }" +
        "  }" +
        "})();", null, object : ValueCallback<String> {
        override fun onReceiveValue(value: String?) {
          if (callback != null) {
            callback.onReceiveValue(null)
          }
        }
      })
    } else {
      if (callback != null) {
        callback.onReceiveValue(null)
      }
    }
  }

  @Throws(Exception::class)
  fun postMessage(message: WebMessage, callback: ValueCallback<Void>?) {
    if (isClosed || isTransferred) {
      throw Exception("Port is already closed or transferred")
    }
    val webView: AqutterWebViewInterface? = if (webMessageChannel != null && webMessageChannel!!.webView != null) webMessageChannel!!.webView else null
    if (webView != null) {
      var portsString = "null"
      val ports: List<WebMessagePort>? = message.ports
      if (ports != null) {
        val portArrayString: MutableList<String> = ArrayList()
        for (port in ports) {
          if (port === this) {
            throw Exception("Source port cannot be transferred")
          }
          if (port.isStarted) {
            throw Exception("Port is already started")
          }
          if (port.isClosed || port.isTransferred) {
            throw Exception("Port is already closed or transferred")
          }
          port.isTransferred = true
          portArrayString.add(JavaScriptBridgeJS.WEB_MESSAGE_CHANNELS_VARIABLE_NAME() + "['" + webMessageChannel!!.id + "']." + port.name)
        }
        portsString = "[" + TextUtils.join(", ", portArrayString) + "]"
      }
      val data = if (message.data != null) Util.replaceAll(message.data!!, "\'", "\\'") else "null"
      val source = "(function() {" +
        "  var webMessageChannel = " + JavaScriptBridgeJS.WEB_MESSAGE_CHANNELS_VARIABLE_NAME() + "['" + webMessageChannel!!.id + "'];" +
        "  if (webMessageChannel != null) {" +
        "      webMessageChannel." + this.name + ".postMessage('" + data + "', " + portsString + ");" +
        "  }" +
        "})();"
      webView.evaluateJavascript(source, null, object : ValueCallback<String> {
        override fun onReceiveValue(value: String?) {
          callback!!.onReceiveValue(null)
        }
      })
    } else {
      callback!!.onReceiveValue(null)
    }
    message.dispose()
  }

  @Throws(Exception::class)
  fun close(callback: ValueCallback<Void>?) {
    if (isTransferred) {
      throw Exception("Port is already transferred")
    }
    isClosed = true
    val webView: AqutterWebViewInterface? = if (webMessageChannel != null && webMessageChannel!!.webView != null) webMessageChannel!!.webView else null
    if (webView != null) {
      val source = "(function() {" +
        "  var webMessageChannel = " + JavaScriptBridgeJS.WEB_MESSAGE_CHANNELS_VARIABLE_NAME() + "['" + webMessageChannel!!.id + "'];" +
        "  if (webMessageChannel != null) {" +
        "      webMessageChannel." + this.name + ".close();" +
        "  }" +
        "})();"
      webView.evaluateJavascript(source, null, object : ValueCallback<String> {
        override fun onReceiveValue(value: String?) {
          callback!!.onReceiveValue(null)
        }
      })
    } else {
      callback!!.onReceiveValue(null)
    }
  }

  fun dispose() {
    isClosed = true
    webMessageChannel = null
  }
}
