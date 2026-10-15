package com.github.aqutter.core.types

class GeolocationPermissionShowPromptResponse(
  var origin: String,
  var isAllow: Boolean,
  var isRetain: Boolean
) {

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as GeolocationPermissionShowPromptResponse

    if (isAllow != that.isAllow) return false
    if (isRetain != that.isRetain) return false
    return origin == that.origin
  }

  override fun hashCode(): Int {
    var result = origin.hashCode()
    result = 31 * result + (if (isAllow) 1 else 0)
    result = 31 * result + (if (isRetain) 1 else 0)
    return result
  }

  override fun toString(): String {
    return "GeolocationPermissionShowPromptResponse{" +
      "origin='" + origin + '\'' +
      ", allow=" + isAllow +
      ", retain=" + isRetain +
      '}'
  }

  companion object {
    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): GeolocationPermissionShowPromptResponse? {
      if (map == null) {
        return null
      }
      val origin = map["origin"] as String
      val allow = map["allow"] as Boolean
      val retain = map["retain"] as Boolean
      return GeolocationPermissionShowPromptResponse(origin, allow, retain)
    }
  }
}
