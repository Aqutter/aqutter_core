package com.github.aqutter.core.chrome_custom_tabs

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.browser.customtabs.CustomTabsClient
import androidx.browser.customtabs.CustomTabsIntent
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.Util
import com.github.aqutter.core.types.ChannelDelegateImpl
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.Serializable
import java.util.UUID

open class ChromeSafariBrowserManager(plugin: AqutterCorePlugin) :
  ChannelDelegateImpl(MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME)) {

  @JvmField
  var plugin: AqutterCorePlugin?

  @JvmField
  var id: String

  @JvmField
  val browsers: MutableMap<String?, ChromeCustomTabsActivity?> = HashMap()

  init {
    this.id = UUID.randomUUID().toString()
    this.plugin = plugin
    shared[this.id] = this
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    val viewId = call.argument<String>("id")
    val plugin = this.plugin
    val activity = plugin?.activity

    when (call.method) {
      "open" -> {
        if (plugin != null && activity != null) {
          val url = call.argument<String>("url")
          val headers = call.argument<HashMap<String, Any?>>("headers")
          val referrer = call.argument<String>("referrer")
          val otherLikelyURLs = call.argument<ArrayList<String>>("otherLikelyURLs")
          val settings = call.argument<HashMap<String, Any?>>("settings")
          val actionButton = call.argument<HashMap<String, Any?>>("actionButton")
          val secondaryToolbar = call.argument<HashMap<String, Any?>>("secondaryToolbar")
          val menuItemList = call.argument<List<HashMap<String, Any?>>>("menuItemList")
          open(activity, viewId, url, headers, referrer, otherLikelyURLs, settings, actionButton, secondaryToolbar, menuItemList, result)
        } else {
          result.success(false)
        }
      }
      "isAvailable" -> {
        if (plugin != null && activity != null) {
          result.success(CustomTabActivityHelper.isAvailable(activity))
        } else {
          result.success(false)
        }
      }
      "getMaxToolbarItems" -> {
        result.success(CustomTabsIntent.getMaxToolbarItems())
      }
      "getPackageName" -> {
        if (plugin != null && activity != null) {
          val packages = call.argument<ArrayList<String>>("packages")
          val ignoreDefault = call.argument<Boolean>("ignoreDefault")
          result.success(CustomTabsClient.getPackageName(activity, packages, ignoreDefault!!))
        } else {
          result.success(null)
        }
      }
      else -> result.notImplemented()
    }
  }

  open fun open(
    activity: Activity, viewId: String?, url: String?, headers: HashMap<String, Any?>?,
    referrer: String?, otherLikelyURLs: ArrayList<String>?,
    settings: HashMap<String, Any?>?, actionButton: HashMap<String, Any?>?,
    secondaryToolbar: HashMap<String, Any?>?,
    menuItemList: List<HashMap<String, Any?>>?, result: MethodChannel.Result
  ) {
    val extras = Bundle()
    extras.putString("url", url)
    extras.putString("id", viewId)
    extras.putString("managerId", this.id)
    extras.putSerializable("headers", headers)
    extras.putString("referrer", referrer)
    extras.putSerializable("otherLikelyURLs", otherLikelyURLs)
    extras.putSerializable("settings", settings)
    extras.putSerializable("actionButton", actionButton)
    extras.putSerializable("secondaryToolbar", secondaryToolbar)
    extras.putSerializable("menuItemList", menuItemList as Serializable?)

    val isSingleInstance = Util.getOrDefault<Boolean>(settings!!, "isSingleInstance", false)
    val isTrustedWebActivity = Util.getOrDefault<Boolean>(settings!!, "isTrustedWebActivity", false)
    if (CustomTabActivityHelper.isAvailable(activity)) {
      val intent = Intent(
        activity,
        if (!isSingleInstance) {
          if (!isTrustedWebActivity) ChromeCustomTabsActivity::class.java else TrustedWebActivity::class.java
        } else {
          if (!isTrustedWebActivity) ChromeCustomTabsActivitySingleInstance::class.java else TrustedWebActivitySingleInstance::class.java
        }
      )
      intent.putExtras(extras)
      val noHistory = Util.getOrDefault<Boolean>(settings!!, "noHistory", false)
      if (noHistory) {
        intent.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY)
      }
      activity.startActivity(intent)
      result.success(true)
      return
    }

    result.error(LOG_TAG, "ChromeCustomTabs is not available!", null)
  }

  override fun dispose() {
    super.dispose()
    val browserList = browsers.values
    for (browser in browserList) {
      if (browser != null) {
        browser.close()
        browser.dispose()
      }
    }
    browsers.clear()
    shared.remove(this.id)
    plugin = null
  }

  companion object {
    protected const val LOG_TAG = "ChromeBrowserManager"
    const val METHOD_CHANNEL_NAME = "com.github.aqutter/chromesafaribrowser"

    @JvmField
    val shared: MutableMap<String, ChromeSafariBrowserManager> = HashMap()
  }
}
