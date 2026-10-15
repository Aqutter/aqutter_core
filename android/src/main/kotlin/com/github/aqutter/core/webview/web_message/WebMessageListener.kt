package com.github.aqutter.core.webview.web_message

import android.net.Uri
import android.text.TextUtils
import android.webkit.WebView
import androidx.webkit.JavaScriptReplyProxy
import androidx.webkit.WebMessageCompat
import androidx.webkit.WebViewCompat
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.Util
import com.github.aqutter.core.plugin_scripts_js.JavaScriptBridgeJS
import com.github.aqutter.core.types.Disposable
import com.github.aqutter.core.types.PluginScript
import com.github.aqutter.core.types.UserScriptInjectionTime
import com.github.aqutter.core.types.WebMessageCompatExt
import com.github.aqutter.core.webview.AqutterWebViewInterface
import com.github.aqutter.core.webview.webview.AqutterWebView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.util.ArrayList
import java.util.HashSet
import java.util.regex.Pattern

class WebMessageListener(
  id: String,
  webView: AqutterWebViewInterface,
  messenger: BinaryMessenger,
  jsObjectName: String,
  allowedOriginRules: MutableSet<String>
) : Disposable {
  companion object {
    // protected in Java
    const val LOG_TAG = "WebMessageListener"
    const val METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/webview_web_message_listener_"

    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun fromMap(webView: AqutterWebViewInterface, messenger: BinaryMessenger, map: MutableMap<String, Any?>?): WebMessageListener? {
      if (map == null) {
        return null
      }
      val id = map["id"] as String?
      val jsObjectName = map["jsObjectName"] as String?
      assert(jsObjectName != null)
      val allowedOriginRuleList = map["allowedOriginRules"] as List<String>?
      assert(allowedOriginRuleList != null)
      val allowedOriginRules: MutableSet<String> = HashSet(allowedOriginRuleList!!)
      return WebMessageListener(id!!, webView, messenger, jsObjectName!!, allowedOriginRules)
    }
  }

  @JvmField
  var id: String

  @JvmField
  var jsObjectName: String

  @JvmField
  var allowedOriginRules: MutableSet<String>

  @JvmField
  var listener: WebViewCompat.WebMessageListener? = null

  @JvmField
  var replyProxy: JavaScriptReplyProxy? = null

  @JvmField
  var webView: AqutterWebViewInterface? = null

  @JvmField
  var channelDelegate: WebMessageListenerChannelDelegate? = null

  init {
    this.id = id
    this.webView = webView
    this.jsObjectName = jsObjectName
    this.allowedOriginRules = allowedOriginRules
    val channel = MethodChannel(messenger, METHOD_CHANNEL_NAME_PREFIX + this.id + "_" + this.jsObjectName)
    this.channelDelegate = WebMessageListenerChannelDelegate(this, channel)

    if (this.webView is AqutterWebView) {
      this.listener = object : WebViewCompat.WebMessageListener {
        override fun onPostMessage(
          view: WebView, message: WebMessageCompat, sourceOrigin: Uri,
          isMainFrame: Boolean, javaScriptReplyProxy: JavaScriptReplyProxy
        ) {
          replyProxy = javaScriptReplyProxy
          if (channelDelegate != null) {
            channelDelegate!!.onPostMessage(WebMessageCompatExt.fromMapWebMessageCompat(message),
              if (sourceOrigin.toString() == "null") null else sourceOrigin.toString(),
              isMainFrame)
          }
        }
      }
    }
  }

  fun initJsInstance() {
    val webView = this.webView
    if (webView != null) {
      val jsObjectNameEscaped = Util.replaceAll(jsObjectName, "\'", "\\'")
      val allowedOriginRulesStringList: MutableList<String> = ArrayList()
      for (allowedOriginRule in allowedOriginRules) {
        if ("*" == allowedOriginRule) {
          allowedOriginRulesStringList.add("'*'")
        } else {
          val rule = Uri.parse(allowedOriginRule)
          val host = if (rule.host != null) "'" + Util.replaceAll(rule.host!!, "\'", "\\'") + "'" else "null"
          allowedOriginRulesStringList.add("{scheme: '" + rule.scheme + "', host: " + host + ", port: " + (if (rule.port != -1) rule.port else "null") + "}")
        }
      }
      val allowedOriginRulesString = TextUtils.join(", ", allowedOriginRulesStringList)

      val source = "(function() {" +
        "  var allowedOriginRules = [" + allowedOriginRulesString + "];" +
        "  var isPageBlank = window.location.href === 'about:blank';" +
        "  var scheme = !isPageBlank ? window.location.protocol.replace(':', '') : null;" +
        "  var host = !isPageBlank ? window.location.hostname : null;" +
        "  var port = !isPageBlank ? window.location.port : null;" +
        "  if (window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "._isOriginAllowed(allowedOriginRules, scheme, host, port)) {" +
        "      window['" + jsObjectNameEscaped + "'] = new AqutterFlutterWebViewWebMessageListener('" + jsObjectNameEscaped + "');" +
        "  }" +
        "})();"
      webView.getUserContentController()!!.addPluginScript(PluginScript(
        "WebMessageListener-" + jsObjectName,
        source,
        UserScriptInjectionTime.AT_DOCUMENT_START,
        null,
        false,
        webView.getCustomSettings()!!.pluginScriptsOriginAllowList,
        webView.getCustomSettings()!!.pluginScriptsForMainFrameOnly
      ))
    }
  }

  @Throws(Exception::class)
  @Suppress("SENSELESS_COMPARISON")
  fun assertOriginRulesValid() {
    var index = 0
    for (originRule in allowedOriginRules) {
      if (originRule == null) {
        throw Exception("allowedOriginRules[" + index + "] is null")
      }
      if (originRule.isEmpty()) {
        throw Exception("allowedOriginRules[" + index + "] is empty")
      }
      if ("*" == originRule) {
        continue
      }
      val url = Uri.parse(originRule)
      val scheme = url.scheme
      val host = url.host
      val path = url.path
      val port = url.port
      if (scheme == null) {
        throw Exception("allowedOriginRules " + originRule + " is invalid")
      }
      if (("http" == scheme || "https" == scheme) && (host == null || host.isEmpty())) {
        throw Exception("allowedOriginRules " + originRule + " is invalid")
      }
      if ("http" != scheme && "https" != scheme && (host != null || port != -1)) {
        throw Exception("allowedOriginRules " + originRule + " is invalid")
      }
      if ((host == null || host.isEmpty()) && port != -1) {
        throw Exception("allowedOriginRules " + originRule + " is invalid")
      }
      if (!path!!.isEmpty()) {
        throw Exception("allowedOriginRules " + originRule + " is invalid")
      }
      if (host != null) {
        val distance = host.indexOf("*")
        if (distance != 0 || (distance == 0 && !host.startsWith("*."))) {
          throw Exception("allowedOriginRules " + originRule + " is invalid")
        }
        if (host.startsWith("[")) {
          if (!host.endsWith("]")) {
            throw Exception("allowedOriginRules " + originRule + " is invalid")
          }
          val ipv6 = host.substring(1, host.length - 1)
          if (!Util.isIPv6(ipv6)) {
            throw Exception("allowedOriginRules " + originRule + " is invalid")
          }
        }
      }
      index++
    }
  }

  fun postMessageForAqutterWebView(message: WebMessageCompatExt?, result: MethodChannel.Result) {
    if (replyProxy != null && WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_LISTENER)) {
      val data = message!!.data
      if (data != null) {
        if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_ARRAY_BUFFER) && message.type == WebMessageCompat.TYPE_ARRAY_BUFFER) {
          replyProxy!!.postMessage(data as ByteArray)
        } else {
          replyProxy!!.postMessage(data.toString())
        }
      }
    }
    result.success(true)
  }

  @Suppress("SENSELESS_COMPARISON", "USELESS_ELVIS")
  fun isOriginAllowed(scheme: String?, host: String?, port: Int): Boolean {
    for (allowedOriginRule in allowedOriginRules) {
      if ("*" == allowedOriginRule) {
        return true
      }
      if (scheme == null || scheme.isEmpty()) {
        continue
      }
      if ((scheme == null || scheme.isEmpty()) && (host == null || host.isEmpty()) && (port == 0 || port == -1)) {
        continue
      }
      val rule = Uri.parse(allowedOriginRule)
      val rulePort = if (rule.port == -1 || rule.port == 0) (if ("https" == rule.scheme) 443 else 80) else rule.port
      val currentPort = if (port == 0 || port == -1) (if ("https" == scheme) 443 else 80) else port
      var IPv6: String? = null
      if (rule.host != null && rule.host!!.startsWith("[")) {
        try {
          IPv6 = Util.normalizeIPv6(rule.host!!.substring(1, rule.host!!.length - 1))
        } catch (ignored: Exception) {
        }
      }
      var hostIPv6: String? = null
      try {
        hostIPv6 = Util.normalizeIPv6(host!!)
      } catch (ignored: Exception) {
      }

      val schemeAllowed = rule.scheme!! == scheme

      val hostAllowed = rule.host == null ||
        rule.host!!.isEmpty() ||
        rule.host!! == host ||
        (rule.host!!.startsWith("*") && host != null && host.contains(Pattern.compile("\\*").split(rule.host!!)[1])) ||
        (hostIPv6 != null && IPv6 != null && hostIPv6 == IPv6)

      val portAllowed = rulePort == currentPort

      if (schemeAllowed && hostAllowed && portAllowed) {
        return true
      }
    }
    return false
  }

  override fun dispose() {
    if (channelDelegate != null) {
      channelDelegate!!.dispose()
      channelDelegate = null
    }
    listener = null
    replyProxy = null
    webView = null
  }
}
