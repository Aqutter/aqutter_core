package com.github.aqutter.core.find_interaction

import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.types.Disposable
import com.github.aqutter.core.types.FindSession
import com.github.aqutter.core.webview.AqutterWebViewInterface
import io.flutter.plugin.common.MethodChannel

open class FindInteractionController(
  webView: AqutterWebViewInterface,
  plugin: AqutterCorePlugin,
  id: Any,
  settings: FindInteractionSettings?
) : Disposable {

  @JvmField
  var webView: AqutterWebViewInterface? = null

  @JvmField
  var activeFindSession: FindSession? = null

  @JvmField
  var channelDelegate: FindInteractionChannelDelegate? = null

  @JvmField
  var settings: FindInteractionSettings? = null

  @JvmField
  var searchText: String? = null

  init {
    this.webView = webView
    this.settings = settings
    val channel = MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME_PREFIX + id)
    this.channelDelegate = FindInteractionChannelDelegate(this, channel)
  }

  fun prepare() {

  }

  fun findAll(find: String?) {
    var find = find
    if (find == null) {
      find = searchText
    } else {
      // updated searchText
      searchText = find
    }
    val webView = this.webView
    if (webView != null && find != null) {
      webView.findAllAsync(find)
    }
  }

  fun findNext(forward: Boolean) {
    val webView = this.webView
    if (webView != null) {
      webView.findNext(forward)
    }
  }

  fun clearMatches() {
    val webView = this.webView
    if (webView != null) {
      webView.clearMatches()
    }
  }

  override fun dispose() {
    val channelDelegate = this.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.dispose()
      this.channelDelegate = null
    }
    webView = null
    activeFindSession = null
    searchText = null
  }

  companion object {
    const val LOG_TAG = "FindInteractionController" // package-private in Java
    const val METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/webview_find_interaction_"
  }
}
