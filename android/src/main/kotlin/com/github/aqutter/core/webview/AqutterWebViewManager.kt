package com.github.aqutter.core.webview

import android.content.Context
import android.content.pm.PackageInfo
import android.os.Build
import android.os.Message
import android.view.ViewGroup
import android.webkit.ValueCallback
import android.webkit.WebSettings
import android.webkit.WebView
import androidx.webkit.WebViewCompat
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.plugin_scripts_js.JavaScriptBridgeJS
import com.github.aqutter.core.types.ChannelDelegateImpl
import com.github.aqutter.core.webview.webview.FlutterWebView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class AqutterWebViewManager(plugin: AqutterCorePlugin) : ChannelDelegateImpl(MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME)) {
  companion object {
    // protected in Java
    const val LOG_TAG = "AqutterWebViewManager"
    const val METHOD_CHANNEL_NAME = "com.github.aqutter/webview_manager"
  }

  @JvmField
  var plugin: AqutterCorePlugin? = plugin

  @JvmField
  val keepAliveWebViews: MutableMap<String, FlutterWebView?> = HashMap()

  @JvmField
  val windowWebViewMessages: MutableMap<Int, Message> = HashMap()
  @JvmField
  var windowAutoincrementId: Int = 0

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "getDefaultUserAgent" -> {
        val plugin = plugin
        if (plugin != null) {
          result.success(WebSettings.getDefaultUserAgent(plugin.applicationContext))
        } else {
          result.success(null)
        }
      }
      "clearClientCertPreferences" -> {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          WebView.clearClientCertPreferences(object : Runnable {
            override fun run() {
              result.success(true)
            }
          })
        } else {
          result.success(false)
        }
      }
      "getSafeBrowsingPrivacyPolicyUrl" -> {
        if (WebViewFeature.isFeatureSupported(WebViewFeature.SAFE_BROWSING_PRIVACY_POLICY_URL)) {
          result.success(WebViewCompat.getSafeBrowsingPrivacyPolicyUrl().toString())
        } else
          result.success(null)
      }
      "setSafeBrowsingAllowlist" -> {
        if (WebViewFeature.isFeatureSupported(WebViewFeature.SAFE_BROWSING_ALLOWLIST)) {
          val hosts: MutableSet<String> = HashSet(call.argument<List<String>>("hosts")!!)
          WebViewCompat.setSafeBrowsingAllowlist(hosts, object : ValueCallback<Boolean> {
            override fun onReceiveValue(value: Boolean?) {
              result.success(value)
            }
          })
        }
        else if (WebViewFeature.isFeatureSupported(WebViewFeature.SAFE_BROWSING_WHITELIST)) {
          val hosts = call.argument<List<String>>("hosts")
          WebViewCompat.setSafeBrowsingWhitelist(hosts!!, object : ValueCallback<Boolean> {
            override fun onReceiveValue(value: Boolean?) {
              result.success(value)
            }
          })
        } else
          result.success(false)
      }
      "getCurrentWebViewPackage" -> {
        run {
          var context: Context? = null
          val plugin = plugin
          if (plugin != null) {
            context = plugin.activity
            if (context == null) {
              context = plugin.applicationContext
            }
          }
          val packageInfo = if (context != null) WebViewCompat.getCurrentWebViewPackage(context) else null
          result.success(if (packageInfo != null) convertWebViewPackageToMap(packageInfo) else null)
        }
      }
      "setWebContentsDebuggingEnabled" -> {
        run {
          val debuggingEnabled = call.argument<Boolean>("debuggingEnabled")!!
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            WebView.setWebContentsDebuggingEnabled(debuggingEnabled)
          }
        }
        result.success(true)
      }
      "getVariationsHeader" -> {
        if (WebViewFeature.isFeatureSupported(WebViewFeature.GET_VARIATIONS_HEADER)) {
          result.success(WebViewCompat.getVariationsHeader())
        }
        else {
          result.success(null)
        }
      }
      "isMultiProcessEnabled" -> {
        if (WebViewFeature.isFeatureSupported(WebViewFeature.MULTI_PROCESS)) {
          result.success(WebViewCompat.isMultiProcessEnabled())
        }
        else {
          result.success(false)
        }
      }
      "disableWebView" -> {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
          WebView.disableWebView()
        }
        result.success(true)
      }
      "disposeKeepAlive" -> {
        val keepAliveId = call.argument<String>("keepAliveId")
        if (keepAliveId != null) {
          disposeKeepAlive(keepAliveId)
        }
        result.success(true)
      }
      "clearAllCache" -> {
        run {
          var context: Context? = null
          val plugin = plugin
          if (plugin != null) {
            context = plugin.activity
            if (context == null) {
              context = plugin.applicationContext
            }
            if (context != null) {
              val includeDiskFiles = call.argument<Boolean>("includeDiskFiles")!!
              clearAllCache(context, includeDiskFiles)
            }
          }
        }
        result.success(true)
      }
      "enableSlowWholeDocumentDraw" -> {
        run {
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            WebView.enableSlowWholeDocumentDraw()
          }
        }
        result.success(true)
      }
      "setJavaScriptBridgeName" -> {
        JavaScriptBridgeJS.set_JAVASCRIPT_BRIDGE_NAME(call.argument<String>("bridgeName")!!)
        result.success(true)
      }
      "getJavaScriptBridgeName" -> {
        run {
          result.success(JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME())
        }
      }
      else -> result.notImplemented()
    }
  }

  fun convertWebViewPackageToMap(webViewPackageInfo: PackageInfo): MutableMap<String, Any?> {
    val webViewPackageInfoMap: HashMap<String, Any?> = HashMap()

    webViewPackageInfoMap["versionName"] = webViewPackageInfo.versionName
    webViewPackageInfoMap["packageName"] = webViewPackageInfo.packageName

    return webViewPackageInfoMap
  }

  fun disposeKeepAlive(keepAliveId: String) {
    val flutterWebView = keepAliveWebViews[keepAliveId]
    if (flutterWebView != null) {
      flutterWebView.keepAliveId = null
      // be sure to remove the view from the previous parent.
      val view = flutterWebView.view
      if (view != null) {
        val parent = view.parent as ViewGroup?
        if (parent != null) {
          parent.removeView(view)
        }
      }
      flutterWebView.dispose()
    }
    if (keepAliveWebViews.containsKey(keepAliveId)) {
      keepAliveWebViews[keepAliveId] = null
    }
  }

  fun clearAllCache(context: Context, includeDiskFiles: Boolean) {
    val tempWebView = WebView(context)
    tempWebView.clearCache(includeDiskFiles)
    tempWebView.destroy()
  }

  override fun dispose() {
    super.dispose()
    val flutterWebViews = keepAliveWebViews.values
    for (flutterWebView in flutterWebViews) {
      if (flutterWebView != null) {
        val keepAliveId = flutterWebView.keepAliveId
        if (keepAliveId != null) {
          disposeKeepAlive(keepAliveId)
        }
      }
    }
    keepAliveWebViews.clear()
    windowWebViewMessages.clear()
    plugin = null
  }
}
