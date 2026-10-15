package com.github.aqutter.core.types

class HttpAuthenticationChallenge(
  protectionSpace: URLProtectionSpace,
  var previousFailureCount: Int,
  var proposedCredential: URLCredential?
) : URLAuthenticationChallenge(protectionSpace) {

  override fun toMap(): MutableMap<String, Any?> {
    val challengeMap = super.toMap()
    challengeMap["previousFailureCount"] = previousFailureCount
    challengeMap["proposedCredential"] = if (proposedCredential != null) proposedCredential!!.toMap() else null
    challengeMap["failureResponse"] = null
    challengeMap["error"] = null
    return challengeMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false
    if (!super.equals(other)) return false

    val that = other as HttpAuthenticationChallenge

    if (previousFailureCount != that.previousFailureCount) return false
    return if (proposedCredential != null) proposedCredential == that.proposedCredential else that.proposedCredential == null
  }

  override fun hashCode(): Int {
    var result = super.hashCode()
    result = 31 * result + previousFailureCount
    result = 31 * result + (if (proposedCredential != null) proposedCredential.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "HttpAuthenticationChallenge{" +
      "previousFailureCount=" + previousFailureCount +
      ", proposedCredential=" + proposedCredential +
      "} " + super.toString()
  }
}
