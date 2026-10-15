package com.github.aqutter.core.headless_webview

import com.github.aqutter.core.types.ChannelDelegateImpl
import com.github.aqutter.core.types.Size2D

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class HeadlessWebViewChannelDelegate(
  headlessWebView: AqutterHeadlessWebView,
  channel: MethodChannel
) : ChannelDelegateImpl(channel) {
  private var headlessWebView: AqutterHeadlessWebView? = headlessWebView

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "dispose" -> {
        val webView = headlessWebView
        if (webView != null) {
          webView.dispose()
          result.success(true)
        } else {
          result.success(false)
        }
      }
      "setSize" -> {
        val webView = headlessWebView
        if (webView != null) {
          val sizeMap = call.argument<MutableMap<String, Any?>>("size")
          val size = Size2D.fromMap(sizeMap)
          if (size != null)
            webView.setSize(size)
          result.success(true)
        } else {
          result.success(false)
        }
      }
      "getSize" -> {
        val webView = headlessWebView
        if (webView != null) {
          val size = webView.getSize()
          result.success(if (size != null) size.toMap() else null)
        } else {
          result.success(null)
        }
      }
      else -> result.notImplemented()
    }
  }

  fun onWebViewCreated() {
    val channel = getChannel() ?: return
    val obj: MutableMap<String, Any?> = HashMap()
    channel.invokeMethod("onWebViewCreated", obj)
  }

  override fun dispose() {
    super.dispose()
    headlessWebView = null
  }
}
