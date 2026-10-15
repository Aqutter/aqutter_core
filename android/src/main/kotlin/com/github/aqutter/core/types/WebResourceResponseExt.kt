package com.github.aqutter.core.types

import android.os.Build
import android.webkit.WebResourceResponse
import com.github.aqutter.core.Util
import java.util.Arrays

class WebResourceResponseExt(
  var contentType: String?,
  var contentEncoding: String?,
  var statusCode: Int?,
  var reasonPhrase: String?,
  var headers: MutableMap<String, String>?,
  var data: ByteArray?
) {
  companion object {
    @JvmStatic
    fun fromWebResourceResponse(response: WebResourceResponse): WebResourceResponseExt {
      var statusCode: Int? = null
      var reasonPhrase: String? = null
      var headers: MutableMap<String, String>? = null
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        statusCode = response.statusCode
        reasonPhrase = response.reasonPhrase
        headers = response.responseHeaders
      }
      return WebResourceResponseExt(response.mimeType,
        response.encoding,
        statusCode,
        reasonPhrase,
        headers,
        Util.readAllBytes(response.data)
      )
    }

    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): WebResourceResponseExt? {
      if (map == null) {
        return null
      }
      val contentType = map["contentType"] as String?
      val contentEncoding = map["contentEncoding"] as String?
      val statusCode = map["statusCode"] as Int?
      val reasonPhrase = map["reasonPhrase"] as String?
      val headers = map["headers"] as MutableMap<String, String>?
      val data = map["data"] as ByteArray?
      return WebResourceResponseExt(contentType, contentEncoding, statusCode, reasonPhrase, headers, data)
    }
  }

  fun toMap(): MutableMap<String, Any?> {
    val webResourceResponseMap: MutableMap<String, Any?> = HashMap()
    webResourceResponseMap["contentType"] = contentType
    webResourceResponseMap["contentEncoding"] = contentEncoding
    webResourceResponseMap["statusCode"] = statusCode
    webResourceResponseMap["reasonPhrase"] = reasonPhrase
    webResourceResponseMap["headers"] = headers
    webResourceResponseMap["data"] = data
    return webResourceResponseMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as WebResourceResponseExt

    if (if (contentType != null) contentType != that.contentType else that.contentType != null)
      return false
    if (if (contentEncoding != null) contentEncoding != that.contentEncoding else that.contentEncoding != null)
      return false
    if (if (statusCode != null) statusCode != that.statusCode else that.statusCode != null)
      return false
    if (if (reasonPhrase != null) reasonPhrase != that.reasonPhrase else that.reasonPhrase != null)
      return false
    if (if (headers != null) headers != that.headers else that.headers != null) return false
    return Arrays.equals(data, that.data)
  }

  override fun hashCode(): Int {
    var result = if (contentType != null) contentType.hashCode() else 0
    result = 31 * result + (if (contentEncoding != null) contentEncoding.hashCode() else 0)
    result = 31 * result + (if (statusCode != null) statusCode.hashCode() else 0)
    result = 31 * result + (if (reasonPhrase != null) reasonPhrase.hashCode() else 0)
    result = 31 * result + (if (headers != null) headers.hashCode() else 0)
    result = 31 * result + Arrays.hashCode(data)
    return result
  }

  override fun toString(): String {
    return "WebResourceResponseExt{" +
            "contentType='" + contentType + '\'' +
            ", contentEncoding='" + contentEncoding + '\'' +
            ", statusCode=" + statusCode +
            ", reasonPhrase='" + reasonPhrase + '\'' +
            ", headers=" + headers +
            ", data=" + Arrays.toString(data) +
            '}'
  }
}
