package com.github.aqutter.core.types

import android.os.Build
import android.print.PrintAttributes
import androidx.annotation.RequiresApi

@RequiresApi(api = Build.VERSION_CODES.KITKAT)
class MediaSizeExt(
  var id: String,
  var label: String?,
  var widthMils: Int,
  var heightMils: Int
) {

  fun toMediaSize(): PrintAttributes.MediaSize {
    return PrintAttributes.MediaSize(
      id, "Custom", widthMils, heightMils
    )
  }

  fun toMap(): MutableMap<String, Any?> {
    val obj: MutableMap<String, Any?> = HashMap()
    obj["id"] = id
    obj["label"] = label
    obj["heightMils"] = heightMils
    obj["widthMils"] = widthMils
    return obj
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as MediaSizeExt

    if (widthMils != that.widthMils) return false
    if (heightMils != that.heightMils) return false
    if (id != that.id) return false
    return if (label != null) label == that.label else that.label == null
  }

  override fun hashCode(): Int {
    var result = id.hashCode()
    result = 31 * result + (if (label != null) label.hashCode() else 0)
    result = 31 * result + widthMils
    result = 31 * result + heightMils
    return result
  }

  override fun toString(): String {
    return "MediaSizeExt{" +
      "id='" + id + '\'' +
      ", label='" + label + '\'' +
      ", widthMils=" + widthMils +
      ", heightMils=" + heightMils +
      '}'
  }

  companion object {
    @JvmStatic
    fun fromMediaSize(mediaSize: PrintAttributes.MediaSize?): MediaSizeExt? {
      if (mediaSize == null) {
        return null
      }
      return MediaSizeExt(
        mediaSize.id,
        null,
        mediaSize.heightMils,
        mediaSize.widthMils
      )
    }

    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): MediaSizeExt? {
      if (map == null) {
        return null
      }
      val id = map["id"] as String
      val label = map["label"] as String?
      val widthMils = map["widthMils"] as Int
      val heightMils = map["heightMils"] as Int
      return MediaSizeExt(id, label, widthMils, heightMils)
    }
  }
}
