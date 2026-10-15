package com.github.aqutter.core.chrome_custom_tabs

import android.content.Intent
import android.graphics.Color
import android.net.Uri
import androidx.browser.customtabs.CustomTabColorSchemeParams
import androidx.browser.customtabs.CustomTabsIntent
import androidx.browser.trusted.TrustedWebActivityIntent
import androidx.browser.trusted.TrustedWebActivityIntentBuilder

open class TrustedWebActivity : ChromeCustomTabsActivity() {

  lateinit var twaBuilder: TrustedWebActivityIntentBuilder

  override fun launchUrl(
    url: String,
    headers: Map<String, String>?,
    referrer: String?,
    otherLikelyURLs: List<String>?
  ) {
    val customTabsSession = this.customTabsSession
    if (customTabsSession == null) {
      return
    }
    val uri = Uri.parse(url)

    mayLaunchUrl(url, otherLikelyURLs)
    twaBuilder = TrustedWebActivityIntentBuilder(uri)
    prepareCustomTabs()

    val trustedWebActivityIntent = twaBuilder.build(customTabsSession)
    prepareCustomTabsIntent(trustedWebActivityIntent)

    CustomTabActivityHelper.openTrustedWebActivity(
      this, trustedWebActivityIntent, uri, headers,
      if (referrer != null) Uri.parse(referrer) else null, CHROME_CUSTOM_TAB_REQUEST_CODE
    )
  }

  private fun prepareCustomTabs() {
    val defaultColorSchemeBuilder = CustomTabColorSchemeParams.Builder()
    val toolbarBackgroundColor = customSettings.toolbarBackgroundColor
    if (toolbarBackgroundColor != null && !toolbarBackgroundColor.isEmpty()) {
      defaultColorSchemeBuilder.setToolbarColor(Color.parseColor(toolbarBackgroundColor))
    }
    val navigationBarColor = customSettings.navigationBarColor
    if (navigationBarColor != null && !navigationBarColor.isEmpty()) {
      defaultColorSchemeBuilder.setNavigationBarColor(Color.parseColor(navigationBarColor))
    }
    val navigationBarDividerColor = customSettings.navigationBarDividerColor
    if (navigationBarDividerColor != null && !navigationBarDividerColor.isEmpty()) {
      defaultColorSchemeBuilder.setNavigationBarDividerColor(Color.parseColor(navigationBarDividerColor))
    }
    val secondaryToolbarColor = customSettings.secondaryToolbarColor
    if (secondaryToolbarColor != null && !secondaryToolbarColor.isEmpty()) {
      defaultColorSchemeBuilder.setSecondaryToolbarColor(Color.parseColor(secondaryToolbarColor))
    }
    twaBuilder.setDefaultColorSchemeParams(defaultColorSchemeBuilder.build())

    if (customSettings.additionalTrustedOrigins != null && !customSettings.additionalTrustedOrigins.isEmpty()) {
      twaBuilder.setAdditionalTrustedOrigins(customSettings.additionalTrustedOrigins)
    }

    val displayMode = customSettings.displayMode
    if (displayMode != null) {
      twaBuilder.setDisplayMode(displayMode)
    }

    twaBuilder.setScreenOrientation(customSettings.screenOrientation)
  }

  private fun prepareCustomTabsIntent(trustedWebActivityIntent: TrustedWebActivityIntent) {
    val intent: Intent = trustedWebActivityIntent.intent
    if (customSettings.packageName != null) {
      intent.setPackage(customSettings.packageName)
    } else {
      intent.setPackage(CustomTabsHelper.getPackageNameToUse(this))
    }

    if (customSettings.keepAliveEnabled) {
      CustomTabsHelper.addKeepAliveExtra(this, intent)
    }

    if (customSettings.alwaysUseBrowserUI) {
      CustomTabsIntent.setAlwaysUseBrowserUI(intent)
    }
  }

  companion object {
    protected const val LOG_TAG = "TrustedWebActivity"
  }
}
