package com.github.aqutter.core.content_blocker

open class ContentBlocker(
  trigger: ContentBlockerTrigger,
  action: ContentBlockerAction
) {
  var trigger: ContentBlockerTrigger = trigger

  var action: ContentBlockerAction = action

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as ContentBlocker

    if (trigger != that.trigger) return false
    return action == that.action
  }

  override fun hashCode(): Int {
    var result = trigger.hashCode()
    result = 31 * result + action.hashCode()
    return result
  }

  override fun toString(): String {
    return "ContentBlocker{" +
      "trigger=" + trigger +
      ", action=" + action +
      '}'
  }
}
