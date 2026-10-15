package com.github.aqutter.core.tracing

import androidx.webkit.TracingController
import com.github.aqutter.core.ISettings

class TracingSettings : ISettings<TracingController> {
  companion object {
    const val LOG_TAG = "TracingSettings"
  }

  @JvmField
  var categories: MutableList<Any> = ArrayList()
  @JvmField
  var tracingMode: Int? = null

  override fun parse(settings: MutableMap<String, Any?>): TracingSettings {
    for (pair in settings.entries) {
      val key = pair.key
      val value = pair.value
      if (value == null) {
        continue
      }

      when (key) {
        "categories" -> categories = value as MutableList<Any>
        "tracingMode" -> tracingMode = value as Int
      }
    }

    return this
  }

  override fun toMap(): MutableMap<String, Any?> {
    val settings: MutableMap<String, Any?> = HashMap()
    settings["categories"] = categories
    settings["tracingMode"] = tracingMode
    return settings
  }

  override fun getRealSettings(obj: TracingController): MutableMap<String, Any?> {
    val realSettings = toMap()
    return realSettings
  }
}
