package com.github.aqutter.core.types

enum class PreferredContentModeOptionType(private val value: Int) {
  RECOMMENDED(0),
  MOBILE(1),
  DESKTOP(2);

  fun equalsValue(otherValue: Int): Boolean {
    return value == otherValue
  }

  fun toValue(): Int {
    return this.value
  }

  companion object {
    @JvmStatic
    fun fromValue(value: Int): PreferredContentModeOptionType {
      for (type in values()) {
        if (value == type.toValue())
          return type
      }
      throw IllegalArgumentException("No enum constant: " + value)
    }
  }
}
