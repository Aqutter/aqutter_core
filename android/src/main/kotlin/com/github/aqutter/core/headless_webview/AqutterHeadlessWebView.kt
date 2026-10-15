package com.github.aqutter.core.headless_webview

import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.Util
import com.github.aqutter.core.types.Disposable
import com.github.aqutter.core.types.Size2D
import com.github.aqutter.core.webview.webview.FlutterWebView
import io.flutter.plugin.common.MethodChannel

open class AqutterHeadlessWebView(
  plugin: AqutterCorePlugin,
  id: String,
  flutterWebView: FlutterWebView
) : Disposable {

  @JvmField
  val id: String = id

  @JvmField
  var channelDelegate: HeadlessWebViewChannelDelegate? = null

  @JvmField
  var flutterWebView: FlutterWebView? = null

  @JvmField
  var plugin: AqutterCorePlugin? = null

  init {
    this.plugin = plugin
    this.flutterWebView = flutterWebView
    val channel = MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME_PREFIX + id)
    this.channelDelegate = HeadlessWebViewChannelDelegate(this, channel)
  }

  fun onWebViewCreated() {
    val channelDelegate = this.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onWebViewCreated()
    }
  }

  fun prepare(params: Map<String, Any?>?) {
    val flutterWebView = this.flutterWebView
    if (flutterWebView != null) {
      val view = flutterWebView.view
      if (view != null) {
        val initialSize = params!!.get("initialSize") as Map<String, Any?>?
        var size = Size2D.fromMap(initialSize)
        if (size == null) {
          size = Size2D(-1.0, -1.0)
        }
        setSize(size)
        view.setVisibility(View.INVISIBLE)
      }
    }
    val plugin = this.plugin
    val pluginActivity = plugin?.activity
    if (plugin != null && pluginActivity != null) {
      // Add the headless WebView to the view hierarchy.
      // This way is also possible to take screenshots.
      val contentView = pluginActivity.findViewById<ViewGroup>(android.R.id.content)
      if (contentView != null) {
        val mainView = contentView.getChildAt(0) as ViewGroup?
        if (mainView != null && flutterWebView != null) {
          val view = flutterWebView.view
          if (view != null) {
            mainView.addView(view, 0)
          }
        }
      }
    }
  }

  fun setSize(size: Size2D) {
    val flutterWebView = this.flutterWebView
    if (flutterWebView != null && flutterWebView.webView != null) {
      val view = flutterWebView.view
      if (view != null) {
        val scale = Util.getPixelDensity(view.context)
        val fullscreenSize = Util.getFullscreenSize(view.context)
        val width = (if (size.width == -1.0) fullscreenSize.width else (size.width * scale)).toInt()
        // NOTE: height 的判斷條件使用的是 size.getWidth()（Java 原行為，保持不變）
        val height = (if (size.width == -1.0) fullscreenSize.height else (size.height * scale)).toInt()
        view.setLayoutParams(FrameLayout.LayoutParams(width, height))
      }
    }
  }

  fun getSize(): Size2D? {
    val flutterWebView = this.flutterWebView
    if (flutterWebView != null && flutterWebView.webView != null) {
      val view = flutterWebView.view
      if (view != null) {
        val scale = Util.getPixelDensity(view.context)
        val fullscreenSize = Util.getFullscreenSize(view.context)
        val layoutParams = view.layoutParams
        return Size2D(
          (if (fullscreenSize.width == layoutParams.width.toDouble()) layoutParams.width.toFloat() else (layoutParams.width / scale)).toDouble(),
          (if (fullscreenSize.height == layoutParams.height.toDouble()) layoutParams.height.toFloat() else (layoutParams.height / scale)).toDouble()
        )
      }
    }
    return null
  }

  fun disposeAndGetFlutterWebView(): FlutterWebView? {
    val newFlutterWebView = flutterWebView
    val flutterWebView = this.flutterWebView
    if (flutterWebView != null) {
      val view = flutterWebView.view
      if (view != null) {
        // restore WebView layout params and visibility
        view.setLayoutParams(FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT))
        view.setVisibility(View.VISIBLE)
        // remove from parent
        val parent = view.parent as ViewGroup?
        if (parent != null) {
          parent.removeView(view)
        }
      }
      // set to null to avoid to be disposed before calling "dispose()"
      this.flutterWebView = null
      dispose()
    }
    return newFlutterWebView
  }

  override fun dispose() {
    val channelDelegate = this.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.dispose()
      this.channelDelegate = null
    }
    val plugin = this.plugin
    if (plugin != null) {
      val headlessAqutterWebViewManager = plugin.headlessAqutterWebViewManager
      if (headlessAqutterWebViewManager != null && headlessAqutterWebViewManager.webViews.containsKey(id)) {
        headlessAqutterWebViewManager.webViews.put(id, null)
      }
      val activity = plugin.activity
      if (activity != null) {
        val contentView = activity.findViewById<ViewGroup>(android.R.id.content)
        if (contentView != null) {
          val mainView = contentView.getChildAt(0) as ViewGroup?
          val flutterWebView = this.flutterWebView
          if (mainView != null && flutterWebView != null) {
            val view = flutterWebView.view
            if (view != null) {
              mainView.removeView(flutterWebView.view)
            }
          }
        }
      }
    }
    val flutterWebView = this.flutterWebView
    if (flutterWebView != null) {
      flutterWebView.dispose()
    }
    this.flutterWebView = null
    this.plugin = null
  }

  companion object {
    protected const val LOG_TAG = "AqutterHeadlessWebView"
    const val METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/headless_webview_"
  }
}
