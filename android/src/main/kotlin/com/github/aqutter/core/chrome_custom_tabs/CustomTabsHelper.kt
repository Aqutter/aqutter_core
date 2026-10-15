package com.github.aqutter.core.chrome_custom_tabs

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.content.pm.ResolveInfo
import android.net.Uri
import android.os.Build
import android.text.TextUtils
import android.util.Log
import androidx.browser.customtabs.CustomTabsService

/**
 * Helper class for Custom Tabs.
 */
open class CustomTabsHelper private constructor() {
  companion object {
    protected const val TAG = "CustomTabsHelper"
    const val STABLE_PACKAGE = "com.android.chrome" // package-private in Java
    const val BETA_PACKAGE = "com.chrome.beta" // package-private in Java
    const val DEV_PACKAGE = "com.chrome.dev" // package-private in Java
    const val LOCAL_PACKAGE = "com.google.android.apps.chrome" // package-private in Java
    const val EXTRA_CUSTOM_TABS_KEEP_ALIVE = "android.support.customtabs.extra.KEEP_ALIVE"

    private var sPackageNameToUse: String? = null

    @JvmStatic
    fun addKeepAliveExtra(context: Context, intent: Intent) {
      val keepAliveIntent = Intent().setClassName(
        context.packageName, KeepAliveService::class.java.canonicalName
      )
      intent.putExtra(EXTRA_CUSTOM_TABS_KEEP_ALIVE, keepAliveIntent)
    }

    /**
     * Goes through all apps that handle VIEW intents and have a warmup service. Picks
     * the one chosen by the user if there is one, otherwise makes a best effort to return a
     * valid package name.
     *
     * This is <strong>not</strong> threadsafe.
     *
     * @param context {@link Context} to use for accessing {@link PackageManager}.
     * @return The package name recommended to use for connecting to custom tabs related components.
     */
    @JvmStatic
    fun getPackageNameToUse(context: Context): String? {
      if (sPackageNameToUse != null) return sPackageNameToUse

      val pm = context.packageManager
      // Get default VIEW intent handler.
      val activityIntent = Intent(Intent.ACTION_VIEW, Uri.parse("http://www.example.com"))
      activityIntent.addCategory(Intent.CATEGORY_BROWSABLE)
      val defaultViewHandlerInfo = pm.resolveActivity(activityIntent, 0)
      var defaultViewHandlerPackageName: String? = null
      if (defaultViewHandlerInfo != null) {
        defaultViewHandlerPackageName = defaultViewHandlerInfo.activityInfo.packageName
      }

      // Get all apps that can handle VIEW intents.
      var flags = 0
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        flags = flags or PackageManager.MATCH_ALL
      }
      val resolvedActivityList = pm.queryIntentActivities(activityIntent, flags)
      val packagesSupportingCustomTabs: MutableList<String> = ArrayList()
      for (info in resolvedActivityList) {
        val serviceIntent = Intent()
        serviceIntent.setAction(CustomTabsService.ACTION_CUSTOM_TABS_CONNECTION)
        serviceIntent.setPackage(info.activityInfo.packageName)
        if (pm.resolveService(serviceIntent, 0) != null) {
          packagesSupportingCustomTabs.add(info.activityInfo.packageName)
        }
      }

      // Now packagesSupportingCustomTabs contains all apps that can handle both VIEW intents
      // and service calls.
      if (packagesSupportingCustomTabs.isEmpty()) {
        sPackageNameToUse = null
      } else if (packagesSupportingCustomTabs.size == 1) {
        sPackageNameToUse = packagesSupportingCustomTabs[0]
      } else if (!TextUtils.isEmpty(defaultViewHandlerPackageName)
        && !hasSpecializedHandlerIntents(context, activityIntent)
        && packagesSupportingCustomTabs.contains(defaultViewHandlerPackageName)
      ) {
        sPackageNameToUse = defaultViewHandlerPackageName
      } else if (packagesSupportingCustomTabs.contains(STABLE_PACKAGE)) {
        sPackageNameToUse = STABLE_PACKAGE
      } else if (packagesSupportingCustomTabs.contains(BETA_PACKAGE)) {
        sPackageNameToUse = BETA_PACKAGE
      } else if (packagesSupportingCustomTabs.contains(DEV_PACKAGE)) {
        sPackageNameToUse = DEV_PACKAGE
      } else if (packagesSupportingCustomTabs.contains(LOCAL_PACKAGE)) {
        sPackageNameToUse = LOCAL_PACKAGE
      }
      return sPackageNameToUse
    }

    /**
     * Used to check whether there is a specialized handler for a given intent.
     * @param intent The intent to check with.
     * @return Whether there is a specialized handler for the given intent.
     */
    private fun hasSpecializedHandlerIntents(context: Context, intent: Intent): Boolean {
      try {
        val pm = context.packageManager
        val handlers = pm.queryIntentActivities(
          intent,
          PackageManager.GET_RESOLVED_FILTER
        )
        if (handlers == null || handlers.size == 0) {
          return false
        }
        for (resolveInfo in handlers) {
          val filter = resolveInfo.filter
          if (filter == null) continue
          if (filter.countDataAuthorities() == 0 || filter.countDataPaths() == 0) continue
          if (resolveInfo.activityInfo == null) continue
          return true
        }
      } catch (e: RuntimeException) {
        Log.e(TAG, "Runtime exception while getting specialized handlers")
      }
      return false
    }

    /**
     * @return All possible chrome package names that provide custom tabs feature.
     */
    @JvmStatic
    fun getPackages(): Array<String> {
      return arrayOf("", STABLE_PACKAGE, BETA_PACKAGE, DEV_PACKAGE, LOCAL_PACKAGE)
    }
  }
}
