package com.github.aqutter.core.types

class PermissionResponse(
  var resources: MutableList<String>,
  var action: Int?
) {

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as PermissionResponse

    if (resources != that.resources) return false
    return if (action != null) action == that.action else that.action == null
  }

  override fun hashCode(): Int {
    var result = resources.hashCode()
    result = 31 * result + (if (action != null) action.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "PermissionResponse{" +
      "resources=" + resources +
      ", action=" + action +
      '}'
  }

  companion object {
    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun fromMap(map: MutableMap<String, Any?>?): PermissionResponse? {
      if (map == null) {
        return null
      }
      val resources = map["resources"] as MutableList<String>
      val action = map["action"] as Int?
      return PermissionResponse(resources, action)
    }
  }
}
