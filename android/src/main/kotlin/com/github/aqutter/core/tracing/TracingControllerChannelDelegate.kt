package com.github.aqutter.core.tracing

import androidx.webkit.WebViewFeature
import com.github.aqutter.core.types.ChannelDelegateImpl
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.FileNotFoundException
import java.io.FileOutputStream
import java.util.concurrent.Executors

class TracingControllerChannelDelegate(tracingControllerManager: TracingControllerManager, channel: MethodChannel) : ChannelDelegateImpl(channel) {
  private var tracingControllerManager: TracingControllerManager? = tracingControllerManager

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    TracingControllerManager.init()
    val tracingController = TracingControllerManager.tracingController

    when (call.method) {
      "isTracing" ->
        if (tracingController != null) {
          result.success(tracingController.isTracing)
        } else {
          result.success(false)
        }
      "start" ->
        if (tracingController != null && WebViewFeature.isFeatureSupported(WebViewFeature.TRACING_CONTROLLER_BASIC_USAGE)) {
          val settingsMap = call.argument<MutableMap<String, Any?>>("settings")
          val settings = TracingSettings()
          settings.parse(settingsMap!!)
          val config = TracingControllerManager.buildTracingConfig(settings)
          tracingController.start(config)
          result.success(true)
        } else {
          result.success(false)
        }
      "stop" ->
        if (tracingController != null && WebViewFeature.isFeatureSupported(WebViewFeature.TRACING_CONTROLLER_BASIC_USAGE)) {
          val filePath = call.argument<String>("filePath")
          try {
            result.success(tracingController.stop(
              if (filePath != null) FileOutputStream(filePath) else null,
              Executors.newSingleThreadExecutor()))
          } catch (e: FileNotFoundException) {
            e.printStackTrace()
            result.success(false)
          }
        } else {
          result.success(false)
        }
      else -> result.notImplemented()
    }
  }

  override fun dispose() {
    super.dispose()
    tracingControllerManager = null
  }
}
