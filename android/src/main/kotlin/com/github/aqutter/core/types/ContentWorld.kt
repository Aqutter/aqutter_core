package com.github.aqutter.core.types

class ContentWorld private constructor(var name: String) {
  companion object {
    @JvmField
    val PAGE = ContentWorld("page")
    @JvmField
    val DEFAULT_CLIENT = ContentWorld("defaultClient")

    @JvmStatic
    fun world(name: String): ContentWorld {
      return ContentWorld(name)
    }

    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): ContentWorld? {
      if (map == null) {
        return null
      }
      val name = map["name"] as String?
      assert(name != null)
      return ContentWorld(name!!)
    }
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as ContentWorld

    return name == that.name
  }

  override fun hashCode(): Int {
    return name.hashCode()
  }

  override fun toString(): String {
    return "ContentWorld{" +
      "name='" + name + '\'' +
      '}'
  }
}
