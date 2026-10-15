package com.github.aqutter.core.webview.webview

import android.annotation.SuppressLint
import android.content.Context
import android.hardware.display.DisplayManager
import android.os.Message
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.webkit.WebView
import android.widget.FrameLayout
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.find_interaction.FindInteractionController
import com.github.aqutter.core.pull_to_refresh.PullToRefreshLayout
import com.github.aqutter.core.pull_to_refresh.PullToRefreshSettings
import com.github.aqutter.core.types.URLRequest
import com.github.aqutter.core.types.UserScript
import com.github.aqutter.core.webview.PlatformWebView
import java.io.IOException
import java.util.ArrayList
import java.util.HashMap

class FlutterWebView(plugin: AqutterCorePlugin, context: Context, id: Any,
                     params: HashMap<String, Any?>?) : PlatformWebView {

  companion object {
    // package-private in Java
    const val LOG_TAG = "IAWFlutterWebView"
  }

  @JvmField
  var webView: AqutterWebView? = null
  @JvmField
  var pullToRefreshLayout: PullToRefreshLayout? = null
  @JvmField
  var keepAliveId: String? = null

  init {
    val displayListenerProxy = DisplayListenerProxy()
    val displayManager = context.getSystemService(Context.DISPLAY_SERVICE) as DisplayManager
    displayListenerProxy.onPreWebViewInitialization(displayManager)

    keepAliveId = params!!["keepAliveId"] as String?

    val initialSettings = params["initialSettings"] as MutableMap<String, Any?>?
    val contextMenu = params["contextMenu"] as MutableMap<String, Any?>?
    val windowId = params["windowId"] as Int?
    val initialUserScripts = params["initialUserScripts"] as List<Map<String, Any?>>?
    val pullToRefreshInitialSettings = params["pullToRefreshSettings"] as MutableMap<String, Any?>?

    val customSettings = AqutterWebViewSettings()
    customSettings.parse(initialSettings!!)

    val userScripts: MutableList<UserScript?> = ArrayList()
    if (initialUserScripts != null) {
      for (initialUserScript in initialUserScripts) {
        userScripts.add(UserScript.fromMap(initialUserScript))
      }
    }

    val webView = AqutterWebView(context, plugin, id, windowId, customSettings, contextMenu,
      if (customSettings.useHybridComposition) null else plugin.flutterView,
      @Suppress("UNCHECKED_CAST") (userScripts as List<UserScript>))
    this.webView = webView
    displayListenerProxy.onPostWebViewInitialization(displayManager)

    // set MATCH_PARENT layout params to the WebView, otherwise it won't take all the available space!
    webView.layoutParams = FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
    val pullToRefreshSettings = PullToRefreshSettings()
    pullToRefreshSettings.parse(pullToRefreshInitialSettings!!)
    val pullToRefreshLayout = PullToRefreshLayout(context, plugin, id, pullToRefreshSettings)
    this.pullToRefreshLayout = pullToRefreshLayout
    pullToRefreshLayout.addView(webView)
    pullToRefreshLayout.prepare()

    val findInteractionController = FindInteractionController(webView, plugin, id, null)
    webView.findInteractionController = findInteractionController
    findInteractionController.prepare()

    webView.prepare()

    // Absent for any caller that predates the gate, and channelDelegate then keeps emitting
    // everything -- see WebViewChannelDelegate#enabledHighFrequencyEvents.
    val enabledHighFrequencyEvents = params["enabledHighFrequencyEvents"] as List<String>?
    val channelDelegate = webView.channelDelegate
    if (enabledHighFrequencyEvents != null && channelDelegate != null) {
      channelDelegate.setEnabledHighFrequencyEvents(enabledHighFrequencyEvents)
    }
  }

  override fun getView(): View? {
    return if (pullToRefreshLayout != null) pullToRefreshLayout else webView
  }

  @SuppressLint("RestrictedApi")
  override fun makeInitialLoad(params: HashMap<String, Any?>?) {
    val webView = this.webView
    if (webView == null) {
      return
    }

    val windowId = params!!["windowId"] as Int?
    val initialUrlRequest = params["initialUrlRequest"] as Map<String, Any?>?
    val initialFile = params["initialFile"] as String?
    val initialData = params["initialData"] as Map<String, String?>?

    if (windowId != null) {
      val plugin = webView.plugin
      val aqutterWebViewManager = plugin?.aqutterWebViewManager
      if (plugin != null && aqutterWebViewManager != null) {
        val resultMsg: Message? = aqutterWebViewManager.windowWebViewMessages[windowId]
        if (resultMsg != null) {
          (resultMsg.obj as WebView.WebViewTransport).setWebView(webView)
          resultMsg.sendToTarget()
          if (WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT)) {
            // for some reason, if a WebView is created using a window id,
            // the initial plugin and user scripts injected
            // with WebViewCompat.addDocumentStartJavaScript will not be added!
            // https://github.com/pichillilorenzo/flutter_inappwebview/issues/1455
            //
            // Also, calling the prepareAndAddUserScripts method right after won't work,
            // so use the View.post method here.
            webView.post {
              if (this.webView != null) {
                this.webView!!.prepareAndAddUserScripts()
              }
            }
          }
        }
      }
    } else {
      if (initialFile != null) {
        try {
          webView.loadFile(initialFile)
        } catch (e: IOException) {
          Log.e(LOG_TAG, "$initialFile asset file cannot be found!", e)
        }
      }
      else if (initialData != null) {
        val data = initialData["data"]
        val mimeType = initialData["mimeType"]
        val encoding = initialData["encoding"]
        val baseUrl = initialData["baseUrl"]
        val historyUrl = initialData["historyUrl"]
        webView.loadDataWithBaseURL(baseUrl, data!!, mimeType, encoding, historyUrl)
      }
      else if (initialUrlRequest != null) {
        val urlRequest = URLRequest.fromMap(initialUrlRequest)
        if (urlRequest != null) {
          webView.loadUrl(urlRequest)
        }
      }
    }
  }

  override fun dispose() {
    if (keepAliveId == null && webView != null) {
      webView!!.dispose()
      webView = null

      if (pullToRefreshLayout != null) {
        pullToRefreshLayout!!.dispose()
        pullToRefreshLayout = null
      }
    }
  }

  override fun onInputConnectionLocked() {
    val webView = this.webView
    if (webView != null && webView.aqutterBrowserDelegate == null && !webView.customSettings.useHybridComposition)
      webView.lockInputConnection()
  }

  override fun onInputConnectionUnlocked() {
    val webView = this.webView
    if (webView != null && webView.aqutterBrowserDelegate == null && !webView.customSettings.useHybridComposition)
      webView.unlockInputConnection()
  }

  override fun onFlutterViewAttached(flutterView: View) {
    val webView = this.webView
    if (webView != null && !webView.customSettings.useHybridComposition) {
      webView.setContainerView(flutterView)
    }
  }

  override fun onFlutterViewDetached() {
    val webView = this.webView
    if (webView != null && !webView.customSettings.useHybridComposition) {
      webView.setContainerView(null)
    }
  }
}
