package com.github.aqutter.core.types

import androidx.webkit.WebMessageCompat
import androidx.webkit.WebViewFeature
import java.util.ArrayList
import java.util.HashMap

class WebMessageCompatExt(
  var data: Any?,
  @WebMessageCompat.Type var type: Int,
  var ports: MutableList<WebMessagePortCompatExt>?
) {
  companion object {
    @JvmStatic
    fun fromMapWebMessageCompat(message: WebMessageCompat): WebMessageCompatExt {
      val data: Any?
      if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_ARRAY_BUFFER) && message.type == WebMessageCompat.TYPE_ARRAY_BUFFER) {
        data = message.arrayBuffer
      } else {
        data = message.data
      }
      return WebMessageCompatExt(data, message.type, null)
    }

    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun fromMap(map: Map<String, Any?>?): WebMessageCompatExt? {
      if (map == null) {
        return null
      }
      val data = map["data"]
      val type = map["type"] as Int?
      val portMapList = map["ports"] as List<Map<String, Any?>>?
      var ports: MutableList<WebMessagePortCompatExt>? = null
      if (portMapList != null && !portMapList.isEmpty()) {
        ports = ArrayList()
        for (portMap in portMapList) {
          ports.add(WebMessagePortCompatExt.fromMap(portMap)!!)
        }
      }
      return WebMessageCompatExt(data, type!!, ports)
    }
  }

  fun toMap(): MutableMap<String, Any?> {
    val proxyRuleMap: MutableMap<String, Any?> = HashMap()
    proxyRuleMap["data"] = data
    proxyRuleMap["type"] = type
    return proxyRuleMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as WebMessageCompatExt

    if (type != that.type) return false
    if (data != that.data) return false
    return ports == that.ports
  }

  override fun hashCode(): Int {
    var result = if (data != null) data.hashCode() else 0
    result = 31 * result + type
    result = 31 * result + (if (ports != null) ports.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "WebMessageCompatExt{" +
      "data=" + data +
      ", type=" + type +
      ", ports=" + ports +
      '}'
  }
}
