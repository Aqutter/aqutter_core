package com.github.aqutter.core.types

import com.github.aqutter.core.Util
import java.util.Objects

class AqutterBrowserMenuItem(
  var id: Int,
  var title: String,
  var order: Int?,
  var icon: Any?,
  var iconColor: String?,
  var isShowAsAction: Boolean
) {

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as AqutterBrowserMenuItem

    if (id != that.id) return false
    if (isShowAsAction != that.isShowAsAction) return false
    if (title != that.title) return false
    if (!Objects.equals(order, that.order)) return false
    if (!Objects.equals(icon, that.icon)) return false
    return Objects.equals(iconColor, that.iconColor)
  }

  override fun hashCode(): Int {
    var result = id
    result = 31 * result + title.hashCode()
    result = 31 * result + (if (order != null) order.hashCode() else 0)
    result = 31 * result + (if (icon != null) icon.hashCode() else 0)
    result = 31 * result + (if (iconColor != null) iconColor.hashCode() else 0)
    result = 31 * result + (if (isShowAsAction) 1 else 0)
    return result
  }

  override fun toString(): String {
    return "AqutterBrowserMenuItem{" +
      "id=" + id +
      ", title='" + title + '\'' +
      ", order=" + order +
      ", icon=" + icon +
      ", iconColor='" + iconColor + '\'' +
      ", showAsAction=" + isShowAsAction +
      '}'
  }

  companion object {
    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun fromMap(map: MutableMap<String, Any?>?): AqutterBrowserMenuItem? {
      if (map == null) {
        return null
      }
      val id = map["id"] as Int
      val title = map["title"] as String
      val order = map["order"] as Int?
      var icon = map["icon"]
      if (icon is Map<*, *>) {
        icon = AndroidResource.fromMap(map["icon"] as MutableMap<String, Any?>?)
      } else if (icon !is ByteArray) {
        icon = null
      }
      val iconColor = map["iconColor"] as String?
      val showAsAction: Boolean = Util.getOrDefault(map, "showAsAction", false)
      return AqutterBrowserMenuItem(id, title, order, icon, iconColor, showAsAction)
    }
  }
}
