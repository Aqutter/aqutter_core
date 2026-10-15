package com.github.aqutter.core.types

enum class UserScriptInjectionTime(private val value: Int) {
  AT_DOCUMENT_START(0),
  AT_DOCUMENT_END(1);

  fun equalsValue(otherValue: Int): Boolean {
    return value == otherValue
  }

  fun toValue(): Int {
    return this.value
  }

  companion object {
    @JvmStatic
    fun fromValue(value: Int): UserScriptInjectionTime {
      for (type in values()) {
        if (value == type.toValue())
          return type
      }
      throw IllegalArgumentException("No enum constant: " + value)
    }
  }
}
