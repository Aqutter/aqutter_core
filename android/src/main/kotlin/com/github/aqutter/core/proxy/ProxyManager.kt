package com.github.aqutter.core.proxy

import androidx.webkit.ProxyConfig
import androidx.webkit.ProxyController
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.types.ChannelDelegateImpl
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.Executor

class ProxyManager(plugin: AqutterCorePlugin) :
  ChannelDelegateImpl(MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME)) {
  companion object {
    // protected static in Java
    const val LOG_TAG = "ProxyManager"
    const val METHOD_CHANNEL_NAME = "com.github.aqutter/webview_proxycontroller"

    @JvmField
    var proxyController: ProxyController? = null

    @JvmStatic
    fun init() {
      if (proxyController == null &&
        WebViewFeature.isFeatureSupported(WebViewFeature.PROXY_OVERRIDE)) {
        proxyController = ProxyController.getInstance()
      }
    }
  }

  @JvmField
  var plugin: AqutterCorePlugin? = plugin

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    init()

    when (call.method) {
      "setProxyOverride" ->
        if (proxyController != null) {
          val settingsMap = call.argument<HashMap<String, Any?>>("settings")
          val settings = ProxySettings()
          if (settingsMap != null) {
            settings.parse(settingsMap)
          }
          setProxyOverride(settings, result)
        } else {
          result.success(false)
        }
      "clearProxyOverride" ->
        if (proxyController != null) {
          clearProxyOverride(result)
        } else {
          result.success(false)
        }
      else -> result.notImplemented()
    }
  }

  private fun setProxyOverride(settings: ProxySettings, result: MethodChannel.Result) {
    if (proxyController != null) {
      val proxyConfigBuilder = ProxyConfig.Builder()
      for (bypassRule in settings.bypassRules) {
        proxyConfigBuilder.addBypassRule(bypassRule)
      }
      for (direct in settings.directs) {
        proxyConfigBuilder.addDirect(direct)
      }
      for (proxyRule in settings.proxyRules) {
        if (proxyRule.schemeFilter != null) {
          proxyConfigBuilder.addProxyRule(proxyRule.url, proxyRule.schemeFilter!!)
        } else {
          proxyConfigBuilder.addProxyRule(proxyRule.url)
        }
      }
      if (settings.bypassSimpleHostnames != null && settings.bypassSimpleHostnames!!) {
        proxyConfigBuilder.bypassSimpleHostnames()
      }
      if (settings.removeImplicitRules != null && settings.removeImplicitRules!!) {
        proxyConfigBuilder.removeImplicitRules()
      }
      if (settings.reverseBypassEnabled != null && WebViewFeature.isFeatureSupported(WebViewFeature.PROXY_OVERRIDE_REVERSE_BYPASS)) {
        proxyConfigBuilder.setReverseBypassEnabled(settings.reverseBypassEnabled!!)
      }
      proxyController!!.setProxyOverride(proxyConfigBuilder.build(), object : Executor {
        override fun execute(command: Runnable) {
          command.run()
        }
      }, object : Runnable {
        override fun run() {
          result.success(true)
        }
      })
    }
  }

  private fun clearProxyOverride(result: MethodChannel.Result) {
    if (proxyController != null) {
      proxyController!!.clearProxyOverride(object : Executor {
        override fun execute(command: Runnable) {
          command.run()
        }
      }, object : Runnable {
        override fun run() {
          result.success(true)
        }
      })
    }
  }

  override fun dispose() {
    super.dispose()
    plugin = null
  }
}
