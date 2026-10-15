package com.github.aqutter.core.types

class CustomTabsMenuItem(
  var id: Int,
  var label: String
) {
  companion object {
    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): CustomTabsMenuItem? {
      if (map == null) {
        return null
      }
      val id = map["id"] as Int
      val label = map["label"] as String
      return CustomTabsMenuItem(id, label)
    }
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as CustomTabsMenuItem

    if (id != that.id) return false
    return label == that.label
  }

  override fun hashCode(): Int {
    var result = id
    result = 31 * result + label.hashCode()
    return result
  }

  override fun toString(): String {
    return "CustomTabsMenuItem{" +
      "id=" + id +
      ", label='" + label + '\'' +
      '}'
  }
}
