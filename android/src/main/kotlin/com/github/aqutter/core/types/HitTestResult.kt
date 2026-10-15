package com.github.aqutter.core.types

import android.webkit.WebView

class HitTestResult(
  var type: Int,
  var extra: String?
) {

  fun toMap(): MutableMap<String, Any?>? {
    val hitTestResultMap: MutableMap<String, Any?> = HashMap()
    hitTestResultMap["type"] = type
    hitTestResultMap["extra"] = extra
    return hitTestResultMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as HitTestResult

    if (type != that.type) return false
    return if (extra != null) extra == that.extra else that.extra == null
  }

  override fun hashCode(): Int {
    var result = type
    result = 31 * result + (if (extra != null) extra.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "HitTestResultMap{" +
      "type=" + type +
      ", extra='" + extra + '\'' +
      '}'
  }

  companion object {
    @JvmStatic
    fun fromWebViewHitTestResult(hitTestResult: WebView.HitTestResult?): HitTestResult? {
      if (hitTestResult == null) {
        return null
      }

      return HitTestResult(hitTestResult.type, hitTestResult.extra)
    }
  }
}
