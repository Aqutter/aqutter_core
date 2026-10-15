package com.github.aqutter.core.types

import java.util.HashMap

class WebMessagePortCompatExt(var index: Int, var webMessageChannelId: String) {
  companion object {
    @JvmStatic
    fun fromMap(map: Map<String, Any?>?): WebMessagePortCompatExt? {
      if (map == null) {
        return null
      }
      val index = map["index"] as Int?
      val webMessageChannelId = map["webMessageChannelId"] as String
      return WebMessagePortCompatExt(index!!, webMessageChannelId)
    }
  }

  fun toMap(): MutableMap<String, Any?> {
    val proxyRuleMap: MutableMap<String, Any?> = HashMap()
    proxyRuleMap["index"] = index
    proxyRuleMap["webMessageChannelId"] = webMessageChannelId
    return proxyRuleMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as WebMessagePortCompatExt

    if (index != that.index) return false
    return webMessageChannelId == that.webMessageChannelId
  }

  override fun hashCode(): Int {
    var result = index
    result = 31 * result + webMessageChannelId.hashCode()
    return result
  }

  override fun toString(): String {
    return "WebMessagePortCompatExt{" +
      "index=" + index +
      ", webMessageChannelId='" + webMessageChannelId + '\'' +
      '}'
  }
}
