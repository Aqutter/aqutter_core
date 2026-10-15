package com.github.aqutter.core.types

class ClientCertResponse(
  var certificatePath: String,
  var certificatePassword: String?,
  var keyStoreType: String,
  var action: Int?
) {
  companion object {
    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): ClientCertResponse? {
      if (map == null) {
        return null
      }
      val certificatePath = map["certificatePath"] as String
      val certificatePassword = map["certificatePassword"] as String?
      val keyStoreType = map["keyStoreType"] as String
      val action = map["action"] as Int?
      return ClientCertResponse(certificatePath, certificatePassword, keyStoreType, action)
    }
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as ClientCertResponse

    if (certificatePath != that.certificatePath) return false
    if (if (certificatePassword != null) certificatePassword != that.certificatePassword else that.certificatePassword != null)
      return false
    if (keyStoreType != that.keyStoreType) return false
    return if (action != null) action == that.action else that.action == null
  }

  override fun hashCode(): Int {
    var result = certificatePath.hashCode()
    result = 31 * result + (if (certificatePassword != null) certificatePassword.hashCode() else 0)
    result = 31 * result + keyStoreType.hashCode()
    result = 31 * result + (if (action != null) action.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "ClientCertResponse{" +
      "certificatePath='" + certificatePath + '\'' +
      ", certificatePassword='" + certificatePassword + '\'' +
      ", keyStoreType='" + keyStoreType + '\'' +
      ", action=" + action +
      '}'
  }
}
