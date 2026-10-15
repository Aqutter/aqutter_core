package com.github.aqutter.core.types

class CreateWindowAction(
  request: URLRequest,
  isForMainFrame: Boolean,
  hasGesture: Boolean,
  isRedirect: Boolean,
  // package-private in Java
  var windowId: Int,
  // package-private in Java
  var isDialog: Boolean
) : NavigationAction(request, isForMainFrame, hasGesture, isRedirect) {

  override fun toMap(): MutableMap<String, Any?> {
    val createWindowActionMap = super.toMap()
    createWindowActionMap["windowId"] = windowId
    createWindowActionMap["isDialog"] = isDialog
    createWindowActionMap["windowFeatures"] = null
    return createWindowActionMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false
    if (!super.equals(other)) return false

    val that = other as CreateWindowAction

    if (windowId != that.windowId) return false
    return isDialog == that.isDialog
  }

  override fun hashCode(): Int {
    var result = super.hashCode()
    result = 31 * result + windowId
    result = 31 * result + (if (isDialog) 1 else 0)
    return result
  }

  override fun toString(): String {
    return "CreateWindowAction{" +
      "windowId=" + windowId +
      ", isDialog=" + isDialog +
      ", request=" + request +
      ", isForMainFrame=" + isForMainFrame +
      ", hasGesture=" + hasGesture +
      ", isRedirect=" + isRedirect +
      '}'
  }
}
