package com.github.aqutter.core.chrome_custom_tabs

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.browser.customtabs.CustomTabsIntent

open class ActionBroadcastReceiver : BroadcastReceiver() {

  override fun onReceive(context: Context, intent: Intent) {
    val clickedId = intent.getIntExtra(CustomTabsIntent.EXTRA_REMOTEVIEWS_CLICKED_ID, -1)
    val url = intent.dataString
    if (url != null) {
      val b = intent.extras!!
      val viewId = b.getString(KEY_ACTION_VIEW_ID)
      val managerId = b.getString(KEY_ACTION_MANAGER_ID)

      if (managerId != null) {
        val chromeSafariBrowserManager = ChromeSafariBrowserManager.shared.get(managerId)
        if (chromeSafariBrowserManager != null) {
          if (clickedId == -1) {
            val id = b.getInt(KEY_ACTION_ID)
            val title = b.getString(KEY_URL_TITLE)

            val browser = chromeSafariBrowserManager.browsers.get(viewId)
            if (browser != null && browser.channelDelegate != null) {
              browser.channelDelegate?.onItemActionPerform(id, url, title)
            }
          } else {
            val browser = chromeSafariBrowserManager.browsers.get(viewId)
            if (browser != null && browser.channelDelegate != null) {
              browser.channelDelegate?.onSecondaryItemActionPerform(browser.resources.getResourceName(clickedId), url)
            }
          }
        }
      }
    }
  }

  companion object {
    protected const val LOG_TAG = "ActionBroadcastReceiver"
    const val KEY_ACTION_ID = "com.github.aqutter.ChromeCustomTabs.ACTION_ID"
    const val KEY_ACTION_VIEW_ID = "com.github.aqutter.ChromeCustomTabs.ACTION_VIEW_ID"
    const val KEY_ACTION_MANAGER_ID = "com.github.aqutter.ChromeCustomTabs.ACTION_MANAGER_ID"
    const val KEY_URL_TITLE = "android.intent.extra.SUBJECT"
  }
}
