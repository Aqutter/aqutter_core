package com.github.aqutter.core.webview.webview

import android.util.Log
import android.webkit.WebView
import androidx.webkit.WebViewFeature
import androidx.webkit.WebViewRenderProcess
import androidx.webkit.WebViewRenderProcessClient
import com.github.aqutter.core.webview.WebViewChannelDelegate

open class AqutterWebViewRenderProcessClient : WebViewRenderProcessClient() {

  companion object {
    protected const val LOG_TAG = "IAWRenderProcessClient"
  }

  override fun onRenderProcessUnresponsive(view: WebView, renderer: WebViewRenderProcess?) {
    val webView = view as AqutterWebView
    val callback = object : WebViewChannelDelegate.RenderProcessUnresponsiveCallback() {
      override fun nonNullSuccess(result: Int): Boolean {
        if (renderer != null) {
          when (result) {
            0 -> {
              if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_VIEW_RENDERER_TERMINATE))
                renderer.terminate()
            }
          }
          return false
        }
        return true
      }

      override fun defaultBehaviour(result: Int?) {

      }

      override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
        defaultBehaviour(null)
      }
    }

    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onRenderProcessUnresponsive(webView.url, callback)
    } else {
      callback.defaultBehaviour(null)
    }
  }

  override fun onRenderProcessResponsive(view: WebView, renderer: WebViewRenderProcess?) {
    val webView = view as AqutterWebView
    val callback = object : WebViewChannelDelegate.RenderProcessResponsiveCallback() {
      override fun nonNullSuccess(result: Int): Boolean {
        if (renderer != null) {
          when (result) {
            0 -> {
              if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_VIEW_RENDERER_TERMINATE))
                renderer.terminate()
            }
          }
          return false
        }
        return true
      }

      override fun defaultBehaviour(result: Int?) {

      }

      override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
        defaultBehaviour(null)
      }
    }

    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onRenderProcessResponsive(webView.url, callback)
    } else {
      callback.defaultBehaviour(null)
    }
  }

  // package-private in Java
  open fun dispose() {

  }
}
