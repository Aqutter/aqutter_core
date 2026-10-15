package com.github.aqutter.core.tracing

import androidx.webkit.TracingConfig
import androidx.webkit.TracingController
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.types.Disposable
import io.flutter.plugin.common.MethodChannel

class TracingControllerManager(plugin: AqutterCorePlugin) : Disposable {
  companion object {
    // protected static in Java
    const val LOG_TAG = "TracingControllerMan"
    const val METHOD_CHANNEL_NAME = "com.github.aqutter/webview_tracingcontroller"

    @JvmField
    var tracingController: TracingController? = null

    @JvmStatic
    fun init() {
      if (tracingController == null &&
        WebViewFeature.isFeatureSupported(WebViewFeature.TRACING_CONTROLLER_BASIC_USAGE)) {
        tracingController = TracingController.getInstance()
      }
    }

    @JvmStatic
    fun buildTracingConfig(settings: TracingSettings): TracingConfig {
      val builder = TracingConfig.Builder()
      for (category in settings.categories) {
        if (category is String) {
          builder.addCategories(category)
        }
        if (category is Int) {
          builder.addCategories(category)
        }
      }
      if (settings.tracingMode != null) {
        builder.setTracingMode(settings.tracingMode!!)
      }
      return builder.build()
    }
  }

  @JvmField
  var channelDelegate: TracingControllerChannelDelegate?
  @JvmField
  var plugin: AqutterCorePlugin? = plugin

  init {
    val channel = MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME)
    this.channelDelegate = TracingControllerChannelDelegate(this, channel)
  }

  override fun dispose() {
    if (channelDelegate != null) {
      channelDelegate!!.dispose()
      channelDelegate = null
    }
    plugin = null
  }
}
