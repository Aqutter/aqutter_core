package com.github.aqutter.core.types

import java.util.HashSet

open class UserScript(
  var groupName: String?,
  var source: String,
  var injectionTime: UserScriptInjectionTime,
  contentWorld: ContentWorld?,
  allowedOriginRules: MutableSet<String>?,
  var isForMainFrameOnly: Boolean
) {
  var contentWorld: ContentWorld = contentWorld ?: ContentWorld.PAGE

  var allowedOriginRules: MutableSet<String> = allowedOriginRules ?: HashSet<String>().apply {
    add("*")
  }

  companion object {
    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun fromMap(map: Map<String, Any?>?): UserScript? {
      if (map == null) {
        return null
      }
      val groupName = map["groupName"] as String?
      val source = map["source"] as String?
      val injectionTime = UserScriptInjectionTime.fromValue(map["injectionTime"] as Int)
      val contentWorld = ContentWorld.fromMap(map["contentWorld"] as MutableMap<String, Any?>?)
      val allowedOriginRules: MutableSet<String> = HashSet(map["allowedOriginRules"] as List<String>)
      val forMainFrameOnly = map["forMainFrameOnly"] as Boolean
      assert(source != null)
      return UserScript(groupName, source!!, injectionTime, contentWorld, allowedOriginRules, forMainFrameOnly)
    }
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as UserScript
    return isForMainFrameOnly == that.isForMainFrameOnly && groupName == that.groupName && source == that.source && injectionTime == that.injectionTime && contentWorld == that.contentWorld && allowedOriginRules == that.allowedOriginRules
  }

  override fun hashCode(): Int {
    var result = groupName?.hashCode() ?: 0
    result = 31 * result + source.hashCode()
    result = 31 * result + injectionTime.hashCode()
    result = 31 * result + contentWorld.hashCode()
    result = 31 * result + allowedOriginRules.hashCode()
    result = 31 * result + isForMainFrameOnly.hashCode()
    return result
  }

  override fun toString(): String {
    return "UserScript{" +
      "groupName='" + groupName + '\'' +
      ", source='" + source + '\'' +
      ", injectionTime=" + injectionTime +
      ", contentWorld=" + contentWorld +
      ", allowedOriginRules=" + allowedOriginRules +
      ", forMainFrameOnly=" + isForMainFrameOnly +
      '}'
  }
}
