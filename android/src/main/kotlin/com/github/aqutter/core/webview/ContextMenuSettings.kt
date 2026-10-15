package com.github.aqutter.core.webview

import com.github.aqutter.core.ISettings

class ContextMenuSettings : ISettings<Any> {
  companion object {
    const val LOG_TAG = "ContextMenuOptions"
  }

  @JvmField
  var hideDefaultSystemContextMenuItems: Boolean? = false

  override fun parse(options: MutableMap<String, Any?>): ContextMenuSettings {
    for (pair in options.entries) {
      val key = pair.key
      val value = pair.value
      if (value == null) {
        continue
      }

      when (key) {
        "hideDefaultSystemContextMenuItems" -> hideDefaultSystemContextMenuItems = value as Boolean
      }
    }

    return this
  }

  override fun toMap(): MutableMap<String, Any?> {
    val options: MutableMap<String, Any?> = HashMap()
    options["hideDefaultSystemContextMenuItems"] = hideDefaultSystemContextMenuItems
    return options
  }

  override fun getRealSettings(obj: Any): MutableMap<String, Any?> {
    val realOptions = toMap()
    return realOptions
  }
}
