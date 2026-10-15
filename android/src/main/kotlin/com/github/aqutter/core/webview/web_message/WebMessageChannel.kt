package com.github.aqutter.core.webview.web_message

import android.webkit.ValueCallback
import androidx.webkit.WebMessageCompat
import androidx.webkit.WebMessagePortCompat
import androidx.webkit.WebViewCompat
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.plugin_scripts_js.JavaScriptBridgeJS
import com.github.aqutter.core.types.Disposable
import com.github.aqutter.core.types.WebMessageCompatExt
import com.github.aqutter.core.types.WebMessagePort
import com.github.aqutter.core.types.WebMessagePortCompatExt
import com.github.aqutter.core.webview.AqutterWebViewInterface
import com.github.aqutter.core.webview.webview.AqutterWebView
import io.flutter.plugin.common.MethodChannel
import java.util.ArrayList
import java.util.Arrays
import java.util.HashMap

class WebMessageChannel(id: String, webView: AqutterWebViewInterface) : Disposable {
  companion object {
    // protected in Java
    const val LOG_TAG = "WebMessageChannel"
    const val METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/webview_web_message_channel_"
  }

  @JvmField
  var id: String

  @JvmField
  var channelDelegate: WebMessageChannelChannelDelegate? = null

  @JvmField
  val compatPorts: MutableList<WebMessagePortCompat>

  @JvmField
  val ports: MutableList<WebMessagePort>

  @JvmField
  var webView: AqutterWebViewInterface? = null

  init {
    this.id = id
    val channel = MethodChannel(webView.getPlugin()!!.messenger, METHOD_CHANNEL_NAME_PREFIX + id)
    this.channelDelegate = WebMessageChannelChannelDelegate(this, channel)
    if (webView is AqutterWebView) {
      this.compatPorts = ArrayList(Arrays.asList(*WebViewCompat.createWebMessageChannel(webView)))
      this.ports = ArrayList()
    } else {
      this.ports = Arrays.asList(WebMessagePort("port1", this), WebMessagePort("port2", this))
      this.compatPorts = ArrayList()
    }
    this.webView = webView
  }

  fun initJsInstance(webView: AqutterWebViewInterface?, callback: ValueCallback<WebMessageChannel>) {
    if (webView != null) {
      val webMessageChannel = this
      webView.evaluateJavascript("(function() {" +
        JavaScriptBridgeJS.WEB_MESSAGE_CHANNELS_VARIABLE_NAME() + "['" + webMessageChannel.id + "'] = new MessageChannel();" +
        "})();", null, object : ValueCallback<String> {
        override fun onReceiveValue(value: String?) {
          callback.onReceiveValue(webMessageChannel)
        }
      })
    } else {
      callback.onReceiveValue(this)
    }
  }

  fun setWebMessageCallbackForAqutterWebView(index: Int, result: MethodChannel.Result) {
    if (webView != null && compatPorts.size > 0 &&
      WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_PORT_SET_MESSAGE_CALLBACK)) {
      val webMessagePort = compatPorts[index]
      val webMessageChannel = this
      try {
        webMessagePort.setWebMessageCallback(object : WebMessagePortCompat.WebMessageCallbackCompat() {
          override fun onMessage(port: WebMessagePortCompat, message: WebMessageCompat?) {
            super.onMessage(port, message)
            webMessageChannel.onMessage(index, if (message != null) WebMessageCompatExt.fromMapWebMessageCompat(message) else null)
          }
        })
        result.success(true)
      } catch (e: Exception) {
        result.error(LOG_TAG, e.message, null)
      }
    } else {
      result.success(true)
    }
  }

  fun postMessageForAqutterWebView(index: Int, message: WebMessageCompatExt?, result: MethodChannel.Result) {
    val webView = this.webView
    if (webView != null && compatPorts.size > 0 &&
      WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_PORT_POST_MESSAGE)) {
      val port = compatPorts[index]
      val webMessagePorts: MutableList<WebMessagePortCompat> = ArrayList()
      val portsExt: List<WebMessagePortCompatExt>? = message!!.ports
      if (portsExt != null) {
        for (portExt in portsExt) {
          val webMessageChannel = webView.getWebMessageChannels()!![portExt.webMessageChannelId]
          if (webMessageChannel != null) {
            webMessagePorts.add(webMessageChannel.compatPorts[portExt.index])
          }
        }
      }
      val data = message.data
      try {
        if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_ARRAY_BUFFER) && data != null &&
          message.type == WebMessageCompat.TYPE_ARRAY_BUFFER) {
          port.postMessage(WebMessageCompat(data as ByteArray, webMessagePorts.toTypedArray()))
        } else {
          port.postMessage(WebMessageCompat(data?.toString(), webMessagePorts.toTypedArray()))
        }
        result.success(true)
      } catch (e: Exception) {
        result.error(LOG_TAG, e.message, null)
      }
    } else {
      result.success(true)
    }
  }

  fun closeForAqutterWebView(index: Int, result: MethodChannel.Result) {
    if (webView != null && compatPorts.size > 0 &&
      WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_PORT_CLOSE)) {
      val port = compatPorts[index]
      try {
        port.close()
        result.success(true)
      } catch (e: Exception) {
        result.error(LOG_TAG, e.message, null)
      }
    } else {
      result.success(true)
    }
  }

  fun onMessage(index: Int, message: WebMessageCompatExt?) {
    if (channelDelegate != null) {
      channelDelegate!!.onMessage(index, message)
    }
  }

  fun toMap(): MutableMap<String, Any?> {
    val webMessageChannelMap: MutableMap<String, Any?> = HashMap()
    webMessageChannelMap["id"] = id
    return webMessageChannelMap
  }

  override fun dispose() {
    if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_PORT_CLOSE)) {
      for (port in compatPorts) {
        try {
          port.close()
        } catch (ignored: Exception) {
        }
      }
    }
    if (channelDelegate != null) {
      channelDelegate!!.dispose()
      channelDelegate = null
    }
    compatPorts.clear()
    webView = null
  }
}
