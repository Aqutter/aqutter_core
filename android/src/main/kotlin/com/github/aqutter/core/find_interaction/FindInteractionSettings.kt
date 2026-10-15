package com.github.aqutter.core.find_interaction

import com.github.aqutter.core.ISettings

open class FindInteractionSettings : ISettings<FindInteractionController> {

  override fun parse(settings: MutableMap<String, Any?>): FindInteractionSettings {
//    for (Map.Entry<String, Object> pair : settings.entrySet()) {
//      String key = pair.getKey();
//      Object value = pair.getValue();
//      if (value == null) {
//        continue;
//      }
//
//      switch (key) {
//
//      }
//    }

    return this
  }

  override fun toMap(): MutableMap<String, Any?> {
    val settings: MutableMap<String, Any?> = HashMap()
    return settings
  }

  override fun getRealSettings(findInteractionController: FindInteractionController): MutableMap<String, Any?> {
    val realSettings = toMap()
    return realSettings
  }

  companion object {
    const val LOG_TAG = "FindInteractionSettings"
  }
}
