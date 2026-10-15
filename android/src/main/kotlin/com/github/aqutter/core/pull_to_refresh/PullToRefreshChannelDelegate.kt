package com.github.aqutter.core.pull_to_refresh

import android.graphics.Color
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.github.aqutter.core.types.ChannelDelegateImpl
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class PullToRefreshChannelDelegate(pullToRefreshView: PullToRefreshLayout, channel: MethodChannel) : ChannelDelegateImpl(channel) {
  private var pullToRefreshView: PullToRefreshLayout? = pullToRefreshView

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "setEnabled" ->
        if (pullToRefreshView != null) {
          val enabled = call.argument<Boolean>("enabled")
          pullToRefreshView!!.settings.enabled = enabled // used by AqutterWebView.onOverScrolled
          pullToRefreshView!!.isEnabled = enabled!!
          result.success(true)
        } else {
          result.success(false)
        }
      "isEnabled" ->
        if (pullToRefreshView != null) {
          result.success(pullToRefreshView!!.isEnabled)
        } else {
          result.success(false)
        }
      "setRefreshing" ->
        if (pullToRefreshView != null) {
          val refreshing = call.argument<Boolean>("refreshing")
          pullToRefreshView!!.isRefreshing = refreshing!!
          result.success(true)
        } else {
          result.success(false)
        }
      "isRefreshing" ->
        result.success(pullToRefreshView != null && pullToRefreshView!!.isRefreshing)
      "setColor" ->
        if (pullToRefreshView != null) {
          val color = call.argument<String>("color")
          pullToRefreshView!!.setColorSchemeColors(Color.parseColor(color))
          result.success(true)
        } else {
          result.success(false)
        }
      "setBackgroundColor" ->
        if (pullToRefreshView != null) {
          val color = call.argument<String>("color")
          pullToRefreshView!!.setProgressBackgroundColorSchemeColor(Color.parseColor(color))
          result.success(true)
        } else {
          result.success(false)
        }
      "setDistanceToTriggerSync" ->
        if (pullToRefreshView != null) {
          val distanceToTriggerSync = call.argument<Int>("distanceToTriggerSync")
          pullToRefreshView!!.setDistanceToTriggerSync(distanceToTriggerSync!!)
          result.success(true)
        } else {
          result.success(false)
        }
      "setSlingshotDistance" ->
        if (pullToRefreshView != null) {
          val slingshotDistance = call.argument<Int>("slingshotDistance")
          pullToRefreshView!!.setSlingshotDistance(slingshotDistance!!)
          result.success(true)
        } else {
          result.success(false)
        }
      "getDefaultSlingshotDistance" ->
        result.success(SwipeRefreshLayout.DEFAULT_SLINGSHOT_DISTANCE)
      "setSize" ->
        if (pullToRefreshView != null) {
          val size = call.argument<Int>("size")
          pullToRefreshView!!.setSize(size!!)
          result.success(true)
        } else {
          result.success(false)
        }
      else -> result.notImplemented()
    }
  }

  fun onRefresh() {
    val channel = getChannel() ?: return
    val obj: MutableMap<String, Any?> = HashMap()
    channel.invokeMethod("onRefresh", obj)
  }

  override fun dispose() {
    super.dispose()
    pullToRefreshView = null
  }
}
