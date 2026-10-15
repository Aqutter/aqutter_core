package com.github.aqutter.core.types

import android.os.Build
import android.webkit.WebResourceRequest
import androidx.annotation.RequiresApi
import androidx.webkit.WebResourceRequestCompat
import androidx.webkit.WebViewFeature
import java.util.HashMap

class WebResourceRequestExt(
  var url: String,
  var headers: MutableMap<String, String>?,
  var isRedirect: Boolean,
  var isHasGesture: Boolean,
  var isForMainFrame: Boolean,
  var method: String?
) {
  companion object {
    @JvmStatic
    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun fromWebResourceRequest(request: WebResourceRequest): WebResourceRequestExt {
      var isRedirect = false
      if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_RESOURCE_REQUEST_IS_REDIRECT)) {
        isRedirect = WebResourceRequestCompat.isRedirect(request)
      } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
        isRedirect = request.isRedirect
      }
      return WebResourceRequestExt(request.url.toString(),
        request.requestHeaders,
        isRedirect,
        request.hasGesture(),
        request.isForMainFrame,
        request.method
      )
    }
  }

  fun toMap(): MutableMap<String, Any?> {
    val webResourceRequestMap: MutableMap<String, Any?> = HashMap()
    webResourceRequestMap["url"] = url
    webResourceRequestMap["headers"] = headers
    webResourceRequestMap["isRedirect"] = isRedirect
    webResourceRequestMap["hasGesture"] = isHasGesture
    webResourceRequestMap["isForMainFrame"] = isForMainFrame
    webResourceRequestMap["method"] = method
    return webResourceRequestMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as WebResourceRequestExt

    if (isRedirect != that.isRedirect) return false
    if (isHasGesture != that.isHasGesture) return false
    if (isForMainFrame != that.isForMainFrame) return false
    if (url != that.url) return false
    if (if (headers != null) headers != that.headers else that.headers != null) return false
    return if (method != null) method == that.method else that.method == null
  }

  override fun hashCode(): Int {
    var result = url.hashCode()
    result = 31 * result + (if (headers != null) headers.hashCode() else 0)
    result = 31 * result + (if (isRedirect) 1 else 0)
    result = 31 * result + (if (isHasGesture) 1 else 0)
    result = 31 * result + (if (isForMainFrame) 1 else 0)
    result = 31 * result + (if (method != null) method.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "WebResourceRequestExt{" +
      "url=" + url +
      ", headers=" + headers +
      ", isRedirect=" + isRedirect +
      ", hasGesture=" + isHasGesture +
      ", isForMainFrame=" + isForMainFrame +
      ", method='" + method + '\'' +
      '}'
  }
}
