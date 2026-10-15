package com.github.aqutter.core.types

import java.util.Arrays

class CustomTabsActionButton(
  var id: Int,
  var icon: ByteArray,
  var description: String,
  var isShouldTint: Boolean
) {
  companion object {
    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): CustomTabsActionButton? {
      if (map == null) {
        return null
      }
      val id = map["id"] as Int
      val icon = map["icon"] as ByteArray
      val description = map["description"] as String
      val shouldTint = map["shouldTint"] as Boolean
      return CustomTabsActionButton(id, icon, description, shouldTint)
    }
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as CustomTabsActionButton

    if (id != that.id) return false
    if (isShouldTint != that.isShouldTint) return false
    if (!Arrays.equals(icon, that.icon)) return false
    return description == that.description
  }

  override fun hashCode(): Int {
    var result = id
    result = 31 * result + Arrays.hashCode(icon)
    result = 31 * result + description.hashCode()
    result = 31 * result + (if (isShouldTint) 1 else 0)
    return result
  }

  override fun toString(): String {
    return "CustomTabsActionButton{" +
      "id=" + id +
      ", icon=" + Arrays.toString(icon) +
      ", description='" + description + '\'' +
      ", shouldTint=" + isShouldTint +
      '}'
  }
}
