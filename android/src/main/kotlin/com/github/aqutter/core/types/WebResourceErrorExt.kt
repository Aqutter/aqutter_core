package com.github.aqutter.core.types

import android.os.Build
import android.webkit.WebResourceError
import androidx.annotation.RequiresApi
import androidx.webkit.WebResourceErrorCompat
import androidx.webkit.WebViewFeature
import java.util.HashMap

class WebResourceErrorExt(var type: Int, var description: String) {
  companion object {
    @JvmStatic
    @RequiresApi(Build.VERSION_CODES.M)
    fun fromWebResourceError(error: WebResourceError): WebResourceErrorExt {
      return WebResourceErrorExt(error.errorCode, error.description.toString())
    }

    @JvmStatic
    @RequiresApi(Build.VERSION_CODES.M)
    fun fromWebResourceError(error: WebResourceErrorCompat): WebResourceErrorExt {
      var type = -1
      if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_RESOURCE_ERROR_GET_CODE)) {
        type = error.errorCode
      }
      var description = ""
      if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_RESOURCE_ERROR_GET_DESCRIPTION)) {
        description = error.description.toString()
      }
      return WebResourceErrorExt(type, description)
    }
  }

  fun toMap(): MutableMap<String, Any?> {
    val webResourceErrorMap: MutableMap<String, Any?> = HashMap()
    webResourceErrorMap["type"] = type
    webResourceErrorMap["description"] = description
    return webResourceErrorMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as WebResourceErrorExt

    if (type != that.type) return false
    return description == that.description
  }

  override fun hashCode(): Int {
    var result = type
    result = 31 * result + description.hashCode()
    return result
  }

  override fun toString(): String {
    return "WebResourceErrorExt{" +
      "type=" + type +
      ", description='" + description + '\'' +
      '}'
  }
}
