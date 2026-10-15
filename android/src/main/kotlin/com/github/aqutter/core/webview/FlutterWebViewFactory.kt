package com.github.aqutter.core.webview

import android.content.Context
import android.view.ViewGroup
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.webview.webview.FlutterWebView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class FlutterWebViewFactory(private val plugin: AqutterCorePlugin) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
  companion object {
    const val VIEW_TYPE_ID = "com.github.aqutter/webview"
  }

  override fun create(context: Context?, id: Int, args: Any?): PlatformView {
    val params = args as HashMap<String, Any?>
    var flutterWebView: FlutterWebView? = null
    var viewId: Any = id

    val keepAliveId = params["keepAliveId"] as String?
    val headlessWebViewId = params["headlessWebViewId"] as String?

    val headlessAqutterWebViewManager = plugin.headlessAqutterWebViewManager
    if (headlessWebViewId != null && headlessAqutterWebViewManager != null) {
      val headlessAqutterWebView = headlessAqutterWebViewManager.webViews[headlessWebViewId]
      if (headlessAqutterWebView != null) {
        flutterWebView = headlessAqutterWebView.disposeAndGetFlutterWebView()
        if (flutterWebView != null) {
          flutterWebView.keepAliveId = keepAliveId
        }
      }
    }

    val aqutterWebViewManager = plugin.aqutterWebViewManager
    if (keepAliveId != null && flutterWebView == null && aqutterWebViewManager != null) {
      flutterWebView = aqutterWebViewManager.keepAliveWebViews[keepAliveId]
      if (flutterWebView != null) {
        // be sure to remove the view from the previous parent.
        val view = flutterWebView.view
        if (view != null) {
          val parent = view.parent as ViewGroup?
          if (parent != null) {
            parent.removeView(view)
          }
        }
      }
    }

    val shouldMakeInitialLoad = flutterWebView == null
    if (flutterWebView == null) {
      if (keepAliveId != null) {
        viewId = keepAliveId
      }
      flutterWebView = FlutterWebView(plugin, context!!, viewId, params)
    }

    if (keepAliveId != null && aqutterWebViewManager != null) {
      aqutterWebViewManager.keepAliveWebViews[keepAliveId] = flutterWebView
    }

    if (shouldMakeInitialLoad) {
      flutterWebView.makeInitialLoad(params)
    }

    return flutterWebView
  }
}
