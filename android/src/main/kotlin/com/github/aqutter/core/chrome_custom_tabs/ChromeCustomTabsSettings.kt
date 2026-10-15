package com.github.aqutter.core.chrome_custom_tabs

import androidx.browser.customtabs.CustomTabsIntent
import androidx.browser.trusted.ScreenOrientation
import androidx.browser.trusted.TrustedWebActivityDisplayMode
import com.github.aqutter.core.ISettings
import com.github.aqutter.core.types.AndroidResource

open class ChromeCustomTabsSettings : ISettings<ChromeCustomTabsActivity> {

  @Deprecated("Deprecated in Java")
  @JvmField
  var addDefaultShareMenuItem: Boolean? = null
  @JvmField
  var shareState: Int = CustomTabsIntent.SHARE_STATE_DEFAULT
  @JvmField
  var showTitle: Boolean = true
  @JvmField
  var toolbarBackgroundColor: String? = null
  @JvmField
  var navigationBarColor: String? = null
  @JvmField
  var navigationBarDividerColor: String? = null
  @JvmField
  var secondaryToolbarColor: String? = null
  @JvmField
  var enableUrlBarHiding: Boolean = false
  @JvmField
  var instantAppsEnabled: Boolean = false
  @JvmField
  var packageName: String? = null
  @JvmField
  var keepAliveEnabled: Boolean = false
  @JvmField
  var isSingleInstance: Boolean = false
  @JvmField
  var noHistory: Boolean = false
  @JvmField
  var isTrustedWebActivity: Boolean = false
  @JvmField
  var additionalTrustedOrigins: MutableList<String> = ArrayList()
  @JvmField
  var displayMode: TrustedWebActivityDisplayMode? = null
  @JvmField
  var screenOrientation: Int = ScreenOrientation.DEFAULT
  @JvmField
  var startAnimations: MutableList<AndroidResource> = ArrayList()
  @JvmField
  var exitAnimations: MutableList<AndroidResource> = ArrayList()
  @JvmField
  var alwaysUseBrowserUI: Boolean = false

  @Suppress("UNCHECKED_CAST", "DEPRECATION")
  override fun parse(options: MutableMap<String, Any?>): ChromeCustomTabsSettings {
    for (pair in options.entries) {
      val key = pair.key
      val value = pair.value
      if (value == null) {
        continue
      }

      when (key) {
        "addDefaultShareMenuItem" ->
          addDefaultShareMenuItem = value as Boolean
        "shareState" ->
          shareState = value as Int
        "showTitle" ->
          showTitle = value as Boolean
        "toolbarBackgroundColor" ->
          toolbarBackgroundColor = value as String
        "navigationBarColor" ->
          navigationBarColor = value as String
        "navigationBarDividerColor" ->
          navigationBarDividerColor = value as String
        "secondaryToolbarColor" ->
          secondaryToolbarColor = value as String
        "enableUrlBarHiding" ->
          enableUrlBarHiding = value as Boolean
        "instantAppsEnabled" ->
          instantAppsEnabled = value as Boolean
        "packageName" ->
          packageName = value as String
        "keepAliveEnabled" ->
          keepAliveEnabled = value as Boolean
        "isSingleInstance" ->
          isSingleInstance = value as Boolean
        "noHistory" ->
          noHistory = value as Boolean
        "isTrustedWebActivity" ->
          isTrustedWebActivity = value as Boolean
        "additionalTrustedOrigins" ->
          additionalTrustedOrigins = value as MutableList<String>
        "displayMode" -> {
          val displayModeMap = value as Map<String, Any?>
          val displayModeType = displayModeMap.get("type") as String?
          if (displayModeType != null) {
            when (displayModeType) {
              "IMMERSIVE_MODE" -> {
                val isSticky = displayModeMap.get("isSticky") as Boolean
                val layoutInDisplayCutoutMode = displayModeMap.get("displayCutoutMode") as Int
                displayMode = TrustedWebActivityDisplayMode.ImmersiveMode(isSticky, layoutInDisplayCutoutMode)
              }
              "DEFAULT_MODE" ->
                displayMode = TrustedWebActivityDisplayMode.DefaultMode()
            }
          }
        }
        "screenOrientation" ->
          screenOrientation = value as Int
        "startAnimations" -> {
          val startAnimationsList = value as List<MutableMap<String, Any?>>
          for (startAnimation in startAnimationsList) {
            val androidResource = AndroidResource.fromMap(startAnimation)
            if (androidResource != null) {
              startAnimations.add(AndroidResource.fromMap(startAnimation)!!)
            }
          }
        }
        "exitAnimations" -> {
          val exitAnimationsList = value as List<MutableMap<String, Any?>>
          for (exitAnimation in exitAnimationsList) {
            val androidResource = AndroidResource.fromMap(exitAnimation)
            if (androidResource != null) {
              exitAnimations.add(AndroidResource.fromMap(exitAnimation)!!)
            }
          }
        }
        "alwaysUseBrowserUI" ->
          alwaysUseBrowserUI = value as Boolean
      }
    }

    return this
  }

  @Suppress("DEPRECATION")
  override fun toMap(): MutableMap<String, Any?> {
    val options = HashMap<String, Any?>()
    options["addDefaultShareMenuItem"] = addDefaultShareMenuItem
    options["showTitle"] = showTitle
    options["toolbarBackgroundColor"] = toolbarBackgroundColor
    options["navigationBarColor"] = navigationBarColor
    options["navigationBarDividerColor"] = navigationBarDividerColor
    options["secondaryToolbarColor"] = secondaryToolbarColor
    options["enableUrlBarHiding"] = enableUrlBarHiding
    options["instantAppsEnabled"] = instantAppsEnabled
    options["packageName"] = packageName
    options["keepAliveEnabled"] = keepAliveEnabled
    options["isSingleInstance"] = isSingleInstance
    options["noHistory"] = noHistory
    options["isTrustedWebActivity"] = isTrustedWebActivity
    options["additionalTrustedOrigins"] = additionalTrustedOrigins
    options["screenOrientation"] = screenOrientation
    options["alwaysUseBrowserUI"] = alwaysUseBrowserUI
    return options
  }

  override fun getRealSettings(obj: ChromeCustomTabsActivity): MutableMap<String, Any?> {
    val realOptions = toMap()
    val intent = obj.intent
    if (intent != null) {
      realOptions["packageName"] = intent.getPackage()
      realOptions["keepAliveEnabled"] = intent.hasExtra(CustomTabsHelper.EXTRA_CUSTOM_TABS_KEEP_ALIVE)
    }
    return realOptions
  }

  companion object {
    const val LOG_TAG = "ChromeCustomTabsSettings" // package-private in Java
  }
}
