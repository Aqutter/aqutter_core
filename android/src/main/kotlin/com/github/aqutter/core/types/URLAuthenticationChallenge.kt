package com.github.aqutter.core.types

import java.util.HashMap

open class URLAuthenticationChallenge(var protectionSpace: URLProtectionSpace) {
  open fun toMap(): MutableMap<String, Any?> {
    val challengeMap: MutableMap<String, Any?> = HashMap()
    challengeMap["protectionSpace"] = protectionSpace.toMap()
    return challengeMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val challenge = other as URLAuthenticationChallenge

    return protectionSpace == challenge.protectionSpace
  }

  override fun hashCode(): Int {
    return protectionSpace.hashCode()
  }

  override fun toString(): String {
    return "URLAuthenticationChallenge{" +
      "protectionSpace=" + protectionSpace +
      '}'
  }
}
