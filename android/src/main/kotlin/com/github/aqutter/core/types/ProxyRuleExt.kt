package com.github.aqutter.core.types

import androidx.webkit.ProxyConfig

class ProxyRuleExt(
  @ProxyConfig.ProxyScheme var schemeFilter: String?,
  var url: String
) {

  fun toMap(): MutableMap<String, String?> {
    val proxyRuleMap: MutableMap<String, String?> = HashMap()
    proxyRuleMap["url"] = url
    proxyRuleMap["schemeFilter"] = schemeFilter
    return proxyRuleMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as ProxyRuleExt

    if (if (schemeFilter != null) schemeFilter != that.schemeFilter else that.schemeFilter != null)
      return false
    return url == that.url
  }

  override fun hashCode(): Int {
    var result = if (schemeFilter != null) schemeFilter.hashCode() else 0
    result = 31 * result + url.hashCode()
    return result
  }

  override fun toString(): String {
    return "ProxyRuleExt{" +
      "schemeFilter='" + schemeFilter + '\'' +
      ", url='" + url + '\'' +
      '}'
  }

  companion object {
    @JvmStatic
    fun fromMap(map: MutableMap<String, String?>?): ProxyRuleExt? {
      if (map == null) {
        return null
      }
      val url = map["url"] as String
      val schemeFilter = map["schemeFilter"] as String?
      return ProxyRuleExt(schemeFilter, url)
    }
  }
}
