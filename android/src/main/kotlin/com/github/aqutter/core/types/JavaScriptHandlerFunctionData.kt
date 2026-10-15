package com.github.aqutter.core.types

class JavaScriptHandlerFunctionData(
  var origin: String,
  var requestUrl: String,
  var isMainFrame: Boolean,
  var args: String
) {

  fun toMap(): MutableMap<String, Any?> {
    val map: MutableMap<String, Any?> = HashMap()
    map["origin"] = origin
    map["requestUrl"] = requestUrl
    map["isMainFrame"] = isMainFrame
    map["args"] = args
    return map
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as JavaScriptHandlerFunctionData
    return isMainFrame == that.isMainFrame && origin == that.origin && requestUrl == that.requestUrl && args == that.args
  }

  override fun hashCode(): Int {
    var result = origin.hashCode()
    result = 31 * result + requestUrl.hashCode()
    result = 31 * result + isMainFrame.hashCode()
    result = 31 * result + args.hashCode()
    return result
  }

  override fun toString(): String {
    return "JavaScriptHandlerFunctionData{" +
      "origin='" + origin + '\'' +
      ", requestUrl='" + requestUrl + '\'' +
      ", isMainFrame=" + isMainFrame +
      ", args='" + args + '\'' +
      '}'
  }

  companion object {
    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): JavaScriptHandlerFunctionData? {
      if (map == null) {
        return null
      }
      val origin = map["origin"] as String
      val requestUrl = map["requestUrl"] as String
      val isMainFrame = map["isMainFrame"] as Boolean
      val args = map["args"] as String
      return JavaScriptHandlerFunctionData(origin, requestUrl, isMainFrame, args)
    }
  }
}
