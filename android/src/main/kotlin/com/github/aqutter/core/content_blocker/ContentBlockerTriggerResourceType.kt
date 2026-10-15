package com.github.aqutter.core.content_blocker

enum class ContentBlockerTriggerResourceType(private val value: String) {
  DOCUMENT("document"),
  IMAGE("image"),
  STYLE_SHEET("style-sheet"),
  SCRIPT("script"),
  FONT("font"),
  SVG_DOCUMENT("svg-document"),
  MEDIA("media"),
  POPUP("popup"),
  RAW("raw");

  fun equalsValue(otherValue: String?): Boolean {
    return value == otherValue
  }

  override fun toString(): String {
    return this.value
  }

  companion object {
    @JvmStatic
    fun fromValue(value: String): ContentBlockerTriggerResourceType {
      for (type in values()) {
        if (value == type.value)
          return type
      }
      throw IllegalArgumentException("No enum constant: " + value)
    }
  }
}
