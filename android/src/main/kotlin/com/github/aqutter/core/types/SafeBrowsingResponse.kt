package com.github.aqutter.core.types

class SafeBrowsingResponse(var isReport: Boolean, var action: Int?) {
  companion object {
    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun fromMap(map: Map<String, Any?>?): SafeBrowsingResponse? {
      if (map == null) {
        return null
      }
      val report = map["report"] as Boolean
      val action = map["action"] as Int?
      return SafeBrowsingResponse(report, action)
    }
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as SafeBrowsingResponse

    if (isReport != that.isReport) return false
    return if (action != null) action == that.action else that.action == null
  }

  override fun hashCode(): Int {
    var result = if (isReport) 1 else 0
    result = 31 * result + (if (action != null) action.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "SafeBrowsingResponse{" +
      "report=" + isReport +
      ", action=" + action +
      '}'
  }
}
