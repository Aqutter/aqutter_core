package com.github.aqutter.core.types

class CustomTabsSecondaryToolbar(
  var layout: AndroidResource,
  var clickableIDs: MutableList<AndroidResource>
) {

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as CustomTabsSecondaryToolbar

    if (layout != that.layout) return false
    return clickableIDs == that.clickableIDs
  }

  override fun hashCode(): Int {
    var result = layout.hashCode()
    result = 31 * result + clickableIDs.hashCode()
    return result
  }

  override fun toString(): String {
    return "CustomTabsSecondaryToolbar{" +
      "layout=" + layout +
      ", clickableIDs=" + clickableIDs +
      '}'
  }

  companion object {
    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun fromMap(map: MutableMap<String, Any?>?): CustomTabsSecondaryToolbar? {
      if (map == null) {
        return null
      }
      // NOTE: AndroidResource.fromMap may return null; Java passed it through to a @NonNull parameter, Kotlin throws NPE here
      val layout = AndroidResource.fromMap(map["layout"] as MutableMap<String, Any?>?)!!
      val clickableIDs: MutableList<AndroidResource> = ArrayList()
      val clickableIDList = map["clickableIDs"] as MutableList<MutableMap<String, Any?>>?
      if (clickableIDList != null) {
        for (clickableIDMap in clickableIDList) {
          val clickableID = AndroidResource.fromMap(clickableIDMap["id"] as MutableMap<String, Any?>?)
          if (clickableID != null) {
            clickableIDs.add(clickableID)
          }
        }
      }
      return CustomTabsSecondaryToolbar(layout, clickableIDs)
    }
  }
}
