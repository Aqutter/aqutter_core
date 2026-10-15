package com.github.aqutter.core.pull_to_refresh

import android.content.Context
import android.graphics.Color
import android.util.AttributeSet
import android.view.View
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.types.Disposable
import com.github.aqutter.core.webview.webview.AqutterWebView
import io.flutter.plugin.common.MethodChannel

class PullToRefreshLayout : SwipeRefreshLayout, Disposable {
  companion object {
    // package-private in Java
    const val LOG_TAG = "PullToRefreshLayout"
    const val METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/webview_pull_to_refresh_"
  }

  @JvmField
  var channelDelegate: PullToRefreshChannelDelegate? = null
  @JvmField
  var settings: PullToRefreshSettings = PullToRefreshSettings()

  constructor(context: Context, plugin: AqutterCorePlugin,
              id: Any, settings: PullToRefreshSettings) : super(context) {
    this.settings = settings
    val channel = MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME_PREFIX + id)
    this.channelDelegate = PullToRefreshChannelDelegate(this, channel)
  }

  constructor(context: Context) : super(context)

  constructor(context: Context, attrs: AttributeSet?) : super(context, attrs)

  fun prepare() {
    isFocusable = true

    val self = this

    isEnabled = settings.enabled!!
    setOnChildScrollUpCallback(object : OnChildScrollUpCallback {
      override fun canChildScrollUp(parent: SwipeRefreshLayout, child: View?): Boolean {
        if (child is AqutterWebView) {
          val aqutterWebView = child
          return (aqutterWebView.canScrollVertically() && aqutterWebView.scrollY > 0) ||
            (!aqutterWebView.canScrollVertically() && aqutterWebView.scrollY == 0)
        }
        return true
      }
    })
    setOnRefreshListener(object : SwipeRefreshLayout.OnRefreshListener {
      override fun onRefresh() {
        if (channelDelegate == null) {
          self.isRefreshing = false
          return
        }
        channelDelegate!!.onRefresh()
      }
    })
    if (settings.color != null)
      setColorSchemeColors(Color.parseColor(settings.color))
    if (settings.backgroundColor != null)
      setProgressBackgroundColorSchemeColor(Color.parseColor(settings.backgroundColor))
    if (settings.distanceToTriggerSync != null)
      setDistanceToTriggerSync(settings.distanceToTriggerSync!!)
    if (settings.slingshotDistance != null)
      setSlingshotDistance(settings.slingshotDistance!!)
    if (settings.size != null)
      setSize(settings.size!!)
  }

  override fun dispose() {
    if (channelDelegate != null) {
      channelDelegate!!.dispose()
      channelDelegate = null
    }
    removeAllViews()
  }
}
