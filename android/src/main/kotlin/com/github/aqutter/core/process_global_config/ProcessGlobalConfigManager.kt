package com.github.aqutter.core.process_global_config

import androidx.webkit.ProcessGlobalConfig
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.types.ChannelDelegateImpl
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ProcessGlobalConfigManager(plugin: AqutterCorePlugin) :
  ChannelDelegateImpl(MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME)) {
  companion object {
    // protected static in Java
    const val LOG_TAG = "ProcessGlobalConfigM"
    const val METHOD_CHANNEL_NAME = "com.github.aqutter/webview_processglobalconfig"
  }

  @JvmField
  var plugin: AqutterCorePlugin? = plugin

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "apply" ->
        if (plugin != null && plugin!!.activity != null) {
          val settings = ProcessGlobalConfigSettings()
            .parse(call.argument<MutableMap<String, Any?>>("settings")!!)
          try {
            ProcessGlobalConfig.apply(settings.toProcessGlobalConfig(plugin!!.activity!!))
            result.success(true)
          } catch (e: Exception) {
            result.error(LOG_TAG, "", e)
          }
        } else {
          result.success(false)
        }
      else -> result.notImplemented()
    }
  }

  override fun dispose() {
    super.dispose()
    plugin = null
  }
}
