package com.github.aqutter.core.types

import java.util.HashMap

class Size2D(var width: Double, var height: Double) {
  companion object {
    @JvmStatic
    fun fromMap(map: Map<String, Any?>?): Size2D? {
      if (map == null) {
        return null
      }
      val width = map["width"] as Double?
      val height = map["height"] as Double?
      assert(width != null)
      assert(height != null)
      return Size2D(width!!, height!!)
    }
  }

  fun toMap(): MutableMap<String, Any?> {
    val sizeMap: MutableMap<String, Any?> = HashMap()
    sizeMap["width"] = width
    sizeMap["height"] = height
    return sizeMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val size = other as Size2D

    if (java.lang.Double.compare(size.width, width) != 0) return false
    return java.lang.Double.compare(size.height, height) == 0
  }

  override fun hashCode(): Int {
    var result: Int
    var temp: Long
    temp = java.lang.Double.doubleToLongBits(width)
    result = (temp xor (temp ushr 32)).toInt()
    temp = java.lang.Double.doubleToLongBits(height)
    result = 31 * result + (temp xor (temp ushr 32)).toInt()
    return result
  }

  override fun toString(): String {
    return "Size{" +
      "width=" + width +
      ", height=" + height +
      '}'
  }
}
