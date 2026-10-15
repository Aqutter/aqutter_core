package com.github.aqutter.core.pull_to_refresh

import com.github.aqutter.core.ISettings

class PullToRefreshSettings : ISettings<PullToRefreshLayout> {
  companion object {
    const val LOG_TAG = "PullToRefreshSettings"
  }

  @JvmField
  var enabled: Boolean? = true
  @JvmField
  var color: String? = null
  @JvmField
  var backgroundColor: String? = null
  @JvmField
  var distanceToTriggerSync: Int? = null
  @JvmField
  var slingshotDistance: Int? = null
  @JvmField
  var size: Int? = null

  override fun parse(settings: MutableMap<String, Any?>): PullToRefreshSettings {
    for (pair in settings.entries) {
      val key = pair.key
      val value = pair.value
      if (value == null) {
        continue
      }

      when (key) {
        "enabled" -> enabled = value as Boolean
        "color" -> color = value as String
        "backgroundColor" -> backgroundColor = value as String
        "distanceToTriggerSync" -> distanceToTriggerSync = value as Int
        "slingshotDistance" -> slingshotDistance = value as Int
        "size" -> size = value as Int
      }
    }

    return this
  }

  override fun toMap(): MutableMap<String, Any?> {
    val settings: MutableMap<String, Any?> = HashMap()
    settings["enabled"] = enabled
    settings["color"] = color
    settings["backgroundColor"] = backgroundColor
    settings["distanceToTriggerSync"] = distanceToTriggerSync
    settings["slingshotDistance"] = slingshotDistance
    settings["size"] = size
    return settings
  }

  override fun getRealSettings(obj: PullToRefreshLayout): MutableMap<String, Any?> {
    val realSettings = toMap()
    return realSettings
  }
}
