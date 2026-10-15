package com.github.aqutter.core.types

import java.security.Principal
import java.util.Arrays

class ClientCertChallenge(
  protectionSpace: URLProtectionSpace,
  var principals: Array<Principal>?,
  var keyTypes: Array<String>?
) : URLAuthenticationChallenge(protectionSpace) {

  override fun toMap(): MutableMap<String, Any?> {
    var principalList: MutableList<String>? = null
    if (principals != null) {
      principalList = ArrayList()
      for (principal in principals!!) {
        principalList.add(principal.name)
      }
    }

    val challengeMap = super.toMap()
    challengeMap["principals"] = principalList
    challengeMap["keyTypes"] = if (keyTypes != null) Arrays.asList(*keyTypes!!) else null
    return challengeMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false
    if (!super.equals(other)) return false

    val that = other as ClientCertChallenge

    // Probably incorrect - comparing Object[] arrays with Arrays.equals
    if (!Arrays.equals(principals, that.principals)) return false
    // Probably incorrect - comparing Object[] arrays with Arrays.equals
    return Arrays.equals(keyTypes, that.keyTypes)
  }

  override fun hashCode(): Int {
    var result = super.hashCode()
    result = 31 * result + Arrays.hashCode(principals)
    result = 31 * result + Arrays.hashCode(keyTypes)
    return result
  }

  override fun toString(): String {
    return "ClientCertChallenge{" +
      "principals=" + Arrays.toString(principals) +
      ", keyTypes=" + Arrays.toString(keyTypes) +
      "} " + super.toString()
  }
}
