package com.github.aqutter.core.types

class DownloadStartRequest(
  var url: String,
  var userAgent: String,
  var contentDisposition: String,
  var mimeType: String,
  var contentLength: Long,
  var suggestedFilename: String?,
  var textEncodingName: String?
) {

  fun toMap(): MutableMap<String, Any?> {
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    obj["userAgent"] = userAgent
    obj["contentDisposition"] = contentDisposition
    obj["mimeType"] = mimeType
    obj["contentLength"] = contentLength
    obj["suggestedFilename"] = suggestedFilename
    obj["textEncodingName"] = textEncodingName
    return obj
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as DownloadStartRequest

    if (contentLength != that.contentLength) return false
    if (url != that.url) return false
    if (userAgent != that.userAgent) return false
    if (contentDisposition != that.contentDisposition) return false
    if (mimeType != that.mimeType) return false
    if (if (suggestedFilename != null) suggestedFilename != that.suggestedFilename else that.suggestedFilename != null)
      return false
    return if (textEncodingName != null) textEncodingName == that.textEncodingName else that.textEncodingName == null
  }

  override fun hashCode(): Int {
    var result = url.hashCode()
    result = 31 * result + userAgent.hashCode()
    result = 31 * result + contentDisposition.hashCode()
    result = 31 * result + mimeType.hashCode()
    result = 31 * result + (contentLength xor (contentLength ushr 32)).toInt()
    result = 31 * result + (if (suggestedFilename != null) suggestedFilename.hashCode() else 0)
    result = 31 * result + (if (textEncodingName != null) textEncodingName.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "DownloadStartRequest{" +
      "url='" + url + '\'' +
      ", userAgent='" + userAgent + '\'' +
      ", contentDisposition='" + contentDisposition + '\'' +
      ", mimeType='" + mimeType + '\'' +
      ", contentLength=" + contentLength +
      ", suggestedFilename='" + suggestedFilename + '\'' +
      ", textEncodingName='" + textEncodingName + '\'' +
      '}'
  }
}
