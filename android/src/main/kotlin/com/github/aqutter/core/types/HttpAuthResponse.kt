package com.github.aqutter.core.types

class HttpAuthResponse(
  var username: String,
  var password: String,
  var isPermanentPersistence: Boolean,
  var action: Int?
) {

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as HttpAuthResponse

    if (isPermanentPersistence != that.isPermanentPersistence) return false
    if (username != that.username) return false
    if (password != that.password) return false
    return if (action != null) action == that.action else that.action == null
  }

  override fun hashCode(): Int {
    var result = username.hashCode()
    result = 31 * result + password.hashCode()
    result = 31 * result + (if (isPermanentPersistence) 1 else 0)
    result = 31 * result + (if (action != null) action.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "HttpAuthResponse{" +
      "username='" + username + '\'' +
      ", password='" + password + '\'' +
      ", permanentPersistence=" + isPermanentPersistence +
      ", action=" + action +
      '}'
  }

  companion object {
    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): HttpAuthResponse? {
      if (map == null) {
        return null
      }
      val username = map["username"] as String
      val password = map["password"] as String
      val permanentPersistence = map["permanentPersistence"] as Boolean
      val action = map["action"] as Int?
      return HttpAuthResponse(username, password, permanentPersistence, action)
    }
  }
}
