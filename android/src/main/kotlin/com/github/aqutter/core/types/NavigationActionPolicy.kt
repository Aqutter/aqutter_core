package com.github.aqutter.core.types

enum class NavigationActionPolicy(private val value: Int) {
  CANCEL(0),
  ALLOW(1);

  fun equalsValue(otherValue: Int): Boolean {
    return value == otherValue
  }

  fun rawValue(): Int {
    return this.value
  }

  override fun toString(): String {
    return this.value.toString()
  }

  companion object {
    @JvmStatic
    fun fromValue(value: Int): NavigationActionPolicy {
      for (type in values()) {
        if (value == type.value)
          return type
      }
      throw IllegalArgumentException("No enum constant: " + value)
    }
  }
}
