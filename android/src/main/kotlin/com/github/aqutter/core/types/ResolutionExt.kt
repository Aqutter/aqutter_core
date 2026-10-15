package com.github.aqutter.core.types

import android.os.Build
import android.print.PrintAttributes
import androidx.annotation.RequiresApi

@RequiresApi(api = Build.VERSION_CODES.KITKAT)
class ResolutionExt(
  var id: String,
  var label: String,
  var verticalDpi: Int,
  var horizontalDpi: Int
) {

  fun toResolution(): PrintAttributes.Resolution {
    return PrintAttributes.Resolution(
      id, label, horizontalDpi, verticalDpi
    )
  }

  fun toMap(): MutableMap<String, Any?> {
    val obj: MutableMap<String, Any?> = HashMap()
    obj["id"] = id
    obj["label"] = label
    obj["verticalDpi"] = verticalDpi
    obj["horizontalDpi"] = horizontalDpi
    return obj
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as ResolutionExt

    if (verticalDpi != that.verticalDpi) return false
    if (horizontalDpi != that.horizontalDpi) return false
    if (id != that.id) return false
    return label == that.label
  }

  override fun hashCode(): Int {
    var result = id.hashCode()
    result = 31 * result + label.hashCode()
    result = 31 * result + verticalDpi
    result = 31 * result + horizontalDpi
    return result
  }

  override fun toString(): String {
    return "ResolutionExt{" +
      "id='" + id + '\'' +
      ", label='" + label + '\'' +
      ", verticalDpi=" + verticalDpi +
      ", horizontalDpi=" + horizontalDpi +
      '}'
  }

  companion object {
    @JvmStatic
    fun fromResolution(resolution: PrintAttributes.Resolution?): ResolutionExt? {
      if (resolution == null) {
        return null
      }
      return ResolutionExt(
        resolution.id,
        resolution.label,
        resolution.verticalDpi,
        resolution.horizontalDpi
      )
    }

    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): ResolutionExt? {
      if (map == null) {
        return null
      }
      val id = map["id"] as String
      val label = map["label"] as String
      val verticalDpi = map["verticalDpi"] as Int
      val horizontalDpi = map["horizontalDpi"] as Int
      return ResolutionExt(id, label, verticalDpi, horizontalDpi)
    }
  }
}
