package com.github.aqutter.core.types

open class NavigationAction(
  // package-private in Java (accessed directly by CreateWindowAction)
  @JvmField var request: URLRequest,
  @JvmField var isForMainFrame: Boolean,
  @JvmField var hasGesture: Boolean,
  @JvmField var isRedirect: Boolean
) {

  open fun toMap(): MutableMap<String, Any?> {
    val navigationActionMap: MutableMap<String, Any?> = HashMap()
    navigationActionMap["request"] = request.toMap()
    navigationActionMap["isForMainFrame"] = isForMainFrame
    navigationActionMap["hasGesture"] = hasGesture
    navigationActionMap["isRedirect"] = isRedirect
    navigationActionMap["navigationType"] = null
    navigationActionMap["sourceFrame"] = null
    navigationActionMap["targetFrame"] = null
    navigationActionMap["shouldPerformDownload"] = null
    return navigationActionMap
  }

  fun getRequest(): URLRequest {
    return request
  }

  fun setRequest(request: URLRequest) {
    this.request = request
  }

  fun isForMainFrame(): Boolean {
    return isForMainFrame
  }

  fun setForMainFrame(forMainFrame: Boolean) {
    isForMainFrame = forMainFrame
  }

  fun isHasGesture(): Boolean {
    return hasGesture
  }

  fun setHasGesture(hasGesture: Boolean) {
    this.hasGesture = hasGesture
  }

  fun isRedirect(): Boolean {
    return isRedirect
  }

  fun setRedirect(redirect: Boolean) {
    isRedirect = redirect
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as NavigationAction

    if (isForMainFrame != that.isForMainFrame) return false
    if (hasGesture != that.hasGesture) return false
    if (isRedirect != that.isRedirect) return false
    return request == that.request
  }

  override fun hashCode(): Int {
    var result = request.hashCode()
    result = 31 * result + (if (isForMainFrame) 1 else 0)
    result = 31 * result + (if (hasGesture) 1 else 0)
    result = 31 * result + (if (isRedirect) 1 else 0)
    return result
  }

  override fun toString(): String {
    return "NavigationAction{" +
      "request=" + request +
      ", isForMainFrame=" + isForMainFrame +
      ", hasGesture=" + hasGesture +
      ", isRedirect=" + isRedirect +
      '}'
  }
}
