package com.github.aqutter.core.types

import java.util.Arrays

class CustomSchemeResponse(
  var data: ByteArray,
  var contentType: String,
  var contentEncoding: String
) {
  companion object {
    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): CustomSchemeResponse? {
      if (map == null) {
        return null
      }
      val data = map["data"] as ByteArray
      val contentType = map["contentType"] as String
      val contentEncoding = map["contentEncoding"] as String
      return CustomSchemeResponse(data, contentType, contentEncoding)
    }
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as CustomSchemeResponse

    if (!Arrays.equals(data, that.data)) return false
    if (contentType != that.contentType) return false
    return contentEncoding == that.contentEncoding
  }

  override fun hashCode(): Int {
    var result = Arrays.hashCode(data)
    result = 31 * result + contentType.hashCode()
    result = 31 * result + contentEncoding.hashCode()
    return result
  }

  override fun toString(): String {
    return "CustomSchemeResponse{" +
      "data=" + Arrays.toString(data) +
      ", contentType='" + contentType + '\'' +
      ", contentEncoding='" + contentEncoding + '\'' +
      '}'
  }
}
