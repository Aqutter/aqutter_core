package com.github.aqutter.core.types

class ShowFileChooserResponse(var isHandledByClient: Boolean, var filePaths: List<String>?) {
  companion object {
    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun fromMap(map: Map<String, Any?>?): ShowFileChooserResponse? {
      if (map == null) {
        return null
      }
      val handledByClient = map["handledByClient"] as Boolean
      val filePaths = map["filePaths"] as List<String>?
      return ShowFileChooserResponse(handledByClient, filePaths)
    }
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as ShowFileChooserResponse
    return isHandledByClient == that.isHandledByClient && filePaths == that.filePaths
  }

  override fun hashCode(): Int {
    var result = isHandledByClient.hashCode()
    result = 31 * result + (filePaths?.hashCode() ?: 0)
    return result
  }

  override fun toString(): String {
    return "ShowFileChooserResponse{" +
      "handledByClient=" + isHandledByClient +
      ", filePaths=" + filePaths +
      '}'
  }
}
