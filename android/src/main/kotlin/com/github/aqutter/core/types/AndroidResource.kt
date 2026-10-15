package com.github.aqutter.core.types

import android.content.Context

class AndroidResource(
  var name: String,
  var defType: String?,
  var defPackage: String?
) {
  companion object {
    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): AndroidResource? {
      if (map == null) {
        return null
      }
      val name = map["name"] as String
      val defType = map["defType"] as String?
      val defPackage = map["defPackage"] as String?
      return AndroidResource(name, defType, defPackage)
    }
  }

  fun toMap(): MutableMap<String, Any?> {
    val urlRequestMap: MutableMap<String, Any?> = HashMap()
    urlRequestMap["name"] = name
    urlRequestMap["defType"] = defType
    urlRequestMap["defPackage"] = defPackage
    return urlRequestMap
  }

  fun getIdentifier(ctx: Context): Int {
    return ctx.resources.getIdentifier(name, defType, defPackage)
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as AndroidResource

    if (name != that.name) return false
    if (if (defType != null) defType != that.defType else that.defType != null) return false
    return if (defPackage != null) defPackage == that.defPackage else that.defPackage == null
  }

  override fun hashCode(): Int {
    var result = name.hashCode()
    result = 31 * result + (if (defType != null) defType.hashCode() else 0)
    result = 31 * result + (if (defPackage != null) defPackage.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "AndroidResource{" +
      "name='" + name + '\'' +
      ", type='" + defType + '\'' +
      ", defPackage='" + defPackage + '\'' +
      '}'
  }
}
