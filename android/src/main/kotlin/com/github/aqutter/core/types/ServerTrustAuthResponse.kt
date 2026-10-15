package com.github.aqutter.core.types

class ServerTrustAuthResponse(var action: Int?) {
  companion object {
    @JvmStatic
    fun fromMap(map: Map<String, Any?>?): ServerTrustAuthResponse? {
      if (map == null) {
        return null
      }
      val action = map["action"] as Int?
      return ServerTrustAuthResponse(action)
    }
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as ServerTrustAuthResponse

    return if (action != null) action == that.action else that.action == null
  }

  override fun hashCode(): Int {
    return if (action != null) action.hashCode() else 0
  }

  override fun toString(): String {
    return "ServerTrustAuthResponse{" +
      "action=" + action +
      '}'
  }
}
