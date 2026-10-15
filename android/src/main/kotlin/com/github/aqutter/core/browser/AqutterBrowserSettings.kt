package com.github.aqutter.core.browser

import com.github.aqutter.core.ISettings
import com.github.aqutter.core.R

class AqutterBrowserSettings : ISettings<AqutterBrowserActivity> {

  @JvmField var hidden: Boolean = false
  @JvmField var hideToolbarTop: Boolean = false
  @JvmField var toolbarTopBackgroundColor: String? = null
  @JvmField var toolbarTopFixedTitle: String? = null
  @JvmField var hideUrlBar: Boolean = false
  @JvmField var hideProgressBar: Boolean = false

  @JvmField var hideTitleBar: Boolean = false
  @JvmField var closeOnCannotGoBack: Boolean = true
  @JvmField var allowGoBackWithBackButton: Boolean = true
  @JvmField var shouldCloseOnBackButtonPressed: Boolean = false
  @JvmField var hideDefaultMenuItems: Boolean = false

  override fun parse(settings: MutableMap<String, Any?>): AqutterBrowserSettings {
    for (pair in settings.entries) {
      val key = pair.key
      val value = pair.value
      if (value == null) {
        continue
      }

      when (key) {
        "hidden" -> hidden = value as Boolean
        "hideToolbarTop" -> hideToolbarTop = value as Boolean
        "toolbarTopBackgroundColor" -> toolbarTopBackgroundColor = value as String
        "toolbarTopFixedTitle" -> toolbarTopFixedTitle = value as String
        "hideUrlBar" -> hideUrlBar = value as Boolean
        "hideTitleBar" -> hideTitleBar = value as Boolean
        "closeOnCannotGoBack" -> closeOnCannotGoBack = value as Boolean
        "hideProgressBar" -> hideProgressBar = value as Boolean
        "allowGoBackWithBackButton" -> allowGoBackWithBackButton = value as Boolean
        "shouldCloseOnBackButtonPressed" -> shouldCloseOnBackButtonPressed = value as Boolean
        "hideDefaultMenuItems" -> hideDefaultMenuItems = value as Boolean
      }
    }

    return this
  }

  override fun toMap(): MutableMap<String, Any?> {
    val settings: MutableMap<String, Any?> = HashMap()
    settings["hidden"] = hidden
    settings["hideToolbarTop"] = hideToolbarTop
    settings["toolbarTopBackgroundColor"] = toolbarTopBackgroundColor
    settings["toolbarTopFixedTitle"] = toolbarTopFixedTitle
    settings["hideUrlBar"] = hideUrlBar
    settings["hideTitleBar"] = hideTitleBar
    settings["closeOnCannotGoBack"] = closeOnCannotGoBack
    settings["hideProgressBar"] = hideProgressBar
    settings["allowGoBackWithBackButton"] = allowGoBackWithBackButton
    settings["shouldCloseOnBackButtonPressed"] = shouldCloseOnBackButtonPressed
    settings["hideDefaultMenuItems"] = hideDefaultMenuItems
    return settings
  }

  override fun getRealSettings(aqutterBrowserActivity: AqutterBrowserActivity): MutableMap<String, Any?> {
    val realSettings = toMap()
    realSettings["hidden"] = aqutterBrowserActivity.isHidden
    realSettings["hideToolbarTop"] = aqutterBrowserActivity.actionBar == null || !aqutterBrowserActivity.actionBar!!.isShowing
    realSettings["hideUrlBar"] = aqutterBrowserActivity.menu == null || !aqutterBrowserActivity.menu!!.findItem(R.id.menu_search).isVisible
    realSettings["hideProgressBar"] = aqutterBrowserActivity.progressBar == null || aqutterBrowserActivity.progressBar!!.max == 0
    return realSettings
  }

  companion object {
    const val LOG_TAG = "AqutterBrowserSettings"
  }
}
