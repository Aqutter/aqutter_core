package com.github.aqutter.core.chrome_custom_tabs

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import androidx.browser.customtabs.CustomTabsService
import com.github.aqutter.core.types.ChannelDelegateImpl
import com.github.aqutter.core.types.CustomTabsSecondaryToolbar
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

open class ChromeCustomTabsChannelDelegate(
  chromeCustomTabsActivity: ChromeCustomTabsActivity,
  channel: MethodChannel
) : ChannelDelegateImpl(channel) {
  private var chromeCustomTabsActivity: ChromeCustomTabsActivity? = chromeCustomTabsActivity

  @Suppress("UNCHECKED_CAST")
  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    val chromeCustomTabsActivity = this.chromeCustomTabsActivity
    when (call.method) {
      "launchUrl" ->
        if (chromeCustomTabsActivity != null) {
          val url = call.argument<String>("url")
          if (url != null) {
            val headers = call.argument<Map<String, String>>("headers")
            val referrer = call.argument<String>("referrer")
            val otherLikelyURLs = call.argument<List<String>>("otherLikelyURLs")
            chromeCustomTabsActivity.launchUrl(url, headers, referrer, otherLikelyURLs)
            result.success(true)
          } else {
            result.success(false)
          }
        } else {
          result.success(false)
        }
      "mayLaunchUrl" ->
        if (chromeCustomTabsActivity != null) {
          val url = call.argument<String>("url")
          val otherLikelyURLs = call.argument<List<String>>("otherLikelyURLs")
          result.success(chromeCustomTabsActivity.mayLaunchUrl(url, otherLikelyURLs))
        } else {
          result.success(false)
        }
      "updateActionButton" ->
        if (chromeCustomTabsActivity != null) {
          val icon = call.argument<ByteArray>("icon")
          val description = call.argument<String>("description")
          chromeCustomTabsActivity.updateActionButton(icon!!, description!!)
          result.success(true)
        } else {
          result.success(false)
        }
      "validateRelationship" ->
        if (chromeCustomTabsActivity != null && chromeCustomTabsActivity.customTabsSession != null) {
          val relation = call.argument<Int>("relation")
          val origin = call.argument<String>("origin")
          result.success(chromeCustomTabsActivity.customTabsSession!!.validateRelationship(relation!!, Uri.parse(origin), null))
        } else {
          result.success(false)
        }
      "updateSecondaryToolbar" ->
        if (chromeCustomTabsActivity != null) {
          val secondaryToolbar = CustomTabsSecondaryToolbar.fromMap(call.argument<MutableMap<String, Any?>>("secondaryToolbar"))
          chromeCustomTabsActivity.updateSecondaryToolbar(secondaryToolbar)
          result.success(true)
        } else {
          result.success(false)
        }
      "requestPostMessageChannel" ->
        if (chromeCustomTabsActivity != null && chromeCustomTabsActivity.customTabsSession != null) {
          val sourceOrigin = call.argument<String>("sourceOrigin")
          val targetOrigin = call.argument<String>("targetOrigin")
          result.success(chromeCustomTabsActivity.customTabsSession!!.requestPostMessageChannel(Uri.parse(sourceOrigin),
            if (targetOrigin != null) Uri.parse(targetOrigin) else null, Bundle()))
        } else {
          result.success(false)
        }
      "postMessage" ->
        if (chromeCustomTabsActivity != null && chromeCustomTabsActivity.customTabsSession != null) {
          val message = call.argument<String>("message")
          result.success(chromeCustomTabsActivity.customTabsSession!!.postMessage(message!!, Bundle()))
        } else {
          result.success(CustomTabsService.RESULT_FAILURE_MESSAGING_ERROR)
        }
      "isEngagementSignalsApiAvailable" ->
        if (chromeCustomTabsActivity != null && chromeCustomTabsActivity.customTabsSession != null) {
          try {
            result.success(chromeCustomTabsActivity.customTabsSession!!.isEngagementSignalsApiAvailable(Bundle()))
          } catch (e: Throwable) {
            result.success(false)
          }
        } else {
          result.success(false)
        }
      "close" ->
        if (chromeCustomTabsActivity != null) {
          chromeCustomTabsActivity.onStop()
          chromeCustomTabsActivity.onDestroy()
          chromeCustomTabsActivity.close()

          if (chromeCustomTabsActivity.manager != null && chromeCustomTabsActivity.manager!!.plugin != null &&
            chromeCustomTabsActivity.manager!!.plugin!!.activity != null) {
            val activity = chromeCustomTabsActivity.manager!!.plugin!!.activity!!
            // https://stackoverflow.com/a/41596629/4637638
            val myIntent = Intent(activity, activity.javaClass)
            myIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            myIntent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
            activity.startActivity(myIntent)
          }
          chromeCustomTabsActivity.dispose()
          result.success(true)
        } else {
          result.success(false)
        }
      else -> result.notImplemented()
    }
  }

  open fun onServiceConnected() {
    val channel = this.channel ?: return
    val obj = HashMap<String, Any?>()
    channel.invokeMethod("onServiceConnected", obj)
  }

  open fun onOpened() {
    val channel = this.channel ?: return
    val obj = HashMap<String, Any?>()
    channel.invokeMethod("onOpened", obj)
  }

  open fun onCompletedInitialLoad() {
    val channel = this.channel ?: return
    val obj = HashMap<String, Any?>()
    channel.invokeMethod("onCompletedInitialLoad", obj)
  }

  open fun onNavigationEvent(navigationEvent: Int) {
    val channel = this.channel ?: return
    val obj = HashMap<String, Any?>()
    obj["navigationEvent"] = navigationEvent
    channel.invokeMethod("onNavigationEvent", obj)
  }

  open fun onClosed() {
    val channel = this.channel ?: return
    val obj = HashMap<String, Any?>()
    channel.invokeMethod("onClosed", obj)
  }

  open fun onItemActionPerform(id: Int, url: String?, title: String?) {
    val channel = this.channel ?: return
    val obj = HashMap<String, Any?>()
    obj["id"] = id
    obj["url"] = url
    obj["title"] = title
    channel.invokeMethod("onItemActionPerform", obj)
  }

  open fun onSecondaryItemActionPerform(name: String?, url: String?) {
    val channel = this.channel ?: return
    val obj = HashMap<String, Any?>()
    obj["name"] = name
    obj["url"] = url
    channel.invokeMethod("onSecondaryItemActionPerform", obj)
  }

  open fun onRelationshipValidationResult(relation: Int, requestedOrigin: Uri, result: Boolean) {
    val channel = this.channel ?: return
    val obj = HashMap<String, Any?>()
    obj["relation"] = relation
    obj["requestedOrigin"] = requestedOrigin.toString()
    obj["result"] = result
    channel.invokeMethod("onRelationshipValidationResult", obj)
  }

  open fun onMessageChannelReady() {
    val channel = this.channel ?: return
    val obj = HashMap<String, Any?>()
    channel.invokeMethod("onMessageChannelReady", obj)
  }

  open fun onPostMessage(message: String) {
    val channel = this.channel ?: return
    val obj = HashMap<String, Any?>()
    obj["message"] = message
    channel.invokeMethod("onPostMessage", obj)
  }

  open fun onVerticalScrollEvent(isDirectionUp: Boolean) {
    val channel = this.channel ?: return
    val obj = HashMap<String, Any?>()
    obj["isDirectionUp"] = isDirectionUp
    channel.invokeMethod("onVerticalScrollEvent", obj)
  }

  open fun onGreatestScrollPercentageIncreased(scrollPercentage: Int) {
    val channel = this.channel ?: return
    val obj = HashMap<String, Any?>()
    obj["scrollPercentage"] = scrollPercentage
    channel.invokeMethod("onGreatestScrollPercentageIncreased", obj)
  }

  open fun onSessionEnded(didUserInteract: Boolean) {
    val channel = this.channel ?: return
    val obj = HashMap<String, Any?>()
    obj["didUserInteract"] = didUserInteract
    channel.invokeMethod("onSessionEnded", obj)
  }

  override fun dispose() {
    super.dispose()
    chromeCustomTabsActivity = null
  }
}
