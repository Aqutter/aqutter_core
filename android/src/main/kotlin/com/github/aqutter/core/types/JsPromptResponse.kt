package com.github.aqutter.core.types

class JsPromptResponse(
  var message: String?,
  var defaultValue: String?,
  var confirmButtonTitle: String?,
  var cancelButtonTitle: String?,
  var isHandledByClient: Boolean,
  var value: String?,
  var action: Int?
) {

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as JsPromptResponse

    if (isHandledByClient != that.isHandledByClient) return false
    if (if (message != null) message != that.message else that.message != null) return false
    if (if (defaultValue != null) defaultValue != that.defaultValue else that.defaultValue != null)
      return false
    if (if (confirmButtonTitle != null) confirmButtonTitle != that.confirmButtonTitle else that.confirmButtonTitle != null)
      return false
    if (if (cancelButtonTitle != null) cancelButtonTitle != that.cancelButtonTitle else that.cancelButtonTitle != null)
      return false
    if (if (value != null) value != that.value else that.value != null) return false
    return if (action != null) action == that.action else that.action == null
  }

  override fun hashCode(): Int {
    var result = if (message != null) message.hashCode() else 0
    result = 31 * result + (if (defaultValue != null) defaultValue.hashCode() else 0)
    result = 31 * result + (if (confirmButtonTitle != null) confirmButtonTitle.hashCode() else 0)
    result = 31 * result + (if (cancelButtonTitle != null) cancelButtonTitle.hashCode() else 0)
    result = 31 * result + (if (isHandledByClient) 1 else 0)
    result = 31 * result + (if (value != null) value.hashCode() else 0)
    result = 31 * result + (if (action != null) action.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "JsPromptResponse{" +
      "message='" + message + '\'' +
      ", defaultValue='" + defaultValue + '\'' +
      ", confirmButtonTitle='" + confirmButtonTitle + '\'' +
      ", cancelButtonTitle='" + cancelButtonTitle + '\'' +
      ", handledByClient=" + isHandledByClient +
      ", value='" + value + '\'' +
      ", action=" + action +
      '}'
  }

  companion object {
    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?): JsPromptResponse? {
      if (map == null) {
        return null
      }
      val message = map["message"] as String?
      val defaultValue = map["defaultValue"] as String?
      val confirmButtonTitle = map["confirmButtonTitle"] as String?
      val cancelButtonTitle = map["cancelButtonTitle"] as String?
      val handledByClient = map["handledByClient"] as Boolean
      val value = map["value"] as String?
      val action = map["action"] as Int?
      return JsPromptResponse(message, defaultValue, confirmButtonTitle, cancelButtonTitle, handledByClient, value, action)
    }
  }
}
