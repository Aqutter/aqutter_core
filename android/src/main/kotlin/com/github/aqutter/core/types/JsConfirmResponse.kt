package com.github.aqutter.core.types

class JsConfirmResponse(
  var message: String?,
  var confirmButtonTitle: String?,
  var cancelButtonTitle: String?,
  var isHandledByClient: Boolean,
  var action: Int?
) {

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as JsConfirmResponse

    if (isHandledByClient != that.isHandledByClient) return false
    if (if (message != null) message != that.message else that.message != null) return false
    if (if (confirmButtonTitle != null) confirmButtonTitle != that.confirmButtonTitle else that.confirmButtonTitle != null)
      return false
    if (if (cancelButtonTitle != null) cancelButtonTitle != that.cancelButtonTitle else that.cancelButtonTitle != null)
      return false
    return if (action != null) action == that.action else that.action == null
  }

  override fun hashCode(): Int {
    var result = if (message != null) message.hashCode() else 0
    result = 31 * result + (if (confirmButtonTitle != null) confirmButtonTitle.hashCode() else 0)
    result = 31 * result + (if (cancelButtonTitle != null) cancelButtonTitle.hashCode() else 0)
    result = 31 * result + (if (isHandledByClient) 1 else 0)
    result = 31 * result + (if (action != null) action.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "JsConfirmResponse{" +
      "message='" + message + '\'' +
      ", confirmButtonTitle='" + confirmButtonTitle + '\'' +
      ", cancelButtonTitle='" + cancelButtonTitle + '\'' +
      ", handledByClient=" + isHandledByClient +
      ", action=" + action +
      '}'
  }

  companion object {
    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): JsConfirmResponse? {
      if (map == null) {
        return null
      }
      val message = map["message"] as String?
      val confirmButtonTitle = map["confirmButtonTitle"] as String?
      val cancelButtonTitle = map["cancelButtonTitle"] as String?
      val handledByClient = map["handledByClient"] as Boolean
      val action = map["action"] as Int?
      return JsConfirmResponse(message, confirmButtonTitle, cancelButtonTitle, handledByClient, action)
    }
  }
}
