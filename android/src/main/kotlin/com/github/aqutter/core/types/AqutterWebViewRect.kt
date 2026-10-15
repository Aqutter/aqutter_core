package com.github.aqutter.core.types

import android.graphics.Rect

class AqutterWebViewRect(
  var height: Double,
  var width: Double,
  var x: Double,
  var y: Double
) {

  fun toMap(): MutableMap<String, Any?> {
    val map: MutableMap<String, Any?> = HashMap()
    map["height"] = height
    map["width"] = width
    map["x"] = x
    map["y"] = y
    return map
  }

  fun toRect(): Rect {
    return Rect(x.toInt(), y.toInt(), (x + width).toInt(), (y + height).toInt())
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as AqutterWebViewRect
    return height.compareTo(that.height) == 0 && width.compareTo(that.width) == 0 && x.compareTo(that.x) == 0 && y.compareTo(that.y) == 0
  }

  override fun hashCode(): Int {
    var result = height.hashCode()
    result = 31 * result + width.hashCode()
    result = 31 * result + x.hashCode()
    result = 31 * result + y.hashCode()
    return result
  }

  override fun toString(): String {
    return "AqutterWebViewRect{" +
      "height=" + height +
      ", width=" + width +
      ", x=" + x +
      ", y=" + y +
      '}'
  }

  companion object {
    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): AqutterWebViewRect? {
      if (map == null) {
        return null
      }
      val height = map["height"] as Double
      val width = map["width"] as Double
      val x = map["x"] as Double
      val y = map["y"] as Double
      return AqutterWebViewRect(height, width, x, y)
    }
  }
}
