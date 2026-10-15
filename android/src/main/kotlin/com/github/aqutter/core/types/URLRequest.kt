package com.github.aqutter.core.types

import java.util.Arrays
import java.util.HashMap

class URLRequest(
  var url: String?,
  var method: String?,
  var body: ByteArray?,
  var headers: MutableMap<String, String>?
) {
  companion object {
    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun fromMap(map: Map<String, Any?>?): URLRequest? {
      if (map == null) {
        return null
      }
      var url = map["url"] as String?
      if (url == null) {
        url = "about:blank"
      }
      val method = map["method"] as String?
      val body = map["body"] as ByteArray?
      val headers = map["headers"] as MutableMap<String, String>?
      return URLRequest(url, method, body, headers)
    }
  }

  fun toMap(): MutableMap<String, Any?> {
    val urlRequestMap: MutableMap<String, Any?> = HashMap()
    urlRequestMap["url"] = url
    urlRequestMap["method"] = method
    urlRequestMap["headers"] = headers
    urlRequestMap["body"] = body
    urlRequestMap["allowsCellularAccess"] = null
    urlRequestMap["allowsConstrainedNetworkAccess"] = null
    urlRequestMap["allowsExpensiveNetworkAccess"] = null
    urlRequestMap["cachePolicy"] = null
    urlRequestMap["httpShouldHandleCookies"] = null
    urlRequestMap["httpShouldUsePipelining"] = null
    urlRequestMap["networkServiceType"] = null
    urlRequestMap["timeoutInterval"] = null
    urlRequestMap["mainDocumentURL"] = null
    urlRequestMap["assumesHTTP3Capable"] = null
    urlRequestMap["attribution"] = null
    return urlRequestMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as URLRequest

    if (if (url != null) url != that.url else that.url != null) return false
    if (if (method != null) method != that.method else that.method != null) return false
    if (!Arrays.equals(body, that.body)) return false
    return if (headers != null) headers == that.headers else that.headers == null
  }

  override fun hashCode(): Int {
    var result = if (url != null) url.hashCode() else 0
    result = 31 * result + (if (method != null) method.hashCode() else 0)
    result = 31 * result + Arrays.hashCode(body)
    result = 31 * result + (if (headers != null) headers.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "URLRequest{" +
      "url='" + url + '\'' +
      ", method='" + method + '\'' +
      ", body=" + Arrays.toString(body) +
      ", headers=" + headers +
      '}'
  }
}
