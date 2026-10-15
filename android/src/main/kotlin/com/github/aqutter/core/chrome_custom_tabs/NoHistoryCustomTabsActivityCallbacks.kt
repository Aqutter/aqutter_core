package com.github.aqutter.core.chrome_custom_tabs

import android.app.Activity
import android.app.Application
import android.os.Bundle
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.types.Disposable
import io.flutter.embedding.android.FlutterActivity

open class NoHistoryCustomTabsActivityCallbacks(plugin: AqutterCorePlugin) : Disposable {
  @JvmField
  var plugin: AqutterCorePlugin? = plugin

  @JvmField
  val noHistoryBrowserIDs: MutableMap<String?, String?> = HashMap()

  @JvmField
  var activityLifecycleCallbacks: Application.ActivityLifecycleCallbacks = object : Application.ActivityLifecycleCallbacks {
    override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {
    }

    override fun onActivityStarted(activity: Activity) {
    }

    override fun onActivityResumed(activity: Activity) {
      val plugin = this@NoHistoryCustomTabsActivityCallbacks.plugin
      val manager = plugin?.chromeSafariBrowserManager
      if (activity is FlutterActivity && manager != null) {
        val browserIds = noHistoryBrowserIDs.values
        for (browserId in browserIds) {
          if (browserId != null) {
            // NOTE: 以 value 當 key 寫入 map，迭代同一 map 的 values 時可能觸發 ConcurrentModificationException（Java 原行為，保持不變）
            noHistoryBrowserIDs[browserId] = null
            val browser = manager.browsers[browserId]
            if (browser != null) {
              browser.close()
              browser.dispose()
            }
          }
        }
      }
    }

    override fun onActivityPaused(activity: Activity) {
    }

    override fun onActivityStopped(activity: Activity) {
    }

    override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {
    }

    override fun onActivityDestroyed(activity: Activity) {
    }
  }

  override fun dispose() {
    noHistoryBrowserIDs.clear()
    plugin = null
  }
}
