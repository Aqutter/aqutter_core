package com.github.aqutter.core.content_blocker

enum class ContentBlockerActionType(private val value: String) {
  BLOCK("block"),
  CSS_DISPLAY_NONE("css-display-none"),
  MAKE_HTTPS("make-https");

  fun equalsValue(otherValue: String?): Boolean {
    return value == otherValue
  }

  override fun toString(): String {
    return this.value
  }

  companion object {
    @JvmStatic
    fun fromValue(value: String): ContentBlockerActionType {
      for (type in values()) {
        if (value == type.value)
          return type
      }
      throw IllegalArgumentException("No enum constant: " + value)
    }
  }
}
