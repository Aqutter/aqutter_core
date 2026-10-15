package com.github.aqutter.core.types

import android.os.Build
import android.print.PrintAttributes
import androidx.annotation.RequiresApi

@RequiresApi(api = Build.VERSION_CODES.KITKAT)
class MarginsExt() {
  var top: Double = 0.0
  var right: Double = 0.0
  var bottom: Double = 0.0
  var left: Double = 0.0

  constructor(top: Double, right: Double, bottom: Double, left: Double) : this() {
    this.top = top
    this.right = right
    this.bottom = bottom
    this.left = left
  }

  fun toMargins(): PrintAttributes.Margins {
    return PrintAttributes.Margins(
      pixelsToMils(left),
      pixelsToMils(top),
      pixelsToMils(right),
      pixelsToMils(bottom)
    )
  }

  fun toMap(): MutableMap<String, Any?> {
    val obj: MutableMap<String, Any?> = HashMap()
    obj["top"] = top
    obj["right"] = right
    obj["bottom"] = bottom
    obj["left"] = left
    return obj
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as MarginsExt

    if (that.top.compareTo(top) != 0) return false
    if (that.right.compareTo(right) != 0) return false
    if (that.bottom.compareTo(bottom) != 0) return false
    return that.left.compareTo(left) == 0
  }

  override fun hashCode(): Int {
    var result: Int
    var temp: Long
    temp = top.toBits()
    result = (temp xor (temp ushr 32)).toInt()
    temp = right.toBits()
    result = 31 * result + (temp xor (temp ushr 32)).toInt()
    temp = bottom.toBits()
    result = 31 * result + (temp xor (temp ushr 32)).toInt()
    temp = left.toBits()
    result = 31 * result + (temp xor (temp ushr 32)).toInt()
    return result
  }

  override fun toString(): String {
    return "MarginsExt{" +
      "top=" + top +
      ", right=" + right +
      ", bottom=" + bottom +
      ", left=" + left +
      '}'
  }

  companion object {
    @JvmStatic
    fun fromMargins(margins: PrintAttributes.Margins?): MarginsExt? {
      if (margins == null) {
        return null
      }
      val marginsExt = MarginsExt()
      marginsExt.top = milsToPixels(margins.topMils)
      marginsExt.right = milsToPixels(margins.rightMils)
      marginsExt.bottom = milsToPixels(margins.bottomMils)
      marginsExt.left = milsToPixels(margins.leftMils)
      return marginsExt
    }

    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): MarginsExt? {
      if (map == null) {
        return null
      }
      return MarginsExt(
        map["top"] as Double,
        map["right"] as Double,
        map["bottom"] as Double,
        map["left"] as Double
      )
    }

    // from mils to pixels
    private fun milsToPixels(mils: Int): Double {
      return mils * 0.09600001209449
    }

    // from pixels to mils
    private fun pixelsToMils(pixels: Double): Int {
      return Math.round(pixels * 10.416665354331).toInt()
    }
  }
}
