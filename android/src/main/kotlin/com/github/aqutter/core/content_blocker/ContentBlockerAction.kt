package com.github.aqutter.core.content_blocker

open class ContentBlockerAction( // package-private constructor in Java
  type: ContentBlockerActionType,
  selector: String?
) {
  var type: ContentBlockerActionType = type

  var selector: String?

  init {
    if (this.type == ContentBlockerActionType.CSS_DISPLAY_NONE) {
      assert(selector != null)
    }
    this.selector = selector
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as ContentBlockerAction

    if (type != that.type) return false
    return if (selector != null) selector == that.selector else that.selector == null
  }

  override fun hashCode(): Int {
    var result = type.hashCode()
    result = 31 * result + (if (selector != null) selector.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "ContentBlockerAction{" +
      "type=" + type +
      ", selector='" + selector + '\'' +
      '}'
  }

  companion object {
    @JvmStatic
    fun fromMap(map: Map<String, Any?>): ContentBlockerAction {
      val type = ContentBlockerActionType.fromValue(map.get("type") as String)
      val selector = map.get("selector") as String?
      return ContentBlockerAction(type, selector)
    }
  }
}
